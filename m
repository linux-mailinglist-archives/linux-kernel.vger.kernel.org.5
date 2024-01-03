Return-Path: <linux-kernel+bounces-15739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2A823125
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C491B21485
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B81BDC3;
	Wed,  3 Jan 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/kL4X0T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368751B297
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso577478f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704298759; x=1704903559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=selIPiTBkoS5l1OMM3i9w0HzBJej2N34COzM6/N+NXw=;
        b=R/kL4X0TuZViqbCth7s4OVAa3mr2h0jHTHDMHYgWkquq6pbl3f1nU5D3JQ450UxFLf
         xhfNez88fb2TgyA0Yr6PKPQF+t81IuNuHYT107+2pD3PLNAFHqJeS0SnMgY0ed79yExL
         lNVBT++TDjCYA3WOUlqfFcc2s7GP94jzpEV0xOJNvjGbP0a8eqYSUJQtet57oVgeNdJC
         KJ0OXHfPkFVGzn06aoPzutMMt66xGNuEY2zrehR+RgQ0xMRK9fzMSaRuYE+J1rS/QLff
         7927CNvu11Ses4Pa1/G9XVQBPBqNRT0A8yIchldWXGPxEC2cMMAUKJstUuKdtdoZXcWO
         8wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298759; x=1704903559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=selIPiTBkoS5l1OMM3i9w0HzBJej2N34COzM6/N+NXw=;
        b=gfWwYFGJ1F1UDzChcqRidzvt5MQqUWzwJbnsBzEe/JvElbkd74xM5cVs67eyAVaXQg
         CTuoy/yVff56lwxWvXYbkNf/gSn1QYRUP/2JE3Xwl/DRmR3cevYKkY0UBZblgOoEchaa
         p/l45t8jsoQIVQOgrYErm8aHMdLo0Gr7lBTKdHyzkynYHT9QDo4jAoyDYfVswTSS1fH+
         +xmIydyJeVAje/z0aQN81ir3KAormboKCA6l71EVfjvJx4EWw1+5JdfvxVc1v2Z8ZNct
         FyD28PS9IzFH71rgDLOqzefNo7AMwJOE0rGpnMEhyu8L5wYPezMO9qM6T4A7/BInej84
         MLZg==
X-Gm-Message-State: AOJu0YwUKuSl7ETkh4vHlcqWhiCzUcb+K0mWy/KIhs3U7+R4130zpcNW
	fgRB3k+3BZzQhTxsctKFLcbrDJ+ymkFliDJNpikrBDCW7XDsyA==
X-Google-Smtp-Source: AGHT+IHxc6RmbUDk8qZRRP/wXwKJQLoJEMFsPKWaRD1qnAIxQ7oGRHhKlBd9L738dgpFKgfPEWiB2CKPi4ihoQcZq9g=
X-Received: by 2002:a5d:4cc8:0:b0:336:95d2:c64a with SMTP id
 c8-20020a5d4cc8000000b0033695d2c64amr9871256wrt.130.1704298759433; Wed, 03
 Jan 2024 08:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
 <20231228114157.104822-4-ulf.hansson@linaro.org> <ZZRY4rMjjkIsG3Ef@p14s> <CAPDyKFqgw_my76dicP9wuQAmF=kF=v5wGwxEF05wTQHdSvfuCA@mail.gmail.com>
In-Reply-To: <CAPDyKFqgw_my76dicP9wuQAmF=kF=v5wGwxEF05wTQHdSvfuCA@mail.gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 3 Jan 2024 09:19:08 -0700
Message-ID: <CANLsYkzAG4EdYgQ9hNgMB3icGY_yrNwXesBnYxnBtzakrGv7zg@mail.gmail.com>
Subject: Re: [PATCH 3/5] remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 03:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 2 Jan 2024 at 19:41, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > I'm in agreement with the modifications done to imx_rproc.c and imx_dsp_rproc.c.
> > There is one thing I am ambivalent on, please see below.
> >
> > On Thu, Dec 28, 2023 at 12:41:55PM +0100, Ulf Hansson wrote:
> > > Let's avoid the boilerplate code to manage the multiple PM domain case, by
> > > converting into using dev_pm_domain_attach|detach_list().
> > >
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: <linux-remoteproc@vger.kernel.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 73 +++++-----------------------------
> > >  1 file changed, 9 insertions(+), 64 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > index 8bb293b9f327..3161f14442bc 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -92,7 +92,6 @@ struct imx_rproc_mem {
> > >
> > >  static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
> > >  static void imx_rproc_free_mbox(struct rproc *rproc);
> > > -static int imx_rproc_detach_pd(struct rproc *rproc);
> > >
> > >  struct imx_rproc {
> > >       struct device                   *dev;
> > > @@ -113,10 +112,8 @@ struct imx_rproc {
> > >       u32                             rproc_pt;       /* partition id */
> > >       u32                             rsrc_id;        /* resource id */
> > >       u32                             entry;          /* cpu start address */
> > > -     int                             num_pd;
> > >       u32                             core_index;
> > > -     struct device                   **pd_dev;
> > > -     struct device_link              **pd_dev_link;
> > > +     struct dev_pm_domain_list       *pd_list;
> > >  };
> > >
> > >  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> > > @@ -853,7 +850,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
> > >               return;
> > >
> > >       if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> > > -             imx_rproc_detach_pd(rproc);
> > > +             dev_pm_domain_detach_list(priv->pd_list);
> > >               return;
> > >       }
> > >
> > > @@ -880,72 +877,20 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> > >  static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > >  {
> > >       struct device *dev = priv->dev;
> > > -     int ret, i;
> > > -
> > > -     /*
> > > -      * If there is only one power-domain entry, the platform driver framework
> > > -      * will handle it, no need handle it in this driver.
> > > -      */
> > > -     priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> > > -                                               "#power-domain-cells");
> > > -     if (priv->num_pd <= 1)
> > > -             return 0;
> >
> > In function dev_pm_domain_attach_list(), this condition is "<= 0" rather than
> > "<= 1".  As such the association between the device and power domain will be
> > done twice when there is a single power domain, i.e once by the core and once in
> > dev_pm_domain_attach_list().
> >
> > I am assuming the runtime PM subsystem is smart enough to deal with this kind of
> > situation but would like a confirmation.
>
> Thanks for reviewing!
>
> To cover the the single PM domain case, imx_rproc_attach_pd() is
> returning 0 when dev->pm_domain has been assigned. Moreover,
> dev_pm_domain_attach_list() doesn't allow attaching in the single PM
> domain case, as it returns -EEXIST if "dev->pm_domain" is already
> assigned.
>
> Did that make sense to you?
>

Ah yes!  The correlation between dev->pm_domain and the magic done by
the core framework was lost on me.

Once you respin to address Nikunj's comment I will ask the NXP team in
Romania to test this set.  With the holiday season still floating in
the air it may take a little while for them to get to it.

> [...]
>
> Kind regards
> Uffe

