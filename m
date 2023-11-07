Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226997E8122
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344675AbjKJSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbjKJSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:23:05 -0500
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC0428B08
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:23:22 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2654e04959aa-37cd9;
        Fri, 10 Nov 2023 18:23:20 +0800 (CST)
X-RM-TRANSID: 2ee2654e04959aa-37cd9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8654e0496769-12c5b;
        Fri, 10 Nov 2023 18:23:20 +0800 (CST)
X-RM-TRANSID: 2ee8654e0496769-12c5b
From:   zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To:     rdunlap@infradead.org
Cc:     James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        zhaimingbing@cmss.chinamobile.com
Subject: [PATCH V2] mm:hugetlb_cgroup: Optimize variable initialization
Date:   Wed,  8 Nov 2023 05:13:07 +0800
Message-Id: <20231107211307.14279-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <785e7f99-ccb9-4640-b554-825061f73ee1@infradead.org>
References: <785e7f99-ccb9-4640-b554-825061f73ee1@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize 'max' with 'unsigned long' instead of 'long'.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index dedd2edb0..d4ca2ac55 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -685,7 +685,7 @@ static char *mem_fmt(char *buf, int size, unsigned long hsize)
 static int __hugetlb_events_show(struct seq_file *seq, bool local)
 {
 	int idx;
-	long max;
+	unsigned long max;
 	struct cftype *cft = seq_cft(seq);
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
 
-- 
2.33.0



