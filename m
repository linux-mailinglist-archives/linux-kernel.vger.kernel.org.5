Return-Path: <linux-kernel+bounces-138169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F2289EDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38731C2174C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7513D8B8;
	Wed, 10 Apr 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AE8fvlol"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993613D60A;
	Wed, 10 Apr 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737814; cv=none; b=XGRCkY32U5n2kVdQLAQjYqjBva6Pu8FzH9GaouiJ7O3B5tQID9NEr6FLxtKjgSz/WzG7ekoX3o6Aw9QZCIUG0fNO7/SZJfmZcjhMkIeTpLEEVU55RosfRACAe/8MZ0LAXABubdSKdTTo7tixBc6JgrkD5iJ5XD6G87UjyPuSTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737814; c=relaxed/simple;
	bh=+nU/7bNYGGkqgDvePENQLG3lijjBSCCDYfWzHR3Q5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJdI3cXL4uoudOVLcCTgiBje69WTom6vXmMH8lQ9Uo9T08H4lbwjvTCmZ3TNqIE4K13v2cBqEv61WoB0ljre7IQfazFK/QyaNa1nwl6OdN8iUCvHz8FIwN58NpEiWCdd/igQDTw0PR/EI/COvkKXlt2pEsHkZcGmMGTkoIeh508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AE8fvlol; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712737811;
	bh=+nU/7bNYGGkqgDvePENQLG3lijjBSCCDYfWzHR3Q5Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE8fvlolajpaZ0UHcpOutZ5YLh0h2EOsLJfr4dn0DyNGKn7ELAmdA+6n+ZyXcTc3i
	 TMften1Ff6dqXwhGWuidRTqYol6HEKFpkFa9Oh1mNEK4ATgq3acAQ7yt4eJ+jT/MYW
	 A0N0FbrCyT8sRBRn7BKulmYi/1uMt79XmdH4MtFx3V7Dag9VcJaaZyH+5xGg+3Utb7
	 YC3f2yI07bdtfJfXhbw2XTJFdPzxpdMzK11igcGxUZ8cUaGWjEoqWNWceT5eUgdDr+
	 TWZTy/tF5/ieEgGGK4zaaNVSVldJqVygTGLuAqYE0Dn1hBo8sFZs7cVVmszBrdAOmT
	 /E1+rV3GBjljw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 73C933781453;
	Wed, 10 Apr 2024 08:30:10 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bchihi@baylibre.com,
	bero@baylibre.com,
	amergnat@baylibre.com,
	nfraprado@collabora.com,
	michael.kao@mediatek.com,
	mka@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/3] arm64: dts: mediatek: mt8195: Fix GPU thermal zone name for SVS
Date: Wed, 10 Apr 2024 10:30:00 +0200
Message-ID: <20240410083002.1357857-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
References: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This SoC has two GPU related thermal zones: the primary zone must be
called "gpu-thermal" for SVS to pick it up.

Fixes: 1e5b6725199f ("arm64: dts: mediatek: mt8195: Add AP domain thermal zones")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 30ee39045e7b..d3254ff74953 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3877,7 +3877,7 @@ vpu1_crit: trip-crit {
 			};
 		};
 
-		gpu0-thermal {
+		gpu-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_GPU0>;
-- 
2.44.0


