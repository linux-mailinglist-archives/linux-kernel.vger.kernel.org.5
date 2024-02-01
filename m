Return-Path: <linux-kernel+bounces-48468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656C845C73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA7A1C2BFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC015B99D;
	Thu,  1 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIG0VGHW"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F715D5D1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803361; cv=none; b=UVkSHj2Q3NHSeExITecSKcmX3mMRz8k7sA24Ryz3PXWN8/XBxhZfIFAJYSN2fK/0D8jS23h1cAWc9/5mkYpSeq5NMUA9eQOyG7HzcpekyzUvbFRldHwXWifvGZOuiq4wXHBUr3dGSt6CZppPtr25nkcBNsiKXwo6PrxKRbK2Xcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803361; c=relaxed/simple;
	bh=06Dt11D92NNfTXfxGIa6pedC8vSTk9HgOVnkFJ8IcZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov2VQ38rWhCTCugB6hsizxAT5TZxs4FKlOZ92PDK0//uFNs1IOywzhjDj4fv30KdwVow9v/PzddYZeH51cQq6i3a5mMbkKXXiBWzBJpvKw6ALcJBwwLXR3iIjd23Xdzhc9qOmxkll4rJUd5Km+GuRSL0bkW2DKHCjLsMp7qdQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIG0VGHW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso856326a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706803359; x=1707408159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KC0BuU+zl2DQsGB9BoRF0ldWge16g1vb9Fh9IPx724=;
        b=hIG0VGHWx2kJ/uTdelL9yLF3YDveMomnMOxYcIumtOtyUWATqS31VgVNCSHE5/tdOa
         5crdag1BntXq34OjyxOznZjSkOS8i3sU28VijzgOPiaN9KlYhAiagbw7f5Tnp3Jo+x0d
         +qQoCElAkIGxyRXNyNEe/mv0tR+zn87AGU1ZY8PN6QRRH3+0FObgvD00vvOY6w8EOr+C
         0C6Sp+F5JUbbiK6G/MgRyUtJCvq9CE7oJO+8RAJUmgxAp9Io6oYmk99udXA7fEUW2Aki
         Mmvx5ruCpuijILfo093qLM1CJPrwKHIdVujSwWFGavMP2VT/lPbEzESlbphHfgRVudmP
         Ebjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803359; x=1707408159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KC0BuU+zl2DQsGB9BoRF0ldWge16g1vb9Fh9IPx724=;
        b=FgZmGsWrHfwWqgqHOHnj+JQL4Cnk0S0lS32oC9oQ4JnY824nAZnOtEd2x4r8L5pex4
         5PwR8MmayB2JlbZnDJifziVjhFVqhTVDtCMXtGrP1/zre+37VVLV5WsNrwQW1azWZu0T
         WV7J7BIXf46I1QZIKj+dTsFCgO0unQve9bwcvpXAqu4lrG+RJMfry/GnPdjWsInk2o00
         T0oXxsWNtJXqkh6TDs/k0iXMFvru0uQ8VKeg42Q2taPoMvQsi90QNHViiGbOQynfojiU
         NqjEdKvnP9tfVmgAshPLiY0AN3v+2li/Hdr542zXu2d5EzodVHV5QV+AjlO8IedY/R4X
         tcGA==
X-Gm-Message-State: AOJu0Yz+6JzNGe3yTt+bvXng4MLbkcNulRa5t3yg5c7d6tcPMYiUqvsl
	kSDEo0gd6RHDrZJUePyvMZSYmetmMMltvzSNlkK2nHa84BQ8qyX8Zim0ROgR4W8=
