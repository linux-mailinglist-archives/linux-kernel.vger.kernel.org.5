Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD70E7768D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjHITfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjHITfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:35:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C910EC;
        Wed,  9 Aug 2023 12:34:59 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691609698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5+5UtRrIxn3jRSLl4kFwCzs3C2Jy/YlqVtMo7BDAa0=;
        b=GKLf7UfYGLOYOzYVhC7XMOxJFtFM1Gd7K31QGQez4TxIdRq/r4inidj/QF+P8r+nO5SR7Z
        sV9uUGN/7tzLtwSZWGQikuCiS+14N6SliznuvxRrsyaW3W4MPmkBs/6ljmZVe3/xyQEZTG
        6ck9rTzMUxZOmPGZPaB8fMjEhzzWpnCI447qD4YXbGxatDImwADc2VXyMVmVELMH0+tStm
        GfT/lA5qgFGFdNVmuBV/wfmRngAvgY4pEPdCPyipctrFFKnjhGy11CCQQBZFLaPJATb5tm
        v7yNhqpBThBdBg8Ot/R+drNviSzMgN8tHDvMkpRv/0FJ4lZL2dds+S+fg7pQfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691609698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5+5UtRrIxn3jRSLl4kFwCzs3C2Jy/YlqVtMo7BDAa0=;
        b=n5CIhLDKBN9sb0zNwNstN1mqiejGghogVXC+5JlzKGdHyQ23BjGp8dlY33+Apa5Oz9dhka
        w9I6enpGcsMAmuAQ==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] MAINTAINERS: Add Peter explicitly to the psi section
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801133235.GA1766885@cmpxchg.org>
References: <20230801133235.GA1766885@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <169160969747.27769.17107965601991518052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     113d0a6b3954b57907d1a6e3209f4174f504e0ae
Gitweb:        https://git.kernel.org/tip/113d0a6b3954b57907d1a6e3209f4174f504e0ae
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Tue, 01 Aug 2023 09:18:21 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:19:25 +02:00

MAINTAINERS: Add Peter explicitly to the psi section

Peter is kind enough to route the low-volume psi patches through the
scheduler tree, but he is frequently not CC'd on them.

While he is matched through the SCHEDULER maintainers and reviewers on
kern/sched/*, that list is long, and mostly not applicable to psi
code. Thus, patch submitters often just CC the explicit PSI entries.

Add him to that section, to make sure he gets those patches.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230801133235.GA1766885@cmpxchg.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee3406..f017dc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17047,6 +17047,7 @@ F:	drivers/net/ppp/pptp.c
 PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Suren Baghdasaryan <surenb@google.com>
+R:	Peter Ziljstra <peterz@infradead.org>
 S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
