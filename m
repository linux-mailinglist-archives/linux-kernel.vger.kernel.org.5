Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4378DE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjH3TD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbjH3RnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:43:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16221107;
        Wed, 30 Aug 2023 10:43:03 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:43:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693417381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2HSt0lqIAYiAozzRD8m8t6/pcsc2XWenMSpuUgh813w=;
        b=murchX7cUNbwJx7eysAtlDUtCKfUXCsOqHZvyAX47J+DKX8c+93k79RzH0+KCqQhLtmxyg
        IXlLMAXR/E45NpQ0MZt89vX/834A9X23CuckCexRCJIurz7D38tpMEb1XN+lT2n0LFLkdC
        XPOkFlWth1fdywuDSYnA+7eQPRlynGafPkDYG+FzFTg2IDnEOcgPwzCvanTFjVl7P2XpQh
        k0hlQwunQ6RNf+aqYpVLx98c2V3mJNO6SX9LiDDWGSOyqapzS5Kd3zyMnqJ9eAm8KCjUx+
        0O1tZ2+HfApt7lNLkYepuyoyGjTpHDjXnoaDCVlviFSPa64urRTaVXReIQ5MHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693417381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2HSt0lqIAYiAozzRD8m8t6/pcsc2XWenMSpuUgh813w=;
        b=AZNRqqY8hjTPrmqDQ99fQFVEOqBA+qRdkGC0l+5BdH+lBravDo2WDFu3XhmFoRW75YO8Wg
        Qiaw3c3lYo4tPNBg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Change order of __user in type
Cc:     kernel test robot <lkp@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169341738043.27769.17879474325654123719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     1fe428d3692fb10a0e8d85fafe719b154e43ad4e
Gitweb:        https://git.kernel.org/tip/1fe428d3692fb10a0e8d85fafe719b154e43ad4e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Thu, 24 Aug 2023 18:45:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 30 Aug 2023 10:35:53 -07:00

x86/shstk: Change order of __user in type

0day reports a sparse warning:
arch/x86/kernel/shstk.c:295:55: sparse: sparse: cast removes address space
'__user' of expression

The __user is in the wrong spot. Move it to right spot and make sparse
happy.

Closes: https://lore.kernel.org/oe-kbuild-all/202308222312.Jt4Tog5T-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230825014554.1769194-1-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index cd10d07..fd68992 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -275,7 +275,7 @@ static int shstk_push_sigframe(unsigned long *ssp)
 		return -EINVAL;
 
 	*ssp -= SS_FRAME_SIZE;
-	if (put_shstk_data((void *__user)*ssp, target_ssp))
+	if (put_shstk_data((void __user *)*ssp, target_ssp))
 		return -EFAULT;
 
 	return 0;
