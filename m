Return-Path: <linux-kernel+bounces-115858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508088984E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468D01C31956
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFCA37F7FE;
	Mon, 25 Mar 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkWgnL6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59B535D6;
	Sun, 24 Mar 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322068; cv=none; b=tRdgUdKMYLykBI6VxQaCwsZDW3G+xdWWxvLlcHxr+T82ggMjnST2bmngqyFLmnUG44N8/ZA19WNxYcoG5Lab2nkrNK1amDsxPopJ1YDoKgD1TPGpbtcpVGYQQycumwdDFTKR4KvsyiNRmkvF0xbJ3tWBY2PwLIcmh7N9tDIJr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322068; c=relaxed/simple;
	bh=k/1149o3J3CwTsV927N69j7If6yH6EDi0cJzlDfc+/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvMKcdAGJ98Gb1sEGqnuUcCdieIVvXwAJ2Op5X3P3dWFNJisKibHPWQO49OFr4kzmMGf82DomvlhKi1/Y0DPJgbKwXFeTDHa11XUO9Y4liLVnQw6Oy7lrRphM+Ho4GzlVIc2QVNjbxBoNHThlv2UsSfOtsODcr/8j4ouFbBilM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkWgnL6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE56C43399;
	Sun, 24 Mar 2024 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322068;
	bh=k/1149o3J3CwTsV927N69j7If6yH6EDi0cJzlDfc+/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkWgnL6mwEYQgcNj/huZv4InXfMrswmSziZNo9/vRSjyUY9AzTLH1H641BLFlmQ3c
	 3K8BySz26V3lQjwg8Tt0TeCe428hB2o3RHcXjUkLc5fmr3iVqiS32p7AoyfaYCJwho
	 4Lb6hQMHM1knRdZ/q7Q02xHGijvlQJCvH05vPS9mQDvW+r5zcwz13XhoA9nRpunNmH
	 zFGG6dtDld2fZz0U1CVadiRrUJGTKvy+v7gxwG3JpJBKAIrqDc0vGsNBeP5eUaNJ9R
	 oaJKcOd++OB1z40AvtGzeMthvBFJI18HB3ATCCAhYkPV/mJ6y/vCS3f1C3ID1DVvmi
	 sf+tQlS6k0LWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 141/451] arm64: dts: mt8183: kukui: Split out keyboard node and describe detachables
Date: Sun, 24 Mar 2024 19:06:57 -0400
Message-ID: <20240324231207.1351418-142-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit 82492c4ef8f65f93cd4a35c4b52518935acbb2fa ]

Kukui devices krane, kodana, and kakadu use detachable keyboards, which
only have switches to be registered.

Change the keyboard node's compatible of those boards to the newly
introduced "google,cros-ec-keyb-switches", which won't include matrix
properties.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Link: https://lore.kernel.org/r/20220527045353.2483042-1-hsinyi@chromium.org
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Stable-dep-of: 04bd6411f506 ("arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  | 6 ++++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi  | 6 ++++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi   | 6 ++++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi         | 1 -
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index dccf367c7ec6c..3d95625f1b0b4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include "mt8183-kukui.dtsi"
+/* Must come after mt8183-kukui.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
 
 / {
 	panel: panel {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index 50a0dd36b5fb3..a11adeb29b1f2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -372,6 +372,12 @@ pen_eject {
 	};
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_KAKADU";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 06f8c80bf5536..4864c39e53a4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -339,6 +339,12 @@ touch_pin_reset: pin_reset {
 	};
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_KODAMA";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index a7b0cb3ff7b0a..d5f41c6c98814 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -343,6 +343,12 @@ rst_pin {
 	};
 };
 
+&cros_ec {
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "LE_Krane";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index a428a581c93a8..de610874a9125 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -999,5 +999,4 @@ hub@1 {
 	};
 };
 
-#include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
-- 
2.43.0


