Return-Path: <linux-kernel+bounces-119831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1E88CD74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C861F626FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D813D25D;
	Tue, 26 Mar 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIXfB8H3"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1C3DABE1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482464; cv=none; b=TaAFp3nPhaViS1jMdiNZaB0sDMlv3mIsuzJMJgjC9hVJ+XvDHZrYHvZBzAraRA5QzDvtn3A2J4wt6baNRQ+lQ9LusrWx8ntMckOjT+P5H3HEy3UY9w/Om9iIzUsdfT8hqAye4Z4rw3eVAhy3zvbMKlwEDykxXZKZCvezy/8flb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482464; c=relaxed/simple;
	bh=9Hrv+yQ6ggCFqu5Jm8HZOWdy9wYvi7d9h22Bf0YsEa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnzc0YIH8ulVATvGkKVgKqCaxAqIAbuLP8LMSKfNsCBAAagmOP717WcWTWFwhi+jJmMKIMqXWdR8n+o/ctLsbvM/rY77W5yOa0p1QLgiMqD6RT72jkcYoTnbUFFc499MySQ2iB0rcPrv61wOYsIOqv5EZSDTQi1eu/jMXaWZdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIXfB8H3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609fb0450d8so63324657b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711482461; x=1712087261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qyPM89Y10g6lsVDwvjAhw3OysernPxYLdybxWGA1Ik=;
        b=lIXfB8H3N2R03ZaF8Xmsh9SO6/3MB43g8Co3QazXF85TAOHLbofwzSp7ah+0ef5cOj
         lGTTXItGvplb6qwu8Cgn5A79TjPtz+NbQqS+CAEEYSkP+XrP5RKNHoEuRgT5sw0UQAM5
         7usZgfqj70bxQePonjtLUici5YAx+g1kpEDCcDeJYQuaBEoIex5D9wTyEPMRo6jwWCj2
         9R48zuvIh6PEisXU4+jbsHX9wxcL+4Jtx2FMM7Y8QHSriRWpuA5QtaDNw0Ml9kucMN/T
         wIXMy7WyPl6GspxnUZQU8LnGFyl1jb7Kj/RybAlb2RsRX1QzQA8hBpN6vXRNviicj8PJ
         WydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482461; x=1712087261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qyPM89Y10g6lsVDwvjAhw3OysernPxYLdybxWGA1Ik=;
        b=t+XP1lCjMAVOdaLRgoRxbFIa4FmtUf+gGYcoSvlH4e+AGeHX6+U5f0M5nQAoM3fwg9
         X2RMvqTq+/UTDCo2iXYPpTfeQL58L/NbFiLPYFuqzc8Rw5DsNrExyLjWvoKxnPq1L21K
         JOXV8pHinlNKSkvTKusuNGmJxB4xrHdRrUAvenDlS/zleANt4q5oRLhNkoH9FwPQVHyI
         ePEUeVJIyU38UzODyis1nucghAOphtsgtXkwPmGb3Veflt6ZNJWYVceZfQ/DOk2CIp6d
         k0/vyPsvB0BJfg2DowcUWLHFV4CDg5VhNEdBmZph8wGhMT39ddEcuPbu6gZFQktAKHv9
         XliA==
X-Forwarded-Encrypted: i=1; AJvYcCXAfRsMYeI8uy9pTu0bZqN5ER6l+BLhxwHOCRmVF8AVb0+m/rqcrJFi/cC/P4ch52+0kWRoJ1xTsMwvu4Ewx+NTfb0Oa3urQeZD5ght
X-Gm-Message-State: AOJu0YwFeH1o23iSxzjDfRWdN5cdlmNv8rC/dItZAr+JLAvOUKol/ZOo
	v2nqJ6YbUJZs+oJExi5ki6hZaOb0GG8d8zEszQ30zF/pCYRkH4JFjI0whA55ZFDty8Mb1bXXK3A
	WnDOgzAcAwh9aB1D8tzX+hgxVPYlqDfAE72JtoQ==
X-Google-Smtp-Source: AGHT+IEDgs+miE1gX6ZQTUPVvtQ4tAfLoH8Z/nDmvJIeTUqUSoM57Xw13la+OqnoQDXlV9aokZwVCnZHBuAHWvDS4Lc=
X-Received: by 2002:a25:aa4d:0:b0:dc7:8c3a:4e42 with SMTP id
 s71-20020a25aa4d000000b00dc78c3a4e42mr8948827ybi.30.1711482461135; Tue, 26
 Mar 2024 12:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
 <CAA8EJprTNFgKJ_3cdZz4f_LCkYFghi-cfaj3bZmYh3oA63my6A@mail.gmail.com>
 <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com> <CAA8EJppqrF10J1qExM=gopiF4GPDt7v4TB6LrQxx5OGyAL9hSg@mail.gmail.com>
 <671d2662-df4e-4350-0084-476eb1671cc1@quicinc.com>
In-Reply-To: <671d2662-df4e-4350-0084-476eb1671cc1@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 21:47:30 +0200
Message-ID: <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
 variable 'out' set but not used
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	freedreno@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 21:32, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 3/26/2024 12:10 PM, Dmitry Baryshkov wrote:
> > On Tue, 26 Mar 2024 at 20:31, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 3/26/2024 11:19 AM, Dmitry Baryshkov wrote:
> >>> On Tue, 26 Mar 2024 at 20:05, Miguel Ojeda
> >>> <miguel.ojeda.sandonis@gmail.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> In today's next, I got:
> >>>>
> >>>>       drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable
> >>>> 'out' set but not used [-Werror,-Wunused-but-set-variable]
> >>>>
> >>>> `out` seems to be there since commit 64d6255650d4 ("drm/msm: More
> >>>> fully implement devcoredump for a7xx").
> >>>>
> >>>> Untested diff below assuming `dumper->iova` is constant -- if you want
> >>>> a formal patch, please let me know.
> >>>
> >>> Please send a proper patch that we can pick up.
> >>>
> >>
> >> This should be fixed with https://patchwork.freedesktop.org/patch/581853/.
> >
> > Is that a correct fix? If you check other usage locations for
> > CRASHDUMP_READ, you'll see that `out` is the last parameter and it is
> > being incremented.
> >
>
> Right but in this function out is not the last parameter of CRASHDUMP_READ.

Yes. I think in this case the patch from this email is more correct.

>
> Maybe you or Rob can correct me but I thought the fix looked sane
> although noone commented on that patch.

>
> >>
> >> We can pickup that one with a Fixes tag applied.
> >>
> >>>>
> >>>> Cheers,
> >>>> Miguel
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >>>> b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >>>> index 1f5245fc2cdc..a847a0f7a73c 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >>>> @@ -852,7 +852,7 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
> >>>>                (block->type << 8) | i);
> >>>>
> >>>>            in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
> >>>> -            block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
> >>>> +            block->size, out);
> >>>>
> >>>>            out += block->size * sizeof(u32);
> >>>>        }
> >>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

