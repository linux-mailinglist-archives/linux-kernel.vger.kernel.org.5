Return-Path: <linux-kernel+bounces-71219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367485A21B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6851F21EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597D2C68C;
	Mon, 19 Feb 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuTyl+rH"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B22C1B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342663; cv=none; b=QFv6qTwwAIjUse85Tz8SGXvDZuCkgZpR1xCpe33tQPSggpz0mJ2MeL9CsA0A8KK78pD25mMjEDI1tqAjrSO5hABEqNedevfnZ+vhSTztMP76u14BBQS9vjim121zdqnkFY1x2ZneMlfECKrio91lrDl4VRMEwB59FgPjEfF/Bt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342663; c=relaxed/simple;
	bh=MqJ6X9bHhgIvnhhVNHt7I9sd6Vf8RfjTJZGaLdv/tzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3VvS9tY13idAfJ/Upt8tILuctMtc4L3P4DCJJqGShL8aauxlYVujfiX9638VZM7hnY0KtsAMocxSNSgTxvsrn/KsuJ6u5oHyV9L2PCu4lk5UVBEnF0m29/RJ7/86/9rE4vLYeLoZbw0BDxIQFh1Qi93FbVdNRfP4KzaHXCqG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuTyl+rH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607bfa4c913so38996227b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708342661; x=1708947461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaUyZ50XjXvDF8jY3Q3ZEC7jLE1bXKIRWKK8kFzpxxY=;
        b=RuTyl+rHwmb3qtgZf8mBDqPfY/pPSiSgag9Ayx0TIStlBIlY71/0yoE2HgZwekCQa/
         RbF0bU4DjziNq9Xi8YaMePPbRSvya9wANnR1jUK/sj9XoTsdv/I0IDw8yEC6neTk41iB
         MCxKbklEizqmodH198SXgbtSFiNTfeYZNlkfZi4H/Z0qmZTc/kD3H6t8v9/LTT6+wDnT
         sSmvVqmbHRFtEv3vWBaB5x11IC/z6MJc84Tmiz+Tswuzxc5EiGDZ2lbnKTNRGN/x63uU
         vkLxh9huXt65tqZFKPVDuIACp5cZ5W0uX+pvl0j4zJARIcVYVQURCOdyPHI591rvuUCi
         4wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342661; x=1708947461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaUyZ50XjXvDF8jY3Q3ZEC7jLE1bXKIRWKK8kFzpxxY=;
        b=fE1FYc3+KBSwKZTl/JcuLrnlw2h7k5C+x9oY98GTpDGL1oBUreL68FQzJA6Ptrbgv+
         azdms7t3+WdepIfhpdgB7gkc5BzSRj8lj33biuxx7z2kGUUNRVEElq+pCMYzA3XSI/VX
         ZZg6ik7Wv8hjs66007SrsqR2qH8oyrW18OhT+W0ArN+BZL1Qd01JQFj9ZyVzXhPQQkAW
         Iqw36v7scvRrIHoMnHWOlijgaX3Da8Q7ZjLfw/Kuk9hRr0vsB8WPUnHuvWMXqav1j0Zw
         pl75b4gHrpmQvVFdtBbu4zlAAyisugv0VN/SaQiBD0OO5tWJtTw/INdj36PsNoQOvgIw
         woEA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+qzK4PKd5gLWsHzyD6i2T4DPYVp643DpgYdR885mZ8IrUlIZXUHBE6/IjL0xJeGjR8JlVrfkC3nqCtZR/yhqZ6RExS1Ki8v9XVA+
X-Gm-Message-State: AOJu0YzbUsJiBvkmjJzNSolql5Q3fAnqJ+7c8//a8gKm8xB2wpZxeHSY
	Dii9xdWfQoEMrP3vglPnwH5KHipegYY4EgHwiKWHFtTd9m50kAvc8HGH9GmBtflBImabzPsE/6v
	QQnqpxxLQCbg+GvW2uEjRrd2+9P+Tts/C4nigmA==
X-Google-Smtp-Source: AGHT+IGQ1WnS7mBk+2g+qAwDGntsHIztsi8TubTD1INdibjvREVQvyi8hjDez2VQ2B6iwhTX0PVK/T0srPtjJXHbaAA=
X-Received: by 2002:a0d:dd94:0:b0:607:a0cf:d9ff with SMTP id
 g142-20020a0ddd94000000b00607a0cfd9ffmr11328416ywe.31.1708342661019; Mon, 19
 Feb 2024 03:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
 <20240208-fd-migrate-mdp5-v4-2-945d08ef3fa8@linaro.org> <9a4bf513-4390-3e36-f3b7-f9fef1c296fd@quicinc.com>
 <CAA8EJpoVivjg2KKVgf725C2cwMCOk=JK6hz65ewTheBAb8t_vQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoVivjg2KKVgf725C2cwMCOk=JK6hz65ewTheBAb8t_vQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 13:37:29 +0200
Message-ID: <CAA8EJprrVnb-5fhq9oc6PanoM8hY1fhBv0NvmcXhbAC9yJGmLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/msm/dpu: support binding to the mdp5 devices
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 20:58, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 9 Feb 2024 at 20:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >
> >
> >
> > On 2/8/2024 7:01 AM, Dmitry Baryshkov wrote:
> > > Existing MDP5 devices have slightly different bindings. The main
> > > register region is called `mdp_phys' instead of `mdp'. Also vbif
> > > register regions are a part of the parent, MDSS device. Add support for
> > > handling this binding differences.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 98 ++++++++++++++++++++++++++-------
> > >   drivers/gpu/drm/msm/msm_drv.h           |  3 +
> > >   drivers/gpu/drm/msm/msm_io_utils.c      | 13 +++++
> > >   3 files changed, 93 insertions(+), 21 deletions(-)
> > >
> >
> > I thought we had agreed on a quite version of msm_ioremap_mdss for
> > vbif_nrt_phys?
> >
> > Anyway, its not something to block this change. Hence,
>
> Excuse me, I'll fix it when applying, if I don't forget.

I took another glance. The  msm_ioremap_mdss is already quiet (it is
not printing warnings if the resource is not present), so this should
be fine by default. But I'll make a note that we might be able to
replace most of msm_ioremap functions with the standard devm ioremap
functions.

-- 
With best wishes
Dmitry

