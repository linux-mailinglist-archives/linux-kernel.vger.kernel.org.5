Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0577692F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGaKTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGaKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A089A6;
        Mon, 31 Jul 2023 03:19:33 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BJ75LvzBavcvQ5QWgiVoQZjevfUet52nbGsiOKDv1M=;
        b=bM0TntVmrJ71+cH6Y4HITxChw+jZt851IO/m8OEE4bStWEwSQe7LIaX3OAVgQiQDkRJQAX
        y+NJkHKSZlbe+ECTf/WFh01I1tThkJvYvkMX/Vj0TAbRgUJ+ssHFLw2T1X5aJR93s4Si4a
        SECI/iW5KYwDUdSRcT8P8Y6jUrQ04RUizc15NoW3c6LwE1ZQXHcePVYQx9Be+dizG4B2Ax
        Yshk0XaWtbai8gfozUdL8xtVUOKzIhJQkhGcJW0IeaEQNMN2caCw68p0GOCxPoVu/npeJc
        9LW9vHHUNpSnoZD86/UQk6GOy41Wfp79Yq2LW/gM4U2BtLKFRHBWI1aJTC60iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BJ75LvzBavcvQ5QWgiVoQZjevfUet52nbGsiOKDv1M=;
        b=ZwC5QBhPo2CdPPqmjedZ63R/b41w21lxN0vgco4845ybVEc/2HCV1nE6wr3lQzoVdbEM4l
        XwOCz7fWoScD0eDA==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove unused
 PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Cc:     James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724134500.970496-3-james.clark@arm.com>
References: <20230724134500.970496-3-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <169079877138.28540.11383129464821949118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4b36873b4a3455590f686903c354c4716e149c74
Gitweb:        https://git.kernel.org/tip/4b36873b4a3455590f686903c354c4716e149c74
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Mon, 24 Jul 2023 14:44:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:46 +02:00

perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability

Since commit bd2756811766 ("perf: Rewrite core context handling") the
relationship between perf_event_context and PMUs has changed so that
the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
silenced no longer exists.

Remove the capability to avoid confusion that it actually influences
any perf core behavior. This change should be a no-op.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230724134500.970496-3-james.clark@arm.com
---
 arch/x86/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 23c9642..185f902 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2166,7 +2166,6 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu = pmu;
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
-			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
