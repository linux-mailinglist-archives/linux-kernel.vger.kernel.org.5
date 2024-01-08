Return-Path: <linux-kernel+bounces-19893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D40982764D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1152D1F21E64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EE54725;
	Mon,  8 Jan 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggUW/8pS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2B5466E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33770772136so470716f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704734763; x=1705339563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QN27VBEQHcgTGcmidTREw1ydFcQQpfGT5IDyKss3q24=;
        b=ggUW/8pSROQxbZoJXfLG5cBylt3w7cAgqsDh0H0nrs/QpvjbksjJ4W4/iQMi5uobwZ
         PQ4SXPj6s86oHAqS7msFfqLwBDGaSLLESJpm2Kpg5K8OswY5F8lMfK1ge8zCmqSovhCS
         CqzXmd2cTOC1Q7/SynBeMNyHgZ3A0cdNkOChc5i/kY2S4ffihYTTsC3L4GFpgfUrA9lO
         GMI81esDgJyYEEoAS7hBSMQJdatUajFdxFNRVVq8yG8H6p5FV83xDNeMc3twqi6sudFx
         xy2kbPUf7bUCK1IwxH/ROW3irYg6xiPht3XpRTu6xvKl1g+mWs6EmxrA643JdW6sGp9Q
         OD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734763; x=1705339563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QN27VBEQHcgTGcmidTREw1ydFcQQpfGT5IDyKss3q24=;
        b=W5tbYdBFuc3R6DfX7xkWKW5K8MwoKJgAkPmfosOU9hMS5EXehQJ3216fRNATSmVM55
         jRz7DXXAlS1sVxuOYI64FVRV7iTcXWANsOUTu4/txrPJTUtcU1d5QW2EhRnOZpEYWPAn
         SuuW4ixqfIbw8l+T4bAQwBASIAYFkxUOx0RbrAqKHtI/AnwP0oj/OlEzCgQe2fTrgEXm
         imiZufbGF5S0A83YjUQXW7rS+zPk7CcsqSR731h08uTg7tcOHmuwfwmBYmBUTe8e2cSh
         xeny4h2QfH8Zx4JTXUMFzlwHSiB/X1PLpVOpyILchfhDuCGd+/QOKbAu/g7GTiFpilu4
         MA9A==
X-Gm-Message-State: AOJu0YxnFDabZxfZ4HIq9KDQnC7QqeundtMNFoSXg7AwU9UH4KKzD0l6
	E+rdYerVPvyLPPicUf3MAoTesDCiRhOE9XRIEOMatxkhQhRf0w==
X-Google-Smtp-Source: AGHT+IHAl9GTlDGzxP/m6RP8NpXy0tlpLGKwdeEbnPIhqHx6xFIoodtHkrqZ4MsVrtMNOERZxIHc825nbShoPPvTMiM=
X-Received: by 2002:a05:6000:18cc:b0:333:c81:8f9d with SMTP id
 w12-20020a05600018cc00b003330c818f9dmr1935156wrq.2.1704734763159; Mon, 08 Jan
 2024 09:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235725.1247350-1-tanmay.shah@amd.com> <20231215235725.1247350-4-tanmay.shah@amd.com>
 <ZZWkqYNqR2/Qq54m@p14s> <0fe87b36-2daf-4b4b-a6b0-28a4c6c599f3@amd.com>
In-Reply-To: <0fe87b36-2daf-4b4b-a6b0-28a4c6c599f3@amd.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 8 Jan 2024 10:25:51 -0700
Message-ID: <CANLsYkzszLZe+0+7Amps6OY9PZrAS9PtT6qSro7Tk8FOWjQneQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] remoteproc: zynqmp: parse TCM from device tree
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, michal.simek@amd.com, 
	ben.levinsky@amd.com, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 09:14, Tanmay Shah <tanmay.shah@amd.com> wrote:
