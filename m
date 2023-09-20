Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CC7A71E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjITFWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjITFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C444E110
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kk6lZRO/t/J9IUZNk6Jb2vRh19MJNCWq1VrhGxnRYi8=; b=gIuisHB8CA3PMSlxEJHLzHsXqn
        K9TT1b2fTS35Y51d5hXTQl5kUvyCsHiWLpWymn00kdEeBQn79xhQPRktUY2dMy7bfz8tbQ/v4MUQ7
        bAhptWXh/DI75Z8tKKEU5XE8yb7PvFVI+GJkVyCrW8WyddUuGkTvkgWCe2e3qZiAEQ7duYoO/ZmOf
        NXQHhcWQvGsVLPKJhZ92iCesGBhbKIQF65DSfpzFBBxvHIbJ+S9Jlj/1SqKpIY4QM6K3gMa5IiC52
        5049TX/Zl7t2x3bxvzU+FI/1zx0M+kFoxBv1JD1PNL2EB5nNwySTEfk4US96J0avdQg/dKUTIdIzM
        mHd1dhlQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeh-001tym-1f;
        Wed, 20 Sep 2023 05:21:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 05/16] xtensa: processor.h: add init_arch() prototype
Date:   Tue, 19 Sep 2023 22:21:28 -0700
Message-ID: <20230920052139.10570-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the prototype for init_arch() to asm/processor.h to prevent a
build warning:

arch/xtensa/kernel/setup.c:244:13: warning: no previous prototype for 'init_arch' [-Wmissing-prototypes]
  244 | void __init init_arch(bp_tag_t *bp_start)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/processor.h |    4 ++++
 1 file changed, 4 insertions(+)

diff -- a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -14,6 +14,8 @@
 
 #include <linux/compiler.h>
 #include <linux/stringify.h>
+
+#include <asm/bootparam.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/regs.h>
@@ -217,6 +219,8 @@ struct mm_struct;
 
 extern unsigned long __get_wchan(struct task_struct *p);
 
+void init_arch(bp_tag_t *bp_start);
+
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
 
