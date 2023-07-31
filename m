Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693A7692F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGaKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjGaKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F9B8;
        Mon, 31 Jul 2023 03:19:32 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v16GS4bcPgXubu6zg/xsRqgp7LY5t94J0pFTVC7YOBg=;
        b=zhPZa3iF1NdFWMY1j9Sxd+feLergV049NE05co7igal59f3E99sj0PRHIfwfjDCuz+iaRD
        eK7Ti9blTxwZHJLoU+UvxwH/Aqk+mMPVJgv3k3YwPGqOXarFlghscZOKDKHV4raRpvtbdo
        nKY6z8yGmtT7vir/T1vzpkW00Ebm8RackF1i2HfYrI0bt94yKhdVA2yAjbLN8TindfVlgm
        LbYVNDf243rYQezLQlefpYiamuk+iB5upHl/Hf1UFCRe3t+8j9Nc5ebY1zLW4tUWxis+Ll
        OvvfhC7p1n6k7ahHJWxOR+WRFOqKK95Fcj6qpa+26MY03bW/iibKh1GWxAaATA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v16GS4bcPgXubu6zg/xsRqgp7LY5t94J0pFTVC7YOBg=;
        b=Ll874X6WVsyBo9IaWJK6mqRxIdUuwt2sxE5slS61UqgasON3E0W4kIA9Z2PFe+Kk6+vmAs
        NecD8ALtAxsn2dAQ==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm_pmu: Remove unused
 PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Cc:     James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724134500.970496-4-james.clark@arm.com>
References: <20230724134500.970496-4-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <169079877090.28540.17067379324093297410.tip-bot2@tip-bot2>
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

Commit-ID:     80391d8c387d406e2ec79776ec834666ab9611b0
Gitweb:        https://git.kernel.org/tip/80391d8c387d406e2ec79776ec834666ab9611b0
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Mon, 24 Jul 2023 14:44:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:47 +02:00

arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability

Since commit bd2756811766 ("perf: Rewrite core context handling") the
relationship between perf_event_context and PMUs has changed so that
the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
silenced no longer exists.

Remove the capability and associated comment to avoid confusion that it
actually influences any perf core behavior. This change should be a
no-op.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230724134500.970496-4-james.clark@arm.com
---
 drivers/perf/arm_pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2e79201..d712a19 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -877,15 +877,12 @@ struct arm_pmu *armpmu_alloc(void)
 		.attr_groups	= pmu->attr_groups,
 		/*
 		 * This is a CPU PMU potentially in a heterogeneous
-		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
-		 * and we have taken ctx sharing into account (e.g. with our
-		 * pmu::filter callback and pmu::event_init group validation).
-		 *
+		 * configuration (e.g. big.LITTLE) so
 		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open
 		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
 		 * specific PMU.
 		 */
-		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
+		.capabilities	= PERF_PMU_CAP_EXTENDED_REGS |
 				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
 	};
 
