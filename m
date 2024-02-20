Return-Path: <linux-kernel+bounces-73778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98985CB24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3B0283724
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8193154443;
	Tue, 20 Feb 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgamkhlv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731F153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469446; cv=none; b=Wn/HsiEk2q1DX4q/72fdYjqcUT7dKlE+kcYjdbetwIsJ1ZkbnixMmAHgwfY9E4PIipcgvHNucIWmur7AI94oaUhyAJvunoW5P6o/zGJl1tDKad4LReaPZAUow3BBrwWvX9m3wesec7mgidYIB2q+afyu44Zaz3yKTd+wZv2nYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469446; c=relaxed/simple;
	bh=XUmTiKV+TS3e6Ef/iekjRyOkUOD1YgaHYwrpRNkCpCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fiH/lpztxxmIVjLk9pu+s/7XuALQ4FcKNs9hXUMFc622mwFM3uZe1fKwX1BE8FNJRrH5aJvXj19SgY6lgUzYe4IONs4pEcWFVKlVXG1US3iY9MbtRoR/r5SbTQrm9CZ9n/vsHTW1Xw527xySRZGzv8ajm6nMVe1tULLGBlCbVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tgamkhlv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b4388dafso3264550e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708469442; x=1709074242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LG/YBimXAQusHofv1q3iQxH4mPaNrde/6RhU8UnryY=;
        b=tgamkhlvBmi4ppQSSZGfvlU9zvfymHJPF3tE7VbZyd2dYe2ypMLk3c2USn6RT/N9kk
         b8XunnoYrdGm8ahoc75TcvhYwRHwtCbXpIPOSfRz79F1BRto2LXs1DMIKYV6VQ1smhci
         PPoHgXuT6vLN1rWHrwQTEI7JqUIEhHxuZncfw6Aum76k/C4+m1CmlBzYDvL330SKW64K
         tSaIGtfDAiMneyZtLdnDKoaOuWGx38Henglli8esKTJODupEvdkKYMYYUsKafHf1AsdG
         DLn6Qeam913IZSJAOdwDFQbioPjP/h1lpwbQOnTWKfW1wcVP6iR1FyE5Oif1KOGlwHIR
         e7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469442; x=1709074242;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LG/YBimXAQusHofv1q3iQxH4mPaNrde/6RhU8UnryY=;
        b=IXF6xtRnbycamOdRM5JWtune3LjlX888Z4hgPJym1fqQj94wpf2QR3kpLx9tDVQbE0
         gD3c9vA6EU613SN3SoyAPCaHY8CBDNj6RhGzxDFNM6u4FPP755Wt2HlQ1oYjjFMZY1r3
         x/z5fARtS5oiISj+Yc+QMMXyCKyZhqlxoIXMoT+cQF3aqt+J1hBXUa2/6p4RStUjDesd
         YNsNqmqkDnTSMU4GghAFFsu43f2gD2HXT5UChnX6i41SkUBjqj6i3lbn1KMkxoxQslrz
         x63G++4gRi/H5d7zZEYHHiVe2MpVYInpz59ZsaZ4uRI3HJWaYbQ9FK8Po8t3ry7VMdzG
         sBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ55xiA2Bs6Xzl0S/emaf8MiqDqb/EMT+vDL5OEIpbAeQ/mPTdpiO3HcHCt1TkkAa7u+yrxrcoBKK2el05jwQGA3KfpUI8lTySDlDm
X-Gm-Message-State: AOJu0YxWfDemFSbL8NJmb25h1LJJhFwzO586SltXAoE3QCqAKSxS2hVc
	mof1HluiKusdhR+lWbceIWHua9QsIoS02buAmbawu2e474ZlLMK9G7B6ndCJq80=
X-Google-Smtp-Source: AGHT+IGFjq4aRmXhKbeVXidrtL0lugiMcB88ZB9NqST7+igCfACT+E7YS8UgO+RIA94FjWGnszt7vw==
X-Received: by 2002:a05:6512:3d04:b0:512:bf82:139f with SMTP id d4-20020a0565123d0400b00512bf82139fmr3245081lfv.25.1708469442497;
        Tue, 20 Feb 2024 14:50:42 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906c18300b00a3ed811cff9sm1601977ejz.154.2024.02.20.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:50:41 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RFC 0/3] drm/msm/dp: Rework the eDP/DP modes and add
 support for X1E80100
Date: Wed, 21 Feb 2024 00:50:30 +0200
Message-Id: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYs1WUC/x2NQQrCMBBFr1Jm7UAm1VLdCh7AbXERpl8dkKQkI
 i2ldzd09x48/l+pIBsKXZqVMn5WLMUqcmhI3yG+wDZWJ+98K17OPAt6J87xaGX6hIUznkG/KbO
 mGLETRLvudOw1oKW6NNXG5v1loPvtSo9t+wMh1QMmegAAAA==
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=XUmTiKV+TS3e6Ef/iekjRyOkUOD1YgaHYwrpRNkCpCI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1Sy4am+8YdtdpgLN1WSUtUIMsRhnVx4qBl0pE
 Q4WaunMBhyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUsuAAKCRAbX0TJAJUV
 Vkb8EAC3yluN0p4bSupKX3D7fdfiWjltnA2GVXEWe4GZm48cgF9Ptk/hXjQP2fy+eIWsUVKW0Aa
 03qKb0Up3xBD0PQMfV+YRVJWm2WOIwiHwmfEDk2jBWh8Vnv2xT7PtU/KcdM597vYxSDo3bQyIFd
 nMtbo5IHRTrrlZU5JUB707ZOdr2VKg5AYqvqrRnL+IOVR8sucuk0s8mgMGp/GippDRHmy4Mdi7w
 EDOW16RpqerHXNMl5u/xjYmcMdHEl/CVHYqqYGh43oWGjwk5gMtzkL5voXRCAj2JyfeWCI+aoId
 8iaVoPhCBQTLUaLRiWSuJTCqYPw8iLbdj4RFy42uf8FwSw62bcwJ93073b4QOCiNo0SBmZPBX3M
 JfN88v8PpMna2Gi+pLAySico47zuLZWenkjkLdo/Y0dvZ5dsMGLScOxh0LCC2Du/uMoeUhuLu5v
 VnI8twihZf78cUrvA0DP7u92b1rWED0yM0KYneZe5APmE72ZJrFdwsB9lZT7L2cRwUOASknA4wP
 VkfEhk/8E7902SPAK0dxHngdlHzfVaUAJvV4F0Cm0dEPfFIkQqknGgEk82rh2VfMB46Zn5lw5ne
 8DSNFWAfC9EuUIfHfZmiS+Fd/+wtEwiqmh2oXRO9Av6/6EVbUGP6UMdpHemIB9LagufuEh5IoXn
 v71QfqsCZZmE1eA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since this new platform supports both DP and eDP, it's the perfect time
to drop the dual compatible (eDP and DP) and figure out a different way
to specify the mode. After some off-list discussion, one suggested way
was to add a 'is-edp' property to the controller node and call
phy_set_mode to let the PHY know which mode it should configure itself.

The PHY counterpart patchset is here:
https://lore.kernel.org/all/20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: display: msm: dp-controller: document X1E80100 compatible
      drm/msm/dp: Add support for setting the eDP mode from devicetree
      drm/msm/dp: Add support for the X1E80100

 .../bindings/display/msm/dp-controller.yaml        |  6 +++++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 11 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c                | 28 +++++++++++++++++++---
 4 files changed, 43 insertions(+), 3 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20231219-x1e80100-display-refactor-connector-e1c66548cae3

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


