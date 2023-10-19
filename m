Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B17CF507
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjJSKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbjJSKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:22:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7121121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca82f015e4so30841305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710929; x=1698315729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnGyqdrVN/X7X7Pb/6Zeyan6nuK9AbTDVs6f1urVbyU=;
        b=ZH7QqMN57vWH5mEk3jIt/msMPtb+PCytDyDZ7DdWqwNq5ELCjtbxyx+pReR01zLzGF
         GLy6j9mSQfK1pDm6HVkf2HdzlewapYeIVkVF92bTpQZAoDL8Cw32EDXFzG0gdvH229gT
         pEp/qNB8xWirNUM+YD5DFEhaO1boXI5VMjVjNJy5eFz5Z5I6lhUwiQ81StEyoIhijziM
         OvcX4VXCpPieBtW22liXVlAR6kgSHntkhi+zb4dg4AqFZtTPyuceVHwaYVjSxafZjYH5
         KLS7Oxk9w3nA+bShKvRFIykGybcmlgmzCgjVXlB98M140UEgH/pXWCLeD2YNFIghobPW
         7FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710929; x=1698315729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnGyqdrVN/X7X7Pb/6Zeyan6nuK9AbTDVs6f1urVbyU=;
        b=MTHBX+PY2x1XNhY2ucXU3jJ84/eVxmVFASB7tmRU0u8I5topZb1BtnJP8JqOEpEWs9
         /YqDKZRYtqd+cafYxGSU3DqorUZrt3CH8C1m3oDG6sY/sX/DATqSqR0OIH1U4GiRYPUg
         ch60d1qjs2/n+NupWU90s5dZYDwVo2Lz1TFre9P9sl6g2km4zs46/xVC+eAQSHkGCyGN
         m0uswaREeyn7qQi/wPx3y8rky56HTUjQzA05mOmqcVnWp0bIMpChmuoUPYGn+omrGYOy
         Fk1S3KN4vozIr8xOjW7DXY0O0q3+AGsGS2g0Os1TyzePHIopArjbCNrmBzsmOddFJ9qb
         YPxw==
X-Gm-Message-State: AOJu0Yx/zDXGfcThdw2oIJAsOIoAMRsuIVB+Hw16M+yZNpTLnSSR4ziz
        2fwjN2NbgJDMEvkUeiV4YWjn+Q==
X-Google-Smtp-Source: AGHT+IHBrXouQ0fgZD6c9LDfPsD3tYKvzOaUPanQACJvsOHkDWcRYF0xvx6KPYOOVG0X1q8snvYDkA==
X-Received: by 2002:a17:902:ef0e:b0:1ca:362b:1482 with SMTP id d14-20020a170902ef0e00b001ca362b1482mr1617202plx.67.1697710929252;
        Thu, 19 Oct 2023 03:22:09 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902864600b001c0c86a5415sm1551706plt.154.2023.10.19.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:22:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH 0/2] OPP: Simplify required-opp handling
Date:   Thu, 19 Oct 2023 15:51:59 +0530
Message-Id: <cover.1697710527.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wasn't able to test this locally (despite trying to hack it around) and need
help from someone who is `virt_devs` field of `struct dev_pm_opp_config`.

I asked Mani earlier to test this, which he did, but unfortunately he could only
half test it as the platform didn't have `virt_devs` configured.

Pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps

-------------------------8<-------------------------

Configuring the required OPP was never properly implemented, we just
took an exception for genpds and configured them directly, while leaving
out all other required OPP types.

Now that a standard call to dev_pm_opp_set_opp() takes care of
configuring the opp->level too, the special handling for genpds can be
avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
which shall eventually configure the corresponding level for genpds.

This also makes it possible for us to configure other type of required
OPPs (no concrete users yet though), via the same path. This is how
other frameworks take care of parent nodes, like clock, regulators, etc,
where we recursively call the same helper.

--
Viresh

Viresh Kumar (2):
  OPP: Use _set_opp_level() for single genpd case
  OPP: Call dev_pm_opp_set_opp() for required OPPs

 drivers/opp/core.c     | 144 ++++++++++++++++++-----------------------
 drivers/opp/of.c       |  35 +++++++---
 drivers/opp/opp.h      |   8 +--
 include/linux/pm_opp.h |   7 +-
 4 files changed, 98 insertions(+), 96 deletions(-)

-- 
2.31.1.272.g89b43f80a514

