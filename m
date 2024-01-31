Return-Path: <linux-kernel+bounces-46884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B58445C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E1628CAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79312CD9D;
	Wed, 31 Jan 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLUFz6cH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A012C539
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721273; cv=none; b=HQtw10J0DfcjKBFfiM3NQnSg6dsUSzMYyhQgtnrX6iigAgL6g3tK7r66ioixQWTxqg+b0kSUZVp2+M+FiRmQVdGTy10fCnhaOMGiQ9+zso+AAPFyCypUxHaHNwTSInpVZxQGNC+bi6LJr198HXbG0BrRqfWl1LWNPxafWGFUkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721273; c=relaxed/simple;
	bh=bwubZvYdPtkVL7W+Tee7HF6BTwatsu9HRYNePcqti7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtHWjS61exQzj/+FboWXFgAubjxIvNfZn6w2D1wzJGdZ6lo7np3z/6QKfseR2y1KJla7eak3tLq1w2N6b9mcURFeEbnHwBEKeQVenJ9j98uuZPJg+uIbjKv5dccdy9YPdvsARNprtrdtFTiGyFgi8U78kyRXPqKdPxjNmsqDfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLUFz6cH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8e7df6abcso24197795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706721270; x=1707326070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLGQmaPNnGaEoMndQ/+BCcRfvGgwN9zIAY8nt17Qiew=;
        b=eLUFz6cHRzV62CzvN2nP3+xpr5G48LzhVkUHCq+CW5P4lGTPliqng72n2bDfXeJbx3
         jUutD+Lpv/of9S9hyomYlR18fM0lvYe2cs+R7hlOt9eB5Q3luyh+LXkwSVEpoDz8Qaw/
         41XyDUP4OJOLtcewuaTVOAeCHTzISJzclqXX4bVeVqYVUVoQ9/RCMDIVDxyIPRbFJn6t
         xNbmLe/93+bQXxCloE8T0ak+1pv2KSuYlMcmyRcF5DB9rsD7c3OJW/eYB6QZAYUF/Y/X
         q9UivZ4UJQ9YqKQmXCZ5VsCaEvPygCnYp1JsrevVl8X8jVh0zITgubBeVSEsYSFJYSbd
         PlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721270; x=1707326070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLGQmaPNnGaEoMndQ/+BCcRfvGgwN9zIAY8nt17Qiew=;
        b=GzBJixrUbF/6/EyNIr7Nm5SVC13srINtiahRAWa462pFqkWOu/EGH40b2+UEbpyIyO
         xu9XR3vBbnfcvkJoCL4toFtbGcEn0pDiKToXan5H3QZzkw9dGSSw6caBh/WHT92q8hD4
         3poAmdbftj4vErlkxR3rdt99jUZxkkRKvHFlnJ/1likTYib95kE1WJWtH9VTrqKX8JMU
         HrnUKDHM0Cog6QuHwuPpKT0FD+G6bT5/dv1SUe3uX4ALlE7ob+Cbz9m3fpJ4F+d/meg7
         mEqnVNU1hsdHDa5lBeNllLIFOnxPRshQVjPGqZdAWkwk85j9auDsWu3VroiTHYskB3Cn
         OQQA==
X-Gm-Message-State: AOJu0YyKmRCTzT8U8T0vO9l86uW+NcM7pBuPTFoGwrf5qh1WLf4FbWix
	U4/7HcZLwMUv8xXFcu3iZGwbUYnREDuCAUs3dEXdoQV1mhdkdw4Xkk/4H0PN5pc=
X-Google-Smtp-Source: AGHT+IHad0+n+vWQsLSKi37U13ncBz0ljHmrhfLlsxOV+EK9ZFtEFehparGBXx5tVCTuP5hC67K1jw==
X-Received: by 2002:a17:903:40cb:b0:1d8:d224:974 with SMTP id t11-20020a17090340cb00b001d8d2240974mr2616814pld.45.1706721269731;
        Wed, 31 Jan 2024 09:14:29 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:130d:9bb4:89ef:ab9e])
        by smtp.gmail.com with ESMTPSA id ml16-20020a17090334d000b001d8e91cff10sm5521036plb.5.2024.01.31.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:14:29 -0800 (PST)
