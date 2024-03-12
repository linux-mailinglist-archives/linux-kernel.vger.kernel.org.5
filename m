Return-Path: <linux-kernel+bounces-100103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD88791D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50DC1F22C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90287866D;
	Tue, 12 Mar 2024 10:23:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8141AD53;
	Tue, 12 Mar 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239017; cv=none; b=HI47wGx1pEz5h68i+8+2slD3CRHdKG51j2k5hsyS9IEWw5ZOBmia4KcK8wyuxj3yK4qoCX4rDL06Bb+e9beoLy6DZkdhzijqa4KlGA+nJe2M7LFl6d8cR5ZmbHVFZUs6TbPXddV2NBsDloFLltwoD9tn7IJlMw6Be9EMqcEu0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239017; c=relaxed/simple;
	bh=jNYp7j/OZLkUygvw4Nl+6VSM+4ieafge9Xe2zEruKhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXrrJYZ+nlZY2+2sjef2ScLsfmVMaGrnE4SdJSX/lAvcFAnI+QecMTZHd1ccKWUK/nw4hY/g9SibeXekaPYWG10nFSKHhd94RQxDDkEKGkeOhF/jNpktkTU5dv1jmqogpA8/3rN/DY/vy0pH2N6WcPYn5toBPXZT8ex04rh9E0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B4651007;
	Tue, 12 Mar 2024 03:24:11 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.52.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB78B3F73F;
	Tue, 12 Mar 2024 03:23:28 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V6 00/11] coresight: Move remaining AMBA ACPI devices into platform driver
Date: Tue, 12 Mar 2024 15:53:07 +0530
Message-Id: <20240312102318.2285165-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves remaining AMBA ACPI devices into respective platform drivers for
enabling ACPI based power management support. This series applies on latest
coresight next. This series has been built, and boot tested on a DT based
(RB5) and ACPI supported coresight platform (N1SDP).

https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v6)

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-stm32@st-md-mailman.stormreply.com

Changes in V6:

- Dropped Jame's RB tag from [PATCH 3/11]
- Added clk_disable_unprepare() for pclk in replicator_probe() error path
- Added clk_disable_unprepare() for pclk in funnel_probe() error path
- Added clk_put() for pclk in catu_platform_probe() error path
- Added clk_put() for pclk in debug_platform_probe() error path
- Added WARN_ON(!drvdata) check in replicator_platform_remove()
- Added WARN_ON(!drvdata) check in funnel_platform_remove()
- Added WARN_ON(!drvdata) check in catu_platform_remove()
- Added WARN_ON(!drvdata) check in tpiu_platform_remove()
- Added WARN_ON(!drvdata) check in tmc_platform_remove()
- Added WARN_ON(!drvdata) check in stm_platform_remove()
- Added WARN_ON(!drvdata) check in debug_platform_remove()
- Added additional elements for all acpi_device_id[] updates

Changes in V5:

https://lore.kernel.org/all/20240222082142.3663983-1-anshuman.khandual@arm.com/

- Used table->mask to filter out bits from pid in coresight_get_uci_data_from_amba()
- Dropped custom masks such as STM_AMBA_MASK and TMC_AMBA_MASK
- Modified tmc_etr_setup_caps() to accept struct csdev_access argument
- Reverted back tmc_etr_setup_caps() call site position in tmc_probe()
- Changed replicator and funnel devices to use the new helpers earlier in series
- Updated the commit messages regarding xxx_probe() refactoring and renaming

Changes in V4:

https://lore.kernel.org/all/20240123054608.1790189-1-anshuman.khandual@arm.com/

- Fixed PM imbalance in etm4_probe() error path with pm_runtime_disable()
- Restored back the pm_runtime_disable() on platform probe error paths
  in replicator, funnel, catu, tpiu, tmc and stm devices
- Dropped dev_caps argument from __tmc_probe()
- Changed xxxx_platform_remove() for platform_driver->remove_new() callback

Changes in V3:

https://lore.kernel.org/all/20231208053939.42901-1-anshuman.khandual@arm.com/

- Split coresight_init_driver/remove_driver() helpers into a separate patch
- Added 'drvdata->pclk' comments in replicator, funnel, tpiu, tmc, and stm devices
- Updated funnel, and replicator drivers to use these new helpers
- Check for drvdata instead of drvdata->pclk in suspend and resume paths in catu,
  tmc and debug devices
- Added patch to extract device name from AMBA pid based table lookup for stm
- Added patch to extract device properties from AMBA pid based table look for tmc
- Dropped pm_runtime_put() from common __probe() functions
- Handled pm_runtime_put() in AMBA driver in success path
- Handled pm_runtime_put() in platform driver in both success and error paths

Changes in V2:

https://lore.kernel.org/all/20231201062053.1268492-1-anshuman.khandual@arm.com/

- Dropped redundant devm_ioremap_resource() hunk from tmc_platform_probe()
- Defined coresight_[init|remove]_driver() for both AMBA/platform drivers
- Changed catu, tmc, tpiu, stm and debug coresight drivers to use the new
  helpers avoiding build issues arising from module_amba_driver(), and
  module_platform_driver() being on the same file

Changes in V1:

https://lore.kernel.org/all/20231027072943.3418997-1-anshuman.khandual@arm.com/

- Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki

Changes in RFC:

https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/

Anshuman Khandual (11):
  coresight: etm4x: Fix unbalanced pm_runtime_enable()
  coresight: stm: Extract device name from AMBA pid based table lookup
  coresight: tmc: Extract device properties from AMBA pid based table lookup
  coresight: Add helpers registering/removing both AMBA and platform drivers
  coresight: replicator: Move ACPI support from AMBA driver to platform driver
  coresight: funnel: Move ACPI support from AMBA driver to platform driver
  coresight: catu: Move ACPI support from AMBA driver to platform driver
  coresight: tpiu: Move ACPI support from AMBA driver to platform driver
  coresight: tmc: Move ACPI support from AMBA driver to platform driver
  coresight: stm: Move ACPI support from AMBA driver to platform driver
  coresight: debug: Move ACPI support from AMBA driver to platform driver

 drivers/acpi/arm64/amba.c                     |   8 -
 drivers/hwtracing/coresight/coresight-catu.c  | 146 ++++++++++++++---
 drivers/hwtracing/coresight/coresight-catu.h  |   1 +
 drivers/hwtracing/coresight/coresight-core.c  |  29 ++++
 .../hwtracing/coresight/coresight-cpu-debug.c | 146 ++++++++++++++---
 .../coresight/coresight-etm4x-core.c          |   3 +
 .../hwtracing/coresight/coresight-funnel.c    |  87 +++++-----
 drivers/hwtracing/coresight/coresight-priv.h  |  10 ++
 .../coresight/coresight-replicator.c          |  82 +++++-----
 drivers/hwtracing/coresight/coresight-stm.c   | 116 +++++++++++--
 .../hwtracing/coresight/coresight-tmc-core.c  | 154 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 drivers/hwtracing/coresight/coresight-tpiu.c  | 103 ++++++++++--
 include/linux/coresight.h                     |   7 +
 14 files changed, 729 insertions(+), 165 deletions(-)

-- 
2.25.1


