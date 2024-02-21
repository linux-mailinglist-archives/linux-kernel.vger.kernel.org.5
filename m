Return-Path: <linux-kernel+bounces-74912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB485DFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F339D287881
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC117FBAA;
	Wed, 21 Feb 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCVvOEOb"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCE7FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526339; cv=none; b=t4wEoM9sMrBJGRUi2id8Ikb+0cgKqOf/1uUJQ7G8rU6uxTeQwGaQnLdbXFvPtFkGq0Wvs9/L51JFMtjgk/lrGbv15y5FF7sCjAjh/7Q54PRIndTk3GLNYtbsi2l432aj2csGGzzaTR6tbM1GhYPeQOhNMruI5UB9k34myzasX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526339; c=relaxed/simple;
	bh=tpSk0M3zSnSlVM7y9XJMuhxS2XPPkzW0s2tzL4z3u1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAy8d2YKsf6iCuXbNZUch2gpEtJqwePYahvR/CZ9N5pAIXuTKwKx/uw8WCUQjCjK6AJPsg4Go7CcPfBchJybzDt6IwTdkui9igEjPUHErDNWfS9v2AsAX3WRs5xlbviwOPgTbjgoaWBNqtQT6cS6aYcE82IIqx0vyLTUFHDmjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BCVvOEOb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f299f828aso139380666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526336; x=1709131136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhBPs6M2gk6rH7s82ekTV9UmMDiSMSdO6mX/HtcFuwU=;
        b=BCVvOEObhbWHB0tthm0dFxdXXMva789IWo8RwSzP2abRQD3pWkb8XpNfDH3gvrUrHh
         9Eab6dZQ2yFPxtHJDZEnfWjpxSefR4cbA8KAJ/t4BP5xkSiY2RqXFaM698EtLU2PUykH
         RST6oOUDmw25h0N55kb4OhwkYEMKwvtZmvx3XHdfKdvFkqfsXGkveIObOHxhEcqCtBnV
         v9omIU3A5hnExz61rUQ+7mfbmKHib9HObF+bjpoDN+Klyjyx7dh4pbHp0K8uurUY9uuK
         rDmnFb5s9Ek7TSB828ZSpVlsz21CdryI0rrC5O2qpzAHcysK9OABCphl3pBq7e833w5j
         wOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526336; x=1709131136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhBPs6M2gk6rH7s82ekTV9UmMDiSMSdO6mX/HtcFuwU=;
        b=jUdxVtACBFGR4ua0xGFBdFeaIHN8j3DM6jDkNnmF2ms+kjZ0wxc+oRdXKS8a5YXOvu
         KrBOwDhvNaQWhLm8ilO/819ULdpFewcaNpEn1i4RwJGpnihg1PPl+GPMl8/R5INv0VrK
         kOQkch+iSMtnVqApsMt+n81VQeSOJzHq4Q3pLl5l2FdCzckiGjjiIWz0uGs4gRvLmwVo
         TChX/Q3PEX8xya5r6js3DAvtY8J+O57aF3qkwNvs36SpAEtmfYUIM8j6eowUUE8Lgt5r
         k+ceAoGx2wbZ8NDKjChGRx6jRTZSrAJdgMrO+JU9o0Nx46qa/U3io9chz5j/cvrQQ5Eb
         2CpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJioYzudj1UhcqVD7gWu/ekgO7nhY6md8gWb4XfE6O6zJh6RawdMcE1jfC+c1LCO9biI0F2qZ6Fe6Ut0/u/TkqEiKyDB8HIv7LHBZ
X-Gm-Message-State: AOJu0YxMtBcPNK0NkNtbCZlSkBJeJdWHJ/bbnchg3t4P36BQA3BGfXls
	PrzsTBiDavS3fAZSKX6onU1Z4bk1EAlB7YmISrgr/9gZ9vNkm1xAKRNZPOmm1VE=
