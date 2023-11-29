Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DC7FDE90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjK2Rml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjK2RKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:10:46 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DB12C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:10:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so32935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701277851; x=1701882651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0mJ9O73VXWzbKqnQ7Cwt7Ek51iP1MX602pncXZ22/k=;
        b=P65SsnVQOgW5yON+SUYKyvA9AqyyeykRgp357FHWN+gEdLVzmhHSQvcmNKawWt6rtg
         RR20oHcGGTpZd5XEJKSnpT1HslrW8RpHtXI/bj8GO4LS//TVVYHhC5Kapj8KNuiqvUxc
         JF1cXbenNopb9uNQh8vsn23brpzDqp+bvvj2jHwsONRACFiH87xhEmK6spSE4m6mC2bA
         y894ZWEq/dH1LrPt87HK0+Bb3cf18CjzrPsUjOkE77yxFkh8t7sl4LkOQ2csW4g0h3C7
         /hmnsnmn5qRjaKixLojRMbXF230zqmT2CP2dxQ+cIQk1kqlPjmrew3m/JYdT7fVRIqUe
         6q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277851; x=1701882651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0mJ9O73VXWzbKqnQ7Cwt7Ek51iP1MX602pncXZ22/k=;
        b=LEO/Uoso8Kkecm5v/44Z6OO1wt3PWJxGJWWVp84g3A/Be0TwEUUKpfybudEvVoEwTD
         D7M3g+l+yzmCptvb7GrKzigy7zA/0pfJomqE2Lyu2oyhG5FS5tD+fmZv86ndHx/bJMGK
         xLcjCz0Rux8eJNMmBOirKOrTJZ8mWpWwjLhVtZkNsR2BqJ5nmmNX60d5pGzhR9R0zZwd
         9F6uP8KwWvTNIG3Z6G/095/OASZrNR+3PmTnSFITSOUBGvxIhNAGwqHdAeLgM0Qw1U4d
         56JYk5K/buHZ2FZmQNNTjkqjQIBrCpPTijS8y8idWXimxP9rstV2qKg9VvUbXZgjMRnJ
         pCDg==
X-Gm-Message-State: AOJu0YwtdzQAJSzw1zmV4I3hzrJEujpGNZUhz9CDsOkkHton1/6dlayP
        laOeK0DxiCEoYaBTeGry5cfwlA==
X-Google-Smtp-Source: AGHT+IHpjxxSlfk2aa8ecHkifcX3uMZ2B7uS1x/5tXF1lBWlLPtNAio9bUMjEX48rxuumxNMf1ShQA==
X-Received: by 2002:a17:903:120e:b0:1cf:b14d:8939 with SMTP id l14-20020a170903120e00b001cfb14d8939mr15855038plh.63.1701277850796;
        Wed, 29 Nov 2023 09:10:50 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:eab1:b670:2dee:fa42])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001cfa5709c15sm10545633plx.104.2023.11.29.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:10:50 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:10:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Message-ID: <ZWdwl/8LC2Nn+vCq@p14s>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com>
 <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com>
 <ZV+V6V2sEWgsqngk@p14s>
 <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:33:05AM -0600, Tanmay Shah wrote:
