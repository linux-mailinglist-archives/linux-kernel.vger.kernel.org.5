Return-Path: <linux-kernel+bounces-63615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61485324A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1BA1C22EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27D56768;
	Tue, 13 Feb 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+QO3Wiw"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472F56471
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832303; cv=none; b=gqv73GTIyErLYs8J/N360+cGrea1Z4BFJxXNplOFdzqDvSrJOIQmVCjMlI0ScPtaVTq649gZyUIGUMKPZbc9SwT8WRw7GqTCV0zbi613FmAz3ciFWx9BZzGKIiNNNevU7xX+tg1a27mN0IsSeGPyDQNasHk8apfS8kejQE0om2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832303; c=relaxed/simple;
	bh=ELPzkWSUzVULNyET4HM5ayqOigWVWyQToxUGJ8VWf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK7ii708k20w+y5VcC8RfryW8ZPOe4AKm8cWNT2uQZcfG8VFPN38HugdZXl8d8gSOlVzjB32WZbqd9/HobS2xcjioVhTbL+GkayLzNpK/xN/sF7L2CSZt+Ltr0nfU73u6fZicGsx6z093z3DMJOSpPbxQrPOI0xGIKFbsPWCTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+QO3Wiw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc742543119so3645344276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707832299; x=1708437099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQQuYoa1votx9Y7bY4V9GoK3AVgFfJazZ638lEOHEsI=;
        b=C+QO3Wiw3OebGafdGOFi6XHBfPdmGR681vwivyKakTs7o6ZHJCBMTiExEhNmuMFgin
         0QGWO/a6qortwPzsLzWxAlrUQI1VffEL3bc/PTNYV1zitOHtc4BIzdAC/mjPWSdqNRTo
         RD7utgK7iVQu/vLbijQ3iWjvz18DzluInaJtN3OrGcRNJrM0Q5mR5RIf1PGs6KP+veez
         jTbwGeckp7Aedj1dQVHWIHWwZZ8CpXeZQpRAofwnPCU+jq/AObGblgT6J1yZtMdtBN4x
         TTKGzIHidvH+rMtsumBvBz39egyYudnSbHt0M8TxU9DDoQEjRcwODCUXzsTRiX7TvXSP
         Tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832299; x=1708437099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQQuYoa1votx9Y7bY4V9GoK3AVgFfJazZ638lEOHEsI=;
        b=opCRXrbiPqswoxw6wE/AYNr+evwo70q/ZJ2sjT0o5ROoduOsDA+qUwl8W1Cq9nH85l
         Wtiz1u6MXtU0e+BeJfLgcojazAP+uKTeJdmXCBmRzlVwkKLFrc36nYeyfd/u/cr/Ggb2
         aJ0QLaGAHbAOuOMgDe7QEUPhUCWnQ03Z1tzzlqARx6qJEa8s4mXvdoIeHB7IJOvtOkmh
         AxRewhGat6bCvxgjJqG1FdWRZFq8Ee5uMRK4fuBZ7u66GznWEdZTqClOfY8yn5E0ccBM
         jYJlb8s49e740gNVhjRRxCd1iTg+KXpl4ZVULQqOKFG6Bfj1u9lA6WjBgkLXlj9ZIQH7
         Xcvg==
X-Forwarded-Encrypted: i=1; AJvYcCXIURR4aFLrIhScJORW6+b5QvzHTYovWYUZaMVATKFzJCEccSH5rPQ2Ke6LFZ9aFN3SPiUZzR+CHhaMvMGrctYCPX63H2+1lRb2/r9t
X-Gm-Message-State: AOJu0YxUaHwTDJ9JmTvEd6oh46r4El4eC613qdz/A5YBzaVbMnGNZckt
	JxTnOkPW2zYjaNKC9Jrm2Bz6G4dROJTGE4qO2Yy9hfXePCjwjBd8zWNRK1ODYxmVucRQmROsFNM
	mClsgcMVcoC7YTnwoinCxPHyQDL1F6BkQ2EoFiw==
X-Google-Smtp-Source: AGHT+IGkxAkUAhS0VW6ZT+XvBBscFNZwdj7E7NzfFhdTEULlMz7KgWfV59riYkqRihUpD3kgVPu+47sroZlgvXYVqAE=
X-Received: by 2002:a5b:d08:0:b0:dbf:487b:1fe7 with SMTP id
 y8-20020a5b0d08000000b00dbf487b1fe7mr6525699ybp.17.1707832298945; Tue, 13 Feb
 2024 05:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org> <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
 <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>
 <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
 <CAPDyKFp1vg2+-pHJ_idkdhb_zZUMpq7W17DnCCGj0eTwd4jFbQ@mail.gmail.com> <87b7967f-d8c4-426e-92ed-5a418c702481@quicinc.com>
