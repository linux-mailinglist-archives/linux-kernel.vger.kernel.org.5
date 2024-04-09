Return-Path: <linux-kernel+bounces-136801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A389D84E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CE1C23DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426312D210;
	Tue,  9 Apr 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PWxzLdIN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C128387;
	Tue,  9 Apr 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662951; cv=none; b=juPV25hgna6H0U2BNO5ZoqhWmI5LFU8oq95kp8WLouLL1ncCeOW4544HU2l2sUKao4t+2hgEOS5axWjo7H/vdxiWalW2Oy7GrQHxDYnueqh3hyCw1+96qbJ00qu9JRFNHtSwYd9/TBhmHRMNuQDOv4CB5QJKQm2XIJKfK0jVy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662951; c=relaxed/simple;
	bh=Xl9MIcf8lfZ5gHbLv/p0PZMszA5xQbjg2yFtG5nVZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS4aJ351aFRiFKn3iD989v1ng3I+uqgzyM0FiG+xTL0UYayu5nAxcINvol786nn7ndVJjoX1ZdSLC70CGatyFUIYgz0x86ISJ5EP9xBnp1e98iM4sNvAi2b/9kwQTlZgquJUM6bqDJX+ioaPmC+JYUe7mvm88uzXZJfjv6uk9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PWxzLdIN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662948;
	bh=Xl9MIcf8lfZ5gHbLv/p0PZMszA5xQbjg2yFtG5nVZmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWxzLdINqOxTG6w44mrSRWESs5zyZcyU8dCPhaqQTlORHj8EftZOwEfUB1eDZ6fri
	 QbbhGn0h8eMZsEtR9aEaY3f0i6W1v4LMBc9Gvb967Atequs1pm9qKwAOdqNxoicPyo
	 xInbB2Ffchhmw22vBC3jYpkbl0rwsFJytZ0B4aKfD868OAhLs8/vkkIZuJqkCSBP2r
	 RzFId9fbsr6TApp6Hwm7+VCEo2mbKJnc/YUVEZMFPxOJk5WjgTbg6BSf25tI7GaFWm
	 fmVGsak3ZylO/6c67gzNuyeLEocc3sbYiqQ95LGv+cbWQJCH/z2g5otGMomlTtxek/
	 AveThPDNe34sA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D5B63782111;
	Tue,  9 Apr 2024 11:42:27 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 3/5] arm64: dts: mediatek: mt8395-nio-12l: Define RSEL in microamperes
Date: Tue,  9 Apr 2024 13:42:09 +0200
Message-ID: <20240409114211.310462-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The paris pinctrl driver supports specifying the RSEL drive strength
in microamperes as well as internal bits definitions: choose to specify
those in uA to avoid using hardware specific values in device trees.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 86f7d4dd5eae..f699633659b6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -434,6 +434,8 @@ &mt6359_vsram_others_ldo_reg {
 };
 
 &pio {
+	mediatek,rsel-resistance-in-si-unit;
+
 	eth_default_pins: eth-default-pins {
 		pins-cc {
 			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
@@ -509,7 +511,7 @@ i2c2_pins: i2c2-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
 				 <PINMUX_GPIO13__FUNC_SCL2>;
-			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			bias-pull-up = <1000>;
 			drive-strength = <6>;
 			drive-strength-microamp = <1000>;
 		};
@@ -519,7 +521,7 @@ i2c4_pins: i2c4-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
 				 <PINMUX_GPIO17__FUNC_SCL4>;
-			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			bias-pull-up = <1000>;
 			drive-strength-microamp = <1000>;
 		};
 	};
-- 
2.44.0


