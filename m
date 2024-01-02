Return-Path: <linux-kernel+bounces-14724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F5822138
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA482282E44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304F15AD3;
	Tue,  2 Jan 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EauHZchQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81815ACE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdfa676fa3so4919696a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704220902; x=1704825702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiARnTFtPVzqukdZN0RA3ZaMhVEbsu3YcZKj4/r2OWM=;
        b=EauHZchQ0zMMRkkZdcBgYGFCEznbC69X2G2LdTUDks7TsYM9yAr+tqcvqGwvVFVbhl
         BzkhUnV01k4po1ypcQk+9nrx2sSr3hpj0ytO2YwQKqlFn3jrheG7e4NvfYlcbMdEXFfi
         4VsdXlshpk1df8NsXRMvV6pkMQxDVrZhyp/BLX1+RFUamM7cOld35wJ5fBzFKf/wu9gU
         WcuALcZF5K9EjTcvXKuI/YOlmFxVRld8x4yuZa1LAMmT4RBhgPj51MRA058M2Q6dZf49
         rkJfyVYRNCJ8HyB7cWHZzN4EOHtYOViBn7VC4GOQbffZLxUPWxHfrVZRTIQZwCM6a1Qd
         5z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220902; x=1704825702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiARnTFtPVzqukdZN0RA3ZaMhVEbsu3YcZKj4/r2OWM=;
        b=m9NpH7AVp11C1mbjQ3hA2UOVbCWxPhsujYmEAi+K8TxIVVh8qlpGVLfdfvUztQ+6om
         QV4DUjTudEk5IR5EFSqG0sznM6mMy2M9MqzMAVqOZcCZke6BvvHo4h8WAh7GkfAWG+k4
         13lWk18CrUwRWqMBLxKqBRMzDRwZObuJmSh6o6Tbojk1HGa/TnCV/eb99cUAPNvQqjz6
         zlHieYBj+mUGlrF7c0lVomi6IzvKx/lXa0dpjZrxT66LGqWjkdhKxjll7nwuFCxcgctO
         6eC1zf5almGF6uUs8h3+YTURJPVNDNhZh5FLskPGxSJa7NlxsBh8BxO7Xv48+d1kPDh3
         Tw4w==
X-Gm-Message-State: AOJu0YzbEK875lkiGlduEN//HOmTCKUMIjDpSxLhk4uKpAi7l5hc+yWA
	xJKr57DDyj3T+5Anj6DZ5xCIEd0dmv2N1w==
X-Google-Smtp-Source: AGHT+IHEm6VtNk0s0JFbJROhAiFMpiK1QaSuMZvJp6MECY5QfyLekDrejEAVN4oBbY22Qy7TBjoGxw==
X-Received: by 2002:a05:6a20:7d83:b0:196:c73c:2eaf with SMTP id v3-20020a056a207d8300b00196c73c2eafmr4392439pzj.44.1704220902150;
        Tue, 02 Jan 2024 10:41:42 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:2dba:4fab:fb9:7d99])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b006d095553f2asm22388197pfb.81.2024.01.02.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:41:41 -0800 (PST)
Date: Tue, 2 Jan 2024 11:41:38 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/5] remoteproc: imx_rproc: Convert to
 dev_pm_domain_attach|detach_list()
Message-ID: <ZZRY4rMjjkIsG3Ef@p14s>
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
 <20231228114157.104822-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228114157.104822-4-ulf.hansson@linaro.org>

Hi Ulf,

I'm in agreement with the modifications done to imx_rproc.c and imx_dsp_rproc.c.
There is one thing I am ambivalent on, please see below.

On Thu, Dec 28, 2023 at 12:41:55PM +0100, Ulf Hansson wrote:
> Let's avoid the boilerplate code to manage the multiple PM domain case, by
> converting into using dev_pm_domain_attach|detach_list().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: <linux-remoteproc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/remoteproc/imx_rproc.c | 73 +++++-----------------------------
>  1 file changed, 9 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 8bb293b9f327..3161f14442bc 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -92,7 +92,6 @@ struct imx_rproc_mem {
>  
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
>  static void imx_rproc_free_mbox(struct rproc *rproc);
> -static int imx_rproc_detach_pd(struct rproc *rproc);
>  
>  struct imx_rproc {
>  	struct device			*dev;
> @@ -113,10 +112,8 @@ struct imx_rproc {
>  	u32				rproc_pt;	/* partition id */
>  	u32				rsrc_id;	/* resource id */
>  	u32				entry;		/* cpu start address */
> -	int                             num_pd;
>  	u32				core_index;
> -	struct device                   **pd_dev;
> -	struct device_link              **pd_dev_link;
> +	struct dev_pm_domain_list	*pd_list;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -853,7 +850,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
>  		return;
>  
>  	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> -		imx_rproc_detach_pd(rproc);
> +		dev_pm_domain_detach_list(priv->pd_list);
>  		return;
>  	}
>  
> @@ -880,72 +877,20 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  static int imx_rproc_attach_pd(struct imx_rproc *priv)
>  {
>  	struct device *dev = priv->dev;
> -	int ret, i;
> -
> -	/*
> -	 * If there is only one power-domain entry, the platform driver framework
> -	 * will handle it, no need handle it in this driver.
> -	 */
> -	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> -						  "#power-domain-cells");
> -	if (priv->num_pd <= 1)
> -		return 0;

In function dev_pm_domain_attach_list(), this condition is "<= 0" rather than
"<= 1".  As such the association between the device and power domain will be
done twice when there is a single power domain, i.e once by the core and once in
dev_pm_domain_attach_list().

I am assuming the runtime PM subsystem is smart enough to deal with this kind of
situation but would like a confirmation.

Thanks,
Mathieu

> -
> -	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
> -	if (!priv->pd_dev)
> -		return -ENOMEM;
> -
> -	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
> -					       GFP_KERNEL);
> -
> -	if (!priv->pd_dev_link)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < priv->num_pd; i++) {
> -		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> -		if (IS_ERR(priv->pd_dev[i])) {
> -			ret = PTR_ERR(priv->pd_dev[i]);
> -			goto detach_pd;
> -		}
> -
> -		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
> -						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> -		if (!priv->pd_dev_link[i]) {
> -			dev_pm_domain_detach(priv->pd_dev[i], false);
> -			ret = -EINVAL;
> -			goto detach_pd;
> -		}
> -	}
> -
> -	return 0;
> -
> -detach_pd:
> -	while (--i >= 0) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return ret;
> -}
> -
> -static int imx_rproc_detach_pd(struct rproc *rproc)
> -{
> -	struct imx_rproc *priv = rproc->priv;
> -	int i;
> +	int ret;
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
> +	};
>  
>  	/*
>  	 * If there is only one power-domain entry, the platform driver framework
>  	 * will handle it, no need handle it in this driver.
>  	 */
> -	if (priv->num_pd <= 1)
> +	if (dev->pm_domain)
>  		return 0;
>  
> -	for (i = 0; i < priv->num_pd; i++) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return 0;
> +	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
> -- 
> 2.34.1
> 

