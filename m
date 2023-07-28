Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D2766BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjG1L2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjG1L14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:27:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BC002D5B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:27:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28CF2F4;
        Fri, 28 Jul 2023 04:28:37 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CB2C3F6C4;
        Fri, 28 Jul 2023 04:27:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] coresight: trbe: Enable ACPI based devices
Date:   Fri, 28 Jul 2023 16:57:30 +0530
Message-Id: <20230728112733.359620-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables detection of ACPI based TRBE devices via a stand alone
purpose built representative platform device. But as a pre-requisite this
changes coresight_platform_data structure assignment for the TRBE device.

This series is based on v6.5-rc1 kernel, is also dependent on the following
EDK2 changes posted earlier by Sami.

https://edk2.groups.io/g/devel/message/107239
https://edk2.groups.io/g/devel/message/107241

Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  arm_pmu: acpi: Add a representative platform device for TRBE
  coresight: trbe: Add a representative coresight_platform_data for TRBE
  coresight: trbe: Enable ACPI based TRBE devices

 arch/arm64/include/asm/acpi.h                |  3 +
 drivers/hwtracing/coresight/coresight-trbe.c | 15 ++++-
 drivers/hwtracing/coresight/coresight-trbe.h |  1 +
 drivers/perf/arm_pmu_acpi.c                  | 63 ++++++++++++++++++++
 include/linux/perf/arm_pmu.h                 |  1 +
 5 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.25.1

