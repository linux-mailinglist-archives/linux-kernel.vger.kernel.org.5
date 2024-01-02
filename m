Return-Path: <linux-kernel+bounces-14046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE30821757
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA3B208B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898FA1549A;
	Tue,  2 Jan 2024 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKcMi3vP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046912E56
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so569568e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172660; x=1704777460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i68l3ZMIss3GPvn7ht4H5iWh7P17JYPVJs5v9dHRks=;
        b=CKcMi3vPrnO5WTr2xzXedHq/EsuzEXPBZjCyKRfVye9zjcgyNMcVrHpeoMpTwn9q2x
         uYqGU7URRSevanMnSO7LIx5culIwnFL75EmzOi+y2Qul/2U9PXBxlpVQVU2IkHKp+H7e
         ruUOf4vlxCmjd0dCrcJs1/jw18ph4JItABfrTFBEUW8aVfQt8RcmF5PMzyZcZaaSDaCC
         JMGOUi6S9OlYKo+/kzc/4Biq6v2DGrlPZXmwoJdx4NGqf5zBOVW16aGFTBQ0039I7s1b
         x8LsvYHixS06QCi8Q5HC3sdW0jHCpyw057/2OYUYo4QcAEsWzI9lJLBQfEiHqEvuS7bX
         FQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172660; x=1704777460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i68l3ZMIss3GPvn7ht4H5iWh7P17JYPVJs5v9dHRks=;
        b=sElcymDCgLblhErOmdHsQ72ps/FHIyz0RdgxSJHYaJ7abnzvKzVekqhQMbZ9bQlXYD
         AxBeuC/L8qLmzptvsZm96gsWxZCc6wgB3c/v0bzLvhCR6JqF3Wi6RybVXbC7bCsJHfuw
         j3zktPOQzJ+KEyzZD4NLl/gYUqlYnK8ivaHaDtJG4CTO52vgmApVlSaEiEG0uhUqWWSH
         ejMEMVDr8+MempHSpr5dSqz5Amx2JSUil++IgICGNwKnA815ScKTWLRsGD5TExoKA//k
         QX8AitwFLt2wlsDzE1cq7NrAerbUq3kK5fAK0DSIysgCn0Xn4c7LcaFNcXFdOw4RVsrB
         avdQ==
X-Gm-Message-State: AOJu0Yyg2x4j+e2t+u62WF6T8CceWJpcLWcdFbV4uu0eDPJYW5Sw9Bkl
	CLAnBbomrr967hok0qOx6cXwrcP0qjqZdw==
X-Google-Smtp-Source: AGHT+IFe3TxQEsomHv98QHExGDU4koAst/Uh5Gg4tlyPDiOp/hsi6F7xFl4RiNcDG1BShTAgi3IT5Q==
X-Received: by 2002:a05:6512:3ba5:b0:50e:7d6b:b5b2 with SMTP id g37-20020a0565123ba500b0050e7d6bb5b2mr5775681lfv.6.1704172659981;
        Mon, 01 Jan 2024 21:17:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:39 +0200
Subject: [PATCH v7 19/22] ARM: dts: qcom: apq8084: drop 'regulator'
 property from SAW2 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-19-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=957;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lY/AMTKVGHFoOaQXLfThkbvJAojfePbHRqHlDDvKCjU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xmSyZyORUrNYN2VUltzZcW/eCeoIgm/ee6f
 vytt8Fr/wGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZgAKCRCLPIo+Aiko
 1aMzB/40VLzUxpHPZP3oWUQM7UmukE3762n44wN9+G0Z27wrYPVx1E7WhHabxhNqNE2sk9xl1k0
 3ycOdtgYa7lMlPrU41opjp07yYL29FE0240Y53QlhKqpJP4HrNpt/46n9OsnoYAHHZFvsY0/Cpq
 Jx+CO2cvoFKiUKYNoYaKNad0RBvs/8lLp2H2yVxk/ooaP+9eraigwv0jA9/6kHoSDOsgs20SlVu
 zKFTLZXcJmS21P2U1ZgT/PumZGkN1HKIL1iAgcGW41ajU/Uc9S2IwpzuBNGLncj07ezgt8ONTdB
 ufSsmfkvZQcPHMKslCR5Kz1Xvt5BEqOTwOpjR94x/kpXwdxV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator node show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
index 6fdf300ef65d..8204e64d9a97 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
@@ -652,7 +652,6 @@ saw3: power-manager@f90b9000 {
 		saw_l2: power-manager@f9012000 {
 			compatible = "qcom,apq8084-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
-			regulator;
 		};
 
 		acc0: power-manager@f9088000 {

-- 
2.39.2


