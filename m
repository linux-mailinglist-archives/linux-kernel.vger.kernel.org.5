Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5EC7EBF74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjKOJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:28:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FFE89B;
        Wed, 15 Nov 2023 01:28:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB29DA7;
        Wed, 15 Nov 2023 01:29:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.37.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3DB63F7B4;
        Wed, 15 Nov 2023 01:28:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
Date:   Wed, 15 Nov 2023 14:58:03 +0530
Message-Id: <20231115092805.737822-1-anshuman.khandual@arm.com>
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

This series drops 'pmu_lock' usage from all arm platforms which had already
been dropped from arm64 platforms earlier via the following commit.

commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking"). 

Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
series applies on 6.7-rc1 and has been tested on arm64. Although just build
tested for arm platform.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Changes in V1:

- Added some build warning fixes

RFC V1:

https://lore.kernel.org/all/20231016052431.1390269-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm: perf: Remove PMU locking
  drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'

 arch/arm/kernel/perf_event_v6.c     | 28 ++++--------------
 arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
 arch/arm/kernel/perf_event_xscale.c | 44 ++++++-----------------------
 drivers/perf/arm_pmu.c              |  1 -
 include/linux/perf/arm_pmu.h        |  6 ----
 5 files changed, 13 insertions(+), 110 deletions(-)

-- 
2.25.1

