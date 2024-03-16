Return-Path: <linux-kernel+bounces-105177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C887DA18
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670912816E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797C17BB9;
	Sat, 16 Mar 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yT6QNQ2b"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0617722
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591053; cv=none; b=WyG8ta9OwGsFoPbbstFcVHmsH2oB4Lfn3qbpM1e8oD8jD+Vme4qwwHQsDd7M/G1AdcWlByuEHiD9ds5H2f9Xr9Tx7OSvbMBpNgmkr4ZWbm4IdDP82XBex7Kc7HOuEzSTccjP7r+CG8AVbaefi5DJfnj8HntKT5LIjN8YrHNMI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591053; c=relaxed/simple;
	bh=fktCCbDv/VIuSyXY3tYWs4IVqhS8SDqxMK0qvxnzbNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eqOAHUy5ss4pbinlQgHPRp+lZvL29y5E3QN6ljoE2RMhyQNpYWWjswM+SDzKuJjXQ2tSob5cOXQ/1ZUBS3NZOXJSPc3SShr1gNbultd209aEPqNouegb6zp21UoBes28jbVS/7X2fzx6dQGQsvb733t8Y7gOtTx3d5e6cQ3s8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yT6QNQ2b; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so37525971fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710591050; x=1711195850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDpnnflX/d44C9t+bbp3CWw+BJoJUiJIyi0Tnl0vMkI=;
        b=yT6QNQ2b2ReX/W79tosz/REgxreL28Ozk3eRP9wmX0kjwJB1a0WuXGDvbDktnsQ1gn
         v+NDeVCa0pm1R1wQLVQmQDrO0bRWBbqML4eztgaLgE444fRPpJxuSpgdNv6hS71Z3bRj
         r84XlW5wlhQdZuFtrKo/oDzHTWfSQLd/OUtY9jfZefTKQeqERz9bV04TLq81fWpwTaBM
         WafnAwcbRO7wasNwi+nCDDQmbS17R1jtd1WaDn4bRzZQjkZt/Trzkey+ZTTNC+LJHA3O
         zNfqu7I23dVwrD4O7Nw6Q9uM5LR1BDB0snLUX+5gS43zKXyI7tgzE3m7HGwj3fvVG/cZ
         cDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710591050; x=1711195850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDpnnflX/d44C9t+bbp3CWw+BJoJUiJIyi0Tnl0vMkI=;
        b=mPzP3SZYaIrpR/OhPJIp+0YHob5xgA9P/zkOMDkfBv8JIfZmFHFKCYh4jzI+GUsUJ3
         DFNd6NPEhFKRpBIcDr9I/MZpSo0W/1Hmgt1akKlgiH8S+GjpNq+6EvXbUktZaYFIXv84
         0SPNf3YRm8Q3iqNp3tDVvFdIhtTGD027VGBdZ+AJiHocTxYpkGsaxXPFm7vevVFKhOy/
         cPtiAZowj5ZjpDaNFqE9KpiwemJ7xzudIL1BP/FHRc7Kcuby9NCou8RnTv0pP0JQNltw
         tWMMjmcsUvhkEq5hTcn2zOhPJtiXLrl5/lxnNi31IFa4LQqEuXhnJbEqGRcmcpuqcUNN
         uIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyMZI2QmMdXc71Y1hOlSRI2Hl2DGlpM6FKOHtRvTmBiptjHluXxDEPI6k1vbJBUJFMp+8aO7mHdrSsEFJ9splJK84E4Xd4I6LgvC7
X-Gm-Message-State: AOJu0YwovdAFES/1pUqa9UzF/vBPx7TqPU4gBHJsmG+rK5ZeKd++G7tB
	SFeVAzZ/DIs/+GUDNyTFeGUh8E9qGcJc3NRcB6+D82Dxu+Kdck2Wu15DyfOHRsE=
X-Google-Smtp-Source: AGHT+IEcAO04rh698adudsqeA0OCLfkC2mSxbb70R3fbi4/BAOaySoscZl/ZJMdaztL3d23VKxoD6g==
X-Received: by 2002:ac2:5e24:0:b0:513:c658:799b with SMTP id o4-20020ac25e24000000b00513c658799bmr3497844lfg.55.1710591049663;
        Sat, 16 Mar 2024 05:10:49 -0700 (PDT)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q13-20020ac246ed000000b005134263d56bsm945284lfo.224.2024.03.16.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 05:10:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 16 Mar 2024 13:10:46 +0100
Subject: [PATCH] arm64: dts: qcom: msm8998-yoshino: Enable RGB led
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-topic-maple_led-v1-1-ca3430fd9dc5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEWM9WUC/x2NWwqDMBAAryL73YUkPsBepZSyJqsuxBiStgji3
 bv0cwaGOaFyEa5wb04o/JUqe1Kwtwb8SmlhlKAMzrjOtHbA957F40Y58itywLnvyNnBmRBG0Gq
 iyjgVSn7VLn1iVJkLz3L8N4/ndf0AVcPOQHYAAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sebastian Raase <linux@sraa.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710591048; l=1354;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7POCFrK25iWDlgWo1fz1erE33bL/FqB3Pzbou7z2qXg=;
 b=1y3D449unX2u/4yzer9iQnPZsjeGGuEasxQxa95dyYh2Jbc37yqg4ImMS4imagsy+2Xf1LDKp
 Tk/+TI8L2thDKJgi7oB+hH9r88T6H6xoHas5AUIPj/2hb5XxJkuw/wk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konradybcio@kernel.org>

Add the multicolor description and enable the PMI8998 LPG to expose the
RGB notification LED.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
Depends on: <20240315225237.1616550-1-linux@sraa.de>
---
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index fdd3953938d9..d8cc0d729e99 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -418,6 +418,35 @@ vib_ldo_en: vib-ldo-en-state {
 	};
 };
 
+&pmi8998_lpg {
+	qcom,power-source = <1>;
+
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@4 {
+			reg = <4>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &qusb2phy {
 	status = "okay";
 

---
base-commit: 6a2bcf40b85ff77e3f32a2fbced3faaf3f59b43c
change-id: 20240316-topic-maple_led-f54a21620dd9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


