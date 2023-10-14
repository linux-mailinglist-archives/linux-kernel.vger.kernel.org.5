Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13907C92C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjJNEj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJNEjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:39:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16203C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b2018a11efso1263642b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1697258393; x=1697863193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IO5psIUHOcx6xz4P4p7pIE6VmBT0LrXpXuleTpT22S4=;
        b=dKtl7Dls65rqUJ8uxnPw7PkMsLxUhq+QinkLc2Qu5AaSXDnJwzxjJ9Gb90HY4KNLmc
         iwhguf4R6d/IqTQhS79WJ7ywpX0kM0tR4Cp7e31mslqgSIYOvufrSisYqQv80fwvl0Mn
         07QH3+Ik4W9ashXp+p5Nhld1ZTBYtq9QMEbVOZrFTgG3orBm/3OGFluTtPNeRIiW5L1+
         iUpUSuFny/2gss9kb2VWAhplmkAf296ALZOlKTZupzR0OYvAkGjgKGiVkt0d6kYMepQR
         z13gZcSk/iDBMwHGUMSIhXs0a42eyU9zOsp2xBMYvepFjEAJvKcLShu3N86182DD0X46
         0rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697258393; x=1697863193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO5psIUHOcx6xz4P4p7pIE6VmBT0LrXpXuleTpT22S4=;
        b=BAUdnXkrDKzWJw2m4DYtZIAB4xOtOqvf6m6av0mZnO1irKRLQBViCW7OoZ2UqM/vmF
         KcmNemq975Nm7BN17rce2tiVSjluQ5DFpdoYCn7UlL9VDMFlOb7wAq+vIXI3gvzGwO1f
         dXlQLSD+EqSpNp67z6gDNhlS9biYSQl3xtmA5kT8Nmq6NzfaU/3Qsp0bUQCqUa85/knR
         OF0GP1m3fOCsPNok77FWcUmMayG91/Dx2/phRbB4os/QB7AxgkcT43Uk6IKAS2G0/3zm
         BIAcOYxQYGKR0gl1gzekwnH+ARAyC54RlZlL7/lRSqJi9R0RHAoAWD1e6+XflBD5n6cC
         9/WA==
X-Gm-Message-State: AOJu0YwmFRmcNma68bcsNzo801admQM0/CmXwI767eVHFOng7oxz4UdY
        XsKC73X1AT3vH5Tvox7A51Aq6w==
X-Google-Smtp-Source: AGHT+IGRvR1Vx+xE646Iq6UlDT5H7Zwh0/g1kuIgt5ZArE2J5BNx1z/XkRa7LXessGSx3qbjOqGicQ==
X-Received: by 2002:a05:6a00:1989:b0:68f:e121:b37c with SMTP id d9-20020a056a00198900b0068fe121b37cmr33741447pfl.4.1697258393451;
        Fri, 13 Oct 2023 21:39:53 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm14271926pfm.109.2023.10.13.21.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:39:53 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/4] Staging: rtl8192e: Variable renames to fix checkpatch
Date:   Fri, 13 Oct 2023 21:44:31 -0700
Message-ID: <20231014044435.11947-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames 4 varialbes to fix checkpatch warning Avoid
CamelCase.

Thank you in advance to all reviewers
~Tree

Tree Davies (4):
  Staging: rtl8192e: Rename variable pBa
  Staging: rtl8192e: Rename variable TSInfo
  Staging: rtl8192e: Rename variable ReasonCode
  Staging: rtl8192e: Rename variable pTS

 drivers/staging/rtl8192e/rtl819x_BAProc.c |  58 ++++++-------
 drivers/staging/rtl8192e/rtl819x_Qos.h    |   2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 100 +++++++++++-----------
 drivers/staging/rtl8192e/rtllib.h         |   2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |   8 +-
 5 files changed, 85 insertions(+), 85 deletions(-)

-- 
2.39.2

