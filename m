Return-Path: <linux-kernel+bounces-45863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305884373D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004B628A184
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4745DF25;
	Wed, 31 Jan 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2XlTFFD"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F875D910
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684931; cv=none; b=WnVGnSHkobfMf/ejrB074z5HA8VlkeD/5qZMfHWE1bRjyskL/hlRP2ZhTmIc6QQTlqn5lMVncAVYpFkBZ5WqnShhwCpizHYnZ664sM9y7IxOtNfi/+8GzSFP4d4NcDp3sWHVhxTblwFuYMMRnTkVaiW+a+ejt1bzsyj2GR9niFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684931; c=relaxed/simple;
	bh=ntzdDmf4FOP4JYl7D86W3Hb9BDqaLc8AljqlYstG++U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwrwogr214R/kMvIjs+SOr6Bc/sfPcCzzC36C7uKeHya/aHOParVljLW5ZVAbWlARdXBlrMU3YCNz0Czy2vLQO9iNSso1GW1PuDj6g4sE09Sb76DBCm+AJHlMUa7EBEELeNuHzmVzg5fVTPyqehuh5J+l2PG6fM42NvPyfUmfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2XlTFFD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e141ee9c14so558537a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706684928; x=1707289728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oNmgtgCElW74VgkhCqruhhIpDueOdHK2RkVOvuNPn0=;
        b=m2XlTFFDFfgz2mvje7zsjxRJaIBQ7BsQKuVN7AQihYVW5dLuXzn6hHOi8XEDh8FZgY
         V0y0HqJNsQZbfSkcHlBnAZwgc5FIYvpcLU7/B8usr4AWJG+xidmH5AQMNG1Lv0AiqV/a
         PU8Cr+YgeZceKBdaPaWrcLkoxwMBKuzmhRwPCLvTPYAUhkxaEnZFY/a4DUZRzu+631sj
         3spBrzgnaRpT0k2dWVK9yQSmrCm6GfN3PIWvd39991TOjyUqEtU0LOAJlkiFr2yvXxi/
         Ib5CnSLmsyDvyACson7LA1OhsOZC38+ieHw0HF7nJmvD8VQIBha7PGe3msa14BW4BC1b
         87aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684928; x=1707289728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oNmgtgCElW74VgkhCqruhhIpDueOdHK2RkVOvuNPn0=;
        b=JGZuholgiEd9yirqq8FXizNsLZ6TBlpeIGpDAK6mPJvrUX1TIlmllQbibc/GLtEFOP
         Fo6lRKlR77ssH2qpSn7EQdksS9yDpWT5kkNApSkTlll0GHDM7iJvntV2YJBjtROAlYeH
         Bi5gqQwQ7Ii5P6dHohvDXeGMA/l2R0tZjNpIudIJQSrQOTNOzoAYFXIvfVPJaFf9oyaQ
         XSW0YGLM7znQ8Ezg4R0buTEBfxKRzZTASuF9A1QEezQktJ8BZuZsfBpj8qrhdvBzvkdA
         sCLAjSzzC/YEx4pTX/E4UUqSbeey4Z7i/1hsoezHFHD7vYhFLEzmFMkcz02jAM+iG6CL
         I5ew==
X-Gm-Message-State: AOJu0YyQaPSBzByZmplgmVzDuNL1zVMJduXv1wSmF78P7GevvsrphRgY
	ybWk5SMxH0RtFi2CC6+DST5545o2AGq1Vnip3xlK1X1unjeCS6lX9zxMGKuXyw==
X-Google-Smtp-Source: AGHT+IEJpAeTczd0tUQq+sU2xCwLdqKOnFAWNye3Ir3ULRnmoSV+/aku6ccP/Y0extXBkhaha6umzA==
X-Received: by 2002:a05:6830:1bd7:b0:6dc:224:21ca with SMTP id v23-20020a0568301bd700b006dc022421camr522371ota.73.1706684928074;
        Tue, 30 Jan 2024 23:08:48 -0800 (PST)
Received: from [127.0.1.1] ([103.28.246.26])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm9087956pfb.46.2024.01.30.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:08:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 31 Jan 2024 12:37:31 +0530
Subject: [PATCH v3 08/17] arm64: dts: qcom: sm6115: Fix UFS PHY clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-ufs-phy-clock-v3-8-58a49d2f4605@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ntzdDmf4FOP4JYl7D86W3Hb9BDqaLc8AljqlYstG++U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlufG8NNFnEdD6AWOhi0T1MZrEuBjXyTANfkvyf
 kU/dOw3owuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbnxvAAKCRBVnxHm/pHO
 9bPQB/wK5qsLJdCyrzYKQmXRamB47fq/4jsJAe5EM2dfZoEhQTbOugH9qvJtG1AEQ6HwxgqrZkk
 5Oef+iz0pbpqFOKFp0Hv66+Ek5yk4CxydWFb8yWvhknXbsk9rNHfD+y8JBilNL+DTSmY1EVkJiA
 N7loSSlaC0/48acL5ye9kbUHREf4CGCFyARKOd1CF+itad/9VIYyUvtgVHHO3Nw8k8YqhqfC6qx
 Xe6RTo0ZaDYhbVWZj8PvOLgE9Kx/TxQ4RXau9OujMCEcHB31nylKtCo3FP2jaFiPBCtzCyerAHI
 aYFG+eJNxWDLG6lnoHRKCkWHpQzjHiX0MrX0xEEHNkf+1C9g
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

QMP PHY used in SM6115 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index e71cbdef7784..261349c148b6 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1195,8 +1195,12 @@ ufs_mem_phy: phy@4807000 {
 			compatible = "qcom,sm6115-qmp-ufs-phy";
 			reg = <0x0 0x04807000 0x0 0x1000>;
 
-			clocks = <&gcc GCC_UFS_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";

-- 
2.25.1


