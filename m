Return-Path: <linux-kernel+bounces-101607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7D87A94C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE71D1F20F11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50446BA6;
	Wed, 13 Mar 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MO03A6vl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B23F9E1;
	Wed, 13 Mar 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339347; cv=none; b=DwLyESGIuoqwnYSQtsQXu5GpppC8HZ6332QKZhseLd6zsbLFJFVIGQZCUOzZHj162S2hy2dU+KX1AxWClkziM8QURV4YxI9NsN/1o22wxk8oDpkJkZiC9TCJgZiRHVSBeYxCQscklk1UFBCZEBstxiAebdqbb9/4oOkXQ2x1kgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339347; c=relaxed/simple;
	bh=n4FuiB7K0drjcCak0GaKJlMMx8Pa/GKxrLH1nXgS5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHUiYys/oFJXVFOrqm1ioTC0tEAhVlJaVulvCr1D1lnuflAxqt+u5KmRAZUtLwh80gf4JhSYxehhT/3f/g5m9o1OXfguf0ZzIKpFSeeuyxfd9YGOjrQo4GqR+WSZhmcHRBGiheGw4LjkOHx9ue41iJZQ4SBKojfnNmqaQdaBHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MO03A6vl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710339343;
	bh=n4FuiB7K0drjcCak0GaKJlMMx8Pa/GKxrLH1nXgS5pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MO03A6vlWbcEdyv72y5bh5Tyjc3t3GHSWzTDoeTYyPIa5PCt5BtERBCHa7oa6v3qR
	 T4TQzKhNvgZnTOcxzp47VOyHmaEvSgjSB7gT8swH7s8AjbL4Z4UPJRR/FBAO6BBGDw
	 lomFmnuRlsmCdBg5wZs7/X62RA6RLkClqcF3iihtYtunFQBJaYLVRtPPH0GGJmlxDA
	 XBgTqa7XxIMS2DwzNUOxtGLbfka70ZPrPOe8oL+A+Pjy4My0bWVfAeLQj9C5W1+GQ4
	 SZwB5UqBAV1JzKmPVmeoNu+5UQAFsFUqvt437HO8s/p9N2EVN0tOu0OGpxPUq5VMgp
	 ZFudSGpHbcEuw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E65237810F1;
	Wed, 13 Mar 2024 14:15:43 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/2] arm64: dts: mediatek: Complete chassis-type for MT8183 Chromebooks
Date: Wed, 13 Mar 2024 15:15:37 +0100
Message-ID: <20240313141538.1438167-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
References: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the chassis type on the remaining MT8183 Chromebooks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts      | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts | 1 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts     | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts   | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts      | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts       | 1 +
 11 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
index 072133fb0f01..f34964afe39b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google cozmo board";
+	chassis-type = "laptop";
 	compatible = "google,cozmo", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index b595622e7bee..72852b760038 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google fennel sku1 board";
+	chassis-type = "convertible";
 	compatible = "google,fennel-sku1", "google,fennel", "mediatek,mt8183";
 
 	pwmleds {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 5a1c39318a6c..757d0afd14fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google fennel sku6 board";
+	chassis-type = "convertible";
 	compatible = "google,fennel-sku6", "google,fennel", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
index 3ea4fdb40118..6641b087e7c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google fennel sku7 board";
+	chassis-type = "convertible";
 	compatible = "google,fennel-sku7", "google,fennel", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
index 3fc5a6181d7e..877256eab262 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google fennel14 sku2 board";
+	chassis-type = "laptop";
 	compatible = "google,fennel-sku2", "google,fennel", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
index 23ad0b91e977..b981dd31a430 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google fennel14 sku0 board";
+	chassis-type = "laptop";
 	compatible = "google,fennel-sku0", "google,fennel", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
index e5bd9191e426..f3ac9c074226 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google kappa board";
+	chassis-type = "laptop";
 	compatible = "google,kappa", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index 8fa89db03e63..e8241587949b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -9,5 +9,6 @@
 
 / {
 	model = "Google kenzo sku17 board";
+	chassis-type = "laptop";
 	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
index 89208b843b27..928b205a616a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google willow board sku0";
+	chassis-type = "laptop";
 	compatible = "google,willow-sku0", "google,willow", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
index c7b20441d053..71307a8052d6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
@@ -9,5 +9,6 @@
 
 / {
 	model = "Google willow board sku1";
+	chassis-type = "laptop";
 	compatible = "google,willow-sku1", "google,willow", "mediatek,mt8183";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts
index 7739358008ee..5a416143b4a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts
@@ -12,6 +12,7 @@
 
 / {
 	model = "MediaTek kodama sku32 board";
+	chassis-type = "tablet";
 	compatible = "google,kodama-sku32", "google,kodama", "mediatek,mt8183";
 };
 
-- 
2.44.0


