Return-Path: <linux-kernel+bounces-39940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1883D7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2841F2F38D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2367E9E;
	Fri, 26 Jan 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eW9AakYd"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEED64CFA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261937; cv=none; b=ReOoIBG0o4QbjmkkDn5PnY46vcJws1C+ALDkDUD1HNsA/vueHgO1JfnixT1hK/VcbL9RpCvoQQEZnLIHHDOyf56JOg24tofW3mQS+NZ/hP5Jn3B6GG3ad3RmsUiW6yaY9rOTKCADuaVFieXz5xy+TnhO/XePLiuU0Cqyip66fEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261937; c=relaxed/simple;
	bh=4449UScTTEGM5kZZoyLU0xXEQfqky887G2FwqhxVQzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKRrk7SEJIT4nK82yLWJImn84opdmUAN3SjQH8hBsZ7uZgtV+2TZ1zEReUiFID/2KB8kqdaCA/5xA1Ot5YF9Sg56beyZ69xija8cs0gcq6LYTwEyugfET2iGOehjtSgxq5/L+dVGzT73Sd4YXKk4vALHO5WvD8kgtRI8uPbrOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eW9AakYd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so15095666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706261932; x=1706866732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SU0QZ/C9JHR+wXOt/l6AbaKKe/yMkJBOBv7GjvM4hjc=;
        b=eW9AakYdTKT4609RZDcSM1M0Xa3J0LC/FpbOSBR4vnaiVhX6jiWI/w204mhAdS3TBJ
         y4M8p1tvfHJGHDmilB9oFC06IKzsBUL8A21ZKem1bpOKhDxHL4Ps500o8UWVEEjRoz+Y
         dXgxHYVP7C/AolMsMBrK1fglf5QkNxikG50mXfLvACW7xBHfeH7MlycpyUUoIVIc4FP9
         lqEVGac6aXG+fN9l64WdHeiRCQfEZPpH31ITkiWOBwCn6j/nXmhXRzaGOelr/VomeB/Y
         L9uXQS25oD4fktz3H1+KHSbA8T5X83A/WRycYzLgnYJ3CSCnvyn7UlUH3797zf18caR4
         T9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261932; x=1706866732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU0QZ/C9JHR+wXOt/l6AbaKKe/yMkJBOBv7GjvM4hjc=;
        b=c5tRBziILYMWaLSD4OH778gQ2D9Oixv8HhrNRvF9gYC7aBek4r/eqQSWoLc3rfRQqN
         Y52z73UOq1WikzTiJdJjHKUqUBX9CIFqtAvwehjROKUK3mOTFDWas+aXmOyIymqZClYy
         ou5wiGcICByK3yTAiBhgwSXAiXgP9CfJlrW/MMyxh0LO4iQDoQEP7/BxTs+z5XFswlq3
         Q36eJ/nADjSlevgquXQz2gpm2djOxxVaN5OXfQQ7WHuJ5yIREzlN9xJntkQp93X6eQL+
         LlXyut7YcHF9qTDTasyzhBx2soWiM7BXMa7QLKyDWT2HuelzzBfte1Xk3qYLWGrJof9J
         2utQ==
X-Gm-Message-State: AOJu0Yy0hiIyYpfVHpdgsE6M6uBv6JVK5v2/Ca6dlP+9gIRRT28S7KDa
	t0CrDakfWRgQTggKY+Mear6oHVH83451HsiyjAAODooRfSxToME+eFfUeJRRmNU=
X-Google-Smtp-Source: AGHT+IF6WMg+EQloM2Nfov3qxjumSbvSzaj+mwT9SUnJkZPl3YgID/ABrmbwxei7lFTdWWGOQbpXDw==
X-Received: by 2002:a17:906:1d0b:b0:a31:5b30:6f54 with SMTP id n11-20020a1709061d0b00b00a315b306f54mr617313ejh.30.1706261932364;
        Fri, 26 Jan 2024 01:38:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm426768ejb.199.2024.01.26.01.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:38:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 10:38:35 +0100
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm8650: describe all PCI MSI
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-6-0bb067f73adb@linaro.org>
References: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
In-Reply-To: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4449UScTTEGM5kZZoyLU0xXEQfqky887G2FwqhxVQzY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls32f/HouX2kiquOsLRlva4BDb/H0zwhQPUv+g
 DtS/w6Fy8GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbN9nwAKCRDBN2bmhouD
 1x0gD/4xWYzaMlIWsbSjIZFH2QFtUcEdZ6Jl4q6NfuOEe//uDaFv5ZSx/ofkrgyeQ1yT4sdK/+I
 8W+HdiiXZVgTrf6puCN+M3JNTFHUM78i9LoPAAZLcFzo3h81T0CjwNj7eYqc0TUKC93HfVOmKUM
 90srCof7cDHSgU4aan3GBV/prIsPiAHRuY24c8x3gwiFdY7p+OdKnC8gUkM04tbJeaLlVE2v0Gy
 e3Kz3uLr9kPo8HBc/UvgrQZhMhcQDnIu52owgO7Pg1NBB7HjUQEuESVeqNIWPlKPZyibSR6s2/J
 zaZeonVSARkXCbqAYDssH/Bl+HBjlG+wyFfuM/hFGlmPaBDE6HAAb8u8/wx9bFFOrWhP7qiwt0F
 lj3qe214ui8kfLb8G7YKw+6Dv3ex8gD701bLMEZyUi5UK5NmB6aE67WZgetAeGwpkX+Ed0c3bdJ
 /iPypfDVtEYk6welMZhWaVmpVu3EowtqPBtuc5C+JJMA+mp5CC+ch9IV2cTGkJFnhVOU8FiDSk5
 tvJGh0Q0kDjWzuFOmtXKKMPNtDzZ+zg6gQWRrZwhdclc5NoWoMnahqdM5O8QLVH7W531H2WH3jm
 CadJ8K4RCv9BV1RiEaEua55bwrepvcclZXewzFltArLZzwQBgojW0FjDptH6SkN2Vc8IZn3/xiN
 rKKcap3pxsxEYGg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each group of MSI interrupts is mapped to the separate host interrupt.
Describe each of interrupts in the device tree for PCIe hosts.  Not
tested on hardware.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..942e602bfc97 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2213,8 +2213,22 @@ pcie0: pci@1c00000 {
 			      <0 0x60100000 0 0x100000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 
 			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
@@ -2317,8 +2331,22 @@ pcie1: pci@1c08000 {
 				    "atu",
 				    "config";
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,

-- 
2.34.1