X-Google-Smtp-Source: AGHT+IGsX/zl/UZKsVb995D9UsicEBg8qON099EeFw4tqWa9IjXvm0O5v90Yx9VXhO9rfxGWASS1wQ==
X-Received: by 2002:a17:90a:fd96:b0:296:2b08:b4b5 with SMTP id cx22-20020a17090afd9600b002962b08b4b5mr779426pjb.29.1706803358457;
        Thu, 01 Feb 2024 08:02:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqOlRGkW/fLpFoE2BkPXfrAcQL3gKwsey9bM8w/ODrFW2APM2iPWGTN5Vw56Tb0Rlcsb1URCvfwK4lBZ6VVTXUkFZq34wLRho9tXv3rKRQkfHoOaehgSgYOkRTf1SIHoglCpLJGgCm+h8dB+b35E0S3ynKEd1sdW7OyFAVeWmQTF7/ki1bU91NiXWLhvhR4fKINLUOH347cLe1tQZwBMbTbQ0J1dIssgNsrb7nnY2p6/PXw/ry6AeJtFDglIDDYM/gpwuKEu0wyAuB7Ji+KGzwn8UdHJSaBUpW15P3vW91yl7ba5nIV6YCGfeUYyXezQve05ADPSw+XrTu8IGOevux/8UjjqfoWdEOLcDhRGDIc5udIDi4Wqci8N76wwi0mBVK0ilhZLalxmdpgXI0c36J3d2hrDNseWEyWdtmUFF9MSHHEvXXQ+IJogkIDHq3LTs9ULHpS/cydTn23Zg0iKQUVwih
