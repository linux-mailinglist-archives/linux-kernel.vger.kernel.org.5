Return-Path: <linux-kernel+bounces-130851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0261897DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E001F28BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96791CFA8;
	Thu,  4 Apr 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6saht0A"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610971CD2D;
	Thu,  4 Apr 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199914; cv=none; b=izmZ0GwHYYrZSF6jUEANmUbp1TtzHtfymk1nXxpTXWltxIN60LDzRCm/heHWbEf3oJ4YwlCW0OsDhWjXAxJgqqs03QFh9DeWzaLDPMgWmDDV9/Z4AWCJvHjK9PB0/CTT8e0F825hX83OWh4phMtUuImQT9d8alkIxTbW1p+1STo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199914; c=relaxed/simple;
	bh=n1Gy12ii5bN7QHH1APM2opNVzrdc9BSnxwogwL1EV3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlaywooWi/JxBG+AX9HE7Ajc/uZw6i5IPxZIXkex9PF5ObvygFgEcv2+jM6bwvXqE1VotW+6YWoisskDfmN5UuB152e3cSBmoYoID6e7JT1bWNJ2ifRwhNgL18TXOrkEG264txU/LonX14s1NV/Xa2fn7k6UP8qkm59kDUkyZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6saht0A; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d8e4d0b267so205403e0c.1;
        Wed, 03 Apr 2024 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712199911; x=1712804711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjHDnpA7O0SA2pBDBfzfbp7mcVeAfKFEgK+y0xJV6BU=;
        b=O6saht0AfkgGFQz75gv8Yshb/5uBD623GjwjhDBVSOPs+T3zaVdCMkM1EZAEAJPBgE
         iRwUbeRjKNgzuGUJEjwhVJWPfGNtFsEnY97PbEePnaW6v0eg0Cv0xW5ttQu6GV37W8Q7
         WzN6qqyvwS8mX29ybSlGM86pXGvBtvp2RutkbD6nJYAmfPrO9U9WH0k2Aj4qlhD9695m
         TQZZbKKkLfl2RRmswmEVYM8Du2uAXs60xGmGXtOicBEGqklI0qWbb84uZmmT42YVO8Rt
         563iQtAEYcG0bTpXkhVOMxN8OvYd3R9Qy6l1Dk9MZpHaJI8sy2JIEuJGttQDRSA6KCq3
         CibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712199911; x=1712804711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjHDnpA7O0SA2pBDBfzfbp7mcVeAfKFEgK+y0xJV6BU=;
        b=hpAUwtKL2qjBZTSggDX7JxjrVtGO6ahjbiJ96WinQMoP1b7LFWaY6yGEngfOhnUAWp
         od4H98SEZcba6hE6qMPpdNmzsglMlUbbjT15o08Oh6icz/weGvRklCQZJDpKXlmfylSC
         8f8kdje8sDQ2VaQCaRXxbzO6QZEBMD9ZuEpckmYiqwqGQh2ICunpKfTHAL4foiAKAub3
         K4DK2SuLNqRvtpEnX8mL2cWSHAx/BReVs7NHAKEhvkh8u6ZM1ANn3HhZ+1P3HIzDHkXF
         zENU5Br4AVTZwrRPMs5kNqmF3erhUerRbSwRcgcpwamSGhjYYKh+Uy/etZZ+/THk4nuH
         Ns/w==
X-Forwarded-Encrypted: i=1; AJvYcCXqUhExbMG8Jn4cbkJWRlMWbcIiLgpzMAGqN8lCJ2JShVbsmp9IvU5QP9XVIPYhpEMSzOYK2KmPtBaAOKf7R5MyPZam1xhRUiPxHe68e5u4nrvOvuQsmp3mBMZFf2ikIJk+
X-Gm-Message-State: AOJu0YyrfUY3aj5+ySdfFNFtrebLqPwKZu23a7egNu3keaul0BVSaC6S
	vqDwiI8VvrgvqJhyVDMAj1p6fEO3VNQbl2SFqTkFRIgTHMZ7Ucak3VVV9bFlZB/YURxT7b0PtFh
	Ygwh0M5gNkIWkOPcO/Xg89A/0lIN+7bq4nBo=
X-Google-Smtp-Source: AGHT+IE154OEEZxkmPiDJ5tY4+FxOYu0pDdm/usOrWPODO/EvEflbVdQTWMgWeImARWWbnYhdtJpp718LuJO136gPK8=
X-Received: by 2002:a05:6122:468c:b0:4da:9aa1:dd5e with SMTP id
 di12-20020a056122468c00b004da9aa1dd5emr1437503vkb.10.1712199911102; Wed, 03
 Apr 2024 20:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com> <82892691-a48f-ad06-7005-5bbd7d0757eb@iogearbox.net>
In-Reply-To: <82892691-a48f-ad06-7005-5bbd7d0757eb@iogearbox.net>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Wed, 3 Apr 2024 23:05:00 -0400
Message-ID: <CAM=Ch045iUe1vHy+h9FSURbffj1GD_WDhcFJ2W7_amVx-BQATw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, paul@isovalent.com, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Edward Cree <ecree@solarflare.com>, "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:09=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 4/2/24 11:20 PM, Harishankar Vishwanathan wrote:
> [...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fcb62300f407..a7404a7d690f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13326,23 +13326,21 @@ static void scalar32_min_max_and(struct bpf_r=
eg_state *dst_reg,
> >               return;
> >       }
> >
> > -     /* We get our minimum from the var_off, since that's inherently
> > +     /* We get our minimum from the var32_off, since that's inherently
> >        * bitwise.  Our maximum is the minimum of the operands' maxima.
> >        */
> >       dst_reg->u32_min_value =3D var32_off.value;
> >       dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, umax_val);
> > -     if (dst_reg->s32_min_value < 0 || smin_val < 0) {
>
> The smin_val is now unused, triggering the following warnings :
>
> ../kernel/bpf/verifier.c:13321:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13321 |         s32 smin_val =3D src_reg->s32_min_value;
>         |             ^~~~~~~~
> ../kernel/bpf/verifier.c:13352:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13352 |         s64 smin_val =3D src_reg->smin_value;
>         |             ^~~~~~~~
> ../kernel/bpf/verifier.c:13386:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13386 |         s32 smin_val =3D src_reg->s32_min_value;
>         |             ^~~~~~~~
> ../kernel/bpf/verifier.c:13417:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13417 |         s64 smin_val =3D src_reg->smin_value;
>         |             ^~~~~~~~
> ../kernel/bpf/verifier.c:13451:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13451 |         s32 smin_val =3D src_reg->s32_min_value;
>         |             ^~~~~~~~
> ../kernel/bpf/verifier.c:13479:6: warning: unused variable 'smin_val' [-W=
unused-variable]
>   13479 |         s64 smin_val =3D src_reg->smin_value;
>         |             ^~~~~~~~
>
> Removing these builds fine then, please follow-up with a v3.

Apologies. Yes, these smin_vals are not required anymore. I'll remove
them when sending
the v3.

> Thanks,
> Daniel

