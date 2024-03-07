Return-Path: <linux-kernel+bounces-96190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF287584D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D48B1F233D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6813A253;
	Thu,  7 Mar 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeF0tkYM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F5137C43
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843201; cv=none; b=FIuyPNCTmVjZIwIwX6SVAKkJPMBtL9I8yDhPmlax1MRew5XwxSFpwuO+5lWf8yzMmyfxPTxSicK0lHx+lNMXSvCSucph6+kwnMiDvkiiqhc7Mh8BXXGmRiZ9fg0PIFxriOXuGz3usfkFmaHDaX8ltEhqZFuQDlz0X1Eku3k5Ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843201; c=relaxed/simple;
	bh=8/DGQ83cSrSaq7LKUH+VcyTeHlJ4+6SBCpMrcm8Id5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0eMPZEKjVKXmAtJT54Jg24uQ5Xvq8pX+Zx93qYez1J/kzgrjz4qWQXLHB0XzUOek3WoijKZ0VQ/J3hm7nCv6QBglqOAY34OK94ugkyNikO46GhxIA/mZtzGMq/QK7XtAHujw/Xx2IPaJAuINcpdFG+A5kKy8FmeYmPdXgr5Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FeF0tkYM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51364c3d5abso1414853e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709843197; x=1710447997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXLwWeiszGpI6rrdYGEs9FVibKJ/VcRC9EN9PxgZG1A=;
        b=FeF0tkYM7p8K+uO++OZ+5ekUyR1DFYG/YzA+aWPOQXeW/qiIZpWxAhmJW4QSQL1m8F
         K54AIDCUW7xBfSeFn92dcNV2mawKKHTXo4f2kYXkUmjWlq+i4DGldo/H9LpuJzqNl/UP
         9un2Pe1hL274UPyaElKN1lVzOJUNloP5IbZ7snDh2cQuyqbxAtrdUUi0YrrEdHbGLBQ/
         cd9EvjQvBOXxGQeMyh6Se2qbbZCuYlteYGlPq3QzMzagiCcoWN3LcDLb8yDf398CROgD
         3ZqHKqn9WqM7mPm/Mw7s1SwxJwKXCaMvsKzO9xBYa5o+2zVIMwrcDYkZjUyWt+1OqBTn
         sOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843197; x=1710447997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXLwWeiszGpI6rrdYGEs9FVibKJ/VcRC9EN9PxgZG1A=;
        b=H+/4RBL46JwGZhou3IBAGlb/3atfqNZdmcexR0wFr4TaGJysAA74mkH0ACX3khVflb
         at/4OdYvZdoU5Dm6bSHl7xU4kO39BQ9YS+KnqmP5SwQDihmbDmmCrAsr4aSAgcvroE+G
         iZsMzP0WTaS1KTdKUgF35Uxmcg++/jDXMEwFxLqsINOGWI5A+i8rFr5qTZS8a2DfmSBP
         ES5mSIAZWFoMlzJrBaYTg9Ly6FxDLqZ/3GaqdXHbh/769SLBkDEgfF2KPMoIeYZPoTST
         OmYK2Bh7kL4+knGy50JZ70REPYJiVu72021JOYsuRFuthhsBSJ7wB+dBRujSv2iG2m4o
         oKGw==
X-Forwarded-Encrypted: i=1; AJvYcCXeadfIegMPUq7N6VCYFwxi50wo8utLHjW3tXi2pOzLkGBSsmbxPOEIZW7zPgeUDUs7EkEYIPut6NjVkR0A3801o13KcZU/WFWtWi2+
X-Gm-Message-State: AOJu0YxYH5AzzVOltyGd8al40xtVt6fU1AXg3koUDi+mEuRDUj4FTMdW
	CeTWaoNIjyp6xkffyRxJrD4uLe6ytknaAknVSUcPEO6lXLA7IlXVyU6hEy//nb1HqnWtlT3V0Qs
	3qJc=
X-Google-Smtp-Source: AGHT+IH93hG+h+Zy3uBuBwbbaDvrwkiy3pPB5UMxB0V3Sm698sVGTruTmwRMuXQR/YJ5ItnZI0ed2A==
X-Received: by 2002:a19:e047:0:b0:513:5b81:f2f8 with SMTP id g7-20020a19e047000000b005135b81f2f8mr2139044lfj.54.1709843197150;
        Thu, 07 Mar 2024 12:26:37 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id dw20-20020a0565122c9400b005132bf9f8dcsm2957606lfb.303.2024.03.07.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:26:36 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 07 Mar 2024 21:25:55 +0100
Subject: [PATCH 2/4] arm64: dts: qcom: sc8280xp: Add QFPROM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-topic-8280_nodes-v1-2-4eba20e08902@linaro.org>
References: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
In-Reply-To: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

Describe the QFPROM NVMEM block. Also, add a subnode to represent the
GPU speed bin region within it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a5b194813079..a3725d917bef 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -862,6 +862,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sc8280xp-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@18b {
+				reg = <0x18b 0x1>;
+				bits = <5 3>;
+			};
+		};
+
 		qup2: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x2000>;

-- 
2.40.1


