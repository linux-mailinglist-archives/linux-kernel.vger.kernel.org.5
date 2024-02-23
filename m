Return-Path: <linux-kernel+bounces-78990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04546861BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE0B22FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788751292FF;
	Fri, 23 Feb 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vToTneSz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24C1448CE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713462; cv=none; b=PjBgKB2yov8bxpUXHiE6H40bYF8ekUl+xYJZgimRunrOb/h7aCDzghoXziim5GSLK4j8Xrf7BBCxS9m1bmMPEfRXfaCN/rTEgi7ldRfeP+C1o+xazxaZvaFFzgZSVPdIaQb5tR22PZYKnmKwba3HgqIb6MXTihZtlOCXwAR/Fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713462; c=relaxed/simple;
	bh=3nEfTqBgm07ZRZJkpcjU4ZUO4nSW1cavBczC6VQp8tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgHgRZVNSHJIeQIKPmrB/t8jR1uSCXeI1vJszXJ4etUWngojbn5ps+MLXnqaQbx7iJMeus472ZY0Vut1lf4LkdL4tNhuEbBlXIuP2fn/zrXkfJhNzvRTfsPl5HNcTExSPu2RbjtdqzW/h0wbewAFYvL/U9OJzqkzzxjbM47nIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vToTneSz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc75972f25so4718575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708713452; x=1709318252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZoiqAY2Uur/aGWMy2naDtSDhhq1uQ0pWzfI5wkuDOg=;
        b=vToTneSzxNebAOCfg8eR3ynp6VBJX5qTX7fojT2b5pzFbe3tJsJ2UfC1WyXn/baYfM
         2o1QOJ2CMqguqgHs99Y5j/U6nhxCxK5WQwa2ia278H9R6ccRgIgyzpIb+mmY0zWyXmoD
         w/XVrXNed7VM49p55Zlr07jh9r1itENhd2r1TskXjJ6VR5XjGSVinhJFeDGpAJ3urMjv
         nclh5MuF7cdcxCauPTaGOPx4NI3G+MXmxsU+y6xtSiHVLBFVr6277dcBLhwmVKjQMgBP
         5n7mXxOzkzxRgUHSlrtxIdAOMxhp0K1Ik786blAKjHnsoAS3GaXOlOkGPFr0vhSdoZlF
         kc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708713452; x=1709318252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZoiqAY2Uur/aGWMy2naDtSDhhq1uQ0pWzfI5wkuDOg=;
        b=OwGt8zMrnHkpeFRyWyc2/o2FVbK9HrWbqX9/xmldkzvlcHdLDaYa4mAq5d4YjpqqD8
         K+DI7NXNlbxqf8F2t2yGg9mq+qYKBTTs/NlxhVTWKJTG0VYGFzHec7tJxeYKvb4cqueG
         UM1OewGuIQwvAbW+V2cjWHWB1jET2Rd8ScNL7dc389NAw5BvPGezm00v84IiCJjhawHx
         qqiFRPoyZayZpNjyiXxpnYYAwsyWiiDvl8TehUA1/5vg1CuDHaTEatZJfQzGZ0TECOt4
         O1feS5HySAyUw21c4RtQcXDbC2cvq/7xv14+umujGW/OhhQtUQxMV+iGArLy06Mmul6G
         4ZOA==
X-Forwarded-Encrypted: i=1; AJvYcCXDWUTvi7xZ24dfTJUBujStaSUyIiReklUeqo3dcImMXgmvAGJv2uKDpTLGYTZ1s58cXkRvOAu7/cROcBCD1zb7Hh6M2fAZ8D8orhZV
X-Gm-Message-State: AOJu0Yx5Yv8maMd9rQL4sJEu3b+OyHrbTQC5Rq7jmkQwdu2WHb6f560U
	QDH0TQqkhseCDg8SMbgmkXoy+QtTe8oL65B40m9t7jY33CpReNBgj5VM0y7JaT0=
X-Google-Smtp-Source: AGHT+IEFnq/adSWGsq0T7PG+TvSPinae6jkrUQ6p7/FCofH5i6KR3wHNsGv2ykbTotKDS+HU96hvow==
X-Received: by 2002:a17:902:c146:b0:1dc:5ae8:174c with SMTP id 6-20020a170902c14600b001dc5ae8174cmr624284plj.17.1708713452286;
        Fri, 23 Feb 2024 10:37:32 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:a9ba:9d9e:b797:23f1])
        by smtp.gmail.com with ESMTPSA id kb6-20020a170903338600b001db5bdd5e3bsm12042829plb.13.2024.02.23.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:37:31 -0800 (PST)
Date: Fri, 23 Feb 2024 11:37:29 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <Zdjl6Z2ktTwi+oWp@p14s>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <20240214172127.1022199-8-arnaud.pouliquen@foss.st.com>
 <ZdeaUGpWlqGOG31u@p14s>
 <609373ba-c81d-4aee-81cb-8628e2c6897b@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609373ba-c81d-4aee-81cb-8628e2c6897b@foss.st.com>