X-Google-Smtp-Source: AGHT+IGjKUlXy9lg2fFYmpP0KZOibyKT/DZ2/v9F1MVXMJ7fcG1Elhrl5rOpKQ2SQtqxHIcO/zQMcg==
X-Received: by 2002:a17:906:d8b4:b0:a3f:3acf:c58b with SMTP id qc20-20020a170906d8b400b00a3f3acfc58bmr1209784ejb.13.1708526336223;
        Wed, 21 Feb 2024 06:38:56 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id wp12-20020a170907060c00b00a3eb953335esm2653970ejb.44.2024.02.21.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:38:55 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 16:38:31 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: x1e80100: Add SPMI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-x1e80100-dts-smb2360-v2-1-037d183cc021@linaro.org>
References: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
In-Reply-To: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=tpSk0M3zSnSlVM7y9XJMuhxS2XPPkzW0s2tzL4z3u1E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1gr57hJ28ZZZcZcrzgpopRaMSDJxbHVq87S9O
 mxO5sDiOj6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdYK+QAKCRAbX0TJAJUV
 Vgh9D/91MjIC8bAbJKaJbMBGUxh63ygCYOecY7d9iDeksK2FOiry3RzuW93kGvKIU1ZwV+Td5b0
 WnTRpnO4ocO8mXNHYsYEJ7HUcAv8QJtPA+SyCn/6Y3+cjc8hpRlDBN1rlBI+fb+plUN9qGPOE66
 URFPmwv3ObfOhpNao+fOMZVSpKpyTXPc94tGJwg0zZjUn2IkEpf/CdfGaSXpYsVxPhs47+v8+Eo
 wOOcDpfSj1HOCtIPCXzSBeIZG2g4wwF7x+Gj0HOq+hyV/mPtZxEVH0dXxef5qRn3cr8wfDmVgIg
 5Gh53zgsIXQ4gIaSbLM5DOsEwMyUSeFpoLJkpbEFIEKpRW816usO/YMILocb+UqntXo2MjB142n
 NAl4I8HCdXJYrmbzkgXGg0pwApA2l96TuYPL+GzCYxTtcSumJzDlTll6je6xDyWmZ4f7ZT/oIFY
 q+URjC2WNzQfCROIN58MwwHNfna/niCsHC09pJrBQSGgBzpVqds8lojacY33JqxCiUO1svVTG6t
 317ft1H+pLLiheAocCd97/sXADRUKwib4w1lfq9Uyf+uSmF3NQhW8Xd3BZQEDCfPjlnrGycWv81
 EDeMKjXM2KGTbBUES8rI987GnSLl8tt1etKixlPuZ/HcTRFOmBi8M2xLt8ilXHppYsQFnZ1fK+0
 QG5otkc94YMG9NA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X1E80100 platform implements the v7 SPMI arbiter, which means it
implements two separate buses. The difference, when compared to existing
platforms that also implement v7 SPMI arbiter, is that this is the first
platform that actually has boards with secondary bus populated with some
PMICs. This is why it needs to have 2 separate buses as child nodes of
the arbiter.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 8e517f76189e..d1c012fd71e6 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4221,6 +4221,48 @@ aoss_qmp: power-management@c300000 {
 			#clock-cells = <0>;
 		};
 
+		spmi: arbiter@c400000 {
+			compatible = "qcom,spmi-pmic-arb-v7";
+			reg = <0 0x0c400000 0 0x3000>,
+			      <0 0x0c500000 0 0x400000>,
+			      <0 0x0c440000 0 0x80000>;
+			reg-names = "core", "chnls", "obsrvr";
+
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			spmi_bus0: spmi@0 {
+				reg = <0 0x0c42d000 0 0x4000>,
+				      <0 0x0c4c0000 0 0x10000>;
+				reg-names = "cnfg", "intr";
+
+				interrupt-names = "periph_irq";
+				interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <4>;
+
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+
+			spmi_bus1: spmi@1 {
+				reg = <0 0x0c432000 0 0x4000>,
+				      <0 0x0c4d0000 0 0x10000>;
+				reg-names = "cnfg", "intr";
+
+				interrupt-names = "periph_irq";
+				interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <4>;
+
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+		};
 
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,x1e80100-tlmm";

-- 
2.34.1


