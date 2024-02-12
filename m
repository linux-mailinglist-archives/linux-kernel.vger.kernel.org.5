Return-Path: <linux-kernel+bounces-61508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D65851309
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E74C1C22142
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C663D540;
	Mon, 12 Feb 2024 12:03:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348283D3A8;
	Mon, 12 Feb 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739382; cv=none; b=Ez/SMGd5QtlQ3CPKtkhOx6yOdtVTkYS5q7wgjVPNbD8rJ29w/IGa0AMQqYecDwfg83f0hElHtocqqnoBtiPiXXzqTDHg965fgXd4lHpxphClZ8VJctciTL4CncQo/78LOTNFnr+sVkfKTP8EVZN6xV5sKLjVfawzdORRt5ppmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739382; c=relaxed/simple;
	bh=ApJjDeIIKrDznGMpwQqBzha7bOkPels9yAEp1nMU498=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq8/5uPpbIrWqLgn6ZuuVHLi6Xy7+jnN2739rSvFsmYwEWUnWrQw5/nfYAQM4JDQfJn8Sw+wXmsfYOBqqnoIQ4Cfvo/2E26LTmOp0BVkAkXhUD8mRRm4RWMqelA3qgHbjRbfFoZkmwRJJKcFHRVnvmveL/KpW3e3yt4H1Pu26iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC2EDA7;
	Mon, 12 Feb 2024 04:03:41 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808D63F7BD;
	Mon, 12 Feb 2024 04:02:57 -0800 (PST)
Message-ID: <60499829-a5fa-54e6-42e3-bd48f25a65dc@arm.com>
Date: Mon, 12 Feb 2024 12:02:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 00/11] coresight: Move remaining AMBA ACPI devices into
 platform driver
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240123054608.1790189-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/01/2024 05:45, Anshuman Khandual wrote:
> This moves remaining AMBA ACPI devices into respective platform drivers for
> enabling ACPI based power management support. This series applies on kernel
> v6.8-rc1 release. This series has been built, and boot tested on a DT based
> coresight platform. Although this still requires some more testing on ACPI
> based coresight platforms.
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v4)
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> 

Reviewed-by: James Clark <james.clark@arm.com>

> Changes in V4:
> 
> - Fixed PM imbalance in etm4_probe() error path with pm_runtime_disable()
> - Restored back the pm_runtime_disable() on platform probe error paths
>   in replicator, funnel, catu, tpiu, tmc and stm devices
> - Dropped dev_caps argument from __tmc_probe()
> - Changed xxxx_platform_remove() for platform_driver->remove_new() callback
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/20231208053939.42901-1-anshuman.khandual@arm.com/
> 
> - Split coresight_init_driver/remove_driver() helpers into a separate patch
> - Added 'drvdata->pclk' comments in replicator, funnel, tpiu, tmc, and stm devices
> - Updated funnel, and replicator drivers to use these new helpers
> - Check for drvdata instead of drvdata->pclk in suspend and resume paths in catu,
>   tmc and debug devices
> - Added patch to extract device name from AMBA pid based table lookup for stm
> - Added patch to extract device properties from AMBA pid based table look for tmc
> - Dropped pm_runtime_put() from common __probe() functions
> - Handled pm_runtime_put() in AMBA driver in success path
> - Handled pm_runtime_put() in platform driver in both success and error paths
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20231201062053.1268492-1-anshuman.khandual@arm.com/
> 
> - Dropped redundant devm_ioremap_resource() hunk from tmc_platform_probe()
> - Defined coresight_[init|remove]_driver() for both AMBA/platform drivers
> - Changed catu, tmc, tpiu, stm and debug coresight drivers to use the new
>   helpers avoiding build issues arising from module_amba_driver(), and
>   module_platform_driver() being on the same file
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20231027072943.3418997-1-anshuman.khandual@arm.com/
> 
> - Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki
> 
> Changes in RFC:
> 
> https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/
> 
> Anshuman Khandual (11):
>   coresight: etm4x: Fix unbalanced pm_runtime_enable()
>   coresight: stm: Extract device name from AMBA pid based table lookup
>   coresight: tmc: Extract device properties from AMBA pid based table lookup
>   coresight: Add helpers registering/removing both AMBA and platform drivers
>   coresight: replicator: Move ACPI support from AMBA driver to platform driver
>   coresight: funnel: Move ACPI support from AMBA driver to platform driver
>   coresight: catu: Move ACPI support from AMBA driver to platform driver
>   coresight: tpiu: Move ACPI support from AMBA driver to platform driver
>   coresight: tmc: Move ACPI support from AMBA driver to platform driver
>   coresight: stm: Move ACPI support from AMBA driver to platform driver
>   coresight: debug: Move ACPI support from AMBA driver to platform driver
> 
>  drivers/acpi/arm64/amba.c                     |   8 -
>  drivers/hwtracing/coresight/coresight-catu.c  | 142 +++++++++++++---
>  drivers/hwtracing/coresight/coresight-catu.h  |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |  29 ++++
>  .../hwtracing/coresight/coresight-cpu-debug.c | 141 ++++++++++++++--
>  .../coresight/coresight-etm4x-core.c          |   3 +
>  .../hwtracing/coresight/coresight-funnel.c    |  86 +++++-----
>  drivers/hwtracing/coresight/coresight-priv.h  |  10 ++
>  .../coresight/coresight-replicator.c          |  81 ++++-----
>  drivers/hwtracing/coresight/coresight-stm.c   | 117 +++++++++++--
>  .../hwtracing/coresight/coresight-tmc-core.c  | 158 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  | 102 +++++++++--
>  include/linux/coresight.h                     |   7 +
>  14 files changed, 726 insertions(+), 161 deletions(-)
> 

