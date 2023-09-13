Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA61379E43F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjIMJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbjIMJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:54:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D51BCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:53:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so8291748a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694598838; x=1695203638; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fad1rR7O92f8MbM+uIDjcw5AGbZOnibqZ09Elwwq4ek=;
        b=bJxNXu9RU7h4EQyXiLfDZFmMM5eSl0q/orWum/zxLJnnpc/FTdYbP4YYhkFTGT/1pO
         OTBnQSnGL5aqkYzZhePH5cOpH/k0sEzchGOpBWFkuYAaAS/ozOzYlPh4J2NMLCRhfstW
         R9+6I2LOStzy8MB7LfXgo5KZDx1KwASzlQrQhdxaSOhMAbnQkWB5bXY/HoziOGvFP4mx
         Mfa27u0/2/7dEeMRL3G76VHIOluxejomJS2Ua0iNvybzW59LzlR/AeBJUF3XDZxa+PFo
         0iWM+tES4NFy1p63W7Y6eexcrVdiFGJMs3h1fmVyps+HikHDj7APArmrtiAlhsEM+OTy
         OV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598838; x=1695203638;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fad1rR7O92f8MbM+uIDjcw5AGbZOnibqZ09Elwwq4ek=;
        b=TWSRwTTAHvcOrA8cHHjzLwmYGULc6biOZZKaa4qVScY6bF8wSAAaIkuxOSTxifi9kH
         LL+GyTs/bsLQWnHTPEuNijCdo1sFA3z9/+GZOo2wJu2bs2f0GNjlBAxlfa6hAF8q6MMF
         goeGIleLKQn0WSTVOkNtmKNBsfiqGMmJaJBbK74s0s7nI/iIQ/kxAzvnrexJ3VOXZrlq
         RslARgheLO6gU82WckjJdYvFCeYVGMbEWFUEVYsulFBwhzlCQGHUPsFt0ffue7kqDJlN
         T/H/2kj/QjOOc13C1KyNnYzXXMHqsj8Y5Rp31Z3o+lZtiEuNTvxyxa946HDoSNp1PuuD
         lCmg==
X-Gm-Message-State: AOJu0Yxn+tHM5W2G4F+6hPNoFuGWbnLYcZvmD6ca9mp2Y6nG9Zikmpkx
        6YDzS4O0R3B5yzL12SSmLxtftg==
X-Google-Smtp-Source: AGHT+IGnGtXQchEs2Ii+OMSkJplLM+jTdktXjIslZBx2soTdmdINHLx0PipggsOaf3dRDQU6Re+rfg==
X-Received: by 2002:a17:906:315a:b0:99b:e5c3:2e45 with SMTP id e26-20020a170906315a00b0099be5c32e45mr1481772eje.28.1694598838102;
        Wed, 13 Sep 2023 02:53:58 -0700 (PDT)
Received: from [10.167.154.1] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906939500b00985ed2f1584sm8092669ejx.187.2023.09.13.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:53:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] EUSB2 repeater init sequence override
Date:   Wed, 13 Sep 2023 11:53:22 +0200
Message-Id: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOGAWUC/4WNQQqDMBAAv1JybkpMqqQ99R9FyiauuiCJbDS0i
 H9v6gd6nIFhNpGQCZO4nzbBmClRDAX0+ST8CGFASV1hoZU2yhollziTl7gmp18xIzN1KAGaput
 vHpprJUrqIKF0DMGPJQ7rNBU5M/b0Pl7PtvBIaYn8Oda5+tk/l1xJJcFpY3VtbA32MVEAjpfIg
 2j3ff8C0hIX/M4AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694598835; l=1192;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QZkLavErYAckHPtysRiIt6y82qlIstwn9hPWxIXGKnk=;
 b=H7+WiwYdLnKaEO7l/O93t4KHu1fBwQsdrs/2pnS29hKZFdQNJp5Rh7y9E99j1+dFPXAR9Itkq
 99FGy8WHI22AEhxFhXSenjlO7+mivRXWZ1G6vU7ghafVhKptQEZRRxW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EUSB2 repeater goes through a tuning sequence as part of its
initialization. This series ensures the tuning is "clean" and can be
overridden for devices that need it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Change register names to something more human readable in bindings (RobH)
- Make "Zero out untouched tuning regs" actually do what it says
- Link to v1: https://lore.kernel.org/r/20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org

---
Konrad Dybcio (4):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic tuning overrides
      phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields
      phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs
      phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning overrides

 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |  21 +++
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     | 146 ++++++++++++++++-----
 2 files changed, 132 insertions(+), 35 deletions(-)
---
base-commit: 3c13c772fc233a10342c8e1605ff0855dfdf0c89
change-id: 20230830-topic-eusb2_override-aa66df9ca641

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

