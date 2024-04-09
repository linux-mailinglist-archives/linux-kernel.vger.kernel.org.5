Return-Path: <linux-kernel+bounces-136800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8835889D84C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4401F22091
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F173128818;
	Tue,  9 Apr 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vxz4zJaW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70C86AC2;
	Tue,  9 Apr 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662950; cv=none; b=K+HYdeMgdX9eCGm1EAmjYT0YoKfWWwVNnwIXg3An+Ba69kM59bKnV56SQ9PFjj5Y3RRo6NyugCWjG4e/ChIMidVzQ0D2gTE97qbdryR239owtl0q64+5Fkw6ATfTnoyO4Anw5w/lRbSwXcCXE0XcBYA2D3v3ZySbiH9GuLBANdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662950; c=relaxed/simple;
	bh=o1ZO250f2gq4FpmkK9DlGabPiZaW6bBFlLH8cfcJxfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLWVBNdNNy1mEkHAolcplfRz9SWiRAUkqQE+5JvHoSWZNh6btbrLJmaqgN0d5mhkPtx/SFXC8AOUTXSenCNrnOdKa/ldiB9RIKPLUcSAafu9HSYDP2/YvN0pi0anPEdryyOFRdcCVgQ0HT/TTm1+cx2hZ3eSbGgXG+HE/blgTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vxz4zJaW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662947;
	bh=o1ZO250f2gq4FpmkK9DlGabPiZaW6bBFlLH8cfcJxfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxz4zJaWymPrDOsrclq/ElwXrIy58HmDaaNpOunu1zE/lVlGv1flya+vlciMTeEpx
	 Cf11bvlfux9qs2/iVPccNsq2G3Jx2AZyXcNehgB93I7jM/WVvPmKoGmMYVf75JmxSc
	 UojyZl7vhlj5V8yT8sYkljQh0Oht6ZyqpnD3dCqxQq0+XvLxE4fcwqArti3neqT0y/
	 dvjLfqCoQ1r1cGS/TxRN3Cntk8oKtq7NENDZWzQ2nGUsj2tLBmkENn7mCAbI9HXDNv
	 HYAOzjgl7p4k+2D3qXGf5pNqu5sy4B7KavgXJIIcCGVAa1XQkWdlE+Wd9F1GS/FjLF
	 Es/HBEx5YbNRQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B999E37820FD;
	Tue,  9 Apr 2024 11:42:26 +0000 (UTC)
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
Subject: [PATCH 2/5] arm64: dts: medaitek: mt8395-nio-12l: Set i2c6 pins to bias-disable
Date: Tue,  9 Apr 2024 13:42:08 +0200
Message-ID: <20240409114211.310462-3-angelogioacchino.delregno@collabora.com>
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

GPIOs 25 and 26 do not support pull-up/pull-down when those are muxed
as I2C6's SDA6/SCL6 lines: set those to bias-disable to avoid warning
messages from the pinctrl driver.

Fixes: 96564b1e2ea4 ("arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 18182cf073fb..86f7d4dd5eae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -528,7 +528,7 @@ i2c6_pins: i2c6-pins {
 		pins {
 			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
 				 <PINMUX_GPIO26__FUNC_SCL6>;
-			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			bias-disable;
 		};
 	};
 
-- 
2.44.0


