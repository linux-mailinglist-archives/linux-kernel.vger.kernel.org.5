Return-Path: <linux-kernel+bounces-7450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA581A80D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F5B21E11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46B48CF3;
	Wed, 20 Dec 2023 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyRJ2EnQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B7495C2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso110766276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703107500; x=1703712300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SthL2gAMsR+mHPBG1JCkY0mqpm5FBToJ0tzjEFRNHcc=;
        b=wyRJ2EnQ9EILyke63DVwLzUHKo0u/iLIfiV5P2SeSbjf0HPELqe+zAB5xn/pR42JsU
         3VYjXVIgU/QZ5u9DHPyfNyW2qRrb3RCaaZdxXvUnNe3hYuORFbOMhgl5aCCs6IIutIOZ
         E87liu3bD6V/+aCuNpY2xBnySs1QF9WSTOZYijkAo/czWMfX5BNX8kC8XNZNZP8v7vU/
         Vo05a5/faIRWYmA8ay9vhLKTIEy6UWH2hFaUTyEePLK6qCdvlWmU/N8eJ/GjY4f2torP
         1TBYgCY5TJoic22xEmwlUot/jtdy5VogzAv/sFgjO1y3UU6AAdO+32wNz8MEJzpYqd/3
         E0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107500; x=1703712300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SthL2gAMsR+mHPBG1JCkY0mqpm5FBToJ0tzjEFRNHcc=;
        b=WZktsOZulvmA7U1UdPLgosxg2jJzxcZc1FaNbJBpCVlUbdvd0eKs1z1dVjMzhh14/n
         MbgPRgNjUGJIOMXSp0sK1INPDNwAOsPLVpTjG7JsInQDhJcLfzZxNiPEP6wytzPvIURs
         6eSCIO5BxFtljsaba+8FD7v+ICNbHiaGnHk907mHX0l8vTDRwDKdB7mJZ3PKPIj3H+Pt
         i9iGszP2AIKcV9hipokpGcTCXP48IsD4ZODL4yQPAojQq+P9cGHDBT/hIA5u4tkn7IB7
         1uLXXSWKDsFazEcxmR8qZV3y5NMFsRrG3NMXyLbtL/BsHV9Ecc708zJxsO/MOFP87QDX
         dxiw==
X-Gm-Message-State: AOJu0Ywig1Equ49izGziHoge5lFOxJvkWe8R9FScnAlNtWIepOmooqjg
	8C9LMqJVLO5N8zOS63b5/YB9y2QGU1JfuUs9BKuZoQ==
X-Google-Smtp-Source: AGHT+IE6LxPyhK7rvwt29snj4Fy9r1G3RAjYWLNpqAdsYml2G2psdqOTq5HPBmaiXCvCS1lPHFkhzmrUiePLk1rasPA=
X-Received: by 2002:a25:690e:0:b0:dbd:7177:6531 with SMTP id
 e14-20020a25690e000000b00dbd71776531mr348556ybc.37.1703107499779; Wed, 20 Dec
 2023 13:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org> <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
 <CAA8EJpouBOLJ_1Pz_YauuOX+97ud9RkLYRaui4GM6ZFJUKYJMw@mail.gmail.com>
 <9d94317c-5da9-5494-26a2-12007761a1e5@quicinc.com> <CAA8EJpoCGRT=eETab8mF2MZZ04RmCkNnFKaRBFoUYk5qqDAPhg@mail.gmail.com>
 <eb288a33-a8c3-9dea-ffc1-e97a69be9a4c@quicinc.com> <CAA8EJprZ1TK7UwfhSh2PtwuNJLUMace7MWnzQkrUMqV5R+WgOA@mail.gmail.com>
 <cf2c1c84-2d9d-1be4-997f-d3dde362b27a@quicinc.com>