Received: from p14s ([2604:3d09:148c:c800:83ea:dbe3:14f3:572])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a16cf00b00295ef5b7eb0sm3693372pje.4.2024.02.01.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:02:38 -0800 (PST)
Date: Thu, 1 Feb 2024 09:02:35 -0700
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
Subject: Re: [PATCH v2 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <ZbvAmxHscnbUQGOD@p14s>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-5-arnaud.pouliquen@foss.st.com>
 <ZbPnsJm67G10+HQ3@p14s>
 <7ec6c9e8-9267-4e7c-81a4-abcdb2ab4239@foss.st.com>
 <ZbqW5YfDmEWG4G1X@p14s>
 <8ede77bb-0fbc-4de2-b51b-67674744b551@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ede77bb-0fbc-4de2-b51b-67674744b551@foss.st.com>

On Thu, Feb 01, 2024 at 04:06:37PM +0100, Arnaud POULIQUEN wrote:
> hello Mathieu,
> 
> On 1/31/24 19:52, Mathieu Poirier wrote:
> > On Tue, Jan 30, 2024 at 10:13:48AM +0100, Arnaud POULIQUEN wrote:
> >>
> >>
> >> On 1/26/24 18:11, Mathieu Poirier wrote:
> >>> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
> >>>> The new TEE remoteproc device is used to manage remote firmware in a
> >>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> >>>> introduced to delegate the loading of the firmware to the trusted
> >>>> execution context. In such cases, the firmware should be signed and
> >>>> adhere to the image format defined by the TEE.
> >>>>
> >>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>>> ---
> >>>> V1 to V2 update:
> >>>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detected by
> >>>>   the kernel test robot:
> >>>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
> >>>>      Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
> >>>>      Selected by [y]:
> >>>>      - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]
> >>>> - Fix initialized trproc variable in  stm32_rproc_probe
> >>>> ---
> >>>>  drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++++++--
> >>>>  1 file changed, 144 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> >>>> index fcc0001e2657..cf6a21bac945 100644
> >>>> --- a/drivers/remoteproc/stm32_rproc.c
> >>>> +++ b/drivers/remoteproc/stm32_rproc.c
> >>>> @@ -20,6 +20,7 @@
> >>>>  #include <linux/remoteproc.h>
> >>>>  #include <linux/reset.h>
> >>>>  #include <linux/slab.h>
> >>>> +#include <linux/tee_remoteproc.h>
> >>>>  #include <linux/workqueue.h>
> >>>>  
> >>>>  #include "remoteproc_internal.h"
> >>>> @@ -49,6 +50,9 @@
> >>>>  #define M4_STATE_STANDBY	4
> >>>>  #define M4_STATE_CRASH		5
> >>>>  
> >>>> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
> >>>> +#define STM32_MP1_M4_PROC_ID    0
> >>>> +
> >>>>  struct stm32_syscon {
> >>>>  	struct regmap *map;
> >>>>  	u32 reg;
> >>>> @@ -90,6 +94,8 @@ struct stm32_rproc {
> >>>>  	struct stm32_mbox mb[MBOX_NB_MBX];
> >>>>  	struct workqueue_struct *workqueue;
> >>>>  	bool hold_boot_smc;
> >>>> +	bool fw_loaded;
> >>>> +	struct tee_rproc *trproc;
> >>>>  	void __iomem *rsc_va;
> >>>>  };
> >>>>  
> >>>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rproc)
> >>>>  	return err;
> >>>>  }
> >>>>  
> >>>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
> >>>> +					    const struct firmware *fw)
> >>>> +{
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +	unsigned int ret = 0;
> >>>> +
> >>>> +	if (rproc->state == RPROC_DETACHED)
> >>>> +		return 0;
> >>>> +
> >>>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
> >>>> +	if (!ret)
> >>>> +		ddata->fw_loaded = true;
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
> >>>> +				    const struct firmware *fw)
> >>>> +{
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +	unsigned int ret;
> >>>> +
> >>>> +	/*
> >>>> +	 * This function can be called by remote proc for recovery
> >>>> +	 * without the sanity check. In this case we need to load the firmware
> >>>> +	 * else nothing done here as the firmware has been preloaded for the
> >>>> +	 * sanity check to be able to parse it for the resource table.
> >>>> +	 */
> >>>
> >>> This comment is very confusing - please consider refactoring.  
> >>>
> >>>> +	if (ddata->fw_loaded)
> >>>> +		return 0;
> >>>> +
> >>>
> >>> I'm not sure about keeping a flag to indicate the status of the loaded firmware.
> >>> It is not done for the non-secure method, I don't see why it would be needed for
> >>> the secure one.
> >>>
> >>
> >> The difference is on the sanity check.
> >> - in rproc_elf_sanity_check we  parse the elf file to verify that it is
> >> valid.
> >> - in stm32_rproc_tee_elf_sanity_check we have to do the same, that means to
> >> authenticate it. the authentication is done during the load.
> >>
> >> So this flag is used to avoid to reload it twice time.
> >> refactoring the comment should help to understand this flag
> >>
> >>
> >> An alternative would be to bypass the sanity check. But this lead to same
> >> limitation.
> >> Before loading the firmware in remoteproc_core, we call rproc_parse_fw() that is
> >> used to get the resource table address. To get it from tee we need to
> >> authenticate the firmware so load it...
> >>
> > 
> > I spent a long time thinking about this patchset.  Looking at the code as it
> > is now, request_firmware() in rproc_boot() is called even when the TEE is
> > responsible for loading the firmware.  There should be some conditional code
> > that calls either request_firmware() or tee_rproc_load_fw().  The latter should
> > also be renamed to tee_rproc_request_firmware() to avoid confusion.
> 
> 
> The request_firmware() call is needed in both cases to get the image from the
> filesystem. The tee_rproc_load_fw() gets, as input, the struct firmware provided
> by request_firmware().

The cover letter clearly state the secure side is responsible for loading the
firmware image but here you're telling me it has to be loaded twice.  This is
very confusing.

I'm also confused as to why stm32_rproc_tee_elf_sanity_check() is calling
tee_rproc_load_fw().  There should be one call to load the firmware and another
to perform a sanity check on it.  If the sanity check is done at load time by
the secure world then ops::sanity_check() is NULL.

Most of what this patchset does makes sense, but some of it needs to be moved
around.  

Thanks,
Mathieu

> 
> If we want to integrate in remoteproc_core the solution could probably have to
> create the equivalent of the rproc_fw_boot() to load the firmware with an
> external method. Here is an example based on a new rproc_ops ( not tested)
> 
> + static int rproc_fw_ext_boot(struct rproc *rproc, const struct firmware *fw)
> + {
> + 	struct device *dev = &rproc->dev;
> + 	const char *name = rproc->firmware;
> + 	int ret;
> +
> +
> + 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
> + 	
> + 	/* ops to load and start the remoteprocessor */
> + 	ret = rproc->ops->boot(rproc, fw);
> + 	if (ret)
> + 		return ret;
> +
> + 	/*
> + 	 * if enabling an IOMMU isn't relevant for this rproc, this is
> + 	 * just a nop
> + 	 */
> + 	ret = rproc_enable_iommu(rproc);
> + 	if (ret) {
> + 		dev_err(dev, "can't enable iommu: %d\n", ret);
> + 		return ret;
> + 	}
> +
> + 	/* Prepare rproc for firmware loading if needed */
> + 	ret = rproc_prepare_device(rproc);
> + 	if (ret) {
> + 		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
> + 		goto disable_iommu;
> + 	}
> +
> + 	ret = rproc_set_rsc_table(rproc);
> + 	if (ret) {
> + 		dev_err(dev, "can't load resource table: %d\n", ret);
> + 		goto unprepare_device;
> + 	}
> +
> +
> + 	/* reset max_notifyid */
> + 	rproc->max_notifyid = -1;
> +
> + 	/* reset handled vdev */
> + 	rproc->nb_vdev = 0;
> +
> + 	/* handle fw resources which are required to boot rproc */
> + 	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
> + 	if (ret) {
> + 		dev_err(dev, "Failed to process resources: %d\n", ret);
> + 		goto clean_up_resources;
> + 	}
> +
> + 	/* Allocate carveout resources associated to rproc */
> + 	ret = rproc_alloc_registered_carveouts(rproc);
> + 	if (ret) {
> + 		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
> + 			ret);
> + 		goto clean_up_resources;
> + 	}
> +
> + 	return 0;
> +
> + clean_up_resources:
> + 	rproc_resource_cleanup(rproc);
> + unprepare_rproc:
> + 	/* release HW resources if needed */
> + 	rproc_unprepare_device(rproc);
> + disable_iommu:
> + 	rproc_disable_iommu(rproc);
> + 	return ret;
> + }
> 
> 
> int rproc_boot(struct rproc *rproc)
> {
> [...]
> 
> - 		ret = rproc_fw_boot(rproc, firmware_p);
> + 		if(rproc->ops->boot)
> + 			ret = rproc_fw_ext_boot(rproc, firmware_p);
> + 		else
> + 			ret = rproc_fw_boot(rproc, firmware_p);
> 
> Another advantage of this solution is that it opens the framework to other
> formats. For instance it could be a way to support dtb format requested in [RFC]
> Passing device-tree to remoteproc [1].
> 
> [1]
> https://lore.kernel.org/linux-remoteproc/f67cd822-4e29-71f2-7c42-e11dbaa6cd8c@kalrayinc.com/T/#t
> 
> Thanks,
> Arnaud
> 
> 
> 
> > 
> > I touched on that before but please rename rproc_tee_get_rsc_table() to
> > rproc_tee_elf_load_rsc_table().  I also suggest to introduce a new function,
> > rproc_tee_get_loaded_rsc_table() that would be called from
> > rproc_tee_elf_load_rsc_table().  That way we don't need trproc->rsc_va.  
> > 
> > I also think tee_rproc should be renamed to "rproc_tee_interface" and folded
> > under struct rproc.  
> > 
> > With the above most of the problems with the current implementation should
> > naturally go away.
> > 
> > Thanks,
> > Mathieu
> > 
> >>
> >>>> +	ret = tee_rproc_load_fw(ddata->trproc, fw);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +	ddata->fw_loaded = true;
> >>>> +
> >>>> +	/* Update the resource table parameters. */
> >>>> +	if (rproc_tee_get_rsc_table(ddata->trproc)) {
> >>>> +		/* No resource table: reset the related fields. */
> >>>> +		rproc->cached_table = NULL;
> >>>> +		rproc->table_ptr = NULL;
> >>>> +		rproc->table_sz = 0;
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static struct resource_table *
> >>>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
> >>>> +					  const struct firmware *fw)
> >>>> +{
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +
> >>>> +	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
> >>>> +}
> >>>> +
> >>>> +static int stm32_rproc_tee_start(struct rproc *rproc)
> >>>> +{
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +
> >>>> +	return tee_rproc_start(ddata->trproc);
> >>>> +}
> >>>> +
> >>>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
> >>>> +{
> >>>> +	/* Nothing to do, remote proc already started by the secured context. */
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> >>>> +{
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +	int err;
> >>>> +
> >>>> +	stm32_rproc_request_shutdown(rproc);
> >>>> +
> >>>> +	err = tee_rproc_stop(ddata->trproc);
> >>>> +	if (err)
> >>>> +		return err;
> >>>> +
> >>>> +	ddata->fw_loaded = false;
> >>>> +
> >>>> +	return stm32_rproc_release(rproc);
> >>>> +}
> >>>> +
> >>>>  static int stm32_rproc_prepare(struct rproc *rproc)
> >>>>  {
> >>>>  	struct device *dev = rproc->dev.parent;
> >>>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
> >>>>  
> >>>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >>>>  {
> >>>> -	if (rproc_elf_load_rsc_table(rproc, fw))
> >>>> +	struct stm32_rproc *ddata = rproc->priv;
> >>>> +	int ret;
> >>>> +
> >>>> +	if (ddata->trproc)
> >>>> +		ret = rproc_tee_get_rsc_table(ddata->trproc);
> >>>> +	else
> >>>> +		ret = rproc_elf_load_rsc_table(rproc, fw);
> >>>> +	if (ret)
> >>>>  		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
> >>>>  
> >>>>  	return 0;
> >>>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops = {
> >>>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> >>>>  };
> >>>>  
> >>>> +static const struct rproc_ops st_rproc_tee_ops = {
> >>>> +	.prepare	= stm32_rproc_prepare,
> >>>> +	.start		= stm32_rproc_tee_start,
> >>>> +	.stop		= stm32_rproc_tee_stop,
> >>>> +	.attach		= stm32_rproc_tee_attach,
> >>>> +	.kick		= stm32_rproc_kick,
> >>>> +	.parse_fw	= stm32_rproc_parse_fw,
> >>>> +	.find_loaded_rsc_table = stm32_rproc_tee_elf_find_loaded_rsc_table,
> >>>> +	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
> >>>> +	.sanity_check	= stm32_rproc_tee_elf_sanity_check,
> >>>> +	.load		= stm32_rproc_tee_elf_load,
> >>>> +};
> >>>> +
> >>>>  static const struct of_device_id stm32_rproc_match[] = {
> >>>> -	{ .compatible = "st,stm32mp1-m4" },
> >>>> +	{.compatible = "st,stm32mp1-m4",},
> >>>> +	{.compatible = "st,stm32mp1-m4-tee",},
> >>>>  	{},
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> >>>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>>>  	struct device *dev = &pdev->dev;
> >>>>  	struct stm32_rproc *ddata;
> >>>>  	struct device_node *np = dev->of_node;
> >>>> +	struct tee_rproc *trproc = NULL;
> >>>>  	struct rproc *rproc;
> >>>>  	unsigned int state;
> >>>>  	int ret;
> >>>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>>>  	if (ret)
> >>>>  		return ret;
> >>>>  
> >>>> -	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
> >>>> -	if (!rproc)
> >>>> -		return -ENOMEM;
> >>>> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> >>>> +		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
> >>>> +		if (IS_ERR(trproc)) {
> >>>> +			dev_err_probe(dev, PTR_ERR(trproc),
> >>>> +				      "signed firmware not supported by TEE\n");
> >>>> +			return PTR_ERR(trproc);
> >>>> +		}
> >>>> +		/*
> >>>> +		 * Delegate the firmware management to the secure context.
> >>>> +		 * The firmware loaded has to be signed.
> >>>> +		 */
> >>>> +		dev_info(dev, "Support of signed firmware only\n");
> >>>
> >>> Not sure what this adds.  Please remove.
> >>
> >> This is used to inform the user that only a signed firmware can be loaded, not
> >> an ELF file.
> >> I have a patch in my pipe to provide the supported format in the debugfs. In a
> >> first step, I can suppress this message and we can revisit the issue when I push
> >> the debugfs proposal.
> >>
> >> Thanks,
> >> Arnaud
> >>
> >>>
> >>>> +	}
> >>>> +	rproc = rproc_alloc(dev, np->name,
> >>>> +			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
> >>>> +			    NULL, sizeof(*ddata));
> >>>> +	if (!rproc) {
> >>>> +		ret = -ENOMEM;
> >>>> +		goto free_tee;
> >>>> +	}
> >>>>  
> >>>>  	ddata = rproc->priv;
> >>>> +	ddata->trproc = trproc;
> >>>> +	if (trproc)
> >>>> +		trproc->rproc = rproc;
> >>>>  
> >>>>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> >>>>  
> >>>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >>>>  		device_init_wakeup(dev, false);
> >>>>  	}
> >>>>  	rproc_free(rproc);
> >>>> +free_tee:
> >>>> +	if (trproc)
> >>>> +		tee_rproc_unregister(trproc);
> >>>> +
> >>>>  	return ret;
> >>>>  }
> >>>>  
> >>>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
> >>>>  		device_init_wakeup(dev, false);
> >>>>  	}
> >>>>  	rproc_free(rproc);
> >>>> +	if (ddata->trproc)
> >>>> +		tee_rproc_unregister(ddata->trproc);
> >>>>  }
> >>>>  
> >>>>  static int stm32_rproc_suspend(struct device *dev)
> >>>> -- 
> >>>> 2.25.1
> >>>>

