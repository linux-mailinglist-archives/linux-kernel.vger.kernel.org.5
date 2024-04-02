Return-Path: <linux-kernel+bounces-128364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB58959F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EEE1C22C94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42B159907;
	Tue,  2 Apr 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2uap/MJ"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87602AD1E;
	Tue,  2 Apr 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076236; cv=none; b=DkQFeWLPNDBcYFi/2qhaTvfWWb9sF2rlpH10+9pqAJZ/7027ZNXxBH94VhQ4ptgs7uPbWobeKp2VIjaFsIis+f6hWN11X62RiPcqMw9otGJV7tlaZV/4OJZ4osHxR1Rp7UPNna8Uj0GdbSRYEtpnlpsRL2cG8Vigh3Ojm3wNc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076236; c=relaxed/simple;
	bh=fFnCKGfkqLN0RGRz6CY7g5EViCTuK6Py2Kheiwv8YEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN1LWBBHEqGMm85RcL5LXuwXslC4+EztTiaQKO0F/5B3UKkJFYtT5PgOsDgerjN19RLzMeQL+L7gPGnaQN81WUOzTIB+N3q+OJmj6N/hmc5lfV9TA6VSRo0TFvwQCk3ERZxd5xjMZdhesJVC07bLx06nS0RzvI11zcZ/qTcabpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2uap/MJ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4788939769fso453871137.1;
        Tue, 02 Apr 2024 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076234; x=1712681034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bARqrFgsneD+covumrGgNw8HoiNpsNx2Oy2kurbEzMY=;
        b=i2uap/MJ42a9MfVhM34XZIwNrvav+LxizPyFnjVOcArllZ/jMDDBJetMlQ2Ej51otw
         Px6+ywf93hDqziGrR81m4r/cuzW17coGjZefb/QUmP78d4/z54bbemeuHQcrLWvK2bF4
         hIG3F7JIfqOz6BjLQibZHxYvpMxa922CG5kr4fFiiV0NYxVysb3j7Dm8I8N4x6ZObqp4
         Vu1UqTp8sRXKDaSlxEOVaZ7d61zv3rccNfmt3nz40eBRlylZ0T10VuvKIi4Tqn/iEtIW
         Orsn2HMcCmRIpYkGdYOcbQPUHdYjaAlriDt+UzgwMsLHJbjRCuOb6wJ7xHxj2L1/Hsm6
         kJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076234; x=1712681034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bARqrFgsneD+covumrGgNw8HoiNpsNx2Oy2kurbEzMY=;
        b=bRIgpl3fD8OufWIBFlPpSDUVN3lBa9LeuJ3d0UwZukrs7rghNDLvjG6fmwdyjZnrP1
         b7aW1QsmjraUENhE/LLCA/sy1igKWFBxX6zr8El3O+x0s6bVz+SG5qKhznMuUuJF2s90
         W/DYiC2sBuRXMa+0UO+nKC+tqMoa48DtifAcawTmRR81QdRJTfxnHHZsU9uAbgIH38BO
         LOi8G5FlvAINKLGEdQ3yzUSIMKRu6zbccoS1gl41IxSESOHiTFOAH0FxK/6m0nRapcbi
         6ommqQBDlSBnPbwcr/5SvVv0JSIpUy6NDQ4ds/W/QopAfIrsfmB8meESuyCzTBehuCxl
         e+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXOfwXnBLuJ7rb/R1vy4SzFsnzZYoaWWPtJJ/BJ2fuocbBEgO9sb5yyG5WovqlQrJ2C1NbKlN1tnZ/avpW3U3mOTj0kK6YxynKIbDyF6Jx7A3X/EHm/jU1WzeKgedB1repy
X-Gm-Message-State: AOJu0YyIeGuTkUmqglwxDy0614eZ98E80BcjJCWGduvmKnrmsVERR/ZK
	1H0AxGT5vDMRZQI3HODtWjyrOGOBqdbrVxQHrJ6v6XMuV/zUbVNR+0gqCxqlUmx6GHYMvaL19a9
	+e87X9F5tlfxNzQbjkx9by8QX3PI=
X-Google-Smtp-Source: AGHT+IEt+fJ7GEt4KSeoI6+aUZvSguyLsKb+pR2+23RlZf1IKPkQFw5EZfNod0HX1wWF36ZA/+gpXjk4tHFYfDCyfbA=
X-Received: by 2002:a05:6102:4192:b0:476:f10a:b0da with SMTP id
 cd18-20020a056102419200b00476f10ab0damr13934082vsb.16.1712076233647; Tue, 02
 Apr 2024 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
 <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
 <CAM=Ch04JAJDS84xYHFUfjrShwqSSc8gQ5a_sLCoRNAsf6tyjYQ@mail.gmail.com>
 <CAEf4BzZp69diFeyjUAa8-jbZatDouwSaexwuakJdXHTdHwsBLQ@mail.gmail.com>
 <CAM=Ch04BBaucesmw0MY5U2bsrtqPAjurLdLkMdxMRMB0OuOtcw@mail.gmail.com> <4229e0ff-777b-6afb-f0c0-a329e426d87e@iogearbox.net>
