Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467567C6E78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbjJLMvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbjJLMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:50:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE5CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:50:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27b22de9b5bso654844a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115057; x=1697719857; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G875lR9e4K6JzzqFQjwIG6tgL2EBPo5TFmSbi4YHY6s=;
        b=P0udcksLBmXrLb6kxUIdkdb8cRtt4B6rSfsm7DfsYmKD/yyprz8t1Km9sppYJ3FUKA
         UDhrrJ61QPb+sY2q8+tEbceCUNSS0uu/h/hqB3BNQoCQSkbY9plg+0PuGhBOrhyADuMG
         WmlXjdHANKT65ff49GkWIcHuuhFC0sVBhIEHGXg76kxy+9Ql6wiRq+6pNJbxL+u6KgaS
         +5A0p1bRV7Eyn6xBlCLP6UCcb5vqCahHVVNh4g3L1zzXdcmu+mBKUkhoe4JajBpfekqf
         KPE2oN4TdiAWs6PUeEsqaW4Xm13n3L7esBW0tDrvNSEljc7yGgdg4yGqbCeMVMA/DR4p
         5m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115057; x=1697719857;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G875lR9e4K6JzzqFQjwIG6tgL2EBPo5TFmSbi4YHY6s=;
        b=aZeVR7bFuH2kEA3XXkvTGG+Pz1YA2bikpvojPe7AfABCTrGnXoQPiB+GwGcqJMmzfk
         Tt4UL4ZrcDcb/a+33O7YcTnwiHBSXLhCWqZ8sL9hEEyZcq1QVJZ2PtVyWz/YpaK8F0uJ
         MY5/i2SyIJ3NreCjg5aNN/oEOtGH/gBQ7rEO7k915GTQK6ZWWI+ackVAWL81v03rmwBf
         GZEwPHk7OIPKVYfHNOW6UjEd6V2vRX6DB/0Xc4r/sR7zeABJmifPMcqEH0hDM3+8/tfU
         UE0xHDx9mUwh76GIbO0sm0COguKfj3Os7eDJE2YF2SNNOoIKmRO0BGVxt47vaTgXhlA6
         2prA==
X-Gm-Message-State: AOJu0Yzu+Q3miGeExMtKKCiCZwbnPjEjg8ggYy1j4+ik88AynrYUMn3A
        H31IoVxL0GAQBFemldBpZlVuFDOt80MWXg==
X-Google-Smtp-Source: AGHT+IF4hfw/QbwiGe1+9mT91FI/lvIRw9/Nkg/diggzdi6I7n7W+x4AsQMJxHKg5rrYah728ADZpA==
X-Received: by 2002:a17:90a:454e:b0:27d:1862:a494 with SMTP id r14-20020a17090a454e00b0027d1862a494mr2691566pjm.11.1697115057224;
        Thu, 12 Oct 2023 05:50:57 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id gw17-20020a17090b0a5100b002772faee740sm1796252pjb.5.2023.10.12.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:50:57 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rts5208: Fix checkpatch macro warnings
Date:   Thu, 12 Oct 2023 05:50:21 -0700
Message-Id: <cover.1697113047.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the driver staging/rts5208, checkpatch.pl warns of possible precedence 
issues in the header rtsx.h because macro arguments are not parenthesized.
This patch set handles the respective macros differently(as needed) in 
each patch to fix the warnings. Patches can be applied in any order.

Soumya Negi (2):
  staging: rts5208: Refactor macros to static inline functions
  staging: rts5208: Remove macros scsi_lock(), scsi_unlock()

 drivers/staging/rts5208/rtsx.c | 24 ++++++-------
 drivers/staging/rts5208/rtsx.h | 66 ++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 38 deletions(-)

-- 
2.17.1

