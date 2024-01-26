Return-Path: <linux-kernel+bounces-39936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114983D79B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3044C1C2C76A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DF25574;
	Fri, 26 Jan 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3ozpM+h"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1D24A1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261929; cv=none; b=FW7eJczGfp+q/fGXpPpUQGR4IZ1lAvznirhuI1N1yAFtKJX9uvohmEWLnyVQc+qsWymU0AG5j3s1uTgomgMi0/goF5WxF9hbfyTidMYJAesE234SVgyL7uI2oQG1UIBKb9beiLPH+0qgw8wWfBzgSzwMXihrHvcZhlSsZsE3F2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261929; c=relaxed/simple;
	bh=oUA/GaBGkFvaGwcavZv2QERuR6XAZ8QB50VXFuxN0Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6Q0J+ySRl6Qc0iAjxvZz/f9Q/u2zcRKf/dz81JgF6Zt+u2WGh/iSmL0vl8szkaBsES8vkuaGnPDnOe+XLewhx10pEEskOZtA7LXHkin7CyVAubfRXwW9qAb3iR0kJJ+CKsTEaY8/HmhEiPaTrqxJNzIj9+XmepBa0DmrfTjAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3ozpM+h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3510d79ae9so224366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706261926; x=1706866726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPCmkIZ2BTfr4vragKTZ+nwQkoDopVxL0r8M8YgvZA8=;
        b=a3ozpM+hMhH68EayeC3zNkDewOZ4mg+61BFc0qZa3lVWxEXmZq6SKvAnT/XKeRVHSN
         OR7VMhAG/JYPHBjLaKuYLbJRQNTZmFatqyNwsOo4Q6J5KeBtmEUr/3CT5jX+BX+rhiKN
         Q+MPx3YyDt/0sycFcifysGvqykoIgl6VqrNcRgxuNBathuDQvv9tGGdug+QgAcCjghO2
         f4dHUbdpFptpHFa5YzmsJttYuxlTq/s+eWnamCWYyjA2RSh1KQvJDnjywmICW0oqx/+D
         D+8h44Bv0hyIDqxm+bB3hkhl6h51VmVREoA4JeyVCnviMu0CJXkZWiSqZq/582AUcB26
         FiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261926; x=1706866726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPCmkIZ2BTfr4vragKTZ+nwQkoDopVxL0r8M8YgvZA8=;
        b=a9bTP5it2JbrlMdDHdUJBLsH9Hjame7KqHEGv9UYHPLWg4WqDF1gPyMU04WA3nldij
         c26oacHpvJjYRe3gthvEsRWeyOirf2gFx5kpUbwtG61nBOArNB7Q9uFf2c5Wef37zaBH
         F/k+dSb7eZZm/YAVO0HHV76j7xn5DElj2q/g7Vc5pbC2cf5ylseurqUG3Xj+C64AF1R2
         W3jw5sdLcvlMi3JrKk1NjjOS8WZO15mseuSi3knS8tuFvO421oohUu0izjbJlDON6jLl
         56QydUVE7m/GO9+ZblnuEZvmJgvP2JiuuPFBTBa1XyXjNnAAZDBP8fR40o2SohanBGC4
         XeGw==
X-Gm-Message-State: AOJu0YyQ+A9lFTVB+ZKc8M6hQNlrGrQGiQQZE81fUxYuhhm8QFBJQKve
	wzDxAvWz1BtTxfIYT7qWc/wr8D9xt+8kZDusi5ONDAznSGgMXVuWHMk4KJdn+oU=
X-Google-Smtp-Source: AGHT+IHOQCKANQeGGX88wSHVlKDFwY3vM6MyR6E4YQ+NQhY9Knlw0phFsHyK3uDN0uvBkqqoJLMkiA==
X-Received: by 2002:a17:906:4112:b0:a35:6c3:9656 with SMTP id j18-20020a170906411200b00a3506c39656mr195237ejk.59.1706261925965;
        Fri, 26 Jan 2024 01:38:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm426768ejb.199.2024.01.26.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:38:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 10:38:31 +0100
Subject: [PATCH v2 2/7] arm64: dts: qcom: sm8250: describe all PCI MSI
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-2-0bb067f73adb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oUA/GaBGkFvaGwcavZv2QERuR6XAZ8QB50VXFuxN0Qs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls32cs/vmdsMfVh76Cjm4lrslmzscNpfDqvoCU
 XfTqkbjN7SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbN9nAAKCRDBN2bmhouD
 1whlD/93ssYZGmisz9EnmgjSqH91cpWXaYZRmHViB5m14a/TSxCOd56E9KpLU61QvwuYqeFBTUJ
 UGDVNMakMEWUfOSPLBiciP6wxC5sP3twE+VSgHA3AZdbLTZNC5ElLVjb8+EXD6q7NnM6b1UcXpI
 OwVyDhpp0v3QHYgDNv4IXlfqt73gOxjvLP4+ZXHy4ZJ04s+uyCI+M5f+5ynGjVUjXraOJBZPJZd
 gI+1bH3t25jabfnQgeNxu1/HXzZ0NL60RPxGe4UThRD8kNCXSFrJh0UvEyQG3wiLY7gSbw2spCW
 L7Uhrdw3I1p3fh4B1LJnWzZ9QIVmSjB2Qs62931DctZU+lhoNBHcQ8CSK0i/SaLYvcpJNAJNm/i
 pHgHIaaMyLMe1uTD2NqbJwwBb58cNpX5520zg8wBlK+WCU06zkGKWnd+fjPmwkHN2iwgdB+45SD
 9ufn2h9Gx7lP0/CdXB684WPICOleF16RpfpBQPdWCg7iaGaKYySqBVsU3ST8P9cVbCMRF58pNU0
 5cP5+fsER5WQka0K9ZMwYNIFK83wbTermscGyM8GiZ4s2AhJMWQNqtlRJN/UQaPr2/4h8YLZ9gD
 JAzKxsm85HiUv/Pw0F8fWETZaiCWkHPXrsYosVgp8jPLgqOe7XCo/SXw8BI0uMDdtcnGrAXmnaW
 qrPJGIQVSDU9Cwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each group of MSI interrupts is mapped to the separate host interrupt.
Describe each of interrupts in the device tree for PCIe hosts.  Not
tested on hardware.

PCIe0 was done already in commit f2819650aab5 ("arm64: dts: qcom:
sm8250: provide additional MSI interrupts").

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 760501c1301a..decb2e5794ee 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2248,8 +2248,22 @@ pcie1: pcie@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
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
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2349,8 +2363,22 @@ pcie2: pcie@1c10000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x64200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 290 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.34.1


