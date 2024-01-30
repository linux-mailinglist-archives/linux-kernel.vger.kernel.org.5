Return-Path: <linux-kernel+bounces-44251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9B841F56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B0B1F21E28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6DA605D8;
	Tue, 30 Jan 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnwWbdZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FD59155
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606646; cv=none; b=Xjs4DyFz2C3Rgx/azxwUN5Id4+bASP6Non/jYKH/S1opHG+JLfBHVQXEPR8/MsyWvY9RhGpTRNq11qU6EYaSDY+CS/Z5Clt+Q++bpoueEB5TKSK1OiHJ+gaTZVY3UoGkHIYCfib5j5GnmAuHC0OP4f+jTEgPIPCQTkn6qzMnM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606646; c=relaxed/simple;
	bh=WTPD0u8lNCTsfkYlNmFQbgM3oe0GIKson6ZShvZ71kw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MX3wWGr38afQx4KY/6TVULiYdg8HS3DUeD8teNtsI+7M2tizgKrk4asQqWYEagxH3/ZfjkoPKywAMW19vplQW0DPX2kpTfcSrcmzZhWHpqkvRRNXfrde1kZCpYuRQS/xY3vFqVyVrk/2lBWOc0bD/ZQdYNQzKIrz0j2f79HPZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnwWbdZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72015C43390;
	Tue, 30 Jan 2024 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706606646;
	bh=WTPD0u8lNCTsfkYlNmFQbgM3oe0GIKson6ZShvZ71kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VnwWbdZnWEdUqlcs1nDlVIFBIRrbma+J9F81Qf9TjbfM3GTI4/Ltn0hn/bjFbbXto
	 xfMGOo3Cl7eIQQfodxaGE5D0m5gKrbhIkFJE4bxUOdjGYo2F3JN0vLAdvvmhNiziOk
	 hlqZMKDZG5lZ0AdIagtzaWNVmWEkli9NdCb4wB16Z2WW+LA0aVOuo0tjHNZAcA1dwb
	 0dE95dOy+teCDMIjKQUm5VkyBrZJ2LrFL0h1HLNQ1FAkPfYHTeIWDtlx4VrR3lVPth
	 krAJuIKYQhA3KHzwyODPPmz4a6UmwwVf9Gja8ih/Y0s94zSoc/Axg9RmQQCEee5rzC
	 ObS0JSRS9ihIA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jan 2024 10:24:00 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Dave Airlie <airlied@gmail.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Inki Dae <daeinki@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, DRI mailing list
 <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael
 Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <CABGWkvp5Xx61h+sfKotb=jsQE3jPXP0bJfTtb1k9_OCH-TzTvQ@mail.gmail.com>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org>
 <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
 <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
 <b18d88302acfca001a6693d78909bc2a@kernel.org>
 <31e1a38a1d012a32d6f7bc8372b6360e@kernel.org>
 <CABGWkvp5Xx61h+sfKotb=jsQE3jPXP0bJfTtb1k9_OCH-TzTvQ@mail.gmail.com>
Message-ID: <25f0cdf7305eac946629895179be8f2b@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Dario,

>> >> Just FYI this conflictted pretty heavily with drm-misc-next changes in
>> >> the same area, someone should check drm-tip has the correct
>> >> resolution, I'm not really sure what is definitely should be.
>> >
>> > FWIW, this looks rather messy now. The drm-tip doesn't build.
>> >
>> > There was a new call to samsung_dsim_set_stop_state() introduced
>> > in commit b2fe2292624ac (drm: bridge: samsung-dsim: enter display
>> > mode in the enable() callback).
>> 
>> I had a closer look at the latest linux-next (where somehow my patch
>> made it into) and tried to apply commit b2fe2292624ac (drm: bridge:
>> samsung-dsim: enter display mode in the enable() callback). It looks
>> like only the following hunk is still needed from that patch. 
>> Everything
>> else is covered by this fixes patch.
>> 
>> Dario, could you rebase your commit onto this patch? I had a quick 
>> test
>> with this change and it seems to work fine for our case.
>> 
>> --snip--
>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
>> b/drivers/gpu/drm/bridge/samsung-dsim.c
>> index 63a1a0c88be4..92755c90e7d2 100644
>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
>> @@ -1498,6 +1498,8 @@ static void samsung_dsim_atomic_disable(struct
>> drm_bridge *bridge,
>>          if (!(dsi->state & DSIM_STATE_ENABLED))
>>                  return;
>> 
>> +       samsung_dsim_set_display_enable(dsi, false);
>> +
>>          dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
>>   }
>> 
>> @@ -1506,8 +1508,6 @@ static void
>> samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
>>   {
>>          struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>> 
>> -       samsung_dsim_set_display_enable(dsi, false);
>> -
>>          dsi->state &= ~DSIM_STATE_ENABLED;
>>          pm_runtime_put_sync(dsi->dev);
>>   }
>> --snip--
>> 
>> -michael
> 
> I'm sorry, but I didn't understand well what I have to do.

Basically, just rebase your patch (drm: bridge: samsung-dsim:
enter display mode in the enable() callback) on top of
linux-next.

> This is what I have done:
> 
> git clone 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> cd linux-next
> # add your changes, the ones of the emails
> git am --reject 
> 0001-drm-bridge-samsung-dsim-enter-display-mode-in-the-en.patch
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 92755c90e7d2..b47929072583 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1508,6 +1508,9 @@ static void
> samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
>  {
>         struct samsung_dsim *dsi = bridge_to_dsi(bridge);
> 
> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> +               samsung_dsim_set_stop_state(dsi, true);
> +

This one should be removed. There is no stop state anymore.
With that hunk, it doesn't compile anyway.

>         dsi->state &= ~DSIM_STATE_ENABLED;
>         pm_runtime_put_sync(dsi->dev);
>  }
> 
> And then test the driver for my use case.

Yes. The hunk I've posted above, should be all what's left
of your patch, because as far as I see it, most of your changes
are already contained in my fixes patch. What's left is that
you disable the video mode in .disable() and not in
post_disable().

-michael

