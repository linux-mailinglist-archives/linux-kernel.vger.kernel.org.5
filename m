Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C775C331
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGUJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGUJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826EF2D4A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b9cd6a0051so11754135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932470; x=1690537270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfVjb+XTXQMZBJMVJn4MrXS6wRwbcO0K1EZZjr+U+hw=;
        b=Yl2LgVrUYyludPDYyQwOZ8HvgZpfli3mRz9cabR+eZEGSXEP9ppuStt5XbHMbXa1Cw
         n01cO9TxURDYRcRRoxHId+EhzEckok9HaHl0/AfSlG5opj+hCiQ6VeUibAw2rJMXd+gD
         aKBFR8hxXqjB/vAY5KcH4IK89XrEJcxyTojPC2cERxuXDP96tKFsmHjd9i+HslJrVvQM
         Au/Ot68Qw+1m3vSGJdczQUrC2vwCbKYeXXT6s3pwh4oOPxbCGLK6qdY5NJ6HH8tLHkhj
         zZ2ZraEIig7jP/8ypK+wsBCLQYyhktJw4v00kOXx4eN3tAeUF1iyuevds1x3QYIUbcdt
         95iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932470; x=1690537270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfVjb+XTXQMZBJMVJn4MrXS6wRwbcO0K1EZZjr+U+hw=;
        b=Y28gOm2iCf3xoDv8FCPPBGe4qwLrHaK1FREnjBIqESmjiowxv01Wr7U4MeiGgPXQB4
         wqdHPd+wGe76gzNdHkJSkRli6LsfdQpfnaFBI/lx/uXbgaDycpQ29xUd5jUnLzA+b+BP
         nm/CzD9IGaixYBFMhScy/xM2/iYghdpU9nbRmeGTO7aocifIuJJDztXA13VZzI8sNGlv
         diZpT/QUL64gOMGfbJTi3h1bkZ3lGXbeaqobrZ/L9d48EJWoHMDbvx28SZBzVmWdRfzm
         /74Iu+jv+4M4bPbjW9yqUxzdnZU79SAQ6wPllLTe0xoi3/xwSJ7COb6Rgpsgqu8gKbyV
         /EGA==
X-Gm-Message-State: ABy/qLaVT/aSS57Y1hYwXn4kv+ax1aHABLyG4os5wqLlD5D6O7ZdoNWr
        ctySL/psv9XSnCN9Yws9zm8D0w==
X-Google-Smtp-Source: APBJJlEVcLQFoRpP2ZdOULBfard9br9JYX0AOcHyewsuorbPDYMKqlgGhJOqVozxBZZ5zkEZf50cFQ==
X-Received: by 2002:a17:902:9f88:b0:1b9:e1d6:7c30 with SMTP id g8-20020a1709029f8800b001b9e1d67c30mr1030899plq.39.1689932469892;
        Fri, 21 Jul 2023 02:41:09 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b9fdeead86sm2988654plb.68.2023.07.21.02.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] OPP: Indexed searching based on frequency
Date:   Fri, 21 Jul 2023 15:10:53 +0530
Message-Id: <cover.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for indexed versions OPP finding helpers.
Some of these are picked from the series posted by Manivannan.

--
Viresh

Manivannan Sadhasivam (2):
  OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
  OPP: Introduce dev_pm_opp_get_freq_indexed() API

Viresh Kumar (4):
  OPP: Rearrange entries in pm_opp.h
  OPP: Add dev_pm_opp_find_freq_exact_indexed()
  OPP: Update _read_freq() to return the correct frequency
  OPP: Reuse dev_pm_opp_get_freq_indexed()

 drivers/opp/core.c     | 109 ++++++++++++++++++++++++++++++++++++-----
 include/linux/pm_opp.h |  62 ++++++++++++++++++-----
 2 files changed, 146 insertions(+), 25 deletions(-)

-- 
2.31.1.272.g89b43f80a514

