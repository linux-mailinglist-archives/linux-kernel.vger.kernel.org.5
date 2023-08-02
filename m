Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD676C901
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjHBJJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHBJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:09:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D53FD2D52
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:09:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA1B5113E;
        Wed,  2 Aug 2023 02:09:49 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.53.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F1D43F5A1;
        Wed,  2 Aug 2023 02:09:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: pmuv3: Remove comments from armv8pmu_[enable|disable]_event()
Date:   Wed,  2 Aug 2023 14:38:53 +0530
Message-Id: <20230802090853.1190391-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments in armv8pmu_[enable|disable]_event() are blindingly obvious,
and does not contribute in making things any better. Let's drop them off.
Functional change is not intended.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This change is taken from BRBE V13 series [PATCH 05/10] just to keep the
remaining change set in context. Mark Rutland had suggested this earlier.

https://lore.kernel.org/all/Y8AZXQJUO6h5mlgq@FVFF77S0Q05N/

 drivers/perf/arm_pmuv3.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 08b3a1bf0ef6..b46ff9f73f42 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -721,38 +721,15 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-
-	/*
-	 * Disable counter
-	 */
 	armv8pmu_disable_event_counter(event);
-
-	/*
-	 * Set event.
-	 */
 	armv8pmu_write_event_type(event);
-
-	/*
-	 * Enable interrupt for this counter
-	 */
 	armv8pmu_enable_event_irq(event);
-
-	/*
-	 * Enable counter
-	 */
 	armv8pmu_enable_event_counter(event);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
 {
-	/*
-	 * Disable counter
-	 */
 	armv8pmu_disable_event_counter(event);
-
-	/*
-	 * Disable interrupt for this counter
-	 */
 	armv8pmu_disable_event_irq(event);
 }
 
-- 
2.25.1

