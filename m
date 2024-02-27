Return-Path: <linux-kernel+bounces-83396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A659869822
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A702B22395
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65548145B11;
	Tue, 27 Feb 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVaU9pZj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9613EFF4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044053; cv=none; b=EK+vtZukc4hxJ/utkna+xf99CkfDZ0K1N1ZaSm/i3WmOEw8Gwi4uJKnsGeDDHGDh86Y/SrlFnwBWLtqqCT/pTwIV3z4noGmnWul1kZWaYXoG0l5FDEmblkYPhT+ojRB9vb9wv+mULkM0/iMgZ1IxcshiopsonO6KP7SH38GGvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044053; c=relaxed/simple;
	bh=bsf32Y7coVxxTSmKbLEaQtO9FBe/PteLHrHMoCJPWNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duWnYz6W9yDE4k4NovFlEVO6M6ShtBSgnafJliH3UeygwUhLPzcCJLAALm5JwSwVlamA0JwDGINLCeiBWhoptD1Zu8xrHY6sN+h/RbtCICGPzw151n3RNYcT3RHrxtj/NA8g5ZwQ7h8+w4bFWJvqGNysAcFCvWKeF6yn7/jdAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVaU9pZj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so4644737a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709044050; x=1709648850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33B8gJG0ZgTkJiJm72SjJZHXMoaZN/mFMW+Qqrnw2t8=;
        b=IVaU9pZjuhsJ1zFdWoQuozQa/7/tNS0nLICblbHILCW1ry233EHzqkgoT8YUpqGBKt
         rhGoXZvL6bWtUWfYfK/cfnuSiA+/a0Ocw/1a1qQB58Y44jTpiNZDEI5WLHIVSghsn3ZM
         0iSlcEIYdi1HSh+YUO9uhlrwIGCluVz3B+9V4nOV2ypHMuOgxyeH1sWBxs6soA0ogbhV
         fc5ivc8DFjr18AAdn3ALiLJmZia244q7SzOQgREktIAFyqHkN98yqIr87QF6mIZdgM7l
         QAYMcWfOJbdsmurYm4L3MHu1HqAdrSFQMwCps1oSGgYT4+Mj75PwD6YKuQIuuOdeq81K
         fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709044050; x=1709648850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33B8gJG0ZgTkJiJm72SjJZHXMoaZN/mFMW+Qqrnw2t8=;
        b=nP2rfii781XP4NUHPDwW+TfmOO9g6yzetwxxraxymUrXlTm9rfnaVoYjR8kncyAAfE
         jMVj8OIhhM/J9OlGYRI1RMwBWXgHxr/giwXszdwTbWYSMs62yuMokz38RAOslHSOh58Q
         rAJtISx+kUftXWmCyVBrvK4xTIC6c8vYKRKwugIyuZAzJrCiLqp3RZzIAY2jiorzR73i
         P5tDBTO2PalE7dGSj+8tml68++MKKa/O7xOC4yhXzYxWmy5CX8Ict1HCXDp3LM44aW3l
         dBvWk92gdswLjvdRcV62IZ+uXncjqpj6iI42tT3/DDvhK8K/NjoJTJOJOORcbZGAht4T
         Xxzw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5qr+iVE6+7h98hjAYztSI+vUXeAwooZn8Rlu69mDWKtcxZlSKA+bPNEt0S+u8w5iEbKHlUc9BVHKuRBB02CUtzcovCfxI0U5fGwc
X-Gm-Message-State: AOJu0YznOO58IC8Wi8FYfAE1NHHRFiVkTcKGuEssdRg7LKYlq7uSmSUK
	jFInfj/qPtx+Qet+nRmahOijP7ejYPhKbYqZMTnglub0ASYY+uXob900kU4N3wA=
X-Google-Smtp-Source: AGHT+IEij7029UEKKPfIsg6SV1R+vPsLyeR6KBl+70fxTzEzohEkoVCooioBYOnozthxWZTZ/05cSw==
X-Received: by 2002:a05:6402:3456:b0:565:7116:d533 with SMTP id l22-20020a056402345600b005657116d533mr7046605edc.6.1709044050058;
        Tue, 27 Feb 2024 06:27:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d550000000b00564c7454bf3sm813689edr.8.2024.02.27.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:27:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: switch WSA8845 speakers to shared reset-gpio
Date: Tue, 27 Feb 2024 15:27:24 +0100
Message-Id: <20240227142725.625561-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
References: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each pair of WSA8845 speakers share the powerdown SD_N GPIO, thus this
GPIO is specified twice in each WSA8845 device node.  Such DTS was added
hoping non-exclusive GPIO usage would be accepted, but it turned out
otherwise: it is not supported by the Linux kernel.

Linux kernel however supports sharing reset GPIOs, when used bia the
reset controller framework as implemented in commit 26c8a435fce6 ("ASoC:
dt-bindings: qcom,wsa8840: Add reset-gpios for shared line") and
commit c721f189e89c ("reset: Instantiate reset GPIO controller for
shared reset-gpios").

Convert the property with shutdown GPIO to "reset-gpios" to use
mentioned Linux kernel feature.  This allows to bring all four speakers
out of reset.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Dependencies merged by respective maintainers for next release:
1. ASoC: commit 26c8a435fce6 ("ASoC: dt-bindings: qcom,wsa8840: Add
   reset-gpios for shared line")
2. reset: commit c721f189e89c ("reset: Instantiate reset GPIO controller
   for shared reset-gpios").
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index d7ba45953277..266a461f4882 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -802,13 +802,14 @@ &smb2360_2_eusb2_repeater {
 &swr0 {
 	status = "okay";
 
+	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
+	pinctrl-names = "default";
+
 	/* WSA8845, Left Woofer */
 	left_woofer: speaker@0,0 {
 		compatible = "sdw20217020400";
 		reg = <0 0>;
-		pinctrl-0 = <&spkr_01_sd_n_active>;
-		pinctrl-names = "default";
-		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "WooferLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -819,8 +820,7 @@ left_woofer: speaker@0,0 {
 	left_tweeter: speaker@0,1 {
 		compatible = "sdw20217020400";
 		reg = <0 1>;
-		/* pinctrl in left_woofer node because of sharing the GPIO*/
-		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TwitterLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -853,13 +853,14 @@ wcd_tx: codec@0,3 {
 &swr3 {
 	status = "okay";
 
+	pinctrl-0 = <&wsa2_swr_active>, <&spkr_23_sd_n_active>;
+	pinctrl-names = "default";
+
 	/* WSA8845, Right Woofer */
 	right_woofer: speaker@0,0 {
 		compatible = "sdw20217020400";
 		reg = <0 0>;
-		pinctrl-0 = <&spkr_23_sd_n_active>;
-		pinctrl-names = "default";
-		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "WooferRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -870,8 +871,7 @@ right_woofer: speaker@0,0 {
 	right_tweeter: speaker@0,1 {
 		compatible = "sdw20217020400";
 		reg = <0 1>;
-		/* pinctrl in right_woofer node because of sharing the GPIO*/
-		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TwitterRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
-- 
2.34.1


