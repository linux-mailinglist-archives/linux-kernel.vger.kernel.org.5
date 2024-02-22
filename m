Return-Path: <linux-kernel+bounces-76683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345785FAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8E2286E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802941482F8;
	Thu, 22 Feb 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhH032qX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AB148FE3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611587; cv=none; b=GLs86S2gPXZiz9LEVF4Wm5m5UVGoz9TXYdp8w46P05q6YU8q7WuAbLp4yUB4gYAYdenmIHD/J7cWM9NIr8EVD4BZ27T21IozF0rXZ/6xIJk3vunZTwbpf7HTRwDj0HPe5mlkkhN6vWFGWYRsvcDQRU1yh35qKDOSb2ivDOcLmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611587; c=relaxed/simple;
	bh=7zuRio/YC9dKxpTczQCi+EW95Tb0CgPeF+kjRH91dS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjewmMP7X7PJJ8cDKeua3wSQsyigmnlTHqZwt4OL/U6BZ7sYGD8pCVTgcr8tUb7I7dmxQJNbLwmfeJF0Z2snGOpKX4jRe2xLPhXjiV1ECc3wMdBEU2XfUQ8PDHgIQLnNY1sZgvwBIa/GW2HtV7kf3gbSlO2B9vLEW2+yjKljjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhH032qX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f829cde6dso92987866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708611580; x=1709216380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em+oLMU0Ctbe0IGKzRk8PkwOLrG5qQYA4R+AhRZWikk=;
        b=FhH032qXj2ujetvXEeWXKv3Joal+PqGSP64xs7+vN/u52gmDKebx7PW2Tdk0fea3AB
         gf3Tyn/LNtgFYKPrf21aFHvRsQGVs4ckSqoLN/IdkloxWyOJ2XoG/3HNVaE/tO189r0c
         5iVT2SY5qRaK0Yp7j3fDh2CgVAX1ktUoYztcOOZ9rGq1A+R1/k2tt6vfvI50EtNCEjE3
         HhJOPFJhXscvvn9AgjZ6FLQQqW9GD+Pkm6kUMwdbucSy3pATJLGlboqp6OR0Xhl7FqVj
         tr/qD1G+E4zNw361xEKibHOEx3001+IqHjbPhPEhKGzHBecciqrL3JKfsaLMxh08yEK8
         H7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611580; x=1709216380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em+oLMU0Ctbe0IGKzRk8PkwOLrG5qQYA4R+AhRZWikk=;
        b=JV6ZhnCRzR/BG2F/kmmcZe4FLzyqAZNkSpdNWciqThBSHDkod0MinKcxkNRxNm1aMs
         eExWVANDOQZbtZ5k4GbNNVmYFbIzowiT8mjzGCQXm39w6MrYt0pdScqJglgHrvDiePzS
         GEs5cMg6J/V7NugdAGmY4055EAZtjHU6b8ORZs4S2j2NaTn5AUsP22r6H1JUZetI94nV
         LnFLKwUIdMFkzGB4kS+uRArldfHEymYe6JjOkYstFjlTlcFjdFi5HBVFw91Bwh8hWfCH
         FDO3/LHLOQmEsM8rbGvMqDdvIULR4dAxkDbU8xarhbc8Zi+5qWwqiVOyXIiNteibY0H2
         pvsA==
X-Forwarded-Encrypted: i=1; AJvYcCXGQoXAkQA5fRoJ0ODzZyjENmW562LQnD7+Yoac9cTonOi7Xduhzzy4NsNFiJa6qgizcj6v7nmgXOfhviRgf40mgpxsQlhuwhBIFUgW
X-Gm-Message-State: AOJu0YxqMNGJdquS8477xDssiuqo/b1Ua09S2b7v2qZohOJZ4kz1dzhk
	MNZ6oD7C86T0WfHdxHdk5q0YD0YNI3pEuUJYX5BXaqe4J602TVA6b+CkidtF3vg=
X-Google-Smtp-Source: AGHT+IEi7ObQmrjDV3EI7a2VmG6QF44ehmeUfAFUQfyZM9dnBA9t6Pllcxvx4VpsO6cVEZl6oXOTSA==
X-Received: by 2002:a17:906:d8b4:b0:a3f:3acf:c58b with SMTP id qc20-20020a170906d8b400b00a3f3acfc58bmr3122657ejb.13.1708611580371;
        Thu, 22 Feb 2024 06:19:40 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a3daf530fd8sm5992588ejc.210.2024.02.22.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:19:39 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 22 Feb 2024 16:19:19 +0200
Subject: [PATCH v3 1/4] arm64: dts: qcom: x1e80100: Add SPMI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-x1e80100-dts-smb2360-v3-1-85a691d4f68a@linaro.org>
References: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
In-Reply-To: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=7zuRio/YC9dKxpTczQCi+EW95Tb0CgPeF+kjRH91dS0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl11f1SQcUEkIia+/V4BLdSK0l3uRkQRkIQ0I9e
 THTx/0FeX+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZddX9QAKCRAbX0TJAJUV
 VkyvEACXc9N9a4AaElTAUxALqmqZ/Vwqn/FwPDD9eLFDqa7XHTn1Ftejc3KDSOGFpTJw4KLzX4l
 lXGoHlAVfXeOIm/QhGSg4a50jZksgPVIN0blf2+o22aU49HIh3VeI787Tx1IzYS4jk+k+vmfEwD
 K6wM1DWrvHyys4rGTX02ntBkxvoDeJ+6rxfneijv/ATu+Rp6Pp6f5TzUJ3qVAw3Q/HckmwAdunX
 iJX4LhsD69DOE6qfPEEYSsVeNYXr8PIR3KYEJ+9TUtkybWEZwdOuacyHcfwH66REXVxIZDxvq6G
 Sl5CNYxefYwceFusEGQXkfPcs6P2zHKftPAGpF+JcCHbQZ7N0dafUzdbkvfhlezN5R40eLw491A
 9SCasbRiPoqyvYgNP/lcPwTN8ZZZgeWN7ykOAMdaMNqSZ08NoiV5gD/KtXx0uQ4k4pjCb+r2Fnr
 bDd2hOed50oofWSDRP2GwwGNHY1ncHW9fJcaMaSmYeB+HYswEpsDCI37kCArC0M+IgKD0hr/GYh
 idIG92eCVcUoQ2+XI/U/XRyeTTB68IiM920ZDCi9Yx7nijWceiygT9tjT4428Oll6F7ZmpT9CQo
 fm0sZKsLfv+g+HNlyia0L/ktZNJH3AiQHJ2B6/wmzW6RSQcbslPsiqpGVjtB2q2Ith5FoNcKXh/
 yBr7icxNMhkRIEw==
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
index 8e517f76189e..1665bd1eaad6 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4221,6 +4221,48 @@ aoss_qmp: power-management@c300000 {
 			#clock-cells = <0>;
 		};
 
+		spmi: arbiter@c400000 {
+			compatible = "qcom,x1e80100-spmi-pmic-arb";
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
+			spmi_bus0: spmi@c42d000 {
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
+			spmi_bus1: spmi@c432000 {
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