>
>
> On 1/3/24 12:17 PM, Mathieu Poirier wrote:
> > On Fri, Dec 15, 2023 at 03:57:25PM -0800, Tanmay Shah wrote:
> > > ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information
> >
> > s/"is fixed in driver"/"was fixed in driver"
> >
> > > is available in device-tree. Parse TCM information in driver
> > > as per new bindings.
> > >
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >
> > > Changes in v8:
> > >   - parse power-domains property from device-tree and use EEMI calls
> > >     to power on/off TCM instead of using pm domains framework
> > >   - Remove checking of pm_domain_id validation to power on/off tcm
> > >   - Remove spurious change
> > >
> > > Changes in v7:
> > >   - move checking of pm_domain_id from previous patch
> > >   - fix mem_bank_data memory allocation
> > >
> > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 154 +++++++++++++++++++++++-
> > >  1 file changed, 148 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > index 4395edea9a64..36d73dcd93f0 100644
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
> > >     {0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > > @@ -878,6 +878,139 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >     return ERR_PTR(ret);
> > >  }
> > >
> > > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +   struct of_phandle_args out_args;
> > > +   int tcm_reg_per_r5, tcm_pd_idx;
> > > +   struct zynqmp_r5_core *r5_core;
> > > +   int i, j, tcm_bank_count, ret;
> > > +   struct platform_device *cpdev;
> > > +   struct mem_bank_data *tcm;
> > > +   struct device_node *np;
> > > +   struct resource *res;
> > > +   u64 abs_addr, size;
> > > +   struct device *dev;
> > > +
> > > +   for (i = 0; i < cluster->core_count; i++) {
> > > +           r5_core = cluster->r5_cores[i];
> > > +           dev = r5_core->dev;
> > > +           np = of_node_get(dev_of_node(dev));
> > > +           tcm_pd_idx = 1;
> > > +
> > > +           /* we have address cell 2 and size cell as 2 */
> > > +           tcm_reg_per_r5 = of_property_count_elems_of_size(np, "reg",
> > > +                                                            4 * sizeof(u32));
> > > +           if (tcm_reg_per_r5 <= 0) {
> > > +                   dev_err(dev, "can't get reg property err %d\n", tcm_reg_per_r5);
> > > +                   return -EINVAL;
> > > +           }
> > > +
> > > +           /*
> > > +            * In lockstep mode, r5 core 0 will use r5 core 1 TCM
> > > +            * power domains as well. so allocate twice of per core TCM
> >
> > Twice of what?  Please use proper english in your multi line comments, i.e a
> > capital letter for the first word and a dot at the end.
> >
> > > +            */
> > > +           if (cluster->mode == LOCKSTEP_MODE)
> > > +                   tcm_bank_count = tcm_reg_per_r5 * 2;
> > > +           else
> > > +                   tcm_bank_count = tcm_reg_per_r5;
> > > +
> > > +           r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +                                             sizeof(struct mem_bank_data *),
> > > +                                             GFP_KERNEL);
> > > +           if (!r5_core->tcm_banks)
> > > +                   ret = -ENOMEM;
> > > +
> > > +           r5_core->tcm_bank_count = tcm_bank_count;
> > > +           for (j = 0; j < tcm_bank_count; j++) {
> > > +                   tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> > > +                                      GFP_KERNEL);
> > > +                   if (!tcm)
> > > +                           return -ENOMEM;
> > > +
> > > +                   r5_core->tcm_banks[j] = tcm;
> > > +
> > > +                   /*
> > > +                    * In lockstep mode, get second core's TCM power domains id
> > > +                    * after first core TCM parsing is done as
> >
> > There seems to be words missing at the end of the sentence, and there is no dot.
> >
> > > +                    */
> > > +                   if (j == tcm_reg_per_r5) {
> > > +                           /* dec first core node */
> > > +                           of_node_put(np);
> > > +
> > > +                           /* get second core node */
> > > +                           np = of_get_next_child(cluster->dev->of_node, np);
> > > +
> > > +                           /*
> > > +                            * reset index of power-domains property list
> > > +                            * for second core
> > > +                            */
> > > +                           tcm_pd_idx = 1;
> > > +                   }
> > > +
> > > +                   /* get power-domains id of tcm */
> > > +                   ret = of_parse_phandle_with_args(np, "power-domains",
> > > +                                                    "#power-domain-cells",
> > > +                                                    tcm_pd_idx,
> > > +                                                    &out_args);
> > > +                   if (ret) {
> > > +                           dev_err(r5_core->dev,
> > > +                                   "failed to get tcm %d pm domain, ret %d\n",
> > > +                                   j, ret);
> > > +                           of_node_put(out_args.np);
> >
> > I'm pretty sure this isn't needed in error conditions since @out_args would not
> > have been assigned.
> >
> > > +                           return ret;
> > > +                   }
> > > +                   tcm->pm_domain_id = out_args.args[0];
> > > +                   of_node_put(out_args.np);
> > > +                   tcm_pd_idx++;
> > > +
> > > +                   /*
> > > +                    * In lockstep mode, we only need second core's power domain
> > > +                    * ids. Other information from second core isn't needed so
> > > +                    * ignore it. This forms table as zynqmp_tcm_banks_lockstep
> >
> > I don't understand the last sentence of this comment and it is missing a dot at
> > the end.  Comments should be enlightening, the ones I found in this patch are
> > sowing confusion.
> >
> > > +                    */
> > > +                   if (j >= tcm_reg_per_r5)
> > > +                           contiue;
> > > +
> >
> > This condition and the one above (j == tcm_reg_per_r5) is brittle and almost
> > guaranteed to cause maintenance problems in the future.
> >
> > I understand your will to reuse as much code as possible but this is one of the
> > rare cases where duplicating code is probably better.  Please introduce two new
> > functions, i.e zynqmp_r5_get_tcm_node_from_dt_split() and
> > zynqmp_r5_get_tcm_node_from_dt_lockstep(), and do all the necessary processing
> > based on the use case.
>
> Hi Mathieu,
>
> I tried to implement this and it still looks hacky, as in lockstep mode unnecessary TCM is being allocated just to store power-domains.
>
> Instead, I am taking another cleaner approach where, TCM is parsed in uniform way in both modes from device-tree during
>
> zynqmp_r5_core_init. However, during  "add_tcm_carveout_lockstep_mode" call, I will simply parse second core's TCM power-domains
>
> from device-tree and turn it on.
>
> I will implement this and send v9 after successful testing. I wanted to give you heads up on this approach. I hope it is fine.
>

