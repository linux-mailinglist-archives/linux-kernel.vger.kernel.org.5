Return-Path: <linux-kernel+bounces-154374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58598ADB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A41B20D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35A1095B;
	Tue, 23 Apr 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z9oXWbiB"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DAD26A;
	Tue, 23 Apr 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834028; cv=none; b=JrkLOYibx/f02CBEa/yrk/t5jwLPUU7foKp+i5B+4nQwy/yJMxuk1YMZbb+/+5S982FCX3M0xrN/tY/aq1INfXEPoDRPebjEgVFsiYQ++LPOrt9bdHnQ6oxo23CaivLtQDI8LyNYOAu7yexIjT6aFxiQjehlVsz6qzycSdvdMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834028; c=relaxed/simple;
	bh=azzotw59+fIUctTzsp336N40GiSS/5h+GVjPdzV0YX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NHrJjBGmJibbWW1eNiFoxinFvJ36IupSyC+/LIqGPCIHVTHjIqzor0q4v80Q/+Zn0k8cZN5o1HUhW5kt0gl55IfcX8o37aAArEG8xn2Z3qsaK/NZLSFFlVB0EOXXnDOOMjB5QvSvBmusx6dMmPhN9+on1zoXYMOxsVwMyGOKVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z9oXWbiB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713834025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bo/IwqMdn2PyKSW/xDDhX0TDb5wE3TkJGLlooZNGiQY=;
	b=Z9oXWbiB3ZDNO6H9HQmVypjp8rIzFHBSbSjy23n5y5kpSXxvCntecFqB1ZgeP9z5yOsm+d
	785u5UGpt+cZb+SZtqGTRwVlE09nE+mKpSgDdWqmRWGGqh8zqKWmhadJR0HnHKiz6nx/jn
	3bqixgl205iH/hJ0Wnkd1kWYEFGUcXjv9exyG330G1qHb+7qCs52C/Ar0rulpUImszKM0R
	DXDXVRBSRMIxEBwiKjLcjPOgWuhRyFgfv4iRPck39Nb16soWtshkHI3/uHPnYaiqFsYZ7a
	857jHjpyQ9q3k9U8m1HHQh/J8+Mc+X6G8Vn3q9sCjkR4yGJ2OkIkmNqJ7JAv4g==
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
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
Date: Tue, 23 Apr 2024 03:00:19 +0200
Message-Id: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the descriptions of a few Pine64 boards and devices, according
to their official names used on the Pine64 wiki.  This ensures consistency
between the officially used names and the names in the source code.

Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This completes the correction of the descriptions of the Pine64 boards
    and devices, which was started with the Pine64 boards and devices based
    on Rockchip SoCs. [1]
    
    [1] https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/

 Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..b66873ae2d71 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -709,17 +709,17 @@ properties:
           - const: sochip,s3
           - const: allwinner,sun8i-v3
 
-      - description: Pine64 PineH64 model A
+      - description: Pine64 H64 Model A
         items:
           - const: pine64,pine-h64
           - const: allwinner,sun50i-h6
 
-      - description: Pine64 PineH64 model B
+      - description: Pine64 H64 Model B
         items:
           - const: pine64,pine-h64-model-b
           - const: allwinner,sun50i-h6
 
-      - description: Pine64 LTS
+      - description: Pine64 A64 LTS
         items:
           - const: pine64,pine64-lts
           - const: allwinner,sun50i-r18
@@ -748,17 +748,17 @@ properties:
           - const: pine64,pinephone
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab, Development Sample
+      - description: Pine64 PineTab Developer Sample
         items:
           - const: pine64,pinetab
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab, Early Adopter's batch (and maybe later ones)
+      - description: Pine64 PineTab Early Adopter
         items:
           - const: pine64,pinetab-early-adopter
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 SoPine Baseboard
+      - description: Pine64 SOPine
         items:
           - const: pine64,sopine-baseboard
           - const: pine64,sopine

