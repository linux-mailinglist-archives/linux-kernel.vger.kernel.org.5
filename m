Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8A7B2F30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjI2Jcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjI2Jcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:32:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FB195;
        Fri, 29 Sep 2023 02:32:43 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:32:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695979961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/uIN1it0W3Eg412WINyJjgbanaVu7oqFOS2ToQ1k1I=;
        b=oPDlZe4EuEBJHu7RD8eXfYDqAq8Ky5aVJ4eAsVYD97sZNRueh6YGOwao7x8en3nuDXqUKU
        KeTw9CLhRyMCuR/GxcqzJpstPluTSTUHsamrcIUPZrqUunlU9Z/7jJ6FJxIWj0HlaPRUID
        tDDFhzI1iqHupi06YRMhJOv++cok1FUSJJhW1hybqNTMwagaMRVt3ds/XdClzg5rfXOIXm
        ER2y86QFPElwmqtHqzJkTmKlvmgNzyx9ksRbJwcHGKdov7ISQ10bW+xgdLw1L1SUQcfgRP
        1mrs7ot1GtPYg3xp9T6pmEVbtNxl9JLrVfkmN+osLYKFpdTSD9AvA4ex/9kP7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695979961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/uIN1it0W3Eg412WINyJjgbanaVu7oqFOS2ToQ1k1I=;
        b=T0gwaieTwhQ1cUQJdwVlYJdqFCzQ/hiiqNyQBwRtFwFAHpn9ZzDVTl9BMmFls0QVVQ0bXS
        VSEHqw15nSP+UsDw==
From:   "tip-bot2 for Baolin Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Remove redundant 'break' statement
Cc:     Baolin Liu <liubaolin@kylinos.cn>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <396ba14d.2726.189d957b74b.Coremail.liubaolin12138@163.com>
References: <396ba14d.2726.189d957b74b.Coremail.liubaolin12138@163.com>
MIME-Version: 1.0
Message-ID: <169597996101.27769.5754143943416979953.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b5034c63858d8cb44587bb1ce5a0790a1b4e4a05
Gitweb:        https://git.kernel.org/tip/b5034c63858d8cb44587bb1ce5a0790a1b4e4a05
Author:        Baolin Liu <liubaolin@kylinos.cn>
AuthorDate:    Wed, 09 Aug 2023 16:09:11 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Sep 2023 11:24:09 +02:00

x86/cpu/amd: Remove redundant 'break' statement

This break is after the return statement, so it is redundant & confusing,
and should be deleted.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/396ba14d.2726.189d957b74b.Coremail.liubaolin12138@163.com
---
 arch/x86/kernel/cpu/amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1011ce2..c3cb69e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1001,7 +1001,6 @@ static bool cpu_has_zenbleed_microcode(void)
 
 	default:
 		return false;
-		break;
 	}
 
 	if (boot_cpu_data.microcode < good_rev)