In-Reply-To: <cf2c1c84-2d9d-1be4-997f-d3dde362b27a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 23:24:48 +0200
Message-ID: <CAA8EJprMr2vjZki7+p1zepCvmeocnGtZ0w5Ew8rW38=RKyQ7UQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stanimir.k.varbanov@gmail.com, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, mchehab@kernel.org, bryan.odonoghue@linaro.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Abhinav,

On Wed, 20 Dec 2023 at 20:55, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Dmitry and Krzysztof
>
> On 12/20/2023 1:52 AM, Dmitry Baryshkov wrote:
> > On Wed, 20 Dec 2023 at 10:53, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
> >>
> >> On 12/20/2023 2:09 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 20 Dec 2023 at 10:14, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 12/20/2023 1:07 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, 20 Dec 2023 at 08:32, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
> >>>>>>
> >>>>>> Hi Dmitry,
> >>>>>>
> >>>>>> On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
> >>>>>>> On 18/12/2023 13:31, Dikshita Agarwal wrote:
> >>>>>>>> This patch series introduces support for Qualcomm new video acceleration
> >>>>>>>> hardware architecture, used for video stream decoding/encoding. This driver
> >>>>>>>> is based on new communication protocol between video hardware and application
> >>>>>>>> processor.
> >>>>>>>
> >>>>>>> This doesn't answer one important point, you have been asked for v1. What is the
> >>>>>>> actual change point between Venus and Iris? What has been changed so much that
> >>>>>>> it demands a separate driver. This is the main question for the cover letter,
> >>>>>>> which has not been answered so far.
> >>>>>>>
> >>>>>>>  From what I see from you bindings, the hardware is pretty close to what we see
> >>>>>>> in the latest venus generations. I asssme that there was a change in the vcodec
> >>>>>>> inteface to the firmware and other similar changes. Could you please point out,
> >>>>>>> which parts of Venus driver do no longer work or are not applicable for sm8550
> >>>>>>
> >>>>>> The motivation behind having a separate IRIS driver was discussed earlier in [1]
> >>>>>> In the same discussion, it was ellaborated on how the impact would be with
> >>>>>> change in the new firmware interface and other video layers in the driver. I can
> >>>>>> add this in cover letter in the next revision.
> >>>>>
> >>>>> Ok. So the changes cover the HFI interface. Is that correct?
> >>>> Change wise, yes.
> >>>>
> >>>>>> We see some duplication of code and to handle the same, the series brings in a
> >>>>>> common code reusability between iris and venus. Aligning the common peices of
> >>>>>> venus and iris will be a work in progress, once we land the base driver for iris.
> >>>>>
> >>>>> This is not how it usually works. Especially not with the patches you
> >>>>> have posted.
> >>>>>
> >>>>> I have the following suggestion how this story can continue:
> >>>>> You can _start_ by reworking venus driver, separating the HFI /
> >>>>> firmware / etc interface to an internal interface in the driver. Then
> >>>>> implement Iris as a plug in for that interface. I might be mistaken
> >>>>> here, but I think this is the way how this can be beneficial for both
> >>>>> the video en/decoding on both old and new platforms.
> >>>>
> >>>> HFI/firmware interface is already confined to HFI layer in the existing venus
> >>>> driver. We explained in the previous discussion [1], on how the HFI change
> >>>> impacts the other layers by taking example of a DRC usecase. Please have a look
> >>>> considering the usecase and the impact it brings to other layers in the driver.
> >>>
> >>> I have looked at it. And I still see huge change in the interface
> >>> side, but it doesn't tell me about the hardware changes.
> >>
> >> I hope you noticed how the common layers like decoder, response, state layers
> >> are impacted in handling one of usecase. Now add that to all the different
> >> scenarios like seek, drain, DRC during seek, DRC during drain, etc.
> >
> > Yes, for sure.
> >
> >>
> >>> Have you evaluated the other opportunity?
> >>>
> >>> To have a common platform interface and firmware-specific backend?
> >>>
> >>> You have already done a part of it, but from a different perspective.
> >>> You have tried to move common code out of the driver. Instead we are
> >>> asking you to do a different thing. Move non-common code within the
> >>> driver. Then add your code on top of that.
> >>
> >> For common platform - yes, we are bringing in common stuff like PIL.
> >> Other than that, abstraction to firmware interface is not that confined to one
> >> layer. It spreads over decoder/encoder/common layers. Now when majority of the
> >> layers/code is different, we planned to make it in parallel to venus and have a
> >> common layer having common things to both iris and venus.
> >
> > My suggestion still holds. Start with this common platform code.
> > Rather than arguing back and forth, could you please perform an
> > experiment on the current venus driver and move firmware interface to
> > subdirs, leaving just the platform / PIL / formats / etc in place?
> > This will at least allow us to determine whether it is a feasible
> > concept or not.
> >
>
> Your comments are valid. The platform driver piece and some other pieces
> still are common between venus and iris despite this initial effort of
> moving common pieces out. I have also seen this from whatever I have
> reviewed.
>
> Video team also acknowledges this part and internally I think they did
> evaluate this option and their feedback was, the more and more they
> changed, they were touching pretty much every file of venus.

