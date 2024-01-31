Return-Path: <linux-kernel+bounces-45867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FF84374A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4FFB238E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D260DCB;
	Wed, 31 Jan 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ie9O1BMH"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371D6340C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684946; cv=none; b=TfiiyufjGJGrN5yuLbQbJKuhpv6puoPYvOwLmWiRQMz46u4222XWOljFOzyufxMJpFib7nanYe6xbfqh5URwgvQp+QR5aPvlTK3+0B0ztO60EeHEwJi4MkCvhx3nSI9O9KVLaCzUBp3dx3/9cjG9Og4QJ3iQHcjpuiwOmSw6sXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684946; c=relaxed/simple;
	bh=ROl06bKVN5C5JMVM/k0aozEkWtTHx+mchi2GT8R0eL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujQpMs3TOsIr5nBuOZxXMpf0By6jUXltLddBM9KsGbwlCr8CXzJGDdP8Xkr6I8g+pQFa4lCacfz6g7nn/j5daJ+jnX5/vcha5klfF4ggLuvlp5Q3xIROIBs/2kRvqOBM3PqwfbVKhKG5gqWYErqvQxUWOCquIohD5cvJIIIQuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ie9O1BMH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddb129350cso2943625b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706684944; x=1707289744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9oRSAu04dlCPd12GT5wZXY8U+i0UJEJNPn5iJdXIgA=;
        b=Ie9O1BMHkoW9pJr2jmDLcbg/LaPtxc6M5VRjZ5AK6NxQu3Hq1ZJ6toTs7hghp5Nc+K
         BG8s0qqShF0rQgxzOBWTq/XKlGbzPkzEwkcYrdy+FHTDNoNsjy2slGQjxYCb3JXtyxPh
         A4abz+333oWLI/Sd5g4JkasQAvodpIA0K3666aaZncdqii3gANvujl6Y0fycLPsH+/f6
         3MQD9CGbbCGO2juDzfPMRRvj6/4pfuD3iTuhV8qM7stwWC96SOj4a9xIjOSaTFTKm42D
         dGaXWtb0EB/jEZa/US9ZBaV14argjzLSqmFJlhffUTp2+ykxLV3oXz5+QlOzJeWueqtr
         SrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684944; x=1707289744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9oRSAu04dlCPd12GT5wZXY8U+i0UJEJNPn5iJdXIgA=;
        b=JpOR4lTK54sTKX6ydq0tC7yXsqmhYoY678GpBxZzAdo+39TtabxxIOEKEvhj1JMG/0
         w7iM7pOj1lB4oaADyRTayS1NEo973R9kPbsSpJuGK0U+AL6JlrrP7HOS61Z3RtAn8Mcs
         LV5O9YWi9vfYb1FFuskn6uox51lMWzjDj87GOBWfY5uNDgeD7LOKmu8fN0HwuIyTY5Nt
         E+QRCsxYI38/XHTfRNSd+jUG2DRmTSyWzgrtQOIHPJXTazBcgt3QZvyhiSpYhqTHYVZv
         mJpD6nBdBzAMp7XGHmtIpuEcENZ+C2H+RghHuVD3XCg8u9ZP+2MFt3zQuUJInc/YulUl
         zJcQ==
X-Gm-Message-State: AOJu0Yz1Vk/LJaw53+Q2QoSzT3R/cJ4xfaVf97CJJXhU5peMPE+t0lk9
	RkzFJMqrcyPB3Os2nqURF5TWEkdGUt3B9osDEOBjTCn6SeDBCYjAOIG3c6/unA==
X-Google-Smtp-Source: AGHT+IHZyBeQI6x6hJT6GYjp+TEq7RFTYqHZ3UOz5mdIL2YfygnxhP80fmM1OmJz57MlcaGiJbIX8w==
X-Received: by 2002:a05:6a00:938b:b0:6dd:db87:6356 with SMTP id ka11-20020a056a00938b00b006dddb876356mr1201124pfb.7.1706684943548;
        Tue, 30 Jan 2024 23:09:03 -0800 (PST)
Received: from [127.0.1.1] ([103.28.246.26])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm9087956pfb.46.2024.01.30.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:09:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 31 Jan 2024 12:37:34 +0530
Subject: [PATCH v3 11/17] arm64: dts: qcom: sm8150: Fix UFS PHY clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-ufs-phy-clock-v3-11-58a49d2f4605@linaro.org>
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
In-Reply-To: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, quic_cang@quicinc.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ROl06bKVN5C5JMVM/k0aozEkWtTHx+mchi2GT8R0eL0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlufG9iupD1/Y4aBPSYlnuMUF3Udkm8VJwVjvGz
 uoQhWBDgyWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbnxvQAKCRBVnxHm/pHO
 9YyOB/47DylBxJWasrkUuurfb0gcQALAFgW3b7qLrDKrxTl/uNX6iZj7wgH2YdtS3/PK96mUaXK
 wB7CxJOcNjN/25xYGPRnyCTK/qkRl7jwXKD1YuMsE0HQaWYjQSTehD6GZwk9OpoGc89D30CmNjY
 2krUhFisIhqOYNl+MMZYPcJ48WnsA3uJFiYfjCVE4CKhdcfGrsFEgz2MZf1BpKWi8gNXQdRHYES
 O88WjY1ujPXxjyUL9/GZRdqqbpucDSRDJsqtU/pwFgR6pvICvAmRqz4mMFY+L808ETRMIthPUpD
 hbkKONYrb2Wkwd+OH5Ih/Lonh4C+dr7mr2PvDZLPL5AgXY1J
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

QMP PHY used in SM8150 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: 3834a2e92229 ("arm64: dts: qcom: sm8150: Add ufs nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index ad1af87991ff..eb1acea2631b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2095,10 +2095,12 @@ ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sm8150-qmp-ufs-phy";
 			reg = <0 0x01d87000 0 0x1000>;
 
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				      "ref_aux",
+				      "qref";
 
 			power-domains = <&gcc UFS_PHY_GDSC>;
 

-- 
2.25.1


