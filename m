Return-Path: <linux-kernel+bounces-123857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF2890EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47F1B21D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D4A3D;
	Fri, 29 Mar 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMsAzdKS"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C806196
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671039; cv=none; b=O4DZmr9bHBlFRbSUeGIhykFP20qRzIvN5M+Ta0X0nE0eoo7VLzhSobDBVrCl3gAmWTb2m/FXOdJk6m09wWmecHUxXap/fXtEe1tW86ILZMNema3k7BICkuDbfVbH8sg4HO8MzsbhqlJctUUHSCVgJOAM3gEGH18rQ+9Hd98XiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671039; c=relaxed/simple;
	bh=EVIdbjbJsRff17pLWIt/KVs78vZXte9uNYVKH2OPIWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCNnZPF7vuyN97OVn9TEGvnm7xW0oq3066lSuvaJ+AfT8MUL0TzF5/FxqTlSzHw1IeB0712Lb+F/tRL2xpwy6suzJlf23kG2EE/T4xDInln63ul6ekj72E18cr0kkBUNkfZikNgf8WIg14hD80WdiDOrqdvlv8SzKRfFhKMXBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TMsAzdKS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a15449303so17208187b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711671036; x=1712275836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5lSPZalTka6RxrpE0PVtOAReRQxe7xqocRBLESvr1I=;
        b=TMsAzdKS9gpswZCkH+QWLZI+Wgs+ybydZtOs8WnsW4dkf/Ieo83SAVYXwZR8oXqU8v
         fffFK27Cpd5kclhRctx9e0AJygz8Oxk+8ZWyFcxZWaUk11A4rZ0kN+srJculxcgb7Rur
         UoybyT/iIYQ774lAQDVLFkG4xqJEciobI+Qe7ma57gomxInKlLpNgCEbaM0Dj4zUnhDQ
         FDLpfmu7+cJLn1zZYufOseG3a8sJIEJp9xCAAkAfwb8iG/qWayO9KorETUme8vlbOwL1
         mm4lb21uFwu2QIfPZL+x8T820N0xIQWf3/WnLIQFeE3xa7Gn6c61n5O9kX4yK8m6CVK/
         XwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711671036; x=1712275836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5lSPZalTka6RxrpE0PVtOAReRQxe7xqocRBLESvr1I=;
        b=Gzg8h9jmGTrn7mgC52kBircuUd4B4dAL1gtiLnANU8XMER/6AQvt6RlLjRmmhDgoHE
         rtWdcq1H1hC7Q7CPeEMfpBnJocHoqS0VVbJVbG4H2P66IT4U+ioW6EN9LnHQV9RG1cnZ
         bDW/7df4KhShANqdFHPbusMgn+y4jDyeaq88RYHcZneSV5hoKw/r2nvpUgxRAULzLhxW
         0cJ20EdVYhG8brE/zWen7pn9ap0LBXhhlvwnYYwUEFjF3rvfAHwWZuZzRDaQFTNQi5hL
         SmKwNTI/7bPCoLIgcoxDHy/1g2V9bFVUY/+bTgoP0H9HJUS4jR+tIbA2qVSn3r6iI9yp
         qK6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyP63szVSyoqxwbolMQMHV1OQlee9bmN6ZK2pNYTkZAJDQPgUSfKKMxfWYosB2n7yvCPiaqc3nPnkI63jOlBKEFkjWvAuu+8RVdNX3
X-Gm-Message-State: AOJu0YxVP3D3z0AbDIooOE5bjfbPChHejnx8Ab4Tas687Z+KWAx9vC+H
	WLtBRmg91uZ2T/JNjNzMfcse4WiqVaIcQ3ylSlaPh0bFpMOlemcEIfh2IM2aI5PCrnG/6oMQO5Y
	6onVDz44YyTAGfeni1KbMdx42KnEfwC/YlA1xVQ==