Date: Wed, 31 Jan 2024 10:14:26 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: "andersson@kernel.org" <andersson@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Levinsky, Ben" <ben.levinsky@amd.com>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/3] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <Zbp/8jpvkdgB+1OK@p14s>
References: <20240110213504.3626468-1-tanmay.shah@amd.com>
 <20240110213504.3626468-4-tanmay.shah@amd.com>
 <ZagjbaGtz/zqoJ6Z@p14s>
 <ae93ee54-21ee-478d-8a24-f8c8347126fa@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae93ee54-21ee-478d-8a24-f8c8347126fa@amd.com>

On Tue, Jan 30, 2024 at 02:47:07PM -0600, Tanmay Shah wrote:
> 
> On 1/17/24 12:58 PM, Mathieu Poirier wrote:
> > Alright, I spent several hours looking at this patchset and the driver as a
> > whole.  I certainly salute your efforts to heed my advice and make the code less
> > brittle but I'm afraid we are not there.
> 
> Hi Mathieu,
> 
> I am back from vacation. Started looking into this. Thanks for spending time on this and helping
> 
> to make clean design of the driver. Please find my comments below.
> 
> > See below for a different way to proceed.
> >
> > On Wed, Jan 10, 2024 at 01:35:05PM -0800, Tanmay Shah wrote:
> > > ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> > > is available in device-tree. Parse TCM information in driver
> > > as per new bindings.
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > > 
> > > Changes in v9:
> > >   - Introduce new API to request and release core1 TCM power-domains in
> > >     lockstep mode. This will be used during prepare -> add_tcm_banks
> > >     callback to enable TCM in lockstep mode.
> > >   - Parse TCM from device-tree in lockstep mode and split mode in
> > >     uniform way.
> > >   - Fix TCM representation in device-tree in lockstep mode.
> > > 
> > > Changes in v8:
> > >   - Remove pm_domains framework
> > >   - Remove checking of pm_domain_id validation to power on/off tcm
> > >   - Remove spurious change
> > >   - parse power-domains property from device-tree and use EEMI calls
> > >     to power on/off TCM instead of using pm domains framework
> > > 
> > > Changes in v7:
> > >   - move checking of pm_domain_id from previous patch
> > >   - fix mem_bank_data memory allocation
> > > 
> > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 245 +++++++++++++++++++++++-
> > >  1 file changed, 239 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > index 4395edea9a64..0f87b984850b 100644
> > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > @@ -74,8 +74,8 @@ struct mbox_info {
> > >  };
> > >  
> > >  /*
> > > - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > > - * accepted for system-dt specifications and upstreamed in linux kernel
> > > + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> > > + * compatibility with device-tree that does not have TCM information.
> > >   */
> > >  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > >  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > > @@ -102,6 +102,7 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > >   * @rproc: rproc handle
> > >   * @pm_domain_id: RPU CPU power domain id
> > >   * @ipi: pointer to mailbox information
> > > + * @lockstep_core1_np: second core's device_node to use in lockstep mode
> > >   */
> > >  struct zynqmp_r5_core {
> > >  	struct device *dev;
> > > @@ -111,6 +112,7 @@ struct zynqmp_r5_core {
> > >  	struct rproc *rproc;
> > >  	u32 pm_domain_id;
> > >  	struct mbox_info *ipi;
> > > +	struct device_node *lockstep_core1_np;
> > >  };
> > >  
> > >  /**
> > > @@ -539,6 +541,110 @@ static int tcm_mem_map(struct rproc *rproc,
> > >  	return 0;
> > >  }
> > >  
> > > +int request_core1_tcm_lockstep(struct rproc *rproc)
> > > +{
> > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > +	struct of_phandle_args out_args = {0};
> > > +	int ret, i, num_pd, pd_id, ret_err;
> > > +	struct device_node *np;
> > > +
> > > +	np = r5_core->lockstep_core1_np;
> > > +
> > > +	/* Get number of power-domains */
> > > +	num_pd = of_count_phandle_with_args(np, "power-domains",
> > > +					    "#power-domain-cells");
> > > +	if (num_pd <= 0)
> > > +		return -EINVAL;
> > > +
> > > +	/* Get individual power-domain id and enable TCM */
> > > +	for (i = 1; i < num_pd; i++) {
> > > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > > +						 "#power-domain-cells",
> > > +						 i, &out_args);
> > > +		if (ret) {
> > > +			dev_warn(r5_core->dev,
> > > +				 "failed to get tcm %d in power-domains list, ret %d\n",
> > > +				 i, ret);
> > > +			goto fail_request_core1_tcm;
> > > +		}
> > > +
> > > +		pd_id = out_args.args[0];
> > > +		of_node_put(out_args.np);
> > > +
> > > +		ret = zynqmp_pm_request_node(pd_id, ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > +		if (ret) {
> > > +			dev_err(r5_core->dev, "failed to request TCM node 0x%x\n",
> > > +				pd_id);
> > > +			goto fail_request_core1_tcm;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +fail_request_core1_tcm:
> > > +
> > > +	/* Cache actual error to return later */
> > > +	ret_err = ret;
> > > +
> > > +	/* Release previously requested TCM in case of failure */
> > > +	while (--i > 0) {
> > > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > > +						 "#power-domain-cells",
> > > +						 i, &out_args);
> > > +		if (ret)
> > > +			return ret;
> > > +		pd_id = out_args.args[0];
> > > +		of_node_put(out_args.np);
> > > +		zynqmp_pm_release_node(pd_id);
> > > +	}
> > > +
> > > +	return ret_err;
> > > +}
> > > +
> > > +void release_core1_tcm_lockstep(struct rproc *rproc)
> > > +{
> > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > +	struct of_phandle_args out_args = {0};
> > > +	struct zynqmp_r5_cluster *cluster;
> > > +	int ret, i, num_pd, pd_id;
> > > +	struct device_node *np;
> > > +
> > > +	/* Get R5 core1 node */
> > > +	cluster = dev_get_drvdata(r5_core->dev->parent);
> > > +
> > > +	if (cluster->mode != LOCKSTEP_MODE)
> > > +		return;
> > > +
> > > +	np = r5_core->lockstep_core1_np;
> > > +
> > > +	/* Get number of power-domains */
> > > +	num_pd = of_count_phandle_with_args(np, "power-domains",
> > > +					    "#power-domain-cells");
> > > +	if (num_pd <= 0)
> > > +		return;
> > > +
> > > +	/* Get individual power-domain id and turn off each TCM */
> > > +	for (i = 1; i < num_pd; i++) {
> > > +		ret = of_parse_phandle_with_args(np, "power-domains",
> > > +						 "#power-domain-cells",
> > > +						 i, &out_args);
> > > +		if (ret) {
> > > +			dev_warn(r5_core->dev,
> > > +				 "failed to get pd of core1 tcm %d in list, ret %d\n",
> > > +				 i, ret);
> > > +			continue;
> > > +		}
> > > +
> > > +		pd_id = out_args.args[0];
> > > +		of_node_put(out_args.np);
> > > +
> > > +		if (zynqmp_pm_release_node(pd_id))
> > > +			dev_warn(r5_core->dev,
> > > +				 "failed to release core1 tcm pd 0x%x\n", pd_id);
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * add_tcm_carveout_split_mode()
> > >   * @rproc: single R5 core's corresponding rproc instance
> > > @@ -633,6 +739,21 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  	r5_core = rproc->priv;
> > >  	dev = r5_core->dev;
> > >  
> > > +	/*
> > > +	 * In lockstep mode, R5 core0 uses TCM of R5 core1 via aliased addresses.
> > > +	 * Aliased addresses are contiguous with core0 TCM and embedded in "reg"
> > > +	 * property. However, R5 core1 TCM power-domains needs to be requested
> > > +	 * from firmware to use R5 core1 TCM. Request core1 TCM power-domains
> > > +	 * if TCM is parsed from device-tree.
> > > +	 */
> > > +	if (of_find_property(r5_core->np, "reg", NULL)) {
> > > +		ret = request_core1_tcm_lockstep(rproc);
> > > +		if (ret) {
> > > +			dev_err(r5_core->dev, "failed to request core1 TCM power-domains\n");
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > >  	/* Go through zynqmp banks for r5 node */
> > >  	num_banks = r5_core->tcm_bank_count;
> > >  
> > > @@ -689,6 +810,9 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > >  		zynqmp_pm_release_node(pm_domain_id);
> > >  	}
> > > +
> > > +	release_core1_tcm_lockstep(rproc);
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > @@ -808,6 +932,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > >  	}
> > >  
> > > +	release_core1_tcm_lockstep(rproc);
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > @@ -878,6 +1004,95 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >  	return ERR_PTR(ret);
> > >  }
> > >  
> > > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int i, j, tcm_bank_count, ret, tcm_pd_idx;
> > > +	struct of_phandle_args out_args = {0};
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	struct platform_device *cpdev;
> > > +	struct mem_bank_data *tcm;
> > > +	struct device_node *np;
> > > +	struct resource *res;
> > > +	u64 abs_addr, size;
> > > +	struct device *dev;
> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		dev = r5_core->dev;
> > > +		np = r5_core->np;
> > > +
> >
> > Using r5_core->np doesn't work because it deals with the specifics of a single
> > subnode when we need to deal with the subnodes of the entire cluster.
> 
> Correct. I think below mentioned design should resolve this problem.
> 
> 
> >
> > > +		/* we have address cell 2 and size cell as 2 */
> > > +		tcm_bank_count = of_property_count_elems_of_size(np, "reg",
> > > +								 4 * sizeof(u32));
> > > +		if (tcm_bank_count <= 0) {
> > > +			dev_err(dev, "can't get reg property err %d\n", tcm_bank_count);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +						  sizeof(struct mem_bank_data *),
> > > +						  GFP_KERNEL);
> >
> > Another problem is that when getting information from the DT, ->tcm_banks is
> > always 2 whereas it varies (2 or 4) when using the static mem_bank_data arrays.
> >
> > We know the current driver works well when using static banks and everything is
> > already in place to address the mode of operation (lockstep vs split). As
> > such I suggest to reuse all that code by making function
> > zynqmp_r5_get_tcm_node_from_dt() return a mem_bank_data array of 4 elements.
> > That array would be instantiated using the information found in the DT,
> > regardless of the mode of operation.  Once we have that array it could simply be
> > inserted in function zynqmp_r5_get_tcm_node() and everything else in the driver
> > works the same way.
> >
> > Note that for that work you will have to set the "reg" values of the second
> > core to 0 when in lockstep mode, which is fine because they are not used anyway.
> 
> I agree to most part. I will have to modify bindings as well to accommodate above design.
> 
> I think the problem is in lockstep mode, where two memory regions are combined and presented as single
> 
> memory-region in table: *zynqmp_tcm_banks_lockstep*. First I will have to fix that.
> 
> If that is fixed, then no need to have two functions for lockstep and split tcm carveouts. They both can be
> 
> handled uniformly. Once that is fixed, bindings needs to be fixed i.e.
> 
> For lockstep mode, "reg" will have 4 entries and split mode "reg" will have only two entries.
> 
> We don't have to make "reg" of core1 as 0 in lockstep mode, as it's not being used anyway.
> 
> Once I change bindings as above, then it's very easy to implement changes as suggested.

I also came to the conclusion the bindings needed to change.  I'm not sure to
understand everything you write above and as such will wait for your next
patchset.

> 
> We parse TCM information from dt if "reg" is available, and fill up the table in r5_core->tcm_banks and rest of the
> 
> driver remain same.
> 
> I will implement and test v10 accordingly. I think this should make design clean.
> 
> Only downside is, we are spliting contiguous region in lockstep mode, so after this change, firmware's linker script
> 
> needs to be updated accordingly for lockstep mode (If contiguous regions are considered which is not the case for Xilinx's firmwares).
> 
> I would consider current implementation as bug, and will send Fixes tag accordingly where needed.

Here too I won't claim to understand exactly what you mean but that is likely
because my head is currently in another patchset.  That said, make sure to keep
things backward compatible when moving forward with your changes.

> 
> 
> Thanks,
> 
> Tanmay
> 
> 
> > Thanks,
> > Mathieu
> >
> > > +		if (!r5_core->tcm_banks)
> > > +			ret = -ENOMEM;
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > > +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
> > > +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> > > +					   GFP_KERNEL);
> > > +			if (!tcm)
> > > +				return -ENOMEM;
> > > +
> > > +			r5_core->tcm_banks[j] = tcm;
> > > +
> > > +			/* Get power-domains id of TCM. */
> > > +			ret = of_parse_phandle_with_args(np, "power-domains",
> > > +							 "#power-domain-cells",
> > > +							 tcm_pd_idx, &out_args);
> > > +			if (ret) {
> > > +				dev_err(r5_core->dev,
> > > +					"failed to get tcm %d pm domain, ret %d\n",
> > > +					tcm_pd_idx, ret);
> > > +				return ret;
> > > +			}
> > > +			tcm->pm_domain_id = out_args.args[0];
> > > +			of_node_put(out_args.np);
> > > +
> > > +			/* Get TCM address without translation. */
> > > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > > +			if (ret) {
> > > +				dev_err(dev, "failed to get reg property\n");
> > > +				return ret;
> > > +			}
> > > +
> > > +			/*
> > > +			 * Remote processor can address only 32 bits
> > > +			 * so convert 64-bits into 32-bits. This will discard
> > > +			 * any unwanted upper 32-bits.
> > > +			 */
> > > +			tcm->da = (u32)abs_addr;
> > > +			tcm->size = (u32)size;
> > > +
> > > +			cpdev = to_platform_device(dev);
> > > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to get tcm resource\n");
> > > +				return -EINVAL;
> > > +			}
> > > +
> > > +			tcm->addr = (u32)res->start;
> > > +			tcm->bank_name = (char *)res->name;
> > > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> > > +						      tcm->bank_name);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to request tcm resource\n");
> > > +				return -EINVAL;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * zynqmp_r5_get_tcm_node()
> > >   * Ideally this function should parse tcm node and store information
> > > @@ -956,9 +1171,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int ret, i;
> > >  
> > > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > > +	r5_core = cluster->r5_cores[0];
> > > +	if (of_find_property(r5_core->np, "reg", NULL))
> > > +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > > +	else
> > > +		ret = zynqmp_r5_get_tcm_node(cluster);
> > > +
> > > +	if (ret) {
> > > +		dev_err(dev, "can't get tcm, err %d\n", ret);
> > >  		return ret;
> > >  	}
> > >  
> > > @@ -1099,7 +1319,19 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> > >  		 * then ignore second child node.
> > >  		 */
> > >  		if (cluster_mode == LOCKSTEP_MODE) {
> > > -			of_node_put(child);
> > > +			/*
> > > +			 * Get second core's device node only to use its power-domains.
> > > +			 * Also, no need to use of_node_put on first core's device_node
> > > +			 * as it is taken care by of_get_next_available_child.
> > > +			 */
> > > +			r5_cores[i]->lockstep_core1_np =
> > > +				of_get_next_available_child(dev_node, child);
> > > +
> > > +			if (!r5_cores[i]->lockstep_core1_np) {
> > > +				ret = -EINVAL;
> > > +				goto release_r5_cores;
> > > +			}
> > > +
> > >  			break;
> > >  		}
> > >  
> > > @@ -1158,6 +1390,7 @@ static void zynqmp_r5_cluster_exit(void *data)
> > >  		r5_core = cluster->r5_cores[i];
> > >  		zynqmp_r5_free_mbox(r5_core->ipi);
> > >  		of_reserved_mem_device_release(r5_core->dev);
> > > +		of_node_put(r5_core->lockstep_core1_np);
> > >  		put_device(r5_core->dev);
> > >  		rproc_del(r5_core->rproc);
> > >  		rproc_free(r5_core->rproc);
> > > -- 
> > > 2.25.1
> > > 

