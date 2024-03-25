Return-Path: <linux-kernel+bounces-116830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6588A982
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381A5BE6B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A381B48A6;
	Mon, 25 Mar 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEkoBknT"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01813FD79
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362409; cv=none; b=D57ZkalZQXLJ56sHKQo95RkbWAul39XJXHBH55PucMFEb22E5+5rt9gNUAxaaNtkqzHK1BNVoCxTGb/ZGjXkE2zBRLUn2XUWYSXrtvFcbvrcJzPi4QnmgCx7Vo40mD2CFQJ2/r+GJ+gvUP+zXJKyXd1whEgGJciQNOu7GKGVKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362409; c=relaxed/simple;
	bh=NAPTtSll1XieWucrBskp4oBsh6P7ZqjYmxSviubfVZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlvIxMva/zwrhjxUhPl6+hrkUcEbWEaAAucOeMbpWJkw77AVudbk/R/cfMtcQ6qdsjLGOHjetP0lU3IOeod0NG8AgtER4jRwR5F9NlJ5zu3cZoN9A/gedYfdOYJDuxv/yddiFpw9App63f+5WxNEpTIDGi1C2/utYT95xeUb+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZEkoBknT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso56956951fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362405; x=1711967205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIVs14OsD+VApo/vkETOeSbK6jpJSlhojNnxWWFG6FI=;
        b=ZEkoBknTMREw0D3VjPx+DrqY2bnCQHsRwH7Vtw+3bqJW6kjsWHPc8UVSZtg2Jd2nbC
         FYYixd/2WO2ZFJWfKxGd90VNXAgtz48eC6VjBL0hmcAkMUr9QCebCYoF6VErarnpBE6Z
         SwoYCCTEmCsvaYQLlt4nsUfj0dVmQ3PKLXGGiVN+mxFY4ki1108MLSyUn8TVMsOYXdcu
         Ixn5mMcwEfl8mCInzusvh2qSj+I1BVHsppV/DpYuD8fBuGPhD6ra63XC3zwuIKF395IY
         27tTWHt9U3EH1Kyk1/9F6UPPI/w8pcc3t7G1DePdEH73f4DpznIx7l0VfdlOXiadGC3S
         bycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362405; x=1711967205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIVs14OsD+VApo/vkETOeSbK6jpJSlhojNnxWWFG6FI=;
        b=TEYvXk5wDxuimclyAqSegCMd4CeJ0W5AUo4AsVSSTEdLSxJhtZ6L8YDFGmpaAPZlwh
         iiCr2wFFj3Kad8hsTcdE57ecroHqMjB97mi+FbpdLbfZfTfExL17E2GdvYeF2xSD7bqr
         33q/xxat/0V8cMSb9H3CQCinsKZ8AGJVtmCRURpQryzHp8TmlibLzMJQEBBe6oczI380
         nN5TpdCbOXovRx6zG31kpAuYBxJV+fLjrfDHIe9nVBMw4twBScjBNOlpnG3OStidksQL
         wg3UJdWdHq/psq+rq4uDKPMuHPEdaHXgV5MnJvjQIEucLPBQOIQvDYIztwXNM6nkqRzk
         BFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVunqHzZDC00zuxuBLwyK1Pa94vDtQJTF5ER8sCGTNqETl2xhgh+RmkJJFUUS7cI5r0rUzqeH6G/M5yRqm1a37IHGqBKKprTEEqDd6o
X-Gm-Message-State: AOJu0Yyz5L1OuL6QsMxiu1SnGFSKZXP2AxM+F4+gKsTGIUiWdYYHOfII
	tQhaSC9GpXAJC7/UAT5G8EfzejUJeZM+zOWih6WnCE0mdZ0x2kur7cFRJKygKb4=
X-Google-Smtp-Source: AGHT+IGkd55xMRSLiu/Uz9y7HpMQQp8XDHGRZOMOCwIk0dBAmI4pXfDi9VFNJXtS1P4ovI1Pqsnbsw==
X-Received: by 2002:a2e:740b:0:b0:2d4:42da:40fe with SMTP id p11-20020a2e740b000000b002d442da40femr3438749ljc.17.1711362405190;
        Mon, 25 Mar 2024 03:26:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id jg24-20020a05600ca01800b0041489884a98sm2899023wmb.6.2024.03.25.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:26:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 11:26:37 +0100
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Document the HDK8650 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-topic-sm8650-upstream-hdk-v3-1-4f365d7932af@linaro.org>
References: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
In-Reply-To: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=952;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NAPTtSll1XieWucrBskp4oBsh6P7ZqjYmxSviubfVZI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVFinsGYaYAK00ipVX05wuA6kq5nIaf/MaTEhZrN
 P/TC52CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFRYgAKCRB33NvayMhJ0V0zEA
 DH2sde/dU9J8pLwNV3rvOfrBdsb0JBBJlE5Ho1hjp2tUi5xLkSy+8HLb9hrdu1QxxxM4BelnJkgtSc
 PF5T1PXokyUq7VWeO7lXKNIUPkEyaR/UAxBI4Y8wVtiDwH7VrOJ91Z6JV9JK1JgK5C3rn+E4SavgTM
 UTFCH/IPakLvaZSbYrWYYlplomLZcdIMuiIC9JEh1nKAT2AWBUdwOvf4Yz9T+VzD1JcNT8Kb9TFLCo
 6MXJjNPXl8uTs27/djB2QwGjmHdiCWlLTQxqn5xh3P9rzg7g2et3+XyGRq9NWxTsGIW5YWRe1vOIiN
 0yoHIfSZWlNbKuRV6MLFo2v3dKdEoD0TIWHwv513PXgbUHtb/LTVF5qlIHkFG/pahBMI8/DfJCYu2D
 dy+ivEDCLFuU7MiXR7DgOguxnec0jxWR3FrKsrv6wPtaJJvRaB+RH7qIUP5Tgfc05QfLT+FHgX2GPm
 pVrhkzaPmNTZ3HV5rHuNWbxl7THCStETZfPUkvXjNTWcOr+5hoQVvAdnmvA0Zq9tqn9nCKZESmbGd4
 Y93g+G0/6/iXwE2H/XccjRSqkK/IGt2uoBXRxmlh2Hsuq6KzRWqphho88DLsZt662+BT5b8CiXS15o
 g8gUYJGl/3cIkHXigTxFnObkl7XPtZIaDfxYi0dwPc/pwpd9Bxb3C5YBMGAg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based HDK (Hardware Development Kit)
embedded development platform designed by Qualcomm and sold by Lantronix [1].

[1] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..fc0649da74b9 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1007,6 +1007,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd
           - const: qcom,sm8650

-- 
2.34.1