In-Reply-To: <4229e0ff-777b-6afb-f0c0-a329e426d87e@iogearbox.net>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 2 Apr 2024 12:43:42 -0400
Message-ID: <CAM=Ch04GNCQ0dJQUPXqYotaoSAULXrR5LiF3EjeQOEyq67kyeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, 
	harishankar.vishwanathan@rutgers.edu, sn624@cs.rutgers.edu, 
	sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:06=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 3/30/24 5:35 PM, Harishankar Vishwanathan wrote:
> > On Sat, Mar 30, 2024 at 1:28=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Fri, Mar 29, 2024 at 8:25=E2=80=AFPM Harishankar Vishwanathan
> >> <harishankar.vishwanathan@gmail.com> wrote:
> >>>
> >>> On Fri, Mar 29, 2024 at 6:27=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> >>>>
> >>>> On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>> @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bp=
f_reg_state *dst_reg,
> >>>>>         */
> >>>>>        dst_reg->u32_min_value =3D max(dst_reg->u32_min_value, umin_=
val);
> >>>>>        dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> >>>>> -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> >>>>> +     if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
> >>>>
> >>>> Hello,
> >>>>
> >>>> Could you please elaborate a bit, why do you use "> 0" not ">=3D 0" =
here?
> >>>> It seems that having one of the min values as 0 shouldn't be an issu=
e,
> >>>> but maybe I miss something.
> >>>
> >>> You are right, this is a mistake, I sent the wrong version of the pat=
ch. Thanks
> >>> for catching it. I will send a new patch.
> >>>
> >>> Note that in the correct version i'll be sending, instead of the foll=
owing
> >>> if condition,
> >>>
> >>> if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0 &&
> >>> (s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
> >>>
> >>> it will use this if condition:
> >>>
> >>> if ((s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value)
> >>>
> >>> Inside the if, the output signed bounds are updated using the unsigne=
d
> >>> bounds; the only case in which this is unsafe is when the unsigned
> >>> bounds cross the sign boundary.  The shortened if condition is enough=
 to
> >>> prevent this. The shortened has the added benefit of being more
> >>> precise. We will make a note of this in the new commit message.
> >>
> >> And that's exactly what reg_bounds_sync() checks as well, which is why
> >> my question/suggestion to not duplicate this logic, rather reset s32
> >> bounds to unknown (S32_MIN/S32_MAX), and let generic reg_bounds_sync()
> >> handle the re-derivation of whatever can be derived.
> >
> > We tried your suggestion (setting the bounds to be completely unbounded=
).
> > This would indeed make the abstract operator scalar(32)_min_max_and
> > sound. However, we found (through Agni and SMT verification) that our p=
atch is
> > more precise than just unconditionally setting the signed bounds to unb=
ounded
> > [S32_MIN/S32_MAX], [S64_MIN,S64_MAX].
> >
> > For example, consider these inputs to BPF_AND:
> >
> > dst_reg
> > -----------------------------------------
> > var_off.value: 8608032320201083347
> > var_off.mask: 615339716653692460
> > smin_value: 8070450532247928832
> > smax_value: 8070450532247928832
> > umin_value: 13206380674380886586
> > umax_value: 13206380674380886586
> > s32_min_value: -2110561598
> > s32_max_value: -133438816
> > u32_min_value: 4135055354
> > u32_max_value: 4135055354
> >
> > src_reg
> > -----------------------------------------
> > var_off.value: 8584102546103074815
> > var_off.mask: 9862641527606476800
> > smin_value: 2920655011908158522
> > smax_value: 7495731535348625717
> > umin_value: 7001104867969363969
> > umax_value: 8584102543730304042
> > s32_min_value: -2097116671
> > s32_max_value: 71704632
> > u32_min_value: 1047457619
> > u32_max_value: 4268683090
> >
> > After going through
> > tnum_and() -> scalar32_min_max_and() -> scalar_min_max_and() ->
> > reg_bounds_sync()
> >
> > Our patch produces the following bounds for s32:
> > s32_min_value: -1263875629
> > s32_max_value: -159911942
> >
> > Whereas, setting the signed bounds to unbounded in
> > scalar(32)_min_max_and produces:
> > s32_min_value: -1263875629
> > s32_max_value: -1
> >
> > Our patch produces a tighter bound as you can see. We also confirmed
> > using SMT that
> > our patch always produces signed bounds that are equal to or more
> > precise than setting
> > the signed bounds to unbounded in scalar(32)_min_max_and.
> >
> > Admittedly, this is a contrived example. It is likely the case that
> > such precision
> > gains are never realized in an actual BPF program.
> >
> > Overall, both the fixes are sound. We're happy to send a patch for
> > either of them.
>
> Given your version is more precise, then that would be preferred. Might
> be good to have the above as part of the commit description for future
> reference.
>
> Thanks,
> Daniel

Thanks Shung-Hsi, Eduard, Andrii, Daniel. I'll send over a new version
of the patch addressing
all the points discussed above.

Best,
Hari