Thanks for letting me know - now I don't have to pull out what's left
of hair on my head to figure out what is going on.

> Thanks,
> Tanmay
>
>
> >
> > Thanks,
> > Mathieu
> >
> > > +                   /* get tcm address without translation */
> > > +                   ret = of_property_read_reg(np, j, &abs_addr, &size);
> > > +                   if (ret) {
> > > +                           of_node_put(np);
> > > +                           dev_err(dev, "failed to get reg property\n");
> > > +                           return ret;
> > > +                   }
> > > +
> > > +                   /*
> > > +                    * remote processor can address only 32 bits
> > > +                    * so convert 64-bits into 32-bits. This will discard
> > > +                    * any unwanted upper 32-bits.
> > > +                    */
> > > +                   tcm->da = (u32)abs_addr;
> > > +                   tcm->size = (u32)size;
> > > +
> > > +                   cpdev = to_platform_device(dev);
> > > +                   res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > > +                   if (!res) {
> > > +                           of_node_put(np);
> > > +                           dev_err(dev, "failed to get tcm resource\n");
> > > +                           return -EINVAL;
> > > +                   }
> > > +
> > > +                   tcm->addr = (u32)res->start;
> > > +                   tcm->bank_name = (char *)res->name;
> > > +                   res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> > > +                                                 tcm->bank_name);
> > > +                   if (!res) {
> > > +                           dev_err(dev, "failed to request tcm resource\n");
> > > +                           of_node_put(np);
> > > +                           return -EINVAL;
> > > +                   }
> > > +           }
> > > +   }
> > > +
> > > +   of_node_put(np);
> > > +   return 0;
> > > +}
> > > +
> > >  /**
> > >   * zynqmp_r5_get_tcm_node()
> > >   * Ideally this function should parse tcm node and store information
> > > @@ -956,10 +1089,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > >     struct zynqmp_r5_core *r5_core;
> > >     int ret, i;
> > >
> > > -   ret = zynqmp_r5_get_tcm_node(cluster);
> > > -   if (ret < 0) {
> > > -           dev_err(dev, "can't get tcm node, err %d\n", ret);
> > > -           return ret;
> > > +   r5_core = cluster->r5_cores[0];
> > > +   if (of_find_property(r5_core->np, "reg", NULL)) {
> > > +           ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > > +           if (ret) {
> > > +                   dev_err(dev, "can't get tcm node from dt, err %d\n", ret);
> > > +                   return ret;
> > > +           }
> > > +   } else {
> > > +           ret = zynqmp_r5_get_tcm_node(cluster);
> > > +           if (ret < 0) {
> > > +                   dev_err(dev, "can't get tcm node, err %d\n", ret);
> > > +                   return ret;
> > > +           }
> > >     }
> > >
> > >     for (i = 0; i < cluster->core_count; i++) {
> > > --
> > > 2.25.1
> > >

