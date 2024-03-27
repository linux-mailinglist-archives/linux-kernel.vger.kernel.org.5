Return-Path: <linux-kernel+bounces-121349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21F88E693
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56A11F31092
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E813A418;
	Wed, 27 Mar 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6KklPvH8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C213A419
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545078; cv=none; b=l8DbNEjCMX8tglnDU8vNGPKGhiwDXTyaM0oIJuqGCbRTe8gL/69HvtqVvhNaJvd/8B8ufUw+/hO6dMdusGFNQ+6Bg3WF2TwraiIZV8n73egr//hBI9U55G1GDkLBV9gSFhaQtnrTmfq42uaV/ATrsz4/oS0El+rCKou0Yg6kDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545078; c=relaxed/simple;
	bh=4+08yiZ8/BpK9Xh7Q7REHMJR/oPi0+ReIHJx0lIfctM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6tNF9MKFTORMZt7ovVZWnyrap9hrtritpeInoADdaRT545d05b4ElXO9Rs0/9IRsBjmZCn71eCT31wazdpoyCLEyZGhUapJVjJDqT/OFfbsXEooYWZ4FUsKpLBlDLt92/IGys+7nrMHV2qMYYk71apNN+iniVUEyiCMsnSxu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6KklPvH8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zh8U3tT2xkVk8r0g0J2g+FthFe+gICVtBzMNdCakEY0=; b=6KklPvH8w55TOAr/sIEWaJXG3Q
	JC+Q4BEmZUS2nm4Rgpu8oQ4ckL2gCj+59YSFtuYrrCIkn4MMOm+0X+8jS6BIH8YhQCEGDFaFbgL/H
	XLh8CP+Ke4XsH9YHNzxrvXcazBlxdNp4BTQ73Lkj6OpA6k1KlanE84m9Yoflu+HMbzlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpT3c-00BOSA-JM; Wed, 27 Mar 2024 14:11:08 +0100
Date: Wed, 27 Mar 2024 14:11:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [RESEND PATCH v3] perf/marvell: Marvell PEM performance monitor
 support
Message-ID: <695199ba-c71d-43ec-8305-8f52488b8c5d@lunn.ch>
References: <20240327072117.1556653-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327072117.1556653-1-gthiagarajan@marvell.com>

On Wed, Mar 27, 2024 at 12:51:17PM +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters
> to monitor the data that is transmitted over the PCIe link. The
> counters track various inbound and outbound transactions which
> includes separate counters for posted/non-posted/completion TLPs.
> Also, inbound and outbound memory read requests along with their
> latencies can also be monitored. Address Translation Services(ATS)events
> such as ATS Translation, ATS Page Request, ATS Invalidation along with
> their corresponding latencies are also supported.
> 
> The performance counters are 64 bits wide.
> 
> For instance,
> perf stat -e ib_tlp_pr <workload>
> tracks the inbound posted TLPs for the workload.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> v2->v3 changes:
> - Dropped device tree support as the acpi table based probing is used.

So people using DT cannot use this driver? Can they use the PCIe
interface?

There does not appear to be any ACPI binding, it is not reading any
properties from ACPI tables etc. So the DT binding should be
trivial...

> index 000000000000..d4175483b982
> --- /dev/null
> +++ b/drivers/perf/marvell_pem_pmu.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Marvell PEM(PCIe RC) Performance Monitor Driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

Why do you need these header files? I don't see any calls to of_
functions.

> +static int pem_perf_probe(struct platform_device *pdev)
> +{
> +	struct pem_pmu *pem_pmu;
> +	struct resource *res;
> +	void __iomem *base;
> +	char *name;
> +	int ret;
> +
> +	pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
> +	if (!pem_pmu)
> +		return -ENOMEM;
> +
> +	pem_pmu->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, pem_pmu);
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pem_pmu->base = base;
> +
> +	pem_pmu->pmu = (struct pmu) {
> +		.module	      = THIS_MODULE,
> +		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr = perf_invalid_context,
> +		.attr_groups = pem_perf_attr_groups,
> +		.event_init  = pem_perf_event_init,
> +		.add	     = pem_perf_event_add,
> +		.del	     = pem_perf_event_del,
> +		.start	     = pem_perf_event_start,
> +		.stop	     = pem_perf_event_stop,
> +		.read	     = pem_perf_event_update,
> +	};
> +
> +	/* Choose this cpu to collect perf data */
> +	pem_pmu->cpu = raw_smp_processor_id();
> +
> +	name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
> +			      res->start);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	cpuhp_state_add_instance_nocalls
> +			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
> +			 &pem_pmu->node);
> +
> +	ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
> +	if (ret)
> +		goto error;
> +
> +	pr_info("Marvell PEM(PCIe RC) PMU Driver for pem@%llx\n", res->start);

Please don't spam the kernel log like this.

       Andrew

