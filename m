Return-Path: <linux-kernel+bounces-6658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51E819BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C266B2610B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E33200CA;
	Wed, 20 Dec 2023 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPvbDhcs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0220200CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5d7a47d06eeso47267017b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703065970; x=1703670770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hogvja0xVIkkpg3N+6iU77v6ti9BPz5LqsXbI7QDFuQ=;
        b=IPvbDhcsHFGMrR+miBhc5XqYqZ/YQUo19qKUfbV1EAYvC/Nn1qMv8KI4myGjLt80Aq
         JB0Rj1MXaWv0KF9B0Yqs8jO+lwtavzPnOTR6wWhfFZR5KjvYlx11DTH/sh4OcQMTMyoF
         6BIBdlmoKGH4oiLwQZYdC29w2Vg6yTAyFqfDY3x8TeZIuc3XCKnAN6eYIRQVnGhviy4G
         muWexjKgFVMA5LOtDVbqdITWDcj0C2vJhFiHj1oXZDWForPM9fX3eTnVqfVcKrDxwvqW
         7ZRUBHpWF4pE8t0r8P1OF81BhR6/W24miMieZrvdOpZbeTmHqe/QfQPTBKETziANxoVz
         CNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703065970; x=1703670770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hogvja0xVIkkpg3N+6iU77v6ti9BPz5LqsXbI7QDFuQ=;
        b=xL3lR9lmcx3q1J3BD5ZfaMshVcoo93CRviC1nHPYKrDA8BxSdHOwDOZ6gtkl0vvnnr
         ZFF7plx8sBN5fJrRs7PQi4YmIzNCT7D5MVJ/KUvOKuUYhcbN/7Fgyi4n0SNOV4Im0rgF
         RQishuNBR4W+hMbIZXi4qq2rhNR5hxozDxcjL95M80yKfgie+CgCdCr3h8ceZBx3YzyF
         xgZyYZZsnEJlJPORdVbQuBdI3AlSmDkpaCXIdXHNdwJttXJvV8wb8r0lVljX7NSCmiKr
         Xg7KxGUgb/P3wf8SvIB6q9h2FsDzONfk/n45RZyGE9uCTKMLBGLylYwJIPEPBKaptKOZ
         3mEA==
X-Gm-Message-State: AOJu0Yy15QJptcGRVU0P2KJirLRePu+k3z/LzCKUOe6AF/hvq/znS7Oo
	M0lat2fLuEasrez8ohAdP6e0di9m7zkwdoFcVpJ60Q==
X-Google-Smtp-Source: AGHT+IHa9abAxBqfvgu2VEATjTXP7RsILfCHv1QAK1a136nQqIhAC3OMNah3ueuDGBDBTH9DAWreJ+FsKm4O3eoCxVA=
X-Received: by 2002:a81:6e42:0:b0:5e7:6f2d:aa90 with SMTP id
 j63-20020a816e42000000b005e76f2daa90mr2340336ywc.3.1703065969854; Wed, 20 Dec
 2023 01:52:49 -0800 (PST)
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
 <eb288a33-a8c3-9dea-ffc1-e97a69be9a4c@quicinc.com>