On Fri, Feb 23, 2024 at 02:54:13PM +0100, Arnaud POULIQUEN wrote:
> Hello Mathieu,
> 
> On 2/22/24 20:02, Mathieu Poirier wrote:
> > Hi,
> > 
> > On Wed, Feb 14, 2024 at 06:21:27PM +0100, Arnaud Pouliquen wrote:
> >> The new TEE remoteproc device is used to manage remote firmware in a
> >> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> >> introduced to delegate the loading of the firmware to the trusted
> >> execution context. In such cases, the firmware should be signed and
> >> adhere to the image format defined by the TEE.
> >>
> >> A new "to_attach" field is introduced to differentiate the use cases
> >> "firmware loaded by the boot stage" and "firmware loaded by the TEE".
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> ---
> >> V2 to V3 update:
> >> - remove stm32_rproc_tee_elf_sanity_check(), stm32_rproc_tee_elf_load()
> >>   stm32_rproc_tee_elf_find_loaded_rsc_table() and  stm32_rproc_tee_start() that are bnow unused
> >> - use new rproc::alt_boot field to sepcify that the alternate fboot method is used
> >> - use stm32_rproc::to_attach field to differenciate attch mode from remoteproc tee boot mode.
> >> - remove the used of stm32_rproc::fw_loaded
> >> ---
> >>  drivers/remoteproc/stm32_rproc.c | 85 +++++++++++++++++++++++++++++---
> >>  1 file changed, 79 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> >> index fcc0001e2657..9cfcf66462e0 100644
> >> --- a/drivers/remoteproc/stm32_rproc.c
> >> +++ b/drivers/remoteproc/stm32_rproc.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/remoteproc.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/tee_remoteproc.h>
> >>  #include <linux/workqueue.h>
> >>  
> >>  #include "remoteproc_internal.h"
> >> @@ -49,6 +50,9 @@
> >>  #define M4_STATE_STANDBY	4
> >>  #define M4_STATE_CRASH		5
> >>  
> >> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
> >> +#define STM32_MP1_M4_PROC_ID    0
> >> +
> >>  struct stm32_syscon {
> >>  	struct regmap *map;
> >>  	u32 reg;
> >> @@ -90,6 +94,8 @@ struct stm32_rproc {
> >>  	struct stm32_mbox mb[MBOX_NB_MBX];
> >>  	struct workqueue_struct *workqueue;
> >>  	bool hold_boot_smc;
> >> +	bool to_attach;
> >> +	struct tee_rproc *trproc;
> >>  	void __iomem *rsc_va;
> >>  };
> >>  
> >> @@ -253,10 +259,30 @@ static int stm32_rproc_release(struct rproc *rproc)
> >>  			return err;
> >>  		}
> >>  	}
> >> +	ddata->to_attach = false;
> >>  
> >>  	return err;
> >>  }
> >>  
> >> +static int stm32_rproc_tee_attach(struct rproc *rproc)
> >> +{
> >> +	/* Nothing to do, remote proc already started by the secured context. */
> >> +	return 0;
> >> +}
> >> +
> >> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> >> +{
> >> +	int err;
> >> +
> >> +	stm32_rproc_request_shutdown(rproc);
> >> +
> >> +	err = tee_rproc_stop(rproc);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	return stm32_rproc_release(rproc);
> >> +}
> >> +
> >>  static int stm32_rproc_prepare(struct rproc *rproc)
> >>  {
> >>  	struct device *dev = rproc->dev.parent;
> >> @@ -637,10 +663,14 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
> >>  {
> >>  	struct stm32_rproc *ddata = rproc->priv;
> >>  	struct device *dev = rproc->dev.parent;
> >> +	struct tee_rproc *trproc = ddata->trproc;
> >>  	phys_addr_t rsc_pa;
> >>  	u32 rsc_da;
> >>  	int err;
> >>  
> >> +	if (trproc && !ddata->to_attach)
> >> +		return tee_rproc_get_loaded_rsc_table(rproc, table_sz);
> >> +
> > 
> > Why do we need a flag at all?  Why can't st_rproc_tee_ops::get_loaded_rsc_table
> > be set to tee_rproc_get_loaded_rsc_table()?
> 
> 
> This function is used to retrieve the address of the resource table in 3 cases
> - attach to a firmware started by the boot loader (U-boot).
> - load of the firmware by OP-TEE.
> - crash recovery on a signed firmware started by the boot loader.
> 
> The flag is used to differentiate the attch from the other uses cases
> For instance we support this use case.
> 1) attach to the firmware on boot
> 2) crash during runtime
>   2a) stop the firmware by OP-TEE( ddata->to_attach set to 0)
>   2b) load the firmware by OP-TEE
>   2c) get the loaded resource table from OP-TEE (we can not guaranty
>       that the firmware loaded on recovery is the same)
>   2d) restart the firmware by OP-TEE

