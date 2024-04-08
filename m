Return-Path: <linux-kernel+bounces-135965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4489CE4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310541C218B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3730149C49;
	Mon,  8 Apr 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGPHDWt/"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB2148854
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614162; cv=none; b=b4N7HIxdcsa1A5N5UNzFA2Z0hHCA9BX3YnDz4x8A8RrZrEikbD6wqxxU1Yz7H4KWVsWJok2EUz6dTMBCmCw8pYtXMCA7vwMS4VKLTyra2fmLEdFBPnNcJoEOIN+K0MpkcaKS+AhT7J4fIVed1R2/0Ba5Mt0WVZuSsp5jazAO2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614162; c=relaxed/simple;
	bh=inmxLRpK34nOcQTWRA3QFZKYcCmbqo4XyyHPheF28sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K73SMqca8Ctkb+lCfLIYHGtJ91LsAcwDCxuBSUPjUm4y+Mq6khBKkJgWavkUFdKNao5PFk6gZrE4WS256KJP7Tpyfcm+cBq7eLufQkCMeFUvozudhxsHqHBZ2rWvhYxCY8Pdoosa0zD2V90YU6paYnqsnymGac4j8xIjxqrAmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGPHDWt/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6151d79db7bso57179817b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712614160; x=1713218960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VCBp/0IT3jpVEswtjWNK+e5ZOhS7JJVdmnMRHam+WQ=;
        b=uGPHDWt/4I0mPhT6oAYyTncGrtxr81ANAIslIERGdCiTe+MshMjYUCoaK+yW1o2VbW
         fdYSJOZCwuXbNi2kcHe92pGoSnZx3jcmr3ExIjA3NO/h0f16WRa46WRMHF2Y4og0bQp8
         MqhKR4ZxW9/4g5R7OlB+iZ0Y/0x42wvpyP9fMsPi6BE0H4u8Ai+cnGBx+c+R9izErYsm
         csspHiNZRdVB9wcurobM9XOb3g3mxqrZyjaZMN1d2Ti28C1kllyV6HSFcrkB7CK3N3wL
         zaB6ZdeSJk8WOW/NjzPVIC/6Qcjgw5xDOFUt/wqZn5yWBmMLRquds9vitSMVMl9plYL6
         JGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712614160; x=1713218960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VCBp/0IT3jpVEswtjWNK+e5ZOhS7JJVdmnMRHam+WQ=;
        b=t3F5XM7foPHgK3G4pHmricAIxF0IfNnYSZkLKFRsGVnV205dJXG/mWoaDJuPxR4r0F
         Ha5d6P3+nrAI798NeJ7j9fUHUjHVG8ZdlrPt6f8UYbd4/mKwcYTD3Dl6Bc7Py1mcf36f
         vuO3hyUbSjhHlcLlFfxCI1YiPZSpinQdgofWvXdQVCn/Xt4ZNL9TYHohiLwD8owYkWuD
         4hd6Vu+aPcQFIbgl4aoSaaRQXp5RREQa4tbdvEDEezQxf7SaWiHFI0DvidLSz3zjoQ9d
         t/KE1Ewuh6zzvOA5SXAU4hpC/5fgg+zjLPxkEuab2LyFPynHrdyUb1flZArcepr+THGP
         BJBA==
X-Forwarded-Encrypted: i=1; AJvYcCX6a7LL3QyHv2zgQRWIIaxpfxnLWJyViQz7+zsSZC2IUjbFTBjwZgDcIEYPHsv1SFPham2vOkFY3tpKZj+eqliPVPb8hElpC+ezao47
X-Gm-Message-State: AOJu0YzuDBgPiu6LYyxqVJZ2zGIl961WAWWhk8kB7kdgniD2EPH+HYbW
	nof/PiU1ZH56Y1WgnVC8tM1mst81RaHSH0+kisu7CWCsK0V7baBbfMaS/R6Xgx64t2RLlVsskfj
	EsfDYDzs33c87xeuZvBYEcs1K8YrHjHOkivYpdA==
X-Google-Smtp-Source: AGHT+IF37BOaV6VJ6j9BQQ4oZ93fuRAAJqf4ze80Vmy8wpcnL6+gzsfqT9wn4U4sN1xkiJb0FYo6F0zwOhyHcyl1thU=
X-Received: by 2002:a25:2d19:0:b0:dcc:a5dc:e9d6 with SMTP id
 t25-20020a252d19000000b00dcca5dce9d6mr9254293ybt.30.1712614159952; Mon, 08
 Apr 2024 15:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
 <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com> <k7f22hyltul4h4o4vqe6prc2yx3mm2q4dzk66j3xrsdpdtqllb@3c6ul4fpimwz>
 <b7ed299d-4cf7-8829-fd7f-e518aef05fb2@quicinc.com> <CAA8EJpqYWXs+KzZcrJA0zL2KNhpHQ+5xNpVNPmepztujmVJf=w@mail.gmail.com>
 <d2442e2d-80fc-c580-3452-57fab0dabf3f@quicinc.com>
