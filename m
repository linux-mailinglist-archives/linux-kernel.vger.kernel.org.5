Return-Path: <linux-kernel+bounces-135933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41089CD46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64BF1F211B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59B147C6D;
	Mon,  8 Apr 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFcQfoFd"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288837E8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610844; cv=none; b=qHImwKc4gt8pLwV2fzPZQBZHg0uZPm/zs38L/wGhTEa87h1QTst1Q1o0jzo1qLrXvn1emyt3CUAIGdTf88ao95TvwngI7aE0vfut3EPB2wkQu5uqtZ/5w3OnAywZWk3lr99vYCluFSyAcyNpox75IiftGT5TNcooz642tntfyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610844; c=relaxed/simple;
	bh=JVukTz5MbqkHdCQ0GujdpyPi+ERWJVOdSTb+ewBrKnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8cGgKbDPaE/o8HsFEXVhi873jk3fI8EV6qzpZtoOku3/5ez0xY2nJIcBuZNTVwhn9xsN0cH8zGzP0W7o8nwC7mV3k7TjmiIFxYAKy6vArVIvCZyrpIx/dVfsLjUR8HVqOVfKwry/wSYAS5oJ85d1Yuf5RDkhtlxmRPBNGhqptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFcQfoFd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-614ec7ee902so51366377b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712610840; x=1713215640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9H/wJYl3v6Nf1hcV5ZGzgLNZ6Hl7Vc5YVwplWIJ86fg=;
        b=xFcQfoFdgDV4AfaH9BHpzATz5eHaXaotnDjZD9NJh8onIIveDwY20PVj/Uvu5u9VHP
         Rqg38H/ygH3HRtyDkeS8hSugELwr0wMKTklz/o0IiwUSaa+TnDZhgf4Lr8tQLRZiWuAc
         AHuur5sjz9tEiShfivbM1s0itSi5AfrDpZ7DIaxdMeaE0YW32mbif5OTS0S3iGaAwLMf
         PDHXgg3k5q+KgLlZezPQPuIlVOml66AL/4FhJ2NHa4l1l28s5xzcbhXCCq5ZO2GcpPKg
         dpFuonF8TnF8s5unh9e+hzwtQ/hSoPv0ba5PnOmMdfQTqVS6LUpWJOfkITy+OE99xCFl
         Rjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610840; x=1713215640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H/wJYl3v6Nf1hcV5ZGzgLNZ6Hl7Vc5YVwplWIJ86fg=;
        b=d3hEZmKCnLtY+Vym1EW5gOcB91F+8kk4crsjAl0IUNrhXF4QJLaOtS1emhpBDuYVWj
         lzCnl8rgi1ZEeClIkxUMJkOZE8zVoEZwEEDGA750RMhkD11ayDQuMDP8tUzKoS7pysyB
         lVYFQLr0YopeZfU0yDHcr+Ff9ZZpOTe1GoUDFzkY2PdvPqS2x8DTARmcXv/yoBNaV56w
         8r6evcFa5tKIFCCJiIEY5ZMfVQLjG8fvHnUx7PBFNQ5xrgU08AlRyST+0v9gQp/HXPtA
         9saby8Yx/+bbwwnObjBhXGwByAc/Rv9jejIGA14XDRg2aE1rSZt4YwF0NGsL2W58lJSg
         d1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVIw86UW19HDi52/BSdrtymyqdzYjlVmBCjDMANG43wkB2Fuy2upPBjIXGntrRF1FIhNOiTXeNUKC6rd+esqyKUMPeUuXtttZwgRfqt
X-Gm-Message-State: AOJu0YxEdqIktiCbnUwCPMRHvB0EmG0Ccqln+rScNKdApaiGRe8Has0v
	/jvO2JpSss7whcTZpD4FzuENwrmL8dSpIyqSLs+LHqz4xCvQN8ex2O2vkEOjv6l0tHFpShj72l2
	AAdwYmmkQwjPu17Bs+CrF9QSUzJf9bPs5NkuS+Q==
X-Google-Smtp-Source: AGHT+IHXQ+bA+Y2zmisBo7GBSUwb5kuuO1IoG7nvhUH198RXgyldfz/Lvk4EBBBE3RI7gbBloKytkwb0/Oo957i0dQQ=
X-Received: by 2002:a25:5f42:0:b0:dca:59a7:896b with SMTP id
 h2-20020a255f42000000b00dca59a7896bmr7293567ybm.50.1712610839753; Mon, 08 Apr
 2024 14:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
 <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com> <k7f22hyltul4h4o4vqe6prc2yx3mm2q4dzk66j3xrsdpdtqllb@3c6ul4fpimwz>
 <b7ed299d-4cf7-8829-fd7f-e518aef05fb2@quicinc.com>
