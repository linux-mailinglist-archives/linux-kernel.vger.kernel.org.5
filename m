Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546BD778420
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHJX3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHJX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:29:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C7270F;
        Thu, 10 Aug 2023 16:29:14 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:29:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691710151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qzz2rJbDMwtqi+XPUXa6GMdkxcSTLqzLBFlCQ0ojhsA=;
        b=0Onl/r8SDqIpcMTNPkT9+/pwvrtLztRR7og50ZMjCZ25rCk7jwdiRLKrY44wM4VroU9kwe
        5o4OsK90/MnG43xk/6veRZDol3O1ZeNbu1KSpMv295D6rsS+led3c1aJFnPx55XYGBprOy
        yN9zS0w4qw1jndw4Xr1PNSjWWeuehImCM8E5KpTU67Vh3pVK1peVYDm8FtLxlcSDKtNP5Z
        hYkP9F8Ueliqn8emUqkpQfNppN4XguPctsP4YMvHcqpJWIVLSy10L1qck8kgicFo4MMTzq
        5T8LMlPeVcd/PcZ8mwxI6EANVL8PXnOjn2wPbAVipboTawEDMkLcX8ZE8P7TSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691710151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qzz2rJbDMwtqi+XPUXa6GMdkxcSTLqzLBFlCQ0ojhsA=;
        b=tW+T1rftDFNJLZHKnA7KJPwVvAdDwhKUNh5UKA51+hrA86j+783o+5MxV11JpGn3oTK4mq
        RQ+A/fRI/Ssi4QDA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/speculation: Add cpu_show_gds() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        stable@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169171015127.27769.17078494858704021692.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a57c27c7ad85c420b7de44c6ee56692d51709dda
Gitweb:        https://git.kernel.org/tip/a57c27c7ad85c420b7de44c6ee56692d51709dda
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 09 Aug 2023 15:04:59 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 10 Aug 2023 09:12:18 -07:00

x86/speculation: Add cpu_show_gds() prototype

The newly added function has two definitions but no prototypes:

drivers/base/cpu.c:605:16: error: no previous prototype for 'cpu_show_gds' [-Werror=missing-prototypes]

Add a declaration next to the other ones for this file to avoid the
warning.

Fixes: 8974eb588283b ("x86/speculation: Add Gather Data Sampling mitigation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/all/20230809130530.1913368-1-arnd%40kernel.org
---
 include/linux/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 23ac87b..e006c71 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -72,6 +72,8 @@ extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_gds(struct device *dev,
+			    struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
