Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CEC7A9E75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIUUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjIUUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:01:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F1255AF8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BEDB1042;
        Wed, 20 Sep 2023 21:21:31 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.32.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDADD3F59C;
        Wed, 20 Sep 2023 21:20:51 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RESEND 0/7] coresight: Move remaining AMBA ACPI devices into platform driver
Date:   Thu, 21 Sep 2023 09:50:33 +0530
Message-Id: <20230921042040.1334641-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves remaining AMBA ACPI devices into respective platform drivers for
enabling ACPI based power management support. This might still require some
further changes but presented here just for some initial review & feedback.

This series applies on coresight/next coresight/for-next/queue and has been
built tested. This series has also been boot tested on a DT based coresight
device latform. Although it still requires testing on ACPI platforms.

Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (7):
  coresight: replicator: Move ACPI support from AMBA driver to platform driver
  coresight: funnel: Move ACPI support from AMBA driver to platform driver
  coresight: catu: Move ACPI support from AMBA driver to platform driver
  coresight: tpiu: Move ACPI support from AMBA driver to platform driver
  coresight: tmc: Move ACPI support from AMBA driver to platform driver
  coresight: stm: Move ACPI support from AMBA driver to platform driver
  coresight: debug: Move ACPI support from AMBA driver to platform driver

 drivers/acpi/arm64/amba.c                     |   8 --
 drivers/hwtracing/coresight/coresight-catu.c  | 136 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-catu.h  |   1 +
 .../hwtracing/coresight/coresight-cpu-debug.c | 130 +++++++++++++++--
 .../hwtracing/coresight/coresight-funnel.c    |  49 ++++---
 .../coresight/coresight-replicator.c          |  44 +++---
 drivers/hwtracing/coresight/coresight-stm.c   |  80 +++++++++--
 .../hwtracing/coresight/coresight-tmc-core.c  | 127 ++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  76 +++++++++-
 10 files changed, 549 insertions(+), 103 deletions(-)

-- 
2.25.1

