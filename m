Return-Path: <linux-kernel+bounces-39937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C251983D79D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B629BA94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52359286B9;
	Fri, 26 Jan 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7NH2ZlG"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03325543
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261931; cv=none; b=MWqW2Iqg8UZdWQMZGpWtEXuV7CKY+p+/9VQnPDOhZjgJRNXxZyPTYyLxQtl394wgKc8163IQh4hfCur/6ojo0ElQ1QnlhK1GoJBBDsupGC2J+0AvsURLtmRYqhkAs20FhJiETr9expRJkhVslTdClmBtPHsd3a/isGpi7HwKLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261931; c=relaxed/simple;
	bh=VP5loI5P/wbfR1eg9u7ftracm3D0KZuQy1Rj2+r2FFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvMxXehnaDclTu8CJON3A3VorQMuvHqZhlozB+24XtkKM6Uo32Cpp0m6RRVjnECOWha0Od0oYxCrzef0WtCNB6MVDt6fLzDarLsmrd8edhWeBLgdyMpJAHzsX45E2AiTwAs7FeKcKBMXEUry/7C+s5p3GEE4lSNwMAUvjzMkA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7NH2ZlG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso1614911fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706261928; x=1706866728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIrFn8/u0zqylTcig4aCZUvXOAI9F+lwhkrMkjO5RfQ=;
        b=V7NH2ZlGEmFyAwkNOeX9Hv0S7WUl0ohnm8oC8D4DRA1w1u6o65/gI5PJ+wu9/6Qem2
         tXAPO0+V4+uQoeWwcZiM0e3bIP3StCQ4j3lf/g8of+V82ycHyjm0k4BsNfGBg+nFJRy5
         xpZLH13UUbPciTgBhAhMhJk30Gcl/zyeAF6XSG72WDwdtwiGFcprT8uhuhpu7QL76EvE
         9guLi97s51oKOwGqHlO1EJqWaLxj2yX0vNLXWGTOeQUhAVPkmHVtuYf3PUbZLYBktnjj
         fhg7NR1r/E2x4AhYz+j1iYXJaLTyuTdVpUA54zjy7BRRbqEjl3gZ3VZ1xzllJDFGW+KT
         ApiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261928; x=1706866728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIrFn8/u0zqylTcig4aCZUvXOAI9F+lwhkrMkjO5RfQ=;
        b=vccDRUptDry7GVwMu76u0836uCCUbxqGxos+fFaEmE9zrV9wcqMt0bf/ZAIPZfTrN8
         kMm01RCGWuy2OaWia9vMpZUZWe1CKG3FblNnv6fE9m9cLwAnNNBVHZGVW/HyADrMGZm7
         5xNrj9swip72Kz0k78VMEcnyoNFvjxI71/jYJyqkd1ri1g6NqBcg31N/WAWkop9dbtZL
         JadXHmEmq6O1RtB6+4L1DHnKfe4TcZcTnbBf200HF7m4zW0ec5Ef33+zEN3OPQWKc0B+
         sb34IqQ/MtoPZhZ02fi8mCqpQFW55p9GpNxNJNWgvzyG+dI6AHhmj9MtibCa+Dtrpqr6
         fCcQ==
X-Gm-Message-State: AOJu0YxZco8Y5IcbMtIvxBY3HTjy4lYzvdt1DiPyV66g/vc4V45b6uSf
	zolunomovIkKDbqmHwoMV/UQP7l/RS7Kpr1EZDY/bLgO26Ojo2yScA/mhnf4V9U=
X-Google-Smtp-Source: AGHT+IGL0fsOX8yuGI1czTOMRxOyC/fkPUyLHnOUaTCGdUV2rvQfq76UkjLlTiRQ0jNj/sidz8iRyA==
X-Received: by 2002:a2e:9047:0:b0:2cf:2db4:cd82 with SMTP id n7-20020a2e9047000000b002cf2db4cd82mr501279ljg.105.1706261927623;
        Fri, 26 Jan 2024 01:38:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm426768ejb.199.2024.01.26.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:38:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 10:38:32 +0100
Subject: [PATCH v2 3/7] arm64: dts: qcom: sm8350: describe all PCI MSI
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-3-0bb067f73adb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VP5loI5P/wbfR1eg9u7ftracm3D0KZuQy1Rj2+r2FFs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls32cKKhpKeiqSPntFfdPzaydG1aEO4i6pzvpf
 7yA2ralHQ+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbN9nAAKCRDBN2bmhouD
 1yX4D/0c27SYTyz+rBPDhmgvFbfXVfBf/zUCIWkCKgl1XlDJLjIimcwF8Sc6Wbt7riDW5eJgSsV
 kUmsagcwCt9sWVNvD79aqhKc0wGqP3biQlStsDotMGVynAtuMJwOCWyGL37uKHNiFkj+N3r2cNc
 GoifKSpyLmtn2+nc+ugq3i3AWY1S3EqUI4m0t9W1qzFADgHZzHcee+RcILvfSyaoKH5eaFjH5ue
 4o+IcbLIqu88kaX8SZZW7LWPCeywAQ3NZSbgLG5aq+XHMb4vrVrjkDpiiV7ryGeSvHlPn/WHG1f
 bmiYx+PLWy/hr0+m6CGfTqMatFxH2jFK1/kR4B+x/+tNh72orMh3fGahOpZdhjZ6dfkOvS3qn5n
 CIwhVxlDpKS0dLUi8g4z1Mlmi8HN4oFpvFzpLBtWIY1E8mYqdNqMzk5VWLTKJGO/0HvcTIyZ/e7
 L4BFr1iNTKOrRGHEzTWmwcc2ogvTodZ6wOzGCp9fEFezyQJMr3YLT2ujP8IC4TjqGdSl5G0X6wD
 0twf9CjXYqjhe4sa1GggzzyDqfCI8Pti5F/Nj9/lGC32Acm6aED7ZbGtM7hloq/cRImopz8JiY8
 lnnoKQhbbdwBt95WtvmTlVPSVaogVd6vAwZ/p1PA8P6NKXhRDY2uPWEoI17bbqiWwA41J6mFoeU
 Vh0xZH+b+Fl0PkA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each group of MSI interrupts is mapped to the separate host interrupt.
Describe each of interrupts in the device tree for PCIe hosts.  Not
tested on hardware.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e78c83a897c2..ad65f6b48e25 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1611,8 +1611,22 @@ pcie1: pcie@1c08000 {
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

-- 
2.34.1


