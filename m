Return-Path: <linux-kernel+bounces-15538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F2822D85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF47F2830BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7F1945E;
	Wed,  3 Jan 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVj0QktV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228E19444
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso6439700276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704286230; x=1704891030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMQJge1OFocSBVvJxeeoeFzhMb6jVyBHP21ntl+sV/E=;
        b=ZVj0QktVZfoenLqVk7AA3TlGU3MUq4uZYDZ12GObE9QSpQ0vYncX+HXpYWgYzgDiQj
         eb7iUM2VEWVrjvsWAFONkTNjdqmePh9wCIS+q6949O0muCxyKlRhKIVQp04Z6Fv/qkQX
         DU6w4GKyPMkHFkBPwUe5AeEpK+sHMd8OQTirUnJ/1h7Fgwp/9hvP6LQzKbpxABZVydom
         rf2TivldeVBM9HFmOcDOvp72DR6ZxnPXg6z6UjrbtTMpdTygnPAb1VThqe59lzXdlwZu
         w7r7NZEyUZ/zndSYwMUVMkrKMe3N6dwMsbZ9v2nkhiD8uAp63fQ1ZgoY24dcO7I5JYFB
         9moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286230; x=1704891030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMQJge1OFocSBVvJxeeoeFzhMb6jVyBHP21ntl+sV/E=;
        b=ASdCUbiy0J3A1LqSO0Two8hICFzdB2dcaCi1+fhsx/iWsYHC/Hts7jsdpXmI59NhNE
         GM5pT3hZPbu3J6HDUBup8T228NeLrWZDDwFnYFTgxwRvpC0AFOqERf/Kkh4sovuo18x1
         rLxgzrMeVWRVBC1qzqqy3yomwOD2NxIrxHQD3A5kJ1KH52zVD5TQ0+ItgFd0Rq1Kt2OV
         HBfV6p1f9ifTA2fAyZhTgCz5qYtmxmLNGTRjXxM2HoxGD6ZBFZ8DIQOSjoMRvC2rkgly
         Ty+zgGxKZYN76d4CI9Hr9gMokj1lQIkpnx0gwT+A8KXGw6PSxG1P3Xj19zoZQJSQIylL
         SBjg==
X-Gm-Message-State: AOJu0Yxrd46K35n/Q/P2DqVaJlBfQaaMvkbE6979bK2FmWxY1saexslI
	Oy0/tEbUJ0VDqW/UeqiH1nh50HhvEN/7uvvPakFkZEo/vEsmBg==
X-Google-Smtp-Source: AGHT+IEli+i1LhMaNCig5qS+FtDFjWedP/VNkzC6jzMcC0RM0qSY5aMRs5tMe1+MaZQwo/pUvmcXTIs/GQCNBQrScXc=
X-Received: by 2002:a25:840c:0:b0:db7:dacf:3fb2 with SMTP id
 u12-20020a25840c000000b00db7dacf3fb2mr8131789ybk.95.1704286229718; Wed, 03
 Jan 2024 04:50:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
 <20231228114157.104822-2-ulf.hansson@linaro.org> <22330d85-1d5c-48de-b006-9176f275328e@quicinc.com>
In-Reply-To: <22330d85-1d5c-48de-b006-9176f275328e@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 13:49:53 +0100
Message-ID: <CAPDyKFqcB_ANOBsJBitjdgdUs2G8B3qWWvD54Bmw56ZoUKNWAg@mail.gmail.com>
Subject: Re: [PATCH 1/5] PM: domains: Add helper functions to attach/detach
 multiple PM domains
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 21:21, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>
>
> On 12/28/2023 3:41 AM, Ulf Hansson wrote:
> > Attaching/detaching of a device to multiple PM domains has started to
> > become a common operation for many drivers, typically during ->probe() and
> > ->remove(). In most cases, this has lead to lots of boilerplate code in the
> > drivers.
> >
> > To fixup up the situation, let's introduce a pair of helper functions,
> > dev_pm_domain_attach|detach_list(), that driver can use instead of the
> > open-coding. Note that, it seems reasonable to limit the support for these
> > helpers to DT based platforms, at it's the only valid use case for now.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   drivers/base/power/common.c | 133 ++++++++++++++++++++++++++++++++++++
> >   include/linux/pm_domain.h   |  38 +++++++++++
> >   2 files changed, 171 insertions(+)
> >
> > diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> > index 44ec20918a4d..1ef51889fc6f 100644
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -167,6 +167,114 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
> >
> > +/**
> > + * dev_pm_domain_attach_list - Associate a device with its PM domains.
> > + * @dev: The device used to lookup the PM domains for.
> > + * @data: The data used for attaching to the PM domains.
> > + * @list: An out-parameter with an allocated list of attached PM domains.
> > + *
> > + * This function helps to attach a device to its multiple PM domains. The
> > + * caller, which is typically a driver's probe function, may provide a list of
> > + * names for the PM domains that we should try to attach the device to, but it
> > + * may also provide an empty list, in case the attach should be done for all of
> > + * the available PM domains.
> > + *
> > + * Callers must ensure proper synchronization of this function with power
> > + * management callbacks.
> > + *
> > + * Returns the number of attached PM domains or a negative error code in case of
> > + * a failure. Note that, to detach the list of PM domains, the driver shall call
> > + * dev_pm_domain_detach_list(), typically during the remove phase.
> > + */
> > +int dev_pm_domain_attach_list(struct device *dev,
> > +                           const struct dev_pm_domain_attach_data *data,
> > +                           struct dev_pm_domain_list **list)
> > +{
> > +     struct device_node *np = dev->of_node;
> > +     struct dev_pm_domain_list *pds;
> > +     struct device *pd_dev = NULL;
> > +     int ret, i, num_pds = 0;
> > +     bool by_id = true;
> > +     u32 link_flags = data && data->pd_flags & PD_FLAG_NO_DEV_LINK ? 0 :
> > +                     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
> > +
> > +     if (dev->pm_domain)
> > +             return -EEXIST;
> > +
> > +     /* For now this is limited to OF based platforms. */
> > +     if (!np)
> > +             return 0;
> > +
> > +     if (data && data->pd_names) {
> > +             num_pds = data->num_pd_names;
> > +             by_id = false;
> > +     } else {
> > +             num_pds = of_count_phandle_with_args(np, "power-domains",
> > +                                                  "#power-domain-cells");
> > +     }
> > +
> > +     if (num_pds <= 0)
> > +             return 0;
> > +
> > +     pds = devm_kzalloc(dev, sizeof(*pds), GFP_KERNEL);
> > +     if (!pds)
> > +             return -ENOMEM;
> > +
> > +     pds->pd_devs = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_devs),
> > +                                 GFP_KERNEL);
> > +     if (!pds->pd_devs)
> > +             return -ENOMEM;
> > +
> > +     pds->pd_links = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_links),
> > +                                  GFP_KERNEL);
> > +     if (!pds->pd_links)
> > +             return -ENOMEM;
> > +
> > +     if (link_flags && data->pd_flags & PD_FLAG_DEV_LINK_ON)
>
> Since data is optional, this check results in crash if data is NULL. Thanks

Thanks for spotting this! I certainly tested that option too, but must
have been on some earlier internal version. :-)

I will iterate the series tomorrow to fix this up.

[...]

Kind regards
Uffe

