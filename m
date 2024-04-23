Return-Path: <linux-kernel+bounces-154375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FEA8ADB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908C6B21299
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCC13AD8;
	Tue, 23 Apr 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bGD6OuMS"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02BE576;
	Tue, 23 Apr 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834029; cv=none; b=idhrlpsgmwSwzYiY5HfZ+l349FxH85n3KXFiLKqcpV124JiF/CVxF9M35/DE+1uN5nKTuysEo6nAUh94K3iTFxipjHj5wpMizXFpUNPMikI2600ZpPbXG7iMu/w8Qyj8ut520xjNHL1KRqUUrawj+6KnWrTqYKra6b7aUjbYNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834029; c=relaxed/simple;
	bh=KGEaVSgegAft3nYNYK9EYCKpbfBuKrk5VXpJPxpMFlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGBwpbUIl44dnq18z0FGaFWGG5uEoXMUQs0mGCo/i4/faF2gG+YT9LdeFRPhKf/jcGyKkZbLv6uPrDkVobdE9EuypsBR+gpqdiVjgaoZzkfBKLhbMl3XdB+8+El3EBkp7FVjOE+bgtWgwB9xef+XmUZAFdTuhcolh5+mIBE6O90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bGD6OuMS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713834025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaGNaaJsi50mZ8vWxsRljFanZ5oeKwmG+YpjSdoLUDg=;
	b=bGD6OuMSBh4guc7XcN19L4CsrUsv/rL/LyvRaLj9heMubELOFRcC5RzJj3kIf/8C5cpJ8/
	6ABIIx4sRouxeUDTCELc3PAp6jBn5HNv9G4DO5T8hrQreUymNuX6GhiwDjDEkY0o44Azxc
	1OWgpOhyIXlbpomezuGURFMNEQUVjd2RyIdXHI29ejo3GZD6Zg00OF+XJgbF5XzxO9IpcK
	H6mQyJ4MTPedEgzqbnBm8nXCHZ/aP8LwK6/oh3iuToHHn+WdbeLF5WnEDtmIn93iQuWba5
	biSbNT64qB+uYqKpkkt80Q55LOkNVX3OZWmuBHE0v13u91vVJPPbitPpo18B3Q==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	didi.debian@cknow.org,
	Marek Kraus <gamiee@pine64.org>
Subject: [PATCH 2/2] arm64: dts: allwinner: Correct the model names for Pine64 boards
Date: Tue, 23 Apr 2024 03:00:20 +0200
Message-Id: <f4a7e60040aa7cc1ad346bd1cc35b64256413858.1713833436.git.dsimic@manjaro.org>
In-Reply-To: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the model names of a few Pine64 boards and devices, according
to their official names used on the Pine64 wiki.  This ensures consistency
between the officially used names and the names in the source code.

Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This completes the correction of the model names of the Pine64 boards
    and devices, which was started with the Pine64 boards and devices based
    on Rockchip SoCs. [1]
    
    These improvements may cause certain issues if some scripts misuse
    /proc/device-tree/model to detect the board they're executed on.  Though,
    the right way to detect a board is to use /proc/device-tree/compatible
    instead, because its contents is part of the ABI.  Such scripts, if they
    actually exist in the field, should be improved to use the right way to
    detect the board model.
    
    [1] https://lore.kernel.org/linux-rockchip/06ce014a1dedff11a785fe523056b3b8ffdf21ee.1713832790.git.dsimic@manjaro.org/

 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts           | 2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts            | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 596a25907432..4aab1f98fac7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,7 +5,7 @@
 #include "sun50i-a64-sopine-baseboard.dts"
 
 / {
-	model = "Pine64 LTS";
+	model = "Pine64 A64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 50ed2e9f10ed..a3c1752fc5d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "Pinebook";
+	model = "Pine64 Pinebook";
 	compatible = "pine64,pinebook", "allwinner,sun50i-a64";
 	chassis-type = "laptop";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
index 6265360ce623..86cc85eb3d48 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
@@ -9,7 +9,7 @@
 #include "sun50i-a64-pinetab.dts"
 
 / {
-	model = "PineTab, Early Adopter's version";
+	model = "Pine64 PineTab Early Adopter";
 	compatible = "pine64,pinetab-early-adopter", "allwinner,sun50i-a64";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0a5607f73049..ebeb04156eb6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -14,7 +14,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "PineTab, Development Sample";
+	model = "Pine64 PineTab Developer Sample";
 	compatible = "pine64,pinetab", "allwinner,sun50i-a64";
 	chassis-type = "tablet";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 5e66ce1a334f..411d97610be9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -8,7 +8,7 @@
 #include "sun50i-a64-sopine.dtsi"
 
 / {
-	model = "SoPine with baseboard";
+	model = "Pine64 SOPine on Baseboard carrier board";
 	compatible = "pine64,sopine-baseboard", "pine64,sopine",
 		     "allwinner,sun50i-a64";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index b710f1a0f53a..52d81ff0d77d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -6,7 +6,7 @@
 #include "sun50i-h6-pine-h64.dts"
 
 / {
-	model = "Pine H64 model B";
+	model = "Pine64 H64 Model B";
 	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
 
 	/delete-node/ reg_gmac_3v3;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 1ffd68f43f87..f8b524d02429 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64 model A";
+	model = "Pine64 H64 Model A";
 	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
 
 	aliases {