In-Reply-To: <eb288a33-a8c3-9dea-ffc1-e97a69be9a4c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 11:52:38 +0200
Message-ID: <CAA8EJprZ1TK7UwfhSh2PtwuNJLUMace7MWnzQkrUMqV5R+WgOA@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanimir.k.varbanov@gmail.com, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mchehab@kernel.org, bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 10:53, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>
> On 12/20/2023 2:09 PM, Dmitry Baryshkov wrote:
> > On Wed, 20 Dec 2023 at 10:14, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/20/2023 1:07 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 20 Dec 2023 at 08:32, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
> >>>>
> >>>> Hi Dmitry,
> >>>>
> >>>> On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
> >>>>> On 18/12/2023 13:31, Dikshita Agarwal wrote:
> >>>>>> This patch series introduces support for Qualcomm new video acceleration
> >>>>>> hardware architecture, used for video stream decoding/encoding. This driver
> >>>>>> is based on new communication protocol between video hardware and application
> >>>>>> processor.
> >>>>>
> >>>>> This doesn't answer one important point, you have been asked for v1. What is the
> >>>>> actual change point between Venus and Iris? What has been changed so much that
> >>>>> it demands a separate driver. This is the main question for the cover letter,
> >>>>> which has not been answered so far.
> >>>>>
> >>>>> From what I see from you bindings, the hardware is pretty close to what we see
> >>>>> in the latest venus generations. I asssme that there was a change in the vcodec
> >>>>> inteface to the firmware and other similar changes. Could you please point out,
> >>>>> which parts of Venus driver do no longer work or are not applicable for sm8550
> >>>>
> >>>> The motivation behind having a separate IRIS driver was discussed earlier in [1]
> >>>> In the same discussion, it was ellaborated on how the impact would be with
> >>>> change in the new firmware interface and other video layers in the driver. I can
> >>>> add this in cover letter in the next revision.
> >>>
> >>> Ok. So the changes cover the HFI interface. Is that correct?
> >> Change wise, yes.
> >>
> >>>> We see some duplication of code and to handle the same, the series brings in a
> >>>> common code reusability between iris and venus. Aligning the common peices of
> >>>> venus and iris will be a work in progress, once we land the base driver for iris.
> >>>
> >>> This is not how it usually works. Especially not with the patches you
> >>> have posted.
> >>>
> >>> I have the following suggestion how this story can continue:
> >>> You can _start_ by reworking venus driver, separating the HFI /
> >>> firmware / etc interface to an internal interface in the driver. Then
> >>> implement Iris as a plug in for that interface. I might be mistaken
> >>> here, but I think this is the way how this can be beneficial for both
> >>> the video en/decoding on both old and new platforms.
> >>
> >> HFI/firmware interface is already confined to HFI layer in the existing venus
> >> driver. We explained in the previous discussion [1], on how the HFI change
> >> impacts the other layers by taking example of a DRC usecase. Please have a look
> >> considering the usecase and the impact it brings to other layers in the driver.
> >
> > I have looked at it. And I still see huge change in the interface
> > side, but it doesn't tell me about the hardware changes.
>
> I hope you noticed how the common layers like decoder, response, state layers
> are impacted in handling one of usecase. Now add that to all the different
> scenarios like seek, drain, DRC during seek, DRC during drain, etc.

Yes, for sure.

>
> > Have you evaluated the other opportunity?
> >
> > To have a common platform interface and firmware-specific backend?
> >
> > You have already done a part of it, but from a different perspective.
> > You have tried to move common code out of the driver. Instead we are
> > asking you to do a different thing. Move non-common code within the
> > driver. Then add your code on top of that.
>
> For common platform - yes, we are bringing in common stuff like PIL.
> Other than that, abstraction to firmware interface is not that confined to one
> layer. It spreads over decoder/encoder/common layers. Now when majority of the
> layers/code is different, we planned to make it in parallel to venus and have a
> common layer having common things to both iris and venus.

My suggestion still holds. Start with this common platform code.
Rather than arguing back and forth, could you please perform an
experiment on the current venus driver and move firmware interface to
subdirs, leaving just the platform / PIL / formats / etc in place?
This will at least allow us to determine whether it is a feasible
concept or not.

>
> >>
> >> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
> >>> Short rationale:
> >>> The venus driver has a history of supported platforms. There is
> >>> already some kind of buffer management in place. Both developers and
> >>> testers have spent their effort on finding issues there. Sending new
> >>> driver means that we have to spend the same amount of efforts on this.
> >>> Moreover, even from the porter point of view. You are creating new
> >>> bindings for the new hardware. Which do not follow the
> >>> venus-common.yaml. And they do not follow the defined bindings for the
> >>> recent venus platforms. Which means that as a developer I have to care
> >>> about two different ways to describe nearly the same hardware.>> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
> >>>> venus as the changes are too interleaved to absorb in venus driver. And there is
> >>>> significant interest in community to start validating video driver on sm8550 or
> >>>> x1e80100.
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
> >>>>
> >>>> Regards,
> >>>> Vikash
> >>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

