Return-Path: <linux-kernel+bounces-14028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88D821721
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4289B2821DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ECB2108;
	Tue,  2 Jan 2024 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX2BZhQz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDD23AA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7be1c65dso5639248e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172649; x=1704777449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFfqk3GWi73d7yO0PZohPdWTnuursIgEws3IpamTyAY=;
        b=IX2BZhQzHjADXoCVn8ZF0mgNwzQb8E+rqrCvVcd8NemeKyxZTPNTaxyLeacGX50cTD
         Yo8nnZPI6B5izbrprD2aAnX2Np9VgVz0yegN1s3kMcfvoXZ8WXdDWM/Y6XB4+HmeEzvy
         nkFkaiF7EMjLKH3msWXwx9VmRol4ZkSCA69tsOM+A8aRl7Yx8inOAVhtir8HOiIMfOlx
         XpyhbZ7Gm5YrcD3OQzkJ6pr7dMh0p1EQhbIxL85EFt9j2af9eqLVOprNGV6+6IlbGRLU
         dpxSYkubfoyWg8FgtvWDJRyvqh36D7D9ajEWTEZd8tmjW9dF880bBHmNbJsm2c2QQXAf
         vH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172649; x=1704777449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFfqk3GWi73d7yO0PZohPdWTnuursIgEws3IpamTyAY=;
        b=qE/YlpGx9P+qipwMNstAY0BfcqE65nksBhSaFXrcdcsflc1uADMYyt5FqunYRsHLVa
         dVoRuGFkqVc0wD+g1+Ka8x0ka+N7cH4gaYXzcQjBkAzYEghzEO19CRw4uVmDimkvLImm
         TaHDUtLoTf/fjptW7PbMf3UDTcr5jk5Plp85+DXLqxFBJyQFZhZK/yEP5WnmM1eFvDWo
         BO5l8Drul5vmhr6mzeq6nlQRHHAxhDRhkofKguWt0vhLS2vHW88gAsRHAZzqIctqN1Xt
         edA1ui/FmXkiB4dpNOVFr/lTPWzjrnOBfk7N/ETNxjkKHYhw3lVFcGqzJIjdc9vxJTdH
         2FWw==
X-Gm-Message-State: AOJu0YyUFvcw59wszwGm3bkSReFezkvQIM+2YnJ4q1LCwwxsBJ4VC0h+
	MnqH48gnKmTQ8F9fk4LIbEREMlcIeOHRKg==
X-Google-Smtp-Source: AGHT+IG/WNw4muoX745dS5qB40CKnhR0IDcIaPIVC39JGhCXwvBqLuzo3CcT4o6hbJhKAPucFsq8Yg==
X-Received: by 2002:a19:ee13:0:b0:50e:73fe:c118 with SMTP id g19-20020a19ee13000000b0050e73fec118mr5108491lfb.71.1704172649116;
        Mon, 01 Jan 2024 21:17:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:22 +0200
Subject: [PATCH v7 02/22] dt-bindings: soc: qcom: qcom,saw2: add missing
 compatible strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-2-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=6seBHQpdQthfiGxSf/xd1qZ7pEbCXNhrQ7ROvS0olF0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xjy3ovISs7HIkTtLCBZJAdKtskDPCJ378hp
 fmmCa9oojuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcYwAKCRCLPIo+Aiko
 1ShDB/49KRDWmMLGG76SIc7wmOFsbA8X2E7Wx2ZIb4SXpJzhOsRh0moBeNCw91cLTkfBHkvu6LG
 aG3rDRZNJj7IReL6f2Q6jiGROWjI3A+9TpbclpJv8wnPI4LOWhCoSfEI8ymOqWaiy90bbAFbu3K
 Yy/uFFH+z/y2BdxE6BE+xKcgCnjQmEOOAucPTUdARy9Vu1DFZLAeB+KD32fRMNsGTeholAxV/kE
 2TR5LY1fSGsYcc8y2ycN7Ubypw0Y9KVt/SKgc+PCoJvq/15//QHW0XTq+SrKToNJnP03S3WkbLL
 PRV78B8sQpFpPZnm4RmPQGxdrDmYUrgxRJPrPVVXAc9jA5CF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define compatible strings for SAW2 units present on MSM8960, IPQ4019
and IPQ8064.  There is no need to include SAW version into the compat
string, so just use the SoC and SAW2 kind.

Also add missing L2 SAW2 compatibles for MSM8974 and APQ8084, they
follow the existing CPU SAW2 strings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index 84b3f01d590c..2178fea37b8c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -25,6 +25,9 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,ipq4019-saw2-cpu
+          - qcom,ipq4019-saw2-l2
+          - qcom,ipq8064-saw2-cpu
           - qcom,sdm660-gold-saw2-v4.1-l2
           - qcom,sdm660-silver-saw2-v4.1-l2
           - qcom,msm8998-gold-saw2-v4.1-l2
@@ -33,10 +36,13 @@ properties:
           - qcom,msm8916-saw2-v3.0-cpu
           - qcom,msm8939-saw2-v3.0-cpu
           - qcom,msm8226-saw2-v2.1-cpu
+          - qcom,msm8960-saw2-cpu
           - qcom,msm8974-saw2-v2.1-cpu
+          - qcom,msm8974-saw2-v2.1-l2
           - qcom,msm8976-gold-saw2-v2.3-l2
           - qcom,msm8976-silver-saw2-v2.3-l2
           - qcom,apq8084-saw2-v2.1-cpu
+          - qcom,apq8084-saw2-v2.1-l2
           - qcom,apq8064-saw2-v1.1-cpu
       - const: qcom,saw2
 

-- 
2.39.2


