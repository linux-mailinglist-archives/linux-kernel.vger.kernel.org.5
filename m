Return-Path: <linux-kernel+bounces-9604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A832B81C84F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CD11F21DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56914F92;
	Fri, 22 Dec 2023 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTSR9CDg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E5171A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso20949605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703241667; x=1703846467; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxqyUslSqcrN4IMz7Jp+2fHS5AF+1/LHXk7BhQrPANE=;
        b=lTSR9CDg2t2uM41tAtbKoIc2REP2FCQ4r3S1oKTFsyxr/ReVwNyLC7zc1/J7mhfrVw
         0P06MiIBxTyBSYF/nzwNQP4ns2Nw2wpsnAAUophAgKS8cJ4ys8IYDfXlQb9jgUFLiyAU
         qZuksc0yCsTVTPfhxTA16CPxWydI91HgVDf8zYR9nB5Q2iZ0BvSsC2V/3ef2SR99iMp+
         JJ3L6ITjHlgZQonMnnkzk9pYoUYgCXk2NOXMBgYgTIRgNVZcdBp1EC0I7c9655Ar3gC+
         pDGigM3GA+Wveyh+BB06ce2vyJSETp5G3ovkZm04rKubRiiZnR7Zbl9Tsk0lc9zdJrhW
         tWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703241667; x=1703846467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxqyUslSqcrN4IMz7Jp+2fHS5AF+1/LHXk7BhQrPANE=;
        b=AY0lpajGfFdzS57sEvhm51kEUJW8XEfBCscxRVgECX9hWOJMupvQ/C4gAqPKk1usHF
         m3POWrKFt5IFLUHLgR03QSatInLmR+of5mTy08qfKM5U+aPUiQepVwC8QiOJrJBBlD5F
         e71c37pBmUZzBjN9Pf53ixoqwUtgghmZQtO0m1t9YTzqMNBFCRh0riZfIgk0v91GBPyD
         EUYsnzXMMf4GqalJIU8Aqu/Af3FhHZ3xnvMbciXlidHS9bj4GMZiiZmZMhgTvZvjerd/
         Wl3DxH1P/6OrTcMRuvIGWWsUzoZvUyNJ0Xr8bIQarmYkC+1ZV9k7XTKatAZxBqlEmpQW
         ylyA==
X-Gm-Message-State: AOJu0YwqKLFgPWq13CdxVzEBr4EKN/eOG9len2vF3uY5Rqw+pWPr4hQC
	C1f5NlCkMbuKMQQ8sjkNWxK7V62/9lmeyX0owKYLMs1GjGI=
X-Google-Smtp-Source: AGHT+IGDzPdK5TDoFGMnm8+yqYXhXxmc+5xJkgHPnuOTFZuEuxW7Rc0UivHB89pXIQedl+5g7puc4Q==
X-Received: by 2002:a05:600c:45d2:b0:40c:48c2:f531 with SMTP id s18-20020a05600c45d200b0040c48c2f531mr663809wmo.42.1703241667326;
        Fri, 22 Dec 2023 02:41:07 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0040c5cf930e6sm6348728wmo.19.2023.12.22.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:41:06 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] phy: qcom: qmp-pcie: Add support for G3/G4 PCIe PHY
 for X1E80100
Date: Fri, 22 Dec 2023 12:40:52 +0200
Message-Id: <20231222-x1e80100-phy-pcie-v1-0-b74ac13390bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRnhWUC/x2NSQrDMAwAvxJ0rkByAl2+UnqwHbkWBNfYNKSE/
 L0ixxkYZocuTaXDY9ihyapdP8WALwPE7MtbUGdjcORGdsS4sdyIibDmH9aogpKuk5/D3aeRwLr
 gu2BovsRsZfkui8naJOl2jp6v4/gD6KQiz3gAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=662; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=irkRhzefKYsakpWhuD4GCaIxkmHudzvNsUgaVCxP7vA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhWe6BrpWct/AD+CaAw8TFtqtC3e5rR6OtHHWq
 bms4hzUQ+WJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYVnugAKCRAbX0TJAJUV
 VsduD/9xBIaySZX8hrDulUrChEN82nNpaiDE/CANv9LrucupoWRb0qP/8EUf6OoVvrk6J/QlIf3
 +nCZ2wcBvuhavjmTN6gF2kv3IL6vivutNDIE8wTLWUcd2l3zN4BdjZVbTjnfqMeArEiHdkon3Qh
 vP1cQc1R0hxy0xhp5Wfe2ISMBCUBLT7cvG6iOS+kgCy1RFolx1kO2gJPC/rD7oiBX8kW3BlDewF
 /ZqRBnwOmUqYf5reyijBRNpKRzpicQEnBESTF7wH02mV+URGpyJO2l66ivb/hkRVgvARybYR02J
 3ru7bhJAK6TEikAGyLJ1JBDTFZrm2K6nend+5vla23223ygub0VS4WWH/zXF4ukmSwFTL/thFgS
 v9VsMzXYp+BQKCoLvhASmVD5oWQaqvkhb5lF6NXoVcNLr9CEOB9CDJF01Y+mNni947Hr4hh+4yN
 I7a562ZPPHUqrzzrFLvHl7Yt0gWcasXnCmRBBfZDBtsCkL9eIQmL8/HZ4j9K8vlQY0M1YErstFs
 4dou+08xV8l5hBaEBl7YHzxJdoN7N60WOPcTGLg9pExkyk14bBILz8ocDi+7KUOK/Qgm0ffNgJW
 cq03i2D4HIN3AhhiHGgcuoLlIJBEhYxFFcHdRM0fbnKDsmkEmp+yKIPXIS6gsepGAb6CC3FYrOV
 PbKjTVADI8umfPw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds the G4 tables and G4/G3 compatibles for X1E80100
platforms.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHYs
      phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   6 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 173 +++++++++++++++++++++
 2 files changed, 179 insertions(+)
---
base-commit: 8a9be2a3cb673dba9d22311beb74be261f0b3f15
change-id: 20231201-x1e80100-phy-pcie-ef74adb9af30

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


