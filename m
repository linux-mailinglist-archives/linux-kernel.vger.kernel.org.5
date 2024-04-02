Return-Path: <linux-kernel+bounces-127384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF8894A91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B270CB23B05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDC17C79;
	Tue,  2 Apr 2024 04:43:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969F12581;
	Tue,  2 Apr 2024 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033007; cv=none; b=dsLJt4xui84BC92wVQEFD/YClDRBZ14sQXuZZH0p2cAAIZO3bDCSlEKguzXMzPRePVU+LfaBjq5R2BHcpr6IMvn3bd2OspH4kHtdXUplK5Ra3xjBaaMsOzdFOjbMGN2QSXZAB2p0+WlxUMmU6nBPdw6d32OqIUB32/z4hNKdIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033007; c=relaxed/simple;
	bh=IO9eT7tg9lscPWXj2+PBlAL369UEdF7MiRsRZ5zSM6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTwKcdjaWSgpzlO0auFD1x26WmeDR1UVXzkO2iNz55o5kSyrmAOw1HVxPtytj8nE01Te7MEJ780KomhfCLz5Bb5/TVDgROgykvvkmUr0GBYNzEpdb0hWwUHgQpcvwE5SoWPfkEQHXjEWoOTlzwLMK+i0ei7LQSnKj7laNdZ3ZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17002106F;
	Mon,  1 Apr 2024 21:43:51 -0700 (PDT)
Received: from [10.163.56.225] (unknown [10.163.56.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8388C3F766;
	Mon,  1 Apr 2024 21:43:14 -0700 (PDT)
Message-ID: <d80f641e-47dc-4fe5-bdfc-61c500aac066@arm.com>
Date: Tue, 2 Apr 2024 10:13:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/11] coresight: Move remaining AMBA ACPI devices into
 platform driver
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240314055843.2625883-1-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240314055843.2625883-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/24 11:28, Anshuman Khandual wrote:
> This moves remaining AMBA ACPI devices into respective platform drivers for
> enabling ACPI based power management support. This series applies on latest
> coresight next. This series has been built, and boot tested on a DT based
> (RB5) and ACPI supported coresight platform (N1SDP).
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v7)
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
> Changes in V7:
> 
> - Dropped reduntant 'drvdata' check in following functions
>   replicator_platform_remove()
>   funnel_platform_remove()
>   tpiu_platform_remove()
>   tmc_platform_remove()
>   catu_platform_remove()
>   catu_platform_probe()
>   debug_platform_remove()
>   debug_platform_probe()
> - Dropped struct resource check before devm_ioremap_resource()
> - Sorted the headers in alphabetic order

Hello Suzuki,

This series still applies cleanly on the latest v6.9-rc2. But please
do let me know if you need this to be posted again.

- Anshuman