> 
> On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> > On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > > Hi Mathieu,
> > > 
> > > Please find my comments below.
> > > 
> > > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > > Hi,
> > > >
> > > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > > Use TCM pm domains extracted from device-tree
> > > > > to power on/off TCM using general pm domain framework.
> > > > > 
> > > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > > ---
> > > > > 
> > > > > Changes in v7:
> > > > >   - %s/pm_dev1/pm_dev_core0/r
> > > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > > >   - %s/pm_dev2/pm_dev_core1/r
> > > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > > >   - remove pm_domain_id check to move next patch
> > > > >   - add comment about how 1st entry in pm domain list is used
> > > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > > 
> > > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > index 4395edea9a64..22bccc5075a0 100644
> > > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include <linux/of_reserved_mem.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/remoteproc.h>
> > > > > +#include <linux/pm_domain.h>
> > > > >  
> > > > >  #include "remoteproc_internal.h"
> > > > >  
> > > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > >   * @rproc: rproc handle
> > > > >   * @pm_domain_id: RPU CPU power domain id
> > > > >   * @ipi: pointer to mailbox information
> > > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > > + * registration
> > > > >   */
> > > > >  struct zynqmp_r5_core {
> > > > >  	struct device *dev;
> > > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > > >  	struct rproc *rproc;
> > > > >  	u32 pm_domain_id;
> > > > >  	struct mbox_info *ipi;
> > > > > +	int num_pm_dev;
> > > > > +	struct device **pm_dev_core0;
> > > > > +	struct device_link **pm_dev_core0_link;
> > > > > +	struct device **pm_dev_core1;
> > > > > +	struct device_link **pm_dev_core1_link;
> > > > >  };
> > > > >  
> > > > >  /**
> > > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > >  		if (ret < 0) {
> > > > > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > > +			dev_err(dev, "failed to turn on TCM 0x%x",
> > > > > +				pm_domain_id);
> > > >
> > > > Spurious change, you should have caught that.
> > > 
> > > Ack, need to observe changes more closely before sending them.
> > > 
> > > >
> > > > >  			goto release_tcm_lockstep;
> > > > >  		}
> > > > >  
> > > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > > +{
> > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > +	struct device *dev = r5_core->dev;
> > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > +	int i;
> > > > > +
> > > > > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > > +
> > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > > +	}
> > > > > +
> > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > +
> > > > > +	if (cluster->mode == SPLIT_MODE) {
> > > > > +		r5_core->num_pm_dev = 0;
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > +		device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > > +	}
> > > > > +
> > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > +	r5_core->num_pm_dev = 0;
> > > > > +}
> > > > > +
> > > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > > +{
> > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > +	struct device *dev = r5_core->dev, *dev2;
> > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > +	struct platform_device *pdev;
> > > > > +	struct device_node *np;
> > > > > +	int i, j, num_pm_dev, ret;
> > > > > +
> > > > > +	cluster = dev_get_drvdata(dev->parent);
> > > > > +
> > > > > +	/* get number of power-domains */
> > > > > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > > +						"#power-domain-cells");
> > > > > +
> > > > > +	if (num_pm_dev <= 0)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > > +					sizeof(struct device *),
> > > > > +					GFP_KERNEL);
> > > > > +	if (!r5_core->pm_dev_core0)
> > > > > +		ret = -ENOMEM;
> > > > > +
> > > > > +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > > +					     sizeof(struct device_link *),
> > > > > +					     GFP_KERNEL);
> > > > > +	if (!r5_core->pm_dev_core0_link) {
> > > > > +		kfree(r5_core->pm_dev_core0);
> > > > > +		r5_core->pm_dev_core0 = NULL;
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +
> > > > > +	r5_core->num_pm_dev = num_pm_dev;
> > > > > +
> > > > > +	/*
> > > > > +	 * start from 2nd entry in power-domains property list as
> > > > > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > > > > +	 * 1st entry is used to configure r5 operation mode.
> > > >
> > > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > > 
> > > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > > 
> > > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> > >
> >
> > That is exactly what I am looking for.  That way people don't have to go through
> > the entire driver trying to figure out what is happening with pm_dev_core[0].
> >
> > I'm also not sure about the power-up order.  Logically the TCMs should be
> > powered up before the R5 in order to put code in them.  The R5s are powered in
> > zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> > TCMs are powered - can you expand on that?
> 
> 
> Sure. Following is call sequece
> 
> zynqmp_r5_rproc_prepare
> 
> zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.
> 
> . . .
> 
> zynqmp_r5_rproc_start -> load firmware and Starts RPU
> 
> So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.
> 
> 
> >
> > > revision. For new platforms pm_dev_core0[0] will be added in future.
> >
> > Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> > future"?
> 
> 
> ZynqMP platform has platform management firmware running on microblaze.
> 
> This firmware design does not expect R5 pm domains to be requested explicitly.
> 
> This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,
> 
> firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.
> 
> However, this design was changed for new platforms i.e. "versal" and onwards.
> 
> Firmware of new platform expects pm domains to be requested explicitly for R5 cores before
> 
> waking them up.
> 
> That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.
> 
> Then, we should wake it up on r5_core.
> 
> To summarize:
> 
> For zynqmp only following call needed to start R5:
> 
> zynqmp_pm_request_wake
> 
> For "versal" and onwards we need two calls to start R5:
> 
> "device_link_add" and zynqmp_pm_request_wake
> 
> So, in future pm_core_dev[0] will be used.
>

Thanks for the clarification on both front.  The problem here is that we are
keeping R5 power domain information in two different places, i.e
zynqmp_r5_core::pm_domain_id and zynqmp_r5_core::pm_dev_core0[0].  

Please see if you can retreive the power domain ID from
zynqmp_r5_core::pm_dev_core0[0].  That way you can get the power domain ID when
calling zynqmp_pm_request_wake() and zynqmp_pm_force_pwrdwn() and get rid of
zynqmp_r5_core::pm_domain_id.

> 
> > > 
> > > I hope this meets expectations.
> > > 
> > > 
> > > >
> > > > > +	 */
> > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > > +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > > >
> > > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > > stick with it.  I have no preference on which one.
> > > 
> > > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > > 
> > > 
> > > >
> > > > > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > > +				PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > > +			ret = -EINVAL;
> > > > > +			goto fail_add_pm_domains;
> > > > > +		}
> > > > > +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > > +								r5_core->pm_dev_core0[i],
> > > > > +								DL_FLAG_STATELESS |
> > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > +		if (!r5_core->pm_dev_core0_link[i]) {
> > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > +			r5_core->pm_dev_core0[i] = NULL;
> > > > > +			ret = -EINVAL;
> > > > > +			goto fail_add_pm_domains;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (cluster->mode == SPLIT_MODE)
> > > > > +		return 0;
> > > > > +
> > > > > +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > > +					sizeof(struct device *),
> > > > > +					GFP_KERNEL);
> > > > > +	if (!r5_core->pm_dev_core1) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto fail_add_pm_domains;
> > > > > +	}
> > > > > +
> > > > > +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > > +					     sizeof(struct device_link *),
> > > > > +					     GFP_KERNEL);
> > > > > +	if (!r5_core->pm_dev_core1_link) {
> > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > +		ret = -ENOMEM;
> > > > > +		goto fail_add_pm_domains;
> > > > > +	}
> > > > > +
> > > > > +	/* get second core's device to detach its power-domains */
> > > > > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > > +
> > > > > +	pdev = of_find_device_by_node(np);
> > > > > +	if (!pdev) {
> > > > > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > +		kfree(r5_core->pm_dev_core1_link);
> > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > +		r5_core->pm_dev_core1_link = NULL;
> > > > > +		ret = -EINVAL;
> > > > > +		goto fail_add_pm_domains;
> > > > > +	}
> > > > > +
> > > > > +	dev2 = &pdev->dev;
> > > > > +
> > > > > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > > > > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > > +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > > +		if (!r5_core->pm_dev_core1[j]) {
> > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > +			ret = -EINVAL;
> > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > +		}
> > > > > +
> > > > > +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > > +								r5_core->pm_dev_core1[j],
> > > > > +								DL_FLAG_STATELESS |
> > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > +		if (!r5_core->pm_dev_core1_link[j]) {
> > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > +			r5_core->pm_dev_core1[j] = NULL;
> > > > > +			ret = -ENODEV;
> > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +fail_add_pm_domains_lockstep:
> > > > > +	while (--j >= 0) {
> > > > > +		device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > +	}
> > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > +
> > > > > +fail_add_pm_domains:
> > > > > +	while (--i >= 0) {
> > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > +	}
> > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > +
> > > >
> > > > The error path is much cleaner and readable now.
> > > >
> > > > I will continue tomorrow.
> > > >
> > > > Mathieu
> > > >
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * zynqmp_r5_rproc_prepare()
> > > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > > >  {
> > > > >  	int ret;
> > > > >  
> > > > > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > > > > +	if (ret) {
> > > > > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > >  	ret = add_tcm_banks(rproc);
> > > > >  	if (ret) {
> > > > >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > > -		return ret;
> > > > > +		goto fail_prepare;
> > > > >  	}
> > > > >  
> > > > >  	ret = add_mem_regions_carveout(rproc);
> > > > >  	if (ret) {
> > > > >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > > -		return ret;
> > > > > +		goto fail_prepare;
> > > > >  	}
> > > > >  
> > > > >  	return 0;
> > > > > +
> > > > > +fail_prepare:
> > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > +
> > > > > +	return ret;
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > > >  
> > > > >  	r5_core = rproc->priv;
> > > > >  
> > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > +
> > > > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > > > > -- 
> > > > > 2.25.1
> > > > > 
