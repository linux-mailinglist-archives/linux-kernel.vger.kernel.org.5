Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C797AD5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIYKXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIYKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:23:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604539F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:23:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5ff5f858dso13695825ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695637381; x=1696242181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsVwcIMcXgFsiUVKDmRKkuK9uYVF+Xg1uxYKZQZf4yM=;
        b=SWJxSoHLHLgf2sAZD+N71VMECKuV8WjksKd0FTMZLArWuunGL0dKoGHFPrkPRx89ad
         1opH1D8yevN1DaOIZfdezgVJmzOrB4O7/YdXIYRZFpGzDTtEE4AIicIqvEzRJozI3c7I
         Qc6yWke8erwxzYrS/mUuXfxRhng3ZIy7kos4c+mliJ1qLcE9THlBEkzd5zAZJsPaGT1S
         fcIididvEuZVtE/30sjFWZxN5bxxVkOVFheTFVVXnlfmRK7ZEVmLvZAGAZRWhoSr3oTB
         TC+pPNxJ5FqwahBzk1L6vbv7XqNAHHPduqhqIZR5/3RamrOQ6oIhUQqqr6ESL2RfLm5r
         Kypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637381; x=1696242181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsVwcIMcXgFsiUVKDmRKkuK9uYVF+Xg1uxYKZQZf4yM=;
        b=RnS2xow0FdV4V0Qi7X54t3bwCGQ4baHQ31L2rgb6+tpbas+fbV3LQUM/pdZ88MYT1b
         t5yozXdpp85xdW5WAPzu2HISxZOOiDMrA5jrfaUH2WJ3hIvoykcbmMESejABjEahoAQF
         VdVuW8STnKV+51Kv1prn/Cyh2pMN/eG+edGZbKE+0b3PwHY4jIKki0VLG7+fdAgPxsDJ
         iBzAAd3WXJMWgZZZsRiVuZSRJGxRkIrfU9g7ktNPAuKwT3FjMwor27yps5KHgcPYpQqb
         qyIf6Lac/yp6ymeRBIxsfFRAWQhD/2df8ykew1P44sikQ8f2Zm8jdwymZRhlMBaKy2mz
         zL4A==
X-Gm-Message-State: AOJu0YwEk1iJB63KTWU/QMLG4Gf2AZIRGwZBToEACznih+mvz3ajtSQh
        ZRl3DphlX+67Vaq64tWL9+lRnCGL2FnY6pxgn3of5JWv
X-Google-Smtp-Source: AGHT+IEZ7d4P3qcW+wk5sDjS4b+88VZbzxe9t6593nd4yav94JX6PPcrSkuyCmsgDnpCv6tJlA1Ffw==
X-Received: by 2002:a17:903:26d4:b0:1c1:f3f8:3949 with SMTP id jg20-20020a17090326d400b001c1f3f83949mr3992812plb.1.1695637380840;
        Mon, 25 Sep 2023 03:23:00 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902868900b001bbdf32f011sm8385011plo.269.2023.09.25.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:23:00 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     hannes@cmpxchg.org
Cc:     surenb@google.com, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] sched/psi: bail out early from irq time accounting
Date:   Mon, 25 Sep 2023 10:21:43 +0000
Message-Id: <20230925102143.462545-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could bail out early when psi was disabled.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..e74e14762d49 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1005,6 +1005,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 	struct psi_group_cpu *groupc;
 	u64 now;
 
+	if (static_branch_likely(&psi_disabled))
+		return;
+
 	if (!task->pid)
 		return;
 
-- 
2.25.1

