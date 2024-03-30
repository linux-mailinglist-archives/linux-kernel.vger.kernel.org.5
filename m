Return-Path: <linux-kernel+bounces-125784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B7892C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC791F22B71
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDA39870;
	Sat, 30 Mar 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar0ukOlZ"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955F1E878;
	Sat, 30 Mar 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816555; cv=none; b=Nhy888gUrNMeyAN7TH7XMjtrXyE38ZDYPHEmyhljxEquno78Zazhot659bBSlSkIJySJ/KNenN1xMM9fcgUV+3KYdoNsO0G/37ilxKMpeHURxjuCufnZxW05invfOBCVe20+JLlq76jGpbD/M6n9rbClcOuf3qZN4+5UsIR7S1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816555; c=relaxed/simple;
	bh=5ldWFZbSM7vabBwJhQdxODU2Y312T0sVkCLMiewgGlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqoDHmfg7gZ5kiXZUZ/CksuAdOoeyBhx/Gwmirwsmu4N8X5qAEVdZw9f7CCguL++kRNyU9koT9EJwv6mYRxhI+4LZ6Ar7JEidZeMHdVF4PdSEuMO6i5a3eVBmtIKvUKgZu0WOUVhSsrrptZrxdIMVEFRU5k9LnCx9MVxfMjRPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar0ukOlZ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e05d6871ddso837113241.1;
        Sat, 30 Mar 2024 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711816552; x=1712421352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0JAHX8SU+y7wtuE0MkN/0QwHwILo/i2aa8SsjYLE2I=;
        b=Ar0ukOlZc0ivvvo7GsEYJnXkN3PhXycuaAOOWsmM2SK+jdzG8X7QTxuNx6gzJGvxMs
         UIh11tk7DStrJXr+rxvag1n1tOm3tuOM5R/D6V7MgjPqumn20MymBHdc+Ql9R0sjJHFG
         I/t2jMqfW8d43UIy6/ra9I8W8tltKuCIBMqrs9StOR1ZC44Yy1EdBwGJSM5NGdO5lCar
         kz4oPkuhYbZjdVL0bkeQqa6t91/BNsk/T64G7i8jZybWyksbqxfQl+xMm0wNxJgGfYIl
         1Uw4YLVxCn//zsFwiS65N0zjn3XoWCBc4e4Ja65XI26YaZWULu6OJw6egErqleqlLwdQ
         wV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711816552; x=1712421352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0JAHX8SU+y7wtuE0MkN/0QwHwILo/i2aa8SsjYLE2I=;
        b=KOi49JHV9+TFCFI1BON/Xyd8s1tXpZnHdF27tfmjZ1j4++cBUM7I3y1i7i5Lw5jGlF
         f2CL+WOIZD82MA2u+Z/U+ZCXqSQCTMwzLItHpzFZLnBtR0cA+o1yCBrHJjIckyqcTYZY
         h08MQR2upV6K6rhQvjctHlgsRQDke2gqmUGdT9TkrcUm2KLRqUR93o0jYS071p27kU2Q
         xsL55yIje+hJN8K7jYQ85zhYs0yoXrGp2FEmd5tIoAqIjYhIJrL9iZhpVrfLs7STFfIG
         Hlxn5gdkZRak9FlW/1lqwTvFCnXR/rgvlMJ3opW74Vg6KpwUN6x6rlF/1hHicUPdRpP2
         9HsA==
X-Forwarded-Encrypted: i=1; AJvYcCVAM00es+zxN/Fiu0qhmOWcPUEJIsBL5vNQ7U6/FPgDn5k/NpcpESw6WBkh3kzOIXRZ4bvW6r3NdhN3Rd+metuxvaNfLP9MAMaEGX5FtcHXrkDzp7pTroJ8p/d5+56l+VM1
X-Gm-Message-State: AOJu0YzZ0ySBOezKBjJ5znzYxuRE912O3suuqksxYJJ4NTQpj3B9Wvb+
	wsAE5d9DzpDPkpREiv5zZ0lKzJggcFIDMmewhOB6MjSFwTl8iaMHfUch/MBwGSdWCJfkKKBGbUV
	//07kh5kwDSy7XzLatbAdPSuMp7w=
X-Google-Smtp-Source: AGHT+IHAYwWi4m8FadNvry/L3459XL7PiHVIHF7zw3Dl+IEIiETywgHyYGAyugHdXRs/QocDtCwQ5dy8D533gJz5iqs=
X-Received: by 2002:a05:6102:c4b:b0:476:d23b:de3c with SMTP id
 y11-20020a0561020c4b00b00476d23bde3cmr5229374vss.0.1711816552117; Sat, 30 Mar
 2024 09:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
 <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
 <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com> <CAEf4BzZp69diFeyjUAa8-jbZatDouwSaexwuakJdXHTdHwsBLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZp69diFeyjUAa8-jbZatDouwSaexwuakJdXHTdHwsBLQ@mail.gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Sat, 30 Mar 2024 12:35:41 -0400