This is not maintainable and needs to be broken down into smaller
building blocks.  The introduction of tee_rproc_parse_fw() should help dealing
with some of the complexity.

> 
> > 
> >>  	/* The resource table has already been mapped, nothing to do */
> >>  	if (ddata->rsc_va)
> >>  		goto done;
> >> @@ -693,8 +723,20 @@ static const struct rproc_ops st_rproc_ops = {
> >>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> >>  };
> >>  
> >> +static const struct rproc_ops st_rproc_tee_ops = {
> >> +	.prepare	= stm32_rproc_prepare,
> >> +	.start		= tee_rproc_start,
> >> +	.stop		= stm32_rproc_tee_stop,
> >> +	.attach		= stm32_rproc_tee_attach,
> >> +	.kick		= stm32_rproc_kick,
> >> +	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
> >> +	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
> >> +	.load		= tee_rproc_load_fw,
> >> +};
> >> +
> >>  static const struct of_device_id stm32_rproc_match[] = {
> >> -	{ .compatible = "st,stm32mp1-m4" },
> >> +	{.compatible = "st,stm32mp1-m4",},
> >> +	{.compatible = "st,stm32mp1-m4-tee",},
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> >> @@ -853,6 +895,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>  	struct device *dev = &pdev->dev;
> >>  	struct stm32_rproc *ddata;
> >>  	struct device_node *np = dev->of_node;
> >> +	struct tee_rproc *trproc = NULL;
> >>  	struct rproc *rproc;
> >>  	unsigned int state;
> >>  	int ret;
> >> @@ -861,12 +904,33 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
> >> -	if (!rproc)
> >> -		return -ENOMEM;
> > 
> > This patch doesn't apply to rproc-next - please rebase.
> 
> Yes, sure. I forgot to mention in my cover letter that my series has been
> applied and tested on 841c35169323 (Linux 6.8-rc4).
> 
> > 
> > 
> >> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> >> +		/*
> >> +		 * Delegate the firmware management to the secure context.
> >> +		 * The firmware loaded has to be signed.
> >> +		 */
> >> +		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
> >> +		if (IS_ERR(trproc)) {
> >> +			dev_err_probe(dev, PTR_ERR(trproc),
> >> +				      "signed firmware not supported by TEE\n");
> >> +			return PTR_ERR(trproc);
> >> +		}
> >> +	}
> >>  
> >> -	ddata = rproc->priv;
> >> +	rproc = rproc_alloc(dev, np->name,
> >> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
> >> +			    NULL, sizeof(*ddata));
> >> +	if (!rproc) {
> >> +		ret = -ENOMEM;
> >> +		goto free_tee;
> >> +	}
> >>  
> >> +	ddata = rproc->priv;
> >> +	ddata->trproc = trproc;
> > 
> > My opinion hasn't changed from the previous patchet, i.e tee_rproc should be
> > folded in struct rproc as rproc::tee_interface.
> 
> Sure, I will do it in next version
> 
> > 
> > More comments to come shortly...
> > 
> 
> Thanks!
> Arnaud
> 
> >> +	if (trproc) {
> >> +		rproc->alt_boot = true;
> >> +		trproc->rproc = rproc;
> >> +	}
> >>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> >>  
> >>  	ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
> >> @@ -881,8 +945,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		goto free_rproc;
> >>  
> >> -	if (state == M4_STATE_CRUN)
> >> +	if (state == M4_STATE_CRUN) {
> >>  		rproc->state = RPROC_DETACHED;
> >> +		ddata->to_attach = true;
> >> +	}
> >>  
> >>  	rproc->has_iommu = false;
> >>  	ddata->workqueue = create_workqueue(dev_name(dev));
> >> @@ -916,6 +982,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>  		device_init_wakeup(dev, false);
> >>  	}
> >>  	rproc_free(rproc);
> >> +free_tee:
> >> +	if (trproc)
> >> +		tee_rproc_unregister(trproc);
> >> +
> >>  	return ret;
> >>  }
> >>  
> >> @@ -923,6 +993,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
> >>  {
> >>  	struct rproc *rproc = platform_get_drvdata(pdev);
> >>  	struct stm32_rproc *ddata = rproc->priv;
> >> +	struct tee_rproc *trproc = ddata->trproc;
> >>  	struct device *dev = &pdev->dev;
> >>  
> >>  	if (atomic_read(&rproc->power) > 0)
> >> @@ -937,6 +1008,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
> >>  		device_init_wakeup(dev, false);
> >>  	}
> >>  	rproc_free(rproc);
> >> +	if (trproc)
> >> +		tee_rproc_unregister(trproc);
> >>  }
> >>  
> >>  static int stm32_rproc_suspend(struct device *dev)
> >> -- 
> >> 2.25.1
> >>
> > 

