Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E97912F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbjIDIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbjIDIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:09:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B0FDF4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:09:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2147311FB;
        Mon,  4 Sep 2023 01:09:42 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AED073F8A4;
        Mon,  4 Sep 2023 01:09:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/7] coresight: Move remaining AMBA ACPI devices into platform driver
Date:   Mon,  4 Sep 2023 13:38:49 +0530
Message-Id: <20230904080856.2183421-1-anshuman.khandual@arm.com>
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

This series applies on coresight/next coresight-next-v6.6 and has been built
tested. This series has also been boot tested on a DT based coresight device
platform. Although it still requires testing on ACPI platform.

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

 drivers/acpi/acpi_amba.c                      |   8 --
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

