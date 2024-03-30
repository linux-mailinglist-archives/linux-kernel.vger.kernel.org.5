Return-Path: <linux-kernel+bounces-125603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D816189297F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFA01F227AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239258F45;
	Sat, 30 Mar 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsQ6MkHy"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339C881F;
	Sat, 30 Mar 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711776538; cv=none; b=ZlULKB+hSZTnsEdwTtFc58KZ2mcF9ZHxEoCr0j43SULFOpNL73AOvaeavUOPulyvxEgZur2mXK/CSGgcE1X3asr0PUKmj4qaWtDfx8RJQeG/R9QaXhCHhLRfzkthEYrvX9W6RELxVj/H/1msgZivrWzzwJvyJy9qpVO6F3sjtKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711776538; c=relaxed/simple;
	bh=EUcUQklyNbH8/SNk483PELZG1vakzV9Wr9CnM70ULio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/2HkhYnWh/MXJeBWuxa99I/vLb4mzb/L8ltsD1b2Is/d8fU3yrv19FjTR1UsVLt3Cz0Fj5qBNnwoebNTiNG4U7nYuI2w/zBKi3f2IPShJiRbDRcbR8zEVpEwVTXciWc1K/BFzSouuAwasS7WNnzWPqt4CM40+IVU4zaaSz15NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsQ6MkHy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1799905a12.1;
        Fri, 29 Mar 2024 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711776536; x=1712381336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzHyUcYN9rBRgPi5AsHIJZShKuTLwgsqehdZBFMpuRw=;
        b=VsQ6MkHyvVdqeiFVmzVlhzKOw6JRtj+QvUwAY8SvSxvePwH+sZUYByZb1JeCUAQwHG
         BA4LB6O61zDE5U9WxBAlnZfBHicnhVJp3Sj4uXf4oEml9b3bTfYWvqbofRrF0xhAn5WC
         3mNlXgxfn/5fM/H6Rupr22TT0RAaYItPUozWMNpiBODV4b5NG1tl6lW6fWqyvZDMtQzI
         fNnPhUbqX59yeHSFYLQGw2OvHVoyABsZUB5eUgcaUhfoFVeCSsv/imoE4h9DOnZ/+5uL
         75Z8U6nci78KGtagRgeK4ZYDhRpA333gMYmMddraJn7XxwATDn6MwB2tgtqk19aZAt+h
         I8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711776536; x=1712381336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzHyUcYN9rBRgPi5AsHIJZShKuTLwgsqehdZBFMpuRw=;
        b=Xl3nDi5Z/KSywfmLTG6gei40BJ195czVu4SnU0SAYqHO51SoqCN/Fd5OSCITJD6e2I
         7nQVIT4miWfaZbpf/HTY6JM4zOWx4xwyytRk1+a4YoyLWcPe2Da/vmfDV3o1Tys/khVL
         snOwTSMCM70d+dikgwvzXFBWHVXSyQvcsmPIIAHT7bo586tnUfml0XxM2et+ANM+D/aZ
         qKdJOqgjupwHE1wuHB2Glb/F30NxgBdLOdNlu6OaqNpViVHAEx0LqQGaPwIB8tG7N6yD
         tFsVMcz/+ir//EuUCwhkborG0fmkvVZeDzk3TldPMychd/3yrVZ2MPvFzrEBvJjczzIE
         j4UA==
X-Forwarded-Encrypted: i=1; AJvYcCWmG7kHfmLwGkU4VlTdzqbmDyd8b5uow1tDs5et6M99JOCSbAm2Mg+gTl9nl7lsfUmB/LZx6xnWL86iy+QcORYf9tFLnuFbfvxudqpjBdIOBio5+QH9SJ1Lyc/tNYxeAik2
X-Gm-Message-State: AOJu0Yx2MgyPJzkT1Q8EeVrltkb0T0mCBMGgchfNW+rVQ/PA1qQ/bnM1
	UjJApPRgScm17UKw7M2Oe1gBTLJHmzTJztR2Ss7GO/Vf7AUk0nmo4S+Wb3YDmdaYzEYmy/4rMcO
	tedPz4mHuPLo+l1v4boNz7D5GgHY=
