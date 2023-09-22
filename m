Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D07AAC52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjIVINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjIVIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:12:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166ED1BFF;
        Fri, 22 Sep 2023 01:12:16 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zIjjyICu9jgMK43t3DhKBMd6B4Guoddzcy+mtiYR0/4=;
        b=WXQqho3IrubgdyV4BejLJ3/KLwdunxUMlXu9+MVVbExUKBgacvXVTP2TPJcDYpfezxwIET
        oOaI3w2zhj7ksEbzENU7a3+6w/Bokgj6K4kUmM5Y8J1R7pndzD1PUNCoZF4+xIAFTlzFkI
        8IKn0VmyoF/DQQm0de7U97259ffZv5TzgyQf/nIUBq9gaZrkIkZ6X4/wxLXgZRyCuG+7Xh
        bvMh/LUi4cVHbCUyl/BdCSq+jOYnN/RpYTzSK+M7m5/kdQ/ZAq5Xhtm3JMWCNP1ydYomEX
        n+AmjT8Ju0TT6h3igDTvwYrKTxlTT9PfNxH7q0vQB3XHCn0OSh7V2GH07cuw1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zIjjyICu9jgMK43t3DhKBMd6B4Guoddzcy+mtiYR0/4=;
        b=BfgeIdM6OQPI6m8b/0GBu0K1GkPNxSjEJ9Vz1NuqKb2tXg9CAyi8+LbnPzM3EaS7bDt/SE
        tEbQcTVB/ct4ieDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] <linux/list.h>: Introduce the
 list_for_each_reverse() method
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169537033408.27769.12070730521509427015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8bf0cdfac7f8aa3fa6151b5c5f5eebdb44a64e89
Gitweb:        https://git.kernel.org/tip/8bf0cdfac7f8aa3fa6151b5c5f5eebdb44a64e89
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 21 Sep 2023 11:32:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:38:42 +02:00

<linux/list.h>: Introduce the list_for_each_reverse() method

The list_head counterpart of list_for_each_entry_reverse() was missing,
add it to complete the list handling APIs in <linux/list.h>.

[ This new API is also relied on by a WIP scheduler patch, so this
  variant is not a theoretical possibility only. ]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/list.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 164b4d0..1837cae 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -687,6 +687,14 @@ static inline void list_splice_tail_init(struct list_head *list,
 	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
 /**
+ * list_for_each_reverse - iterate backwards over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each_reverse(pos, head) \
+	for (pos = (head)->prev; pos != (head); pos = pos->prev)
+
+/**
  * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
  * @pos:	the &struct list_head to use as a loop cursor.
  * @head:	the head for your list.
