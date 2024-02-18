Return-Path: <linux-kernel+bounces-70480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D143E859877
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1828199A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BF10A0D;
	Sun, 18 Feb 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwBK8K15"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE26EB62
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280509; cv=none; b=gV+iQNx038wVEmlKbq2PKeqdBd/pa2ELjibvjNOBUqSXd7y3dJPstsH7y7AU/pOhuMOSQFRA//g/HxaJlKIcy1HzP4fX5FUfjumOu/x6y/mEcZttV3lQlaRUeL6lYfsc1cNC6xxP/b+HjYu7mLrwuZy5qVO1AFBah3zul04GXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280509; c=relaxed/simple;
	bh=hQBeupgLpMDdeU9/zRWMVh2cHsne/7nzl98ihzuTy0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n8y3Z8ei/XSOa7C/q5M8UslBgD4U2bwnzRRoInFbQdKmqHhhW1NRNFUTmYlyflgsJah1zxMbHYWa4ff/vVWYzjyrSS7XC/p7neOND9cvgR6GjmrZxnM/ueIfarqoMFZl8W0NshH9lDbkcU37OSXJwBryIq8r8BanqnuvWDN1aFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwBK8K15; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41264195d5cso3435265e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708280506; x=1708885306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJfZGgvEn4sXAQA9xUq6oU/7z2TY2Q42B8jeqcmrPMo=;
        b=GwBK8K15J6f2YQW7PkLypWhkj+YeRw9TU7B9UrWeICsbjIjtxBoLzFTQfGZvLi5Prl
         wMiB5PyH6ShWStL5t+7z4idZe0MYj2Gnbelkqkamp+iO1W+7O+IXuLVQFRwvnFlHt/MR
         9MS6tQMngwP67TEZRlv8MDnzQymCQupUXTsdSB4yIB5Oe0GvktbXH6ErEEmtKxp/skmA
         GFFXGnf52ABvsYTpdEujhMvM2uCJOW3K55Wyz+laSHZ/z6SJxGkpVBoD/9+1fhp4AhZY
         VfCyNQtaMdir25+XVGEpuFGBmmCW7SjWJXLPBKL4TnuSSa4GqguSkIJfuDgXN2Ur7jEU
         3fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280506; x=1708885306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJfZGgvEn4sXAQA9xUq6oU/7z2TY2Q42B8jeqcmrPMo=;
        b=QPzJmPFLlS4Zmdl/LSSzrFxJeSSyPeq+8er8QK62wAQ/5bsQHTkeK7m17hh0Mp1sIk
         v7eAm5QEPiZ39o5Wx7rosgOVwPO4tGExW/2wn7cb5ldperhjURHNjuJKb6QJK+mqo8pq
         OWIbqdi4NVbXuV415/utQtQLITd3tVndus4nz4qcVKggRSWlBHkeg4/cnx0Rz+ASUJ5O
         7KBftC34k7SVekTT384n+I1c817AI1nj+YWwg4CRwMPnOKeC83/6hXb1Q8HFlRY0KDw1
         p6pHztmuC88O1NW2Xjh/g3ST07kxOIhj6oliIuFHwnZOB2VYHjVlMBoja6jviOJR05dl
         jtHg==
X-Forwarded-Encrypted: i=1; AJvYcCXNuL0H3ppXOcC1wo9sojpUUEcEkPonpZEjrNRucTuMYwMSMQ59u77NQasVCs+K0pAJugxz6jNcJH4fOnJOX1OkUKGP9i9fVbTogbDo
X-Gm-Message-State: AOJu0Yw/sKe/3YsSRZ1r71V5bPCYfngPScppZ1JyB4Q0jt2cwraqo7ae
	JiYJnnliKZMyK2+JrkjxmhXPhulC16mpVgYe/HalnCssYDGEXZalqLaCrk8YdEU=
X-Google-Smtp-Source: AGHT+IHWstA3iuzTRuinVksImDMbVN9kjQ+AD7CMW4/fnnmrJ3dPGSb6Kk6Zp/IrLaM7ddA+WGbHeA==
X-Received: by 2002:a5d:50d2:0:b0:33d:5272:6a8f with SMTP id f18-20020a5d50d2000000b0033d52726a8fmr62048wrt.14.1708280505754;
        Sun, 18 Feb 2024 10:21:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm7867116wrv.40.2024.02.18.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:21:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/4] samsung: drivers for v6.9
Date: Sun, 18 Feb 2024 19:21:38 +0100
Message-Id: <20240218182141.31213-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.9

for you to fetch changes up to 97d4b55111efd72926eb92cbd81c5ad8e6a7b3b1:

  MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl entries (2024-02-07 16:35:26 +0100)

----------------------------------------------------------------
Samsung SoC driver changes for v6.9

1. Add bindings for Google GS101 I2C controller and SYSREG sycon block.
2. Remove Tomasz Figa from Samsung clock and pinctrl maintainer entries.

----------------------------------------------------------------
André Draszik (1):
      dt-bindings: samsung: exynos-sysreg: gs101-peric0/1 require a clock

Tomasz Figa (1):
      MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl entries

Tudor Ambarus (1):
      dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible

 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml                  | 1 +
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml          | 2 ++
 MAINTAINERS                                                             | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