In-Reply-To: <b7ed299d-4cf7-8829-fd7f-e518aef05fb2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Apr 2024 00:13:48 +0300
Message-ID: <CAA8EJpqYWXs+KzZcrJA0zL2KNhpHQ+5xNpVNPmepztujmVJf=w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, freedreno@lists.freedesktop.org, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, swboyd@chromium.org, 
	quic_jesszhan@quicinc.com, quic_bjorande@quicinc.com, johan@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 00:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/8/2024 1:41 PM, Bjorn Andersson wrote:
> > On Mon, Apr 08, 2024 at 12:43:34PM -0700, Abhinav Kumar wrote:
> >>
> >>
> >> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
> >>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
> >>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>> [..]
> >>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> index d80f89581760..bfb6dfff27e8 100644
> >>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> >>>>                    return;
> >>>>            if (!dp_display->link_ready && status == connector_status_connected)
> >>>> -          dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> >>>> +          dp_hpd_plug_handle(dp, 0);
> >>>
> >>> If I read the code correctly, and we get an external connect event
> >>> inbetween a previous disconnect and the related disable call, this
> >>> should result in a PLUG_INT being injected into the queue still.
> >>>
> >>> Will that not cause the same problem?
> >>>
> >>> Regards,
> >>> Bjorn
> >>>
> >>
> >> Yes, your observation is correct and I had asked the same question to kuogee
> >> before taking over this change and posting.
> >>
> >> We will have to handle that case separately. I don't have a good solution
> >> yet for it without requiring further rework or we drop the below snippet.
> >>
> >>          if (state == ST_DISCONNECT_PENDING) {
> >>                  /* wait until ST_DISCONNECTED */
> >>                  dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
> >>                  mutex_unlock(&dp->event_mutex);
> >>                  return 0;
> >>          }
> >>
> >> I will need sometime to address that use-case as I need to see if we can
> >> handle that better and then drop the the DISCONNECT_PENDING state to address
> >> this fully. But it needs more testing.
> >>
> >> But, we will need this patch anyway because without this we will not be able
> >> to fix even the most regular and commonly seen case of basic
> >> connect/disconnect receiving complementary events.
> >>
> >
> > I did some more testing on this patch. Connecting and disconnecting the
> > cable while in fbcon works reliably, except for:
>
> Thanks for the tests !
>
> > - edid/modes are not read before we bring up the link so I always end up
> >    with 640x480
> >
>
> hmmm, I wonder why this should be affected due to this patch. We always
> read the EDID during hpd_connect() and the selected resolution will be
> programmed with the modeset. We will retry this with our x1e80100 and see.

BTW, why is EDID read during HPD handling? I always supposed that it
can be read much later, when the DRM framework calls the get_modes /
get_edid callbacks.

>
> > - if I run modetest -s <id>:<mode> the link is brought up with the new
> >    resolution and I get my test image on the screen.
> >    But as we're shutting down the link for the resolution chance I end up
> >    in dp_bridge_hpd_notify() with link_ready && state = disconnected.
> >    This triggers an unplug which hangs on the event_mutex, such that as
> >    soon as I get the test image, the state machine enters
> >    DISCONNECT_PENDING. This is immediately followed by another
> >    !link_ready && status = connected, which attempts to perform the plug
> >    operation, but as we're in DISCONNECT_PENDING this is posted on the
> >    event queue. From there I get a log entry from my PLUG_INT, every
> >    100ms stating that we're still in DISCONNECT_PENDING. If I exit
> >    modetest the screen goes black, and no new mode can be selected,
> >    because we're in DISCONNECT_PENDING. The only way out is to disconnect
> >    the cable to complete the DISCONNECT_PENDING.
> >
>
> I am going to run this test-case and see what we can do.
>
> > Regards,
> > Bjorn
> >
> >>
> >>>>            else if (dp_display->link_ready && status == connector_status_disconnected)
> >>>> -          dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> >>>> +          dp_hpd_unplug_handle(dp, 0);
> >>>>    }
> >>>> --
> >>>> 2.43.2
> >>>>



-- 
With best wishes
Dmitry