Message-ID: <CAM=Ch04BBaucesmw0MY5U2bsrtqPAjurLdLkMdxMRMB0OuOtcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Sat, Mar 30, 2024 at 1:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 8:25=E2=80=AFPM Harishankar Vishwanathan
> <harishankar.vishwanathan@gmail.com> wrote:
> >
> > On Fri, Mar 29, 2024 at 6:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
com> wrote:
> > >
> > > On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:
> > >
> > > [...]
> > >
> > > > @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bp=
f_reg_state *dst_reg,
> > > >        */
> > > >       dst_reg->u32_min_value =3D max(dst_reg->u32_min_value, umin_v=
al);
> > > >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > > > -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> > > > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
> > >
> > > Hello,
> > >
> > > Could you please elaborate a bit, why do you use "> 0" not ">=3D 0" h=
ere?
> > > It seems that having one of the min values as 0 shouldn't be an issue=
,
> > > but maybe I miss something.
> >
> > You are right, this is a mistake, I sent the wrong version of the patch=
 Thanks
> > for catching it. I will send a new patch.
> >
> > Note that in the correct version i'll be sending, instead of the follow=
ing
> > if condition,
> >
> > if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0 &&
> > (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
> >
> > it will use this if condition:
> >
> > if ((s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
> >
> > Inside the if, the output signed bounds are updated using the unsigned
> > bounds; the only case in which this is unsafe is when the unsigned
> > bounds cross the sign boundary.  The shortened if condition is enough t=
o
> > prevent this. The shortened has the added benefit of being more
> > precise. We will make a note of this in the new commit message.
>
> And that's exactly what reg_bounds_sync() checks as well, which is why
> my question/suggestion to not duplicate this logic, rather reset s32
> bounds to unknown (S32_MIN/S32_MAX), and let generic reg_bounds_sync()
> handle the re-derivation of whatever can be derived.

We tried your suggestion (setting the bounds to be completely unbounded).
This would indeed make the abstract operator scalar(32)_min_max_and
sound. However, we found (through Agni and SMT verification) that our patch=
 is
more precise than just unconditionally setting the signed bounds to unbound=
ed
[S32_MIN/S32_MAX], [S64_MIN,S64_MAX].

For example, consider these inputs to BPF_AND:

dst_reg
-----------------------------------------
var_off.value: 8608032320201083347
var_off.mask: 615339716653692460
smin_value: 8070450532247928832
smax_value: 8070450532247928832
umin_value: 13206380674380886586
umax_value: 13206380674380886586
s32_min_value: -2110561598
s32_max_value: -133438816
u32_min_value: 4135055354
u32_max_value: 4135055354

src_reg
-----------------------------------------
var_off.value: 8584102546103074815
var_off.mask: 9862641527606476800
smin_value: 2920655011908158522
smax_value: 7495731535348625717
umin_value: 7001104867969363969
umax_value: 8584102543730304042
s32_min_value: -2097116671
s32_max_value: 71704632
u32_min_value: 1047457619
u32_max_value: 4268683090

After going through
tnum_and() -> scalar32_min_max_and() -> scalar_min_max_and() ->
reg_bounds_sync()

Our patch produces the following bounds for s32:
s32_min_value: -1263875629
s32_max_value: -159911942

Whereas, setting the signed bounds to unbounded in
scalar(32)_min_max_and produces:
s32_min_value: -1263875629
s32_max_value: -1

Our patch produces a tighter bound as you can see. We also confirmed
using SMT that
our patch always produces signed bounds that are equal to or more
precise than setting
the signed bounds to unbounded in scalar(32)_min_max_and.

Admittedly, this is a contrived example. It is likely the case that
such precision
gains are never realized in an actual BPF program.

Overall, both the fixes are sound. We're happy to send a patch for
either of them.

> >
> > This applies to all scalar(32)_min_max_and/or/xor.
> >
> > > > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_ma=
x_value) {
> > > > +             /* ORing two positives gives a positive, so safe to c=
ast
> > > > +              * u32 result into s32 when u32 doesn't cross sign bo=
undary.
> > > > +              */
> > > > +             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > > > +             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > > > +     } else {
> > > >               /* Lose signed bounds when ORing negative numbers,
> > > >                * ain't nobody got time for that.
> > > >                */
> > > >               dst_reg->s32_min_value =3D S32_MIN;
> > > >               dst_reg->s32_max_value =3D S32_MAX;
> > > > -     } else {
> > > > -             /* ORing two positives gives a positive, so safe to
> > > > -              * cast result into s64.
> > > > -              */
> > > > -             dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > > > -             dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > > >       }
> > > >  }
> > >
> > > [...]
> > >
> > > > @@ -13453,10 +13457,10 @@ static void scalar32_min_max_xor(struct b=
pf_reg_state *dst_reg,
> > > >       /* We get both minimum and maximum from the var32_off. */
> > > >       dst_reg->u32_min_value =3D var32_off.value;
> > > >       dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> > > > -
> > > > -     if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0) {
> > > > -             /* XORing two positive sign numbers gives a positive,
> > > > -              * so safe to cast u32 result into s32.
> > > > +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
> > >
> > > Same question here.
> > >
> > > > +             (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_ma=
x_value) {
> > > > +             /* XORing two positives gives a positive, so safe to =
cast
> > > > +              * u32 result into s32 when u32 doesn't cross sign bo=
undary.
> > > >                */
> > > >               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> > > >               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> > >
> > > [...]

