Return-Path: <linux-kernel+bounces-85219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D99686B26E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DB51F256D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EC73512;
	Wed, 28 Feb 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOICBDu7"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54615B0FD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132030; cv=none; b=dOTNLFV1oz/kUwAo8qEG8zUKaY8oOEkVd0URSsyKrmG7Gdw5Yqm4X7EFHNYJrQ6aP7p0obEnvp6lJmI0mJUZCvKaa/d7p23EN6mEMR9CAIpFlzdqXYgC2fsD2chcw4F5wjPApIhM3YY1ffzvStC6G5RwaD+XfIG7pC69y/h6xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132030; c=relaxed/simple;
	bh=VsrbUGK17Ci0tnA5N7vFsUSQp0s6KarH1ZuZjC1ncic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojwqkZZdBYCaJOtmRK3qhj0j/5FTpVGvVJ/MQjFHZ5L5TZIrRrVrr01srYR1Hi5zx6fcVuf1rG6Yf2vt9Pd5VVBm0PwPV89GCJ68OwLRrgxLhQt3sZMk4v726GUbuXhVQYP2TbNldP9iKWlkNqoUdu0KfdD8azh1g+oWHzyDL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jOICBDu7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso5594273276.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709132026; x=1709736826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eFR/zqUWzZXHDTWl2zVhS4GmYSCxI5mFobosqFYeN0=;
        b=jOICBDu71kT0kD6GOoGi8172fGYDdHbQmJm+NXJFpscYYc8wpNffQuEivEzUfe6Kj0
         F/xoxTSikEi8I7M+NNK5/tQKiVMkTYBmryd+dr5KYXQ2B+OzZrU3drwsggKj+NCaq30L
         fI5b52mIsYc8xllXyyy1EuZQPCUa3s44EXV6or+HEn8fhCmlpdQaab8UvFV05l2IBshZ
         MRzgaRkW/KbuG54I+zXEvyNa/rZaPXG2ALXPHiK1oayMg724+k7rwusYS4i5xwJlMHht
         jo+RfSzGVychX5OF8zronyrMR4OYbAxvu6QbfD+6GVFbl0N8YTzaI4VPiUhqogx1X+P+
         2jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132026; x=1709736826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eFR/zqUWzZXHDTWl2zVhS4GmYSCxI5mFobosqFYeN0=;
        b=iurFF6nRnARVCw9YpAdVlxbkHekI259qbRH4FJaduPiIJ0tlshmZE50Qhk2E+fvzEQ
         P2BeVykYYVuKI5XAJzxsZx+wbKN8VYtNhGgSG7aAszIK2VqIq8ZHS3Zsj7/TVl4wjaOg
         0lQnerRCY6uiSW9B5Ht35Q23InLUlYoDjxuTatswW9D+vnkteYRkV0IA638/On6IQFhl
         OEntH0tSe/001q1rN/niOkX1L7kkvBcm6hHiKRb/rX43KvD8X5g8TAga/JW0WHym+VJW
         GSf/Tq6YpLNqg0KK/VcP+Q2juusTBdfm1gz6DGTxvwJ4adre97jDUAVvtWS95fW/nDV2
         30uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7QFjwcm2WenIjrGXGmm14O0u3puHUkB+wbARlWwH4KKf5uBff682m2zaowhGf52iiqwJ7gLhgB+VxKYtw8H7ZFsW6aBKYwZvDzryo
X-Gm-Message-State: AOJu0YxbbPazQIIZIayugdUsek4SxgYC9U6VbhfffE7b+XC+1O5l1ywn
	/WoG36JcACgZGZfDYWgCchxy/52UeyQRc6mexHB+5gfnWuvir0l1+uSFYRW3D3ZVCOV5XIdS3Mz
	y964eHoSCjPw+2KazEoKYJxxvasfc+ZBAguSYcA==
X-Google-Smtp-Source: AGHT+IEZIfsWKHVHChJ1k7m1/WQgYA6iimovK/wdTzNHxMV/YVZ7sw9Wn6I6cbin+7sVaM+UANGnL8OM9PYZwhjisI4=
X-Received: by 2002:a25:6887:0:b0:dc7:43aa:5c0b with SMTP id
 d129-20020a256887000000b00dc743aa5c0bmr2636221ybc.21.1709132026315; Wed, 28
 Feb 2024 06:53:46 -0800 (PST)
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
 <CAPDyKFp1vg2+-pHJ_idkdhb_zZUMpq7W17DnCCGj0eTwd4jFbQ@mail.gmail.com>
 <87b7967f-d8c4-426e-92ed-5a418c702481@quicinc.com> <CAPDyKFqy0osJRTU1mL0Ew_3pnYOe5z20ZWNrew8B6t99UFO0pg@mail.gmail.com>
 <a1c2641f-80c0-4e6e-9c44-ef7209da97a5@quicinc.com> <CAPDyKFrg_otBETwM9hTOvxkdCPadDYdaxguS5RVJh4wL9NCovA@mail.gmail.com>
 <eb758a6c-a3e0-4ee9-bff4-4b62e5530d09@quicinc.com>