In-Reply-To: <87b7967f-d8c4-426e-92ed-5a418c702481@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 14:51:02 +0100
Message-ID: <CAPDyKFqy0osJRTU1mL0Ew_3pnYOe5z20ZWNrew8B6t99UFO0pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 14:10, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 2/2/2024 5:59 PM, Ulf Hansson wrote:
> > On Fri, 2 Feb 2024 at 00:51, Bjorn Andersson <andersson@kernel.org> wrote:
> >>
> >> On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
> >>> On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
> >>>>
> >>>> On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> >>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>>
> >>>>> Some power-domains may be capable of relying on the HW to control the power
> >>>>> for a device that's hooked up to it. Typically, for these kinds of
> >>>>> configurations the consumer driver should be able to change the behavior of
> >>>>> power domain at runtime, control the power domain in SW mode for certain
> >>>>> configurations and handover the control to HW mode for other usecases.
> >>>>>
> >>>>> To allow a consumer driver to change the behaviour of the PM domain for its
> >>>>> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> >>>>> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> >>>>> which the genpd provider should implement if it can support switching
> >>>>> between HW controlled mode and SW controlled mode. Similarly, add the
> >>>>> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> >>>>> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> >>>>> genpd provider can also implement for reading back the mode from the
> >>>>> hardware.
> >>>>>
> >>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>> ---
> >>>>>   drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>   include/linux/pm_domain.h | 17 ++++++++++++
> >>>>>   2 files changed, 86 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >>>>> index a1f6cba3ae6c..41b6411d0ef5 100644
> >>>>> --- a/drivers/pmdomain/core.c
> >>>>> +++ b/drivers/pmdomain/core.c
> >>>>> @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> >>>>>
> >>>>> +/**
> >>>>> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
> >>>>
> >>>> This isn't proper kernel-doc
> >>>
> >>> Sorry, I didn't quite get that. What is wrong?
> >>>
> >>
> >> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> >> says that there should be () after the function name, and below there
> >> should be a Return:
> >
> > Thanks for the pointers!
> >
> >>
> >>>>
> >>>>> + *
> >>>>> + * @dev: Device for which the HW-mode should be changed.
> >>>>> + * @enable: Value to set or unset the HW-mode.
> >>>>> + *
> >>>>> + * Some PM domains can rely on HW signals to control the power for a device. To
> >>>>> + * allow a consumer driver to switch the behaviour for its device in runtime,
> >>>>> + * which may be beneficial from a latency or energy point of view, this function
> >>>>> + * may be called.
> >>>>> + *
> >>>>> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> >>>>> + * while this routine is getting called.
> >>>>> + *
> >>>>> + * Returns 0 on success and negative error values on failures.
> >>>>> + */
> >>>>> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> >>>>> +{
> >>>>> +     struct generic_pm_domain *genpd;
> >>>>> +     int ret = 0;
> >>>>> +
> >>>>> +     genpd = dev_to_genpd_safe(dev);
> >>>>> +     if (!genpd)
> >>>>> +             return -ENODEV;
> >>>>> +
> >>>>> +     if (!genpd->set_hwmode_dev)
> >>>>> +             return -EOPNOTSUPP;
> >>>>> +
> >>>>> +     genpd_lock(genpd);
> >>>>> +
> >>>>> +     if (dev_gpd_data(dev)->hw_mode == enable)
> >>>>
> >>>> Between this and the gdsc patch, the hw_mode state might not match the
> >>>> hardware state at boot.
> >>>>
> >>>> With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
> >>>> false) will not bring control to SW - which might be fatal.
> >>>
> >>> Right, good point.
> >>>
> >>> I think we have two ways to deal with this:
> >>> 1) If the provider is supporting ->get_hwmode_dev(), we can let
> >>> genpd_add_device() invoke it to synchronize the state.
> >>
> >> I'd suggest that we skip the optimization for now and just let the
> >> update hit the driver on each call.
> >
> > Okay.
> >
> >>
> >>> 2) If the provider doesn't support ->get_hwmode_dev() we need to call
> >>> ->set_hwmode_dev() to allow an initial state to be set.
> >>>
> >>> The question is then, if we need to allow ->get_hwmode_dev() to be
> >>> optional, if the ->set_hwmode_dev() is supported - or if we can
> >>> require it. What's your thoughts around this?
> >>>
> >>
> >> Iiuc this resource can be shared between multiple clients, and we're
> >> in either case returning the shared state. That would mean a client
> >> acting upon the returned value, is subject to races.
> >
> > Not sure I understand this, but I also don't have in-depth knowledge
> > of how the HW works.
> >
> > Isn't the HW mode set on a per device basis?
> >
> >>
> >> I'm therefore inclined to say that we shouldn't have a getter, other
> >> than for debugging purposes, in which case reading the HW-state or
> >> failing would be reasonable outcomes.
> >
> > If you only want this for debug purposes, it seems better to keep it
> > closer to the rpmh code, rather than adding generic callbacks to the
> > genpd interface.
> >
> > So to conclude, you think having a ->set_hwmode_dev() callback should
> > be sufficient and no caching of the current state?
> >
> > Abel, what's your thoughts around this?
> >
>
> We believe it is good to have get_hwmode_dev() callback supported from
> GenPD, since if multiple devices share a GenPD, and if one device moves
> the GenPD to HW mode, the other device won't be aware of it and second
> device's dev_gpd_data(dev)->hw_mode will still be false.
>
> If we have this dev_pm_genpd_get_hwmode() API supported and if we assign
> dev_gpd_data(dev)->hw_mode after getting the mode from get_hwmode_dev()
> callback, consumer drivers can use this API to sync the actual HW mode
> of the GenPD.

Hmm, I thought the HW mode was being set on a per device basis, via
its PM domain. Did I get that wrong?

Are you saying there could be multiple devices sharing the same PM
domain and thus also sharing the same HW mode? In that case, it sure
sounds like we have synchronization issues to deal with too.

Kind regards
Uffe

