Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814707A71DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjITFWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjITFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CEBE6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hCZcNUEy4iqLT3BAp5Zoej2cmdoBsoAXgP3KswQYSrE=; b=DIAVfUJS2KXuakukko0SKLHbFp
        t9u7QyAhg5MDEAde3gUpXH6h4s815PqfeTOLmnk1gfaw8Nzv6zIVxyJf4hhaplD0UoXPyEyQ2kEnW
        1FwEC4rxjmxL7QmlWjQPq78QurRReQw7FsjVouJ9t0/7JGJ1IErgDX+BBbsYA3Q1NoKeEuUTDEiR2
        pHIUrw3fHbam4Qno1CTOVAY6txi4E3LfoB/VJwwpGq1HymSpkBVfs7iK8uFSLSSh83nHLeXK8+bO5
        Oxy+YIPXMSKElgKKPkkKv/i5wKSn3R+VZR6oYCuMMVr/7tIYz/zqdKzwPez4LP7TbBRTJoBAV5AkK
        tdJ5gkqA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeg-001tym-23;
        Wed, 20 Sep 2023 05:21:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 02/16] xtensa: fault: include <asm/traps.h>
Date:   Tue, 19 Sep 2023 22:21:25 -0700
Message-ID: <20230920052139.10570-3-rdunlap@infradead.org>
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

Use <asm/traps.h> to provide the function prototype for do_page_fault()
to prevent a build warning:

arch/xtensa/mm/fault.c:87:6: warning: no previous prototype for 'do_page_fault' [-Wmissing-prototypes]
   87 | void do_page_fault(struct pt_regs *regs)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/fault.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -20,6 +20,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/hardirq.h>
+#include <asm/traps.h>
 
 void bad_page_fault(struct pt_regs*, unsigned long, int);
 
