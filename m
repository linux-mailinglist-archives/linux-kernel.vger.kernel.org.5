Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46CD763148
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGZJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjGZJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:09:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E02688
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:06:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9nzg3fdgzrRwf;
        Wed, 26 Jul 2023 17:05:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 17:06:12 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <lizetao1@huawei.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <thomas.lendacky@amd.com>, <rppt@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <michael.roth@amd.com>,
        <nikunj@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/sev: Mark boot_ghcb_page and boot_ghcb static
Date:   Wed, 26 Jul 2023 17:06:59 +0000
Message-ID: <20230726170659.2474934-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sprse warning:

arch/x86/boot/compressed/sev.c:28:13: warning:
	symbol boot_ghcb_page was not declared. Should it be static?
arch/x86/boot/compressed/sev.c:29:13: warning:
	symbol boot_ghcb was not declared. Should it be static?

No functional change intended.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 arch/x86/boot/compressed/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3c..323f6298a6b2 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -25,8 +25,8 @@
 #include "error.h"
 #include "../msr.h"
 
-struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
-struct ghcb *boot_ghcb;
+static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
+static struct ghcb *boot_ghcb;
 
 /*
  * Copy a version of this function here - insn-eval.c can't be used in
-- 
2.34.1