X-Google-Smtp-Source: AGHT+IE0MVT9pzRAM4noGtnm12NIysa9FA5dVdlH91BgPyrOq2n6tRTkiYTvswlcdbgXxDAO+ZA4y/uo7gKe30cZaSo=
X-Received: by 2002:a05:6a21:3384:b0:1a5:6fde:8303 with SMTP id
 yy4-20020a056a21338400b001a56fde8303mr4307453pzb.38.1711776535998; Fri, 29
 Mar 2024 22:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
 <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com> <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com>
In-Reply-To: <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:28:43 -0700
Message-ID: <CAEf4BzZp69diFeyjUAa8-jbZatDouwSaexwuakJdXHTdHwsBLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, harishankar.vishwanathan@rutgers.edu, 
	sn624@cs.rutgers.edu, sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, 
	paul@isovalent.com, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 8:25=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 6:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:
> >
> > [...]
> >
> > > @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bpf_=
reg_state *dst_reg,
> > >        */
> > >       dst_reg->u32_min_value =3D max(dst_reg->u32_min_value, umin_val=
);
> > >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > > -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> > > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
> >
> > Hello,
> >
> > Could you please elaborate a bit, why do you use "> 0" not ">=3D 0" her=
e?
> > It seems that having one of the min values as 0 shouldn't be an issue,
> > but maybe I miss something.
>
> You are right, this is a mistake, I sent the wrong version of the patch. =
Thanks
> for catching it. I will send a new patch.
>
> Note that in the correct version i'll be sending, instead of the followin=
g
> if condition,
>
> if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0 &&
> (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
>
> it will use this if condition:
>
> if ((s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
>
> Inside the if, the output signed bounds are updated using the unsigned
> bounds; the only case in which this is unsafe is when the unsigned
> bounds cross the sign boundary.  The shortened if condition is enough to
> prevent this. The shortened has the added benefit of being more
> precise. We will make a note of this in the new commit message.

And that's exactly what reg_bounds_sync() checks as well, which is why
my question/suggestion to not duplicate this logic, rather reset s32
bounds to unknown (S32_MIN/S32_MAX), and let generic reg_bounds_sync()
handle the re-derivation of whatever can be derived.

>
> This applies to all scalar(32)_min_max_and/or/xor.
>
> > > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_=
value) {
> > > +             /* ORing two positives gives a positive, so safe to cas=
t
> > > +              * u32 result into s32 when u32 doesn't cross sign boun=
dary.
> > > +              */
> > > +             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > > +             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > > +     } else {
> > >               /* Lose signed bounds when ORing negative numbers,
> > >                * ain't nobody got time for that.
> > >                */
> > >               dst_reg->s32_min_value =3D S32_MIN;
> > >               dst_reg->s32_max_value =3D S32_MAX;
> > > -     } else {
> > > -             /* ORing two positives gives a positive, so safe to
> > > -              * cast result into s64.
> > > -              */
> > > -             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > > -             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > >       }
> > >  }
> >
> > [...]
> >
> > > @@ -13453,10 +13457,10 @@ static void scalar32_min_max_xor(struct bpf=
_reg_state *dst_reg,
> > >       /* We get both minimum and maximum from the var32_off. */
> > >       dst_reg->u32_min_value =3D var32_off.value;
> > >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > > -
> > > -     if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0) {
> > > -             /* XORing two positive sign numbers gives a positive,
> > > -              * so safe to cast u32 result into s32.
> > > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
> >
> > Same question here.
> >
> > > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_=
value) {
> > > +             /* XORing two positives gives a positive, so safe to ca=
st
> > > +              * u32 result into s32 when u32 doesn't cross sign boun=
dary.
> > >                */
> > >               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > >               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> >
> > [...]

