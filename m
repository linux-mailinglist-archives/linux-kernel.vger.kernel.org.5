Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A176AEFB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjHAJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjHAJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:43:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5DD5FF0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:41:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18643D75;
        Tue,  1 Aug 2023 02:41:49 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.53.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16DC03F5A1;
        Tue,  1 Aug 2023 02:41:00 -0700 (PDT)
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
Subject: [PATCH V2 0/4] coresight: trbe: Enable ACPI based devices
Date:   Tue,  1 Aug 2023 15:10:48 +0530
Message-Id: <20230801094052.750416-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables detection of ACPI based TRBE devices via a stand alone
purpose built representative platform device. But as a pre-requisite this
changes coresight_platform_data structure assignment for the TRBE device.

This series is based on v6.5-rc4 kernel, is also dependent on the following
EDK2 changes posted earlier by Sami.

https://edk2.groups.io/g/devel/message/107239
https://edk2.groups.io/g/devel/message/107241

Changes in V2:

- Refactored arm_spe_acpi_register_device() in a separate patch
- Renamed trbe_acpi_resources as trbe_resources
- Renamed trbe_acpi_dev as trbe_dev

Changes in V1:

https://lore.kernel.org/all/20230728112733.359620-1-anshuman.khandual@arm.com/

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

Anshuman Khandual (4):
  arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
  arm_pmu: acpi: Add a representative platform device for TRBE
  coresight: trbe: Add a representative coresight_platform_data for TRBE
  coresight: trbe: Enable ACPI based TRBE devices

 arch/arm64/include/asm/acpi.h                |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c |  15 +-
 drivers/hwtracing/coresight/coresight-trbe.h |   1 +
 drivers/perf/arm_pmu_acpi.c                  | 145 ++++++++++++++-----
 include/linux/perf/arm_pmu.h                 |   1 +
 5 files changed, 122 insertions(+), 43 deletions(-)

-- 
2.25.1

