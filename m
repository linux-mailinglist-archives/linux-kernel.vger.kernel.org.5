Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBB77BB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjHNOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjHNOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E937D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso43970715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022212; x=1692627012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anCPsm4yNva38Frhw8+8vdjk1JVd2SdaUxHmeX1k/Pw=;
        b=Nt9kl0WK5IOZ990jpl3t8Y/d/xjgh/ioONaKZCCl9pNbKNloYsPRSDZLwchUbY1FbC
         v1J0G762tfpsU2Xtw7BNAhnzw1VjGT9xbhv6BiB4gWw+9svmX0Ftf2vorBsJqAHrZ08B
         k5Ijf0ku8GavDI6DXoqkgOeTcm4qDf109UDDsDP2bW3N1yx1/RVdRKL1tgxYG25cEF6a
         1jSP36pJweItLjNBgQRE/JSvnFE8Z4rDkBm60yEh7XsCPqAjVmBwhQ6bdV6GQx6tQocc
         PK05REf1qQZWlJtlflSDGrvrucPM3mayRRC3fBHBS5oL5jvvpvyK1BtQsibYut1+zTpW
         HQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022212; x=1692627012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anCPsm4yNva38Frhw8+8vdjk1JVd2SdaUxHmeX1k/Pw=;
        b=g5OxntDDoNt9Va36z+eBwGFmsKF08tZ/JVC848wDF/EjNKvGZgcPV1kAUvt3LjRkv3
         nORnK5fCoRsPVM7xWwYZ2vucsKwbCFvGoEFAUNzpNlcpeINpXJHwXoAmFEOR3Lnz5iiP
         mVM7YwkPp6ZuSusBiCl2TitZNfQo2o03gCZ9Lm8YhbBxINme0Czt25Ofp3ezW1lchKWA
         UkFynhkLkpL16BtTQXvzOPlXKG2m9rEx7kx9z6LWrrkq0esgY/V9RV6Vu6iVgBGZ+bfX
         nSFgXxvo8aRN94SGyRtUOB3dyLFJ0AIrlKMvcyd98Pykvo7ZSEf8IKA9j/SN20pXAqQa
         sW7Q==
X-Gm-Message-State: AOJu0YwXZTldf4awnqmAqZLHihmBXc1O0vQBUG7ZMDzjCspnNWeeMNDX
        z6CO7wla0o+qZTfJ79WXRbdfyg==
X-Google-Smtp-Source: AGHT+IHsU2dl4NGJt2bq5Bfm9kfdu+RXTBEZPrPSVxvofWzCrCtT1GypzFwL+0Z//SOlzhA76iU6Fg==
X-Received: by 2002:a7b:c3cd:0:b0:3fb:e254:b81e with SMTP id t13-20020a7bc3cd000000b003fbe254b81emr8030552wmj.12.1692022211845;
        Mon, 14 Aug 2023 07:10:11 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm17232749wmc.24.2023.08.14.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:10:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 0/9] media: qcom: camss: Bugfix series
Date:   Mon, 14 Aug 2023 15:09:58 +0100
Message-ID: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series covers a number of Fixes: all of which are for application to
stable as well as -next with the exception of the second patch which is a
fix for a SHA that is still in -next.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3

This series is part of a larger set of fixes, improvements developed/found
when adding a new SoC.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/lenovo-x13s-v6.5-rc4-x13s-camss-patches

First pass on that larger series is to get all of the current Fixes: in the
branch out.

Andrey Konovalov (1):
  media: qcom: camss: Fix csid-gen2 for test pattern generator

Bryan O'Donoghue (8):
  media: qcom: camss: Fix pm_domain_on sequence in probe
  media: qcom: camss: Fix V4L2 async notifier error path
  media: qcom: camss: Fix vfe_get() error jump
  media: qcom: camss: Fix VFE-17x vfe_disable_output()
  media: qcom: camss: Fix VFE-480 vfe_disable_output()
  media: qcom: camss: Fix missing vfe_lite clocks check
  media: qcom: camss: Fix invalid clock enable bit disjunction
  media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater
    than 3

 .../platform/qcom/camss/camss-csid-gen2.c     | 13 +++++-----
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |  2 +-
 .../media/platform/qcom/camss/camss-vfe-170.c | 19 +++-----------
 .../media/platform/qcom/camss/camss-vfe-480.c | 19 +++-----------
 drivers/media/platform/qcom/camss/camss-vfe.c |  5 ++--
 drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++----------
 6 files changed, 29 insertions(+), 55 deletions(-)

-- 
2.41.0