This is fine from my POV. Splitting the the common functionality also
touched a significant part of the venus driver in a pretty bad way.

> The missing piece i think in all this discussion is that in addition to
> the forward channel, the reverse channel of HFI, based on which the rest
> of the video state machine changes should also be considered.
>
> So even with respect to the code layout, its not just the forward
> communication but the backwards communication of fw--->hfi--->codec is
> becoming a challenge as the venus layers seem to only work with the hfi
> of venus.

Again, this is a question of the platform backend part. Nobody
questions that newer platforms have their own driver interface.
We are not asking your team to add if(new) { foo; } else { bar; }
conditions all over the code. Instead we have been asking to split all
platform specifics to the 'backend'. Compare this with mdp4, mdp5 and
dpu backends of the single drm/msm frontend. Or with a similar
approach found in other DRM drivers. Adding new driver is frequently
unjustified, instead the existing driver gets extended to support
different generations.

> For adding support for the new HFI events/communication, it was getting
> harder to extend venus.
>
> What I certainly acknowledge is now with iris whether this can be dealt
> with better for future chipsets to avoid another re-write for another
> HFI as that will be too much of maintenance cost.

Another approach, which might also be fine, if that looks better from
your point of view. The current venus driver might have issues with
the internal interfaces. Or it might be not suitable for the backends.
In this case, can we please get older platforms also supported by the
iris driver? This will be a very simple case then: the old deprecated
driver, being phased out and removed, and a new one, which is being
phased in.

The problem is very simple from my side. I do not want to end up in a
situation where we have to change platform code for both drivers if
there is any common issue. Neither would I like for venus and iris
bindings to diverge more than necessary. And as you have seen from my
comments, the iris bindings already do not follow the venus example.

> I will let the video team comment on this part.
>
> Thanks
>
> Abhinav
>
>
>
>
>
> >>
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
> >>>>> Short rationale:
> >>>>> The venus driver has a history of supported platforms. There is
> >>>>> already some kind of buffer management in place. Both developers and
> >>>>> testers have spent their effort on finding issues there. Sending new
> >>>>> driver means that we have to spend the same amount of efforts on this.
> >>>>> Moreover, even from the porter point of view. You are creating new
> >>>>> bindings for the new hardware. Which do not follow the
> >>>>> venus-common.yaml. And they do not follow the defined bindings for the
> >>>>> recent venus platforms. Which means that as a developer I have to care
> >>>>> about two different ways to describe nearly the same hardware.>> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
> >>>>>> venus as the changes are too interleaved to absorb in venus driver. And there is
> >>>>>> significant interest in community to start validating video driver on sm8550 or
> >>>>>> x1e80100.
> >>>>>>
> >>>>>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
> >>>>>>
> >>>>>> Regards,
> >>>>>> Vikash

-- 
With best wishes
Dmitry

