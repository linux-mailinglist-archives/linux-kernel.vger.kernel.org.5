Return-Path: <linux-kernel+bounces-45872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D884375D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293B81F21A40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E796EB6E;
	Wed, 31 Jan 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vypw+YZr"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291E6EB65
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684964; cv=none; b=ZhQCVgyedW1YQ0UrIksoxRhNtuBucKhMxWIDwpF25Ava1e9R7E6IUbILqjxcJxzMCHEOOqbitNiu5x01dN4h4NJHXhrQ06/Ge1LbuQnMdlazcYWxtLjVfi91nPkCJqMKOtWHERUicp1hIQ1sEad6U9aMTeTxFkUHqph5QBuQJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684964; c=relaxed/simple;
	bh=5wbR3f4WW33GGHcau/dlVX6ejvxsZODVew8hP0iyu30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzvL97JyIcZL3ZBTLtAj8iM7ZtHfOzBRGVqKvs4XimiVltfgoDSA23JlCf+GUBg2ker4rtEevAMcb41//Htl+8zRLT0CwTXai6zGJJkJ9FAva6SzUV6nTZYObxqeiONDeUnlyw0V2p43N0Q/Ae821I1ieVEl3ordnBHtC8HnPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vypw+YZr; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bda741ad7dso4017370b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706684962; x=1707289762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By2qz/vvhRjEPGW0+7mtr6OKhriVYbn3cusAD58pKKQ=;
        b=Vypw+YZrz/aSEfwP8MmY6H4bZ1e/vAkw0clqqzOFaQK56w8IrrtarTOEEpUZQdtzls
         Jwtb3VwrsbHWQpWi0oxNZY/qf2oVVtXMigAfPBPm8jv5/ejQgz4+XSw8x9t7WRIIac4b
         xXptcoQyb1bjfj1RJGpkSQodvi+PQHD2SA6Uy8MJuM3q4mYcmC637b9dJBQsGj/yov8v
         ajcEwxLybfeZpz7Fq0qqrO2XZU0PHU7S6ZzYO0AFU9vdD7XP37YVb68ukBzCWqBrezyo
         2IxZiYU9eA0bLXTcoForTB1jJmFe2h+DRBXfh2fQuFvGkqurlDRqsAfhUBi+tcWqoK7n
         3nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684962; x=1707289762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By2qz/vvhRjEPGW0+7mtr6OKhriVYbn3cusAD58pKKQ=;
        b=u58/1XGM5qem6JOYZb+YCeBnbDcFz+k+QdLQbZ9y4MS1GzFkAgFQJvgvkrat1uzNR+
         1WBjZaMqCzXbzJpl4Yd47uDJ1kcyosB6Ui326qkshcjH10v4WQZ4saBydwr3FGedbbPI
         5mH64RxGp+OKeIIm0AhPn2BTbQSYlnuXOigdaUvgBbHPznweOeYSl4CRDLUeUNwGfKBs
         w68N2sjNCSVbYFdYWigBaaInNGxG/VxYckN2ECaWEnZTxYI2UbG/0/Esz88slHvIXhqU
         zjTIj4LGWz/uCbRwFO5vXX2FMm6RdIwQTzO6Nul9NnRQUkgKybFPFU+TF+alVb57BMgG
         hgFg==
X-Gm-Message-State: AOJu0Ywbh3vsbLqQednkTjNRzMtw/Tw/r7BetWtbTL0tKz6yasv2HhM/
	LSe4RyqVto5fg1vzhstHHK9Cokl98g7qnB9WYWwQ1qE8XLBSh+S0yJfdl4DsiQ==
X-Google-Smtp-Source: AGHT+IFc7Pb2WMzbrtd7ampAIBoyCVgaoFRQIr5Fh3lsPV+AX2fcxD43nyyuB/iUSnkSJaBI4ZhFmA==
X-Received: by 2002:a05:6808:220d:b0:3bd:c19f:2fa3 with SMTP id bd13-20020a056808220d00b003bdc19f2fa3mr972423oib.51.1706684962159;
        Tue, 30 Jan 2024 23:09:22 -0800 (PST)
Received: from [127.0.1.1] ([103.28.246.26])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm9087956pfb.46.2024.01.30.23.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:09:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 31 Jan 2024 12:37:38 +0530
Subject: [PATCH v3 15/17] arm64: dts: qcom: sm8350: Fix UFS PHY clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-ufs-phy-clock-v3-15-58a49d2f4605@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5wbR3f4WW33GGHcau/dlVX6ejvxsZODVew8hP0iyu30=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlufG+ICNR7eXSqIf5LkQALNH6WwX5hS65s0f1P
 gR4bRoFmd+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbnxvgAKCRBVnxHm/pHO
 9ZtdB/9rx0FMamEyvNE2jqwXSD23OtJPpAeAr9uHMNnP1rK/dYROtanBVFSUFFJBTE1YtKurm8M
 GmB4ukc1uVBQGraGxO2K2m+shVq8/Mfi9CeDe2rWF/F4+D8ObSrOkyGViInOxOye2qDXOEMGHO3
 lvbtm1+BNv2O62BDqePZk2u5S7ugjxeS163tUCEbJCHTfUwuWHScpuGkHE5XorYoSxCiFT5yOCG
 qQs/XnNQyc1i5XLyi0iOkOtXgk1urCndOUplRbH5WFWgIS0dF/UZLahpTRItvVo4MDCUG0pTYbJ
 GkkOBT99n6i69R3ksSt4cw+FXmhAO+QsPrigtmB2zRsj2YSC
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

QMP PHY used in SM8350 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 506400992596..65d425f56583 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1746,10 +1746,12 @@ ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sm8350-qmp-ufs-phy";
 			reg = <0 0x01d87000 0 0x1000>;
 
-			clock-names = "ref",
-				      "ref_aux";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1_CLKREF_EN>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";

-- 
2.25.1


