Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85D7E549B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjKHK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344528AbjKHK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:57:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8B19BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:57:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc316ccc38so54938985ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699441040; x=1700045840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn2IA5P26vaovRSBo2ciBaT5wWZFGHvMT0WOwKqY8ag=;
        b=kl4br25R6LOG23ScjAqRq3bCG0JzK68uySVKr7cuJcf+vuTTU+CKPZOuPjBHeYU2O7
         mUWI8C0EXBP0cQF5bfndLpdkURamngqmvfpVmbRZzSetRlVxk5PFYSobjLorDzA+SXHG
         cQeW3vwP9J3I5uXXoE91NJciUezQJfq9PHQqUSYFcAA5WFwdzcNPkeTFsjEdveiwnpRq
         8oQN/F1myWSTdOQ2uoW38MqlT+TlMOKEmH5KfoShPGFhT73x6XEWEuerm6yOex6NAHbt
         UjiDxBTAiXEX8YuPRv5lDcimQW9LY2u8grbxg+RayT9I204b5EeZ/ff9gME87VQItPpW
         vlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441040; x=1700045840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn2IA5P26vaovRSBo2ciBaT5wWZFGHvMT0WOwKqY8ag=;
        b=YmsTg0TsoQqR4A+UUq+NoxSNLBKdVSTzEWWH42Fp0ULpNUBaoMUqGNzZd2mnI8HXTF
         dUYtqgjX8+lsj6qocB58JWagvw4Pcym8+qnZ0ey94db1TChQQTXEe/hODK5nZpPCxZpo
         RD5IhJQPz0KZdSDbAuideVzU44Ci/M1F7QhHBshz9jCh8hSAfrN/EUxoetnA+Ofvue2f
         o7XJpJOWQ1NmOndNScOdo3mQH3nRTBpQzGz8RmXH1apNPv6Wx9IyZlPe7NfUJmQE1s/P
         yDU6YCiCcHSz5/IGL2TydoYVhL5n6Vij7QvsejB9+djEaHBGyzDkL3VHXi4HbInxSUgU
         +JMg==
X-Gm-Message-State: AOJu0YwqaRe+J/Ws+WLagVC6Fi6KdzvjMV5rzXDvg7/ysj2EJpetIbRr
        ozKFMxg5eUICn/HwdHpbDXiqRw==
X-Google-Smtp-Source: AGHT+IFsEHiBs+GUg94W8pGM8xCL2qiuzgZ4Br6QxIZzk5KWFX8UXnJZch0PBgZ+Dylr4VUKAkQ38Q==
X-Received: by 2002:a17:903:11ce:b0:1cc:b09a:b811 with SMTP id q14-20020a17090311ce00b001ccb09ab811mr1864075plh.14.1699441040125;
        Wed, 08 Nov 2023 02:57:20 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001cc79f3c60csm1468546plj.31.2023.11.08.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:57:19 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     longman@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] locking/rwsem: Remove unnessary check in rwsem_down_read_slowpath()
Date:   Wed,  8 Nov 2023 10:56:39 +0000
Message-Id: <20231108105639.70088-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the owner of rw_semaphore is reader, the count can't be
RWSEM_WRITER_LOCKED, so there is no need to check it.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/locking/rwsem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..7a4d8a9ebd9c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1005,8 +1005,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	 * waiter, don't attempt optimistic lock stealing if the lock is
 	 * currently owned by readers.
 	 */
-	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
-	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
+	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) && (rcnt > 1))
 		goto queue;
 
 	/*
-- 
2.25.1

