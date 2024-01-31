Return-Path: <linux-kernel+bounces-46404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA197843F39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB126B275E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4101E522;
	Wed, 31 Jan 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aF2KQPn2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B78676
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703160; cv=none; b=DzJ58tOGLegvuE4AOS27JBLXSAXIK3f46M+24g28bVKG+rsvCPzv2OeyLJ73ZIrkwFjHSDKl0fcrNcSujkKlsku70b4ff5EsbngOHJqhONU2SuqpfscqWntq+d92SrkWSJWbjpWuZJTHgNtZgVfwVGmgUAKbchCj99FR6p+TrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703160; c=relaxed/simple;
	bh=/wVA/4AFAw4JgOYNgYRJpbRJX3HBAQ0JInxifG3k/Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT0D3UpQBWC8iSDS5nlK4ZIm20INvD75uhNiS6Gz72ClJR7v7hcwnzIiCeWzHrBax+tERQ05nXStrih5wrfMXZihXdUwKOe1M8eSCImThOaVuqsFCKEY6UVbCEjw4GfHZWYJMG95gTlzReZG3GzuE9L3cyRRkU3G9KUMX+FYMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aF2KQPn2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-602c714bdbeso7028987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706703156; x=1707307956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=saoJoK9zStSfMj3STxg2WdyLizENiKtg2wNhGKTv28w=;
        b=aF2KQPn2T7Z+qBYWgxZRVcdF8BwDapLvSGAjGUQZkETdjabKy67dop89KfZ0y4Me2T
         up7l1HlMyL+/ucZ4GJEmrLkn8PyeU78/Sl0K092XVz7VhmEKts7tmyv40RZE7idTgFqI
         pWdqz7EQeBNEHUXvS3T/+fwxeyHn0PXutFYu6zIXdXBgL6X4vwWwQTjTpj4UdMkMROGJ
         mrdcfZaAGVMUcDo1rcOSG9vXQcEWeFcXvNIxEphvqVTtcJAXvwkW//beAgiTS7hIrIDJ
         g9/y96JGGe5Tw0iycfFlLcRnd3qtXyawucs1H2zH4/ZEXYuw+OWd8Q/lx2FjB0H0vYuo
         PFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706703156; x=1707307956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saoJoK9zStSfMj3STxg2WdyLizENiKtg2wNhGKTv28w=;
        b=Qz/320A5pqcN8MGGySo58MTLKNY7yX+b/oa0ZoSJfmA2PEBE5aKOcaV1U/tJV9PG1W
         aZFk88GduLiWSN+O2f6iNN48A9mU9+kPS1JcJEwapVuTr8V5y+NegpKDVnPPmLcANpPH
         TDSie+0vAOHPtZzfktxvxGVGeW9lIoc+RwGi71LhDg8W/BSZhA+X2hzxyg9WiCMAJ/E5
         XWxxGEZCRPVeE4nxn2UCUAfWojKooKsGmyEHnmM938NGeDheveBwJiQdGacsWi1lKNld
         Hg5Svyb4gtw9WP02bTpdydmW7ypT3HspPuEUB/9jBhTpE7xiLLy5Y2/WblpHoBBDr0MD
         wEtQ==
X-Gm-Message-State: AOJu0Yy+lyA4a54avn/L/Ji7t0tzIw7elweU1UO87HMOWhEXFjoWYeyc
	Woc9Gqzo2uNPZW0ZSXA2Efq6ZUt0FkQBAmq91v7+e6RaNgLPgihwz07WVHBYXfP6h4ET787Myhd
	m1ZYITtoTiVKlPyC1HHUfHnwfvEt1YRQTAcYMrA==
X-Google-Smtp-Source: AGHT+IHyahz3e4s2n42YdMrUWKGK11tElif28yCW0pIcplk+tuCLctSvZ9MyE7xh0xkmoOSg5CSw+arOO7LUGqKd/7A=
X-Received: by 2002:a81:a0c3:0:b0:604:fd3:e656 with SMTP id
 x186-20020a81a0c3000000b006040fd3e656mr453925ywg.19.1706703156500; Wed, 31
 Jan 2024 04:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org> <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
In-Reply-To: <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jan 2024 13:12:00 +0100
Message-ID: <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Some power-domains may be capable of relying on the HW to control the power
> > for a device that's hooked up to it. Typically, for these kinds of
> > configurations the consumer driver should be able to change the behavior of
> > power domain at runtime, control the power domain in SW mode for certain
> > configurations and handover the control to HW mode for other usecases.
> >
> > To allow a consumer driver to change the behaviour of the PM domain for its
> > device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> > let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> > which the genpd provider should implement if it can support switching
> > between HW controlled mode and SW controlled mode. Similarly, add the
> > dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> > its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> > genpd provider can also implement for reading back the mode from the
> > hardware.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h | 17 ++++++++++++
> >  2 files changed, 86 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index a1f6cba3ae6c..41b6411d0ef5 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> >
> > +/**
> > + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
>
> This isn't proper kernel-doc

Sorry, I didn't quite get that. What is wrong?

>
> > + *
> > + * @dev: Device for which the HW-mode should be changed.
> > + * @enable: Value to set or unset the HW-mode.
> > + *
> > + * Some PM domains can rely on HW signals to control the power for a device. To
> > + * allow a consumer driver to switch the behaviour for its device in runtime,
> > + * which may be beneficial from a latency or energy point of view, this function
> > + * may be called.
> > + *
> > + * It is assumed that the users guarantee that the genpd wouldn't be detached
> > + * while this routine is getting called.
> > + *
> > + * Returns 0 on success and negative error values on failures.
> > + */
> > +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> > +{
> > +     struct generic_pm_domain *genpd;
> > +     int ret = 0;
> > +
> > +     genpd = dev_to_genpd_safe(dev);
> > +     if (!genpd)
> > +             return -ENODEV;
> > +
> > +     if (!genpd->set_hwmode_dev)
> > +             return -EOPNOTSUPP;
> > +
> > +     genpd_lock(genpd);
> > +
> > +     if (dev_gpd_data(dev)->hw_mode == enable)
>
> Between this and the gdsc patch, the hw_mode state might not match the
> hardware state at boot.
>
> With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
> false) will not bring control to SW - which might be fatal.

Right, good point.

I think we have two ways to deal with this:
1) If the provider is supporting ->get_hwmode_dev(), we can let
genpd_add_device() invoke it to synchronize the state.
2) If the provider doesn't support ->get_hwmode_dev() we need to call
->set_hwmode_dev() to allow an initial state to be set.

The question is then, if we need to allow ->get_hwmode_dev() to be
optional, if the ->set_hwmode_dev() is supported - or if we can
require it. What's your thoughts around this?

Kind regards
Uffe