X-Google-Smtp-Source: AGHT+IFNTD2wcHv6N04Ko0vkYz+k2THNRgzN2dkBDjgsSy4EQ2HSZ3QxzAoBtzLez5o4xIavqtXemij+Sg/7cukae7E=
X-Received: by 2002:a0d:cc01:0:b0:611:bdd:452c with SMTP id
 o1-20020a0dcc01000000b006110bdd452cmr1106283ywd.8.1711671036187; Thu, 28 Mar
 2024 17:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
 <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com> <CAE-0n503FwcwreZ14MMKgdzu8QybWYtMdLOKasiCwmE8pCJOSw@mail.gmail.com>
 <23de89e9-3ef3-c52d-7abf-93dc2dbb51a4@quicinc.com> <CAA8EJppEWXnsQzDD1tdNuMb1ijEVtE7LQct9jt1fwVwMd8ch_Q@mail.gmail.com>
 <27cadd17-10a3-3b8c-2b29-6698ccdce531@quicinc.com>
In-Reply-To: <27cadd17-10a3-3b8c-2b29-6698ccdce531@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 02:10:25 +0200
Message-ID: <CAA8EJpqYVDG9pBj39m40rPwUNgE7x07HfCt6C3yaMN7eOaWk6Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: use dp_hpd_plug_handle() and
 dp_hpd_unplug_handle() directly
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, abel.vesa@linaro.org, 
	agross@kernel.org, airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org, 
	dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	vkoul@kernel.org, quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 01:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 3/28/2024 3:50 PM, Dmitry Baryshkov wrote:
> > On Thu, 28 Mar 2024 at 23:21, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 3/28/2024 1:58 PM, Stephen Boyd wrote:
> >>> Quoting Abhinav Kumar (2024-03-28 13:24:34)
> >>>> + Johan and Bjorn for FYI
> >>>>
> >>>> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
> >>>>> For internal HPD case, hpd_event_thread is created to handle HPD
> >>>>> interrupts generated by HPD block of DP controller. It converts
> >>>>> HPD interrupts into events and executed them under hpd_event_thread
> >>>>> context. For external HPD case, HPD events is delivered by way of
> >>>>> dp_bridge_hpd_notify() under thread context. Since they are executed
> >>>>> under thread context already, there is no reason to hand over those
> >>>>> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
> >>>>> dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
> >>>>>
> >>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
> >>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>
> >>>> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
> >>>
> >>> Is this a bug fix or an optimization? The commit text doesn't tell me.
> >>>
> >>
> >> I would say both.
> >>
> >> optimization as it avoids the need to go through the hpd_event thread
> >> processing.
> >>
> >> bug fix because once you go through the hpd event thread processing it
> >> exposes and often breaks the already fragile hpd handling state machine
> >> which can be avoided in this case.
> >
> > Please add a description for the particular issue that was observed
> > and how it is fixed by the patch.
> >
> > Otherwise consider there to be an implicit NAK for all HPD-related
> > patches unless it is a series that moves link training to the enable
> > path and drops the HPD state machine completely.
> >
> > I really mean it. We should stop beating a dead horse unless there is
> > a grave bug that must be fixed.
> >
>
> I think the commit message is explaining the issue well enough.
>
> This was not fixing any issue we saw to explain you the exact scenario
> of things which happened but this is just from code walkthrough.
>
> Like kuogee wrote, hpd event thread was there so handle events coming
> out of the hpd_isr for internal hpd cases. For the hpd_notify coming
> from pmic_glink or any other extnernal hpd cases, there is no need to
> put this through the hpd event thread because this will only make things
> worse of exposing the race conditions of the state machine.
>
> Moving link training to enable and removal of hpd event thread will be
> worked on but delaying obvious things we can fix does not make sense.

From the commit message this feels like an optimisation rather than a
fix. And granted the fragility of the HPD state machine, I'd prefer to
stay away from optimisations. As far as I understood from the history
of the last revert, we'd better make sure that HPD handling goes only
through the HPD event thread.

-- 
With best wishes
Dmitry

