Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B927E1C21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjKFI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:27:55 -0500
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D84A136
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:27:33 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56548a373cd0-97572;
        Mon, 06 Nov 2023 16:27:31 +0800 (CST)
X-RM-TRANSID: 2ee56548a373cd0-97572
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46548a372109-4865e;
        Mon, 06 Nov 2023 16:27:31 +0800 (CST)
X-RM-TRANSID: 2ee46548a372109-4865e
From:   zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To:     rdunlap@infradead.org, James.Bottomley@hansenpartnership.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] mm:hugetlb_cgroup: Fix the wrong format specifier
Date:   Mon,  6 Nov 2023 16:27:23 +0800
Message-Id: <20231106082723.8728-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long type should use "%ld" instead of "%lu".

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index dedd2edb0..3c132795c 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -696,7 +696,7 @@ static int __hugetlb_events_show(struct seq_file *seq, bool local)
 	else
 		max = atomic_long_read(&h_cg->events[idx][HUGETLB_MAX]);
 
-	seq_printf(seq, "max %lu\n", max);
+	seq_printf(seq, "max %ld\n", max);
 
 	return 0;
 }
-- 
2.33.0



