Return-Path: <linux-kernel+bounces-114792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB488913F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA31F2D13F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B41B6336;
	Mon, 25 Mar 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKpotazP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB831276C5C;
	Sun, 24 Mar 2024 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323397; cv=none; b=KrzmcuVcUQqwUbfW9Hf3SUc3V36CvyadvtPfRPQOhtiSsO5XFPwZ1CW4uMl71kE/5Yo8eC9s8a+0Ash9qKXCeMW4vk4l1TmAQHnDqDFBDrT2LqF7uoh6zsKj/gfTmUf/7yGbb5kFdG9Zjc8cLPfIqSP4LwnUSUJq3+KjHvBZIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323397; c=relaxed/simple;
	bh=40LNW5mkr+cn5yL6VNJJ3x2qDezR6Sa5tciUR0reDR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4ELbbFNfwPv3sfJgWY9NjGpqCVnQU1C8wP0E+/CbLFl+fkHK48i06AGRMs75H/qlipvlM1Ry07OjKBVzpGy8a46JcC4QykU1ZLevfR3NjLenVszpWW5kaQN0xJHVBX250L7PWgQLFAAR5JaOvOnLk/d+5oV/mzvBBvwoETQ0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKpotazP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41AC433F1;
	Sun, 24 Mar 2024 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323397;
	bh=40LNW5mkr+cn5yL6VNJJ3x2qDezR6Sa5tciUR0reDR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKpotazP5jyuxBWWmkDY9iwGemJabC9Vv9rhxyDcxWzWHlrChjUM2rFC14J7/XmNo
	 guWnwGijQmZmDfqpvajwDRBgEtPIsqeEsBCzDxL6fGoNcqET2F91a3YNZSwkKiN0z6
	 WCrjrkbURtj1zzoEAuuK+5P3/VGSipZAi9oQcAkLmNFohTxZbCWJChUW5W2phjz+M0
	 WFWpVABFmtehm1KmfcXZpaa3dQ4roNJZ2WE0ID65CtD5hg8oX7+5iwTKwhzzBKemPe
	 O1XIV+p5Fxu1UR3EX0Tto1SKPpW/3DkH3YQ2BKBROpOvpRs6X0Icb8/GgAL63EQqfD
	 Aw1lpJU/fYutQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 098/317] arm64: dts: mt8183: kukui: Split out keyboard node and describe detachables
Date: Sun, 24 Mar 2024 19:31:18 -0400
Message-ID: <20240324233458.1352854-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index c1153580ef958..88fca67dead01 100644
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
index 28966a65391b0..4b419623c8dcc 100644
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
index 3aa79403c0c2c..e6e017260693c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -338,6 +338,12 @@ touch_pin_reset: pin_reset {
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
index 30c183c96a54c..51bb2c23712c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -342,6 +342,12 @@ rst_pin {
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
index 30a84d888c66c..f70f0f43aa52b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -931,5 +931,4 @@ hub@1 {
 	};
 };
 
-#include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
-- 
2.43.0