In-Reply-To: <eb758a6c-a3e0-4ee9-bff4-4b62e5530d09@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 15:53:10 +0100
Message-ID: <CAPDyKFopSyH05oavacniXTesYkeC7wAGd5EKs0p4mNn2QDPm8Q@mail.gmail.com>
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

On Fri, 16 Feb 2024 at 09:01, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 2/15/2024 9:57 PM, Ulf Hansson wrote:
> > On Wed, 14 Feb 2024 at 05:29, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/13/2024 7:21 PM, Ulf Hansson wrote:
> >>> On Tue, 13 Feb 2024 at 14:10, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2/2/2024 5:59 PM, Ulf Hansson wrote:
> >>>>> On Fri, 2 Feb 2024 at 00:51, Bjorn Andersson <andersson@kernel.org> wrote:
> >>>>>>
> >>>>>> On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
> >>>>>>> On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> >>>>>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>>>>>>
> >>>>>>>>> Some power-domains may be capable of relying on the HW to control the power
> >>>>>>>>> for a device that's hooked up to it. Typically, for these kinds of
> >>>>>>>>> configurations the consumer driver should be able to change the behavior of
> >>>>>>>>> power domain at runtime, control the power domain in SW mode for certain
> >>>>>>>>> configurations and handover the control to HW mode for other usecases.
> >>>>>>>>>
> >>>>>>>>> To allow a consumer driver to change the behaviour of the PM domain for its
> >>>>>>>>> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> >>>>>>>>> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> >>>>>>>>> which the genpd provider should implement if it can support switching
> >>>>>>>>> between HW controlled mode and SW controlled mode. Similarly, add the
> >>>>>>>>> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> >>>>>>>>> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> >>>>>>>>> genpd provider can also implement for reading back the mode from the
> >>>>>>>>> hardware.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>>> ---
> >>>>>>>>>     drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>>>     include/linux/pm_domain.h | 17 ++++++++++++
> >>>>>>>>>     2 files changed, 86 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >>>>>>>>> index a1f6cba3ae6c..41b6411d0ef5 100644
> >>>>>>>>> --- a/drivers/pmdomain/core.c
> >>>>>>>>> +++ b/drivers/pmdomain/core.c
> >>>>>>>>> @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
> >>>>>>>>>     }
> >>>>>>>>>     EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> >>>>>>>>>
> >>>>>>>>> +/**
> >>>>>>>>> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
> >>>>>>>>
> >>>>>>>> This isn't proper kernel-doc
> >>>>>>>
> >>>>>>> Sorry, I didn't quite get that. What is wrong?
> >>>>>>>
> >>>>>>
> >>>>>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> >>>>>> says that there should be () after the function name, and below there
> >>>>>> should be a Return:
> >>>>>
> >>>>> Thanks for the pointers!
> >>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>>> + *
> >>>>>>>>> + * @dev: Device for which the HW-mode should be changed.
> >>>>>>>>> + * @enable: Value to set or unset the HW-mode.
> >>>>>>>>> + *
> >>>>>>>>> + * Some PM domains can rely on HW signals to control the power for a device. To
> >>>>>>>>> + * allow a consumer driver to switch the behaviour for its device in runtime,
> >>>>>>>>> + * which may be beneficial from a latency or energy point of view, this function
> >>>>>>>>> + * may be called.
> >>>>>>>>> + *
> >>>>>>>>> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> >>>>>>>>> + * while this routine is getting called.
> >>>>>>>>> + *
> >>>>>>>>> + * Returns 0 on success and negative error values on failures.
> >>>>>>>>> + */
> >>>>>>>>> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> >>>>>>>>> +{
> >>>>>>>>> +     struct generic_pm_domain *genpd;
> >>>>>>>>> +     int ret = 0;
> >>>>>>>>> +
> >>>>>>>>> +     genpd = dev_to_genpd_safe(dev);
> >>>>>>>>> +     if (!genpd)
> >>>>>>>>> +             return -ENODEV;
> >>>>>>>>> +
> >>>>>>>>> +     if (!genpd->set_hwmode_dev)
> >>>>>>>>> +             return -EOPNOTSUPP;
> >>>>>>>>> +
> >>>>>>>>> +     genpd_lock(genpd);
> >>>>>>>>> +
> >>>>>>>>> +     if (dev_gpd_data(dev)->hw_mode == enable)
> >>>>>>>>
> >>>>>>>> Between this and the gdsc patch, the hw_mode state might not match the
> >>>>>>>> hardware state at boot.
> >>>>>>>>
> >>>>>>>> With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
> >>>>>>>> false) will not bring control to SW - which might be fatal.
> >>>>>>>
> >>>>>>> Right, good point.
> >>>>>>>
> >>>>>>> I think we have two ways to deal with this:
> >>>>>>> 1) If the provider is supporting ->get_hwmode_dev(), we can let
> >>>>>>> genpd_add_device() invoke it to synchronize the state.
> >>>>>>
> >>>>>> I'd suggest that we skip the optimization for now and just let the
> >>>>>> update hit the driver on each call.
> >>>>>
> >>>>> Okay.
> >>>>>
> >>>>>>
> >>>>>>> 2) If the provider doesn't support ->get_hwmode_dev() we need to call
> >>>>>>> ->set_hwmode_dev() to allow an initial state to be set.
> >>>>>>>
> >>>>>>> The question is then, if we need to allow ->get_hwmode_dev() to be
> >>>>>>> optional, if the ->set_hwmode_dev() is supported - or if we can
> >>>>>>> require it. What's your thoughts around this?
> >>>>>>>
> >>>>>>
> >>>>>> Iiuc this resource can be shared between multiple clients, and we're
> >>>>>> in either case returning the shared state. That would mean a client
> >>>>>> acting upon the returned value, is subject to races.
> >>>>>
> >>>>> Not sure I understand this, but I also don't have in-depth knowledge
> >>>>> of how the HW works.
> >>>>>
> >>>>> Isn't the HW mode set on a per device basis?
> >>>>>
> >>>>>>
> >>>>>> I'm therefore inclined to say that we shouldn't have a getter, other
> >>>>>> than for debugging purposes, in which case reading the HW-state or
> >>>>>> failing would be reasonable outcomes.
> >>>>>
> >>>>> If you only want this for debug purposes, it seems better to keep it
> >>>>> closer to the rpmh code, rather than adding generic callbacks to the
> >>>>> genpd interface.
> >>>>>
> >>>>> So to conclude, you think having a ->set_hwmode_dev() callback should
> >>>>> be sufficient and no caching of the current state?
> >>>>>
> >>>>> Abel, what's your thoughts around this?
> >>>>>
> >>>>
> >>>> We believe it is good to have get_hwmode_dev() callback supported from
> >>>> GenPD, since if multiple devices share a GenPD, and if one device moves
> >>>> the GenPD to HW mode, the other device won't be aware of it and second
> >>>> device's dev_gpd_data(dev)->hw_mode will still be false.
> >>>>
> >>>> If we have this dev_pm_genpd_get_hwmode() API supported and if we assign
> >>>> dev_gpd_data(dev)->hw_mode after getting the mode from get_hwmode_dev()
> >>>> callback, consumer drivers can use this API to sync the actual HW mode
> >>>> of the GenPD.
> >>>
> >>> Hmm, I thought the HW mode was being set on a per device basis, via
> >>> its PM domain. Did I get that wrong?
> >>>
> >>> Are you saying there could be multiple devices sharing the same PM
> >>> domain and thus also sharing the same HW mode? In that case, it sure
> >>> sounds like we have synchronization issues to deal with too.
> >>>
> >>
> >> Sorry my bad, currently we don't have usecase where multiple devices
> >> sharing the same PM domain that have HW control support, so there is no
> >> synchronization issue.
> >
> > Okay, good!
> >
> >>
> >> But it would be good to have .get_hwmode_dev() callback for consumer
> >> drivers to query the actual GenPD mode from HW, whenever they require it.
> >
> > Okay, no objection from my side.
> >
> > Then the final question is if we need a variable to keep a cache of
> > the current HW mode for each device. Perhaps we should start simple
> > and just always invoke the callbacks from genpd, what do you think?
> >
>
> Yes, agree, we can remove the variable and just always invoke the
> callbacks from genpd. But we may need the variable to reflect GenPD
> mode in debugfs genpd_summary, or need to invoke get callback there as
> well to get the current mode.

Hmm, after some more thinking I believe it may be best to keep the
variable after all. For reasons you point out above.

However, we need a way to synchronize the initial HW mode state for a
device. Therefore I suggest we invoke the ->get_hwmode_dev() callback
from genpd_add_device() and store its return value in the variable.
Later the variable can be used for debugfs and returned from
dev_pm_genpd_get_hwmode() too.

That should work, right?

Kind regards
Uffe