In-Reply-To: <d2442e2d-80fc-c580-3452-57fab0dabf3f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Apr 2024 01:09:09 +0300
Message-ID: <CAA8EJppw0jkkHKNucgOg56OD_eH2Afx875m0oRBCtj=EOSJr4g@mail.gmail.com>
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

On Tue, 9 Apr 2024 at 00:17, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/8/2024 2:13 PM, Dmitry Baryshkov wrote:
> > On Tue, 9 Apr 2024 at 00:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 4/8/2024 1:41 PM, Bjorn Andersson wrote:
> >>> On Mon, Apr 08, 2024 at 12:43:34PM -0700, Abhinav Kumar wrote:
> >>>>
> >>>>
> >>>> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
> >>>>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
> >>>>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>>>> [..]
> >>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>>>> index d80f89581760..bfb6dfff27e8 100644
> >>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>>>> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> >>>>>>                     return;
> >>>>>>             if (!dp_display->link_ready && status == connector_status_connected)
> >>>>>> -          dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> >>>>>> +          dp_hpd_plug_handle(dp, 0);
> >>>>>
> >>>>> If I read the code correctly, and we get an external connect event
> >>>>> inbetween a previous disconnect and the related disable call, this
> >>>>> should result in a PLUG_INT being injected into the queue still.
> >>>>>
> >>>>> Will that not cause the same problem?
> >>>>>
> >>>>> Regards,
> >>>>> Bjorn
> >>>>>
> >>>>
> >>>> Yes, your observation is correct and I had asked the same question to kuogee
> >>>> before taking over this change and posting.
> >>>>
> >>>> We will have to handle that case separately. I don't have a good solution
> >>>> yet for it without requiring further rework or we drop the below snippet.
> >>>>
> >>>>           if (state == ST_DISCONNECT_PENDING) {
> >>>>                   /* wait until ST_DISCONNECTED */
> >>>>                   dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
> >>>>                   mutex_unlock(&dp->event_mutex);
> >>>>                   return 0;
> >>>>           }
> >>>>
> >>>> I will need sometime to address that use-case as I need to see if we can
> >>>> handle that better and then drop the the DISCONNECT_PENDING state to address
> >>>> this fully. But it needs more testing.
> >>>>
> >>>> But, we will need this patch anyway because without this we will not be able
> >>>> to fix even the most regular and commonly seen case of basic
> >>>> connect/disconnect receiving complementary events.
> >>>>
> >>>
> >>> I did some more testing on this patch. Connecting and disconnecting the
> >>> cable while in fbcon works reliably, except for:
> >>
> >> Thanks for the tests !
> >>
> >>> - edid/modes are not read before we bring up the link so I always end up
> >>>     with 640x480
> >>>
> >>
> >> hmmm, I wonder why this should be affected due to this patch. We always
> >> read the EDID during hpd_connect() and the selected resolution will be
> >> programmed with the modeset. We will retry this with our x1e80100 and see.
> >
> > BTW, why is EDID read during HPD handling? I always supposed that it
> > can be read much later, when the DRM framework calls the get_modes /
> > get_edid callbacks.
> >
>
> Well, dp_panel_read_sink_caps() is in dp_display_process_hpd_high()
> currently. We read the edid there.

My question was, why is it done this way? Can it be dropped? There is
no need to store EDID in the driver data,  is it?

>
> get_modes(), parses the EDID and adds the modes using drm_add_edid_modes().
>
> >>
> >>> - if I run modetest -s <id>:<mode> the link is brought up with the new
> >>>     resolution and I get my test image on the screen.
> >>>     But as we're shutting down the link for the resolution chance I end up
> >>>     in dp_bridge_hpd_notify() with link_ready && state = disconnected.
> >>>     This triggers an unplug which hangs on the event_mutex, such that as
> >>>     soon as I get the test image, the state machine enters
> >>>     DISCONNECT_PENDING. This is immediately followed by another
> >>>     !link_ready && status = connected, which attempts to perform the plug
> >>>     operation, but as we're in DISCONNECT_PENDING this is posted on the
> >>>     event queue. From there I get a log entry from my PLUG_INT, every
> >>>     100ms stating that we're still in DISCONNECT_PENDING. If I exit
> >>>     modetest the screen goes black, and no new mode can be selected,
> >>>     because we're in DISCONNECT_PENDING. The only way out is to disconnect
> >>>     the cable to complete the DISCONNECT_PENDING.
> >>>
> >>
> >> I am going to run this test-case and see what we can do.
> >>
> >>> Regards,
> >>> Bjorn
> >>>
> >>>>
> >>>>>>             else if (dp_display->link_ready && status == connector_status_disconnected)
> >>>>>> -          dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> >>>>>> +          dp_hpd_unplug_handle(dp, 0);
> >>>>>>     }
> >>>>>> --
> >>>>>> 2.43.2
> >>>>>>
> >
> >
> >



-- 
With best wishes
Dmitry

