Return-Path: <linux-kernel+bounces-119837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF888CD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F7EB26DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050813D267;
	Tue, 26 Mar 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFHEfosP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887913D258;
	Tue, 26 Mar 2024 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482728; cv=none; b=DE+A42wSIlxUN6c9hhAy0m3RWadROXlaMve7Q7/xHizTwzoXH4RMF9YM3mSiQdTlB+xNj+z+on17l1Q2+oYX17VghBwg6+9nCrnOFZI3hlcmvB0z9ruvp37mM2YZa086t1Ahpn7S6hmJTHzZeQbAg87LaogoMjJoNDejZNoMels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482728; c=relaxed/simple;
	bh=xw5Af1WArsxfJQD3EHAiOmg03E5rcDaK8qUkbAkOVyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/Uq786FecQB4cen77efVXBadmtQP7Z3y94bzthrvcVNKaJXF2tEBUi7rUnZzUqY7BuiXIHW6J9+Ph2vZWiZaQOuhg9hw356w7Yl4fTPt5iFSDsu2Z0kawXcB029aPkY7BJPP7Pb9UVQMqVA1+KieaHpq6g+lf3oDb4snr4/szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFHEfosP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ff53528ceso3911755f8f.0;
        Tue, 26 Mar 2024 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711482724; x=1712087524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoJ7Xgxb57e+lLV6U4E0sAWdkd/64u+XAVmAgLbMPw0=;
        b=WFHEfosPhrbIgpN7rbTTnF3k3ERg7SUUzr2nOZj9QVPy8/ro5RgFcX0w7SbBu8iaSP
         DiEoXOveK+twBQtAICUbENHEycMU03G0HMuF2QVq9bA1V+e2PQNitbv3qNzNqKlVB7jl
         pFs/q51X85LzyKeKLOAb+zmPlr4ufWPrB3sRIbaZgzsPqIKpD5y+6tsGxFIfkVsR4oI0
         uUOVW50Udv57Z2PubSX3FJPiY78VzsaEVF80YVt/1fG6p2fg7mnrlmqVhoAMr+6HlvU4
         /J5DSuefDwUaYIffUanSQ2h4ZX6/To9Dh6j+P9dXAUaJW0h98+/oEtCaEO+NbESNDurM
         hrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482724; x=1712087524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoJ7Xgxb57e+lLV6U4E0sAWdkd/64u+XAVmAgLbMPw0=;
        b=Jg/HcpP/RoitU/Gg6dOed5RqtY+Y8KJ/b/wUeRloycyj4CJUs0Pgqdmel0AeInRc97
         JKu1WlZ2SVy19KyQODbUGjW/MEReTAVA8oi/Asi0ffm6PPCg7xuyQfOa3ibhoy6ALGQ2
         UJW63s2/iW0Xkewy9MXl6xX+GUZ3SAEoQQNoi756QVpw/T8Ltv6qBP2v0Dun1bxiv2KJ
         uCnetQMf+pVu04NUnab5Yo9uJ803MOWuYT8HvxILzZWqf1AcKTOQWi76y4iyczJqu5KO
         f1dPcXaKY/1gts4e2rJoa//0049WaBquC+oArXRczo6haIm54XKYXVYPGKi8szMVgPZp
         OI3A==
X-Forwarded-Encrypted: i=1; AJvYcCXaAWv0wI47gXerQak4y19S4URJgWBBHnD19IhKw2LTjQD0MzW3JjsLAZm1r1PRrMTlsvwQ9QzWGnvOUxJslrxVnolSp6PXwgOHILHtV0eS5hVfp30eFZ41N2MFoDdxZGbqhqcnUF9LIUWx7A==
X-Gm-Message-State: AOJu0YwGhxojIu+wjIEdKqlASV8q5+UqwYzX7b/Jp4z17yac28zNi9zW
	fiGGCYe6CSePmbriPbbgF3KlEZ/DWA0RaKc86SLi7gDI6JTdIeJeZtINSXEpufdtsNH7EGkExPs
	48SLjy52wetQj/SNhL5ivDnfo0yo=
X-Google-Smtp-Source: AGHT+IFdWjE4WHoVtPjuQcx0WsU75NBlLUIGPA+pXpYqfXBQ6kNVdedZPLpDt+1PDG/+8EGDVjm0fb4X9eM/yrOADWQ=
X-Received: by 2002:a5d:640c:0:b0:341:bfe2:da36 with SMTP id
 z12-20020a5d640c000000b00341bfe2da36mr1745593wru.6.1711482724438; Tue, 26 Mar
 2024 12:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
 <CAA8EJprTNFgKJ_3cdZz4f_LCkYFghi-cfaj3bZmYh3oA63my6A@mail.gmail.com>
 <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com> <CAA8EJppqrF10J1qExM=gopiF4GPDt7v4TB6LrQxx5OGyAL9hSg@mail.gmail.com>
 <671d2662-df4e-4350-0084-476eb1671cc1@quicinc.com> <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
In-Reply-To: <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 26 Mar 2024 19:51:53 +0000
Message-ID: <CACu1E7HhCKMJd6fixZSPiNAz6ekoZnkMTHTcLFVmbZ-9VoLxKg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
 variable 'out' set but not used
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	freedreno@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:47=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 26 Mar 2024 at 21:32, Abhinav Kumar <quic_abhinavk@quicinc.com> w=
rote:
> >
> >
> >
> > On 3/26/2024 12:10 PM, Dmitry Baryshkov wrote:
> > > On Tue, 26 Mar 2024 at 20:31, Abhinav Kumar <quic_abhinavk@quicinc.co=
m> wrote:
> > >>
> > >>
> > >>
> > >> On 3/26/2024 11:19 AM, Dmitry Baryshkov wrote:
> > >>> On Tue, 26 Mar 2024 at 20:05, Miguel Ojeda
> > >>> <miguel.ojeda.sandonis@gmail.com> wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>>> In today's next, I got:
> > >>>>
> > >>>>       drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: va=
riable
> > >>>> 'out' set but not used [-Werror,-Wunused-but-set-variable]
> > >>>>
> > >>>> `out` seems to be there since commit 64d6255650d4 ("drm/msm: More
> > >>>> fully implement devcoredump for a7xx").
> > >>>>
> > >>>> Untested diff below assuming `dumper->iova` is constant -- if you =
want
> > >>>> a formal patch, please let me know.
> > >>>
> > >>> Please send a proper patch that we can pick up.
> > >>>
> > >>
> > >> This should be fixed with https://patchwork.freedesktop.org/patch/58=
1853/.
> > >
> > > Is that a correct fix? If you check other usage locations for
> > > CRASHDUMP_READ, you'll see that `out` is the last parameter and it is
> > > being incremented.
> > >
> >
> > Right but in this function out is not the last parameter of CRASHDUMP_R=
EAD.
>
> Yes. I think in this case the patch from this email is more correct.

Yes, this patch is more correct than the other one. I tried to fix a
bug with a6xx that I noticed while adding support for a7xx, which I
forgot to split out from "drm/msm: More fully implement devcoredump
for a7xx" into a separate commit, and this hunk was missing. Sorry
about that.

Connor

