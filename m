Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A77692F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjGaKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGaKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D1B3;
        Mon, 31 Jul 2023 03:19:33 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUvVENE9Gsx+H3JT+ddrJSzNgoAMWPAc5e0sCxh3bgo=;
        b=ocGV9PexRhKMtEhPVFITCxB7xmiT/qIT1J9h0WV48NTtwIrC/S6wl0IXWL3jwNccmqbFSx
        i/oajtz7/id/TCOLNfZwb7qu+V4mSRXZJuvuf/mf07zzVCFbd0c9wTH42XIAzCmqdF9su1
        MEKGVFJH9QE1cwBi7lbqn8l4ycf67ljIl59j8KoEENqG66ZzQEUT+YuuIcG5yv13ytJFbE
        yJ9Xo8OlFOkzau8EDygj1GgZ2dSq9xFZlzE/hfz/03wOE+dh7L2wK+dp0l5zTOtQu4wDki
        edZPjc9I7tPA/VNDwmlCGwBkaQ02gkcY4ikJ3hKWtDCNYlSDdzqiKEF/565x9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUvVENE9Gsx+H3JT+ddrJSzNgoAMWPAc5e0sCxh3bgo=;
        b=/fJi71ysUZY5ROLS67VYEG+QAnkIjFrGYoyT1Uf26ahCtD90cY2NXJ6U5N9r+fCdAvu8lA
        hNwP4u4HfEXl7OCw==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
Cc:     Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724134500.970496-2-james.clark@arm.com>
References: <20230724134500.970496-2-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <169079877184.28540.10430162346785754837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5c816728651ae425954542fed64d21d40cb75a9f
Gitweb:        https://git.kernel.org/tip/5c816728651ae425954542fed64d21d40cb75a9f
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Mon, 24 Jul 2023 14:44:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:46 +02:00

arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability

This capability gives us the ability to open PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
implementation is contained in the Perf core and tool code so no change
to the Arm PMU driver is needed.

The following basic use case now results in Perf opening the event on
all PMUs rather than picking only one in an unpredictable way:

  $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2

   Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':

         963279620      armv8_cortex_a57/cycles/                (99.19%)
         752745657      armv8_cortex_a53/cycles/                (94.80%)

Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230724134500.970496-2-james.clark@arm.com
---
 drivers/perf/arm_pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index f6ccb2c..2e79201 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -880,8 +880,13 @@ struct arm_pmu *armpmu_alloc(void)
 		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
 		 * and we have taken ctx sharing into account (e.g. with our
 		 * pmu::filter callback and pmu::event_init group validation).
+		 *
+		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open
+		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
+		 * specific PMU.
 		 */
-		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
+		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
+				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
 	};
 
 	pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
