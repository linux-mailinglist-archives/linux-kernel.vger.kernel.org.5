Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDC778DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHKLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:37:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75D2723
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:37:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe98583a6fso560353e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691753856; x=1692358656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkPDrqo63Dwtbt3LNOF+f4oaGE4j8leqTEKJPCVRSuU=;
        b=bYk4Q6Sho68yW0NFmpHwV/y3xRSc1O0Nb5k3PDOD8CPxVZF15W2f8Vq6guxH14STxZ
         4Cq2h5O0cq5K9U2OUPs8m58Lw3CpveUbvGSdnxNE2NJvLwBZZ8gLBn6vG+HnH8by98Zx
         JETfULNKeqXwVUJRfdFr6klhs7DBWkVqIXmKdU/WNulBiwX0Imy0BlBg66vI1bM8GRak
         s1rQ9wJKOSyczm1I3CZSb3PFfEp+GdnazuRSF9tSsuMZazG67JraeGTRMhqL3lbYNsvc
         pCBk4zumXeBFsUDwo5b9XeQGcGt0O+lPZU+c4t5s+eCDik2JkwFxCxtWlhYo3UVSiJP4
         y6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691753856; x=1692358656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkPDrqo63Dwtbt3LNOF+f4oaGE4j8leqTEKJPCVRSuU=;
        b=GN60pfQSSTjQjRjCfGEMzaNxdCvsRsTFvJV0GFU2AnDlkoGdSXAZYOWptze+OYsStT
         kt91lJT3cOO2AJTkHwyxaS2tn4CROXlgRm8ZCf4Sht9j8zB6zXcYaWCl6eQ2zyGDls8U
         iCMBrSN5blbJxmMglnd3rw7DD5kulFCO+WU5KGAHjY4081qGEJi2qtpPyuVTz1ypvGfp
         1BXOFL8DKTuklshNXhODsnY1dCn+kfxQPVKK7a7UjeL1NrD8E2RwctNbeHR7OWG0CmPe
         wMLXc2Ky8VpLIgqqU6DO8Oks3BmlaG+hfIbwRJt0g5l5ZF3U/b40rPmimRKzMGlhGhxl
         y+gw==
X-Gm-Message-State: AOJu0YzYrdwNj/eu3iFvwAJ1iJdXlpNJ6Rr24WJTFNbZbgvGw8CIgP7j
        POqlU2ppjpa2stefkfZlx2QxKA==
X-Google-Smtp-Source: AGHT+IEWzKapxcbdbNLQ/i8bHcbGZPMgzoaHNNWjo26Jkj4rwr+7qIDS1eZuSY7EtTlFGDqi0/0JRw==
X-Received: by 2002:a05:6512:ace:b0:4f8:77db:1d9e with SMTP id n14-20020a0565120ace00b004f877db1d9emr1362086lfu.12.1691753856314;
        Fri, 11 Aug 2023 04:37:36 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b004fe3093f1bbsm699093lfq.105.2023.08.11.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:37:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Wing Li <wingers@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] cpuidle-psci fixes for v6.5-rc6
Date:   Fri, 11 Aug 2023 13:37:34 +0200
Message-Id: <20230811113734.158421-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of cpuidle-psci fixes intended for v6.5-rc6. Usually,
this is managed by arm-soc maintainers or Rafael, although due to a busy period
I have stepped in to help out.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/cpuidle-psci-v6.5-rc5

for you to fetch changes up to 12acb348fa4528a4203edf1cce7a3be2c9af2279:

  cpuidle: psci: Move enabling OSI mode after power domains creation (2023-08-08 16:07:01 +0200)

----------------------------------------------------------------
cpuidle: psci
 - Fix the error path to prevent reverting from OSI back to PC mode

----------------------------------------------------------------
Maulik Shah (2):
      cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
      cpuidle: psci: Move enabling OSI mode after power domains creation

 drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++++++++++-----------------------
 drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h       |  7 +++++++
 3 files changed, 44 insertions(+), 26 deletions(-)
