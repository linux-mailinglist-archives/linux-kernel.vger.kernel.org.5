Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273FC7C6EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378662AbjJLM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbjJLM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:58:30 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE591
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697115505;
        bh=Uwmk00hTEYjKV2rzVHsYjkKYDdztz3twiWxYqGGVbyE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ieuk9IjTQxnuOH9lXq5WTvFtLmRtXra3wjsTOSLvYTMQq+mSevMcLN/zP8B7uQqF0
         AmZhrSqEQJZKoyzS4UhLqKnCK0BU18KMPfaeQfDj3bh8NMzXaYi93fOwWfJVle4x4U
         thIQtGZFMCrPl+w87lkTgMLKU2BPpJMXX4XlPfV5CYgaFBjdmmTlIWcEWjsYZNTBW+
         q33Eedw9geArCvXB5EmW8wTEp6ucuDHcvUNrQfsmd9aqjCwt5BJBZuM2gehgXccOIC
         0z+oVWjXEXhrozwX7kxCipjiYwSWTxWW1QgrTLTllWMSykMlx8omUFmQ+aL02l4eS5
         43FkKwrj6CLvg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S5qSd2GQDz1XSQ;
        Thu, 12 Oct 2023 08:58:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/1] sched: Make PELT acronym definition searchable
Date:   Thu, 12 Oct 2023 08:58:24 -0400
Message-Id: <20231012125824.1260774-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PELT acronym definition can be found right at the top of
kernel/sched/pelt.c (of course), but it cannot be found through use of

grep -r PELT kernel/sched/

Add the acronym "(PELT)" after "Per Entity Load Tracking" at the top of
the source file.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f310768260c..63b6cf898220 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Per Entity Load Tracking
+ * Per Entity Load Tracking (PELT)
  *
  *  Copyright (C) 2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  *
-- 
2.39.2

