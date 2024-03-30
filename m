Return-Path: <linux-kernel+bounces-125582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A2892902
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F161F22447
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B805660;
	Sat, 30 Mar 2024 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+G7HytG"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E64685;
	Sat, 30 Mar 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711769111; cv=none; b=txur1GAZjblEbKcUItrDYj1M9Hxo5WrELeRqjfUe6oMrUPef/iYa6SwKo1Ul2MKuWWKvnB8lh0lUGgrcm0sUbc7JfTeOKy+XubDwLbK7ouFBrt1AVcQr34fIP/uO2jt/7NKeUWdzNSHOzIZih6qm3LthUagrVkriOnGpGMD+EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711769111; c=relaxed/simple;
	bh=cCn/Kys0eN1/9g5a2Lnh0Lipbghpno/cSwxko+kcqsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo1yQe+wb+9CkUcICUKfUa8YmisxrGLoXW0m6GRUkErB+TMBpy+HsFyaGoVYMwcUKL4WpfKWLlgXUX1eYxbzHPtzVzYNDPsAQnHKgTNQQRqgfOhXMfXDnzlgEthpj41yAKU5Xhsik68GDkCmA2p67vxmgcprABBzWYJyKGBwbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+G7HytG; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4766e56ccccso987087137.0;
        Fri, 29 Mar 2024 20:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711769108; x=1712373908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpPdvL8Aspg+XruusSIaaeZVrAk0JEByJ+vMpaFBMuo=;
        b=Q+G7HytGkH7EXVFnV8FGRe6wEPjgnZOgPAajgNgrLAZ4SCVQRWmWJxXWkJ5RzKrUuY
         tdGOVTZsqaGvjZtXJkUehA/4DIl+v9ctVxmJsLq4Ditem1S8mf9r+/7bN24TRRzw31l1
         gOH9rjZel25ytme7l9b6wmEXZP0BP7DotLf+AEwv8u8jPvaCJHLI0KDdrWBdNCylJpzu
         XaUltHfgL1gMVzImBS5Ce+iZbJV3z9F+rP+UJ1a6WjUFQ8g1vG2t4meL1c9xeBGFDslH
         Jc+3iD902wY5CBCz9eUzMoO+lG/tDZFm7UdZAbrv+xxFD+EOZ1PKpG/aE9uymfq30YYe
         JJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711769108; x=1712373908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpPdvL8Aspg+XruusSIaaeZVrAk0JEByJ+vMpaFBMuo=;
        b=pMbT5Jr6iKLnI5CN6xcgVsWplnci8vVvPtO+GhqA8dpcJxIWDqPcFeIev5udlHjHvx
         rdm6Zwj+GMGuukTrfiou/5Yl/BK2sL7oXm6b8vuIKAr83uykz83PZnRQxIqfE2XmiVIx
         onecLyWFmAbfMc6aNk4HqWZ2RtRwEz8vK+5qMhD8E5EO821QGClXR6I/hUJq6eIHYFFg
         /4Ww134xxdWhm9qTJ2Yv52QBE8m+ELloYYsfP5VSmPUd3qFe77DFaL5PNwa0y0Eluiqm
         cn8GCAtXMoAw5+5HmQqm1axIt78Oa9JFQDflnw/O6kkSP5i7WQxVtzGTgBgeXvz01zdi
         951g==
X-Forwarded-Encrypted: i=1; AJvYcCW3CT6zWM6+Ry4DEq1jm+5Ji/QltmWbnYSJSBnfZTme5bNn8lj1GZFNF+RqvEDtAiYinLdG1MnW0IANa8RidCA9CmZ0tu5kIMGLsRU6BbgC4AkPThyH1JqXyvfKlnw6j0wK
X-Gm-Message-State: AOJu0Yy9XseNxebPv2e4uClzcvSwuBKvQS+B3L0QbTNzJ1Ymi8WBmpN/
	q27ifR/Gn6PBNEQasIT6tSM/7uVeTEOboHKaGy87w726L/ee6zVD8qcwUzTzYF1tSwrvXePR1do
	MwOA2eB652vd/qCjZ85dosKipi3Y=
X-Google-Smtp-Source: AGHT+IH8+Y/+CrcGLMIY7wx22ahhMw/8tvRJQe+Ia+0YaTAklmIoq+r6BxPE0/GxoEdXjUk8j8e/mqHbaAgdpXjNApo=
X-Received: by 2002:a05:6122:a0b:b0:4d8:9541:41a0 with SMTP id
 11-20020a0561220a0b00b004d8954141a0mr3786757vkn.12.1711769108190; Fri, 29 Mar
 2024 20:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com> <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
In-Reply-To: <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 29 Mar 2024 23:24:57 -0400
Message-ID: <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, sn624@cs.rutgers.edu, 
	sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 6:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:
>
> [...]
>
> > @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bpf_re=
g_state *dst_reg,
> >        */
> >       dst_reg->u32_min_value =3D max(dst_reg->u32_min_value, umin_val);
> >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
>
> Hello,
>
> Could you please elaborate a bit, why do you use "> 0" not ">=3D 0" here?
> It seems that having one of the min values as 0 shouldn't be an issue,
> but maybe I miss something.

You are right, this is a mistake, I sent the wrong version of the patch. Th=
anks
for catching it. I will send a new patch.

Note that in the correct version i'll be sending, instead of the following
if condition,

if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0 &&
(s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)

it will use this if condition:

if ((s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)

Inside the if, the output signed bounds are updated using the unsigned
bounds; the only case in which this is unsafe is when the unsigned
bounds cross the sign boundary.  The shortened if condition is enough to
prevent this. The shortened has the added benefit of being more
precise. We will make a note of this in the new commit message.

This applies to all scalar(32)_min_max_and/or/xor.

> > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_va=
lue) {
> > +             /* ORing two positives gives a positive, so safe to cast
> > +              * u32 result into s32 when u32 doesn't cross sign bounda=
ry.
> > +              */
> > +             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > +             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > +     } else {
> >               /* Lose signed bounds when ORing negative numbers,
> >                * ain't nobody got time for that.
> >                */
> >               dst_reg->s32_min_value =3D S32_MIN;
> >               dst_reg->s32_max_value =3D S32_MAX;
> > -     } else {
> > -             /* ORing two positives gives a positive, so safe to
> > -              * cast result into s64.
> > -              */
> > -             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > -             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> >       }
> >  }
>
> [...]
>
> > @@ -13453,10 +13457,10 @@ static void scalar32_min_max_xor(struct bpf_r=
eg_state *dst_reg,
> >       /* We get both minimum and maximum from the var32_off. */
> >       dst_reg->u32_min_value =3D var32_off.value;
> >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > -
> > -     if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0) {
> > -             /* XORing two positive sign numbers gives a positive,
> > -              * so safe to cast u32 result into s32.
> > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
>
> Same question here.
>
> > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_va=
lue) {
> > +             /* XORing two positives gives a positive, so safe to cast
> > +              * u32 result into s32 when u32 doesn't cross sign bounda=
ry.
> >                */
> >               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> >               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
>
> [...]

