Return-Path: <linux-kernel+bounces-112536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A104887B45
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E5C1F213DD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C71870;
	Sun, 24 Mar 2024 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsm0XIDO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322863B;
	Sun, 24 Mar 2024 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241570; cv=none; b=kpI4aok2abO4h0TJ/C4cnyfYOI0NbDpAUONzFQaEurDhuIxFijcsODL6EV7k6AouQvEE8IexGyCPeyV5adCJo4ObjxU2eK4ef7uNYibd+x0k2eLMMUYt/+09P9dvxWADFOGTQBL2/9zlxb19ncIEMt4ZzTMEHqhOHOrKWr0gboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241570; c=relaxed/simple;
	bh=nYgcbG5xVcO1IJ6Ul3gaDuVgnCIJ2TJ/C5BK1a5zrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrRPFIF7+f7jvzq1yp8U9XwDLRU7Qio/EIQhWWRV8g0tn/nlmrPPVP8YOV5e/rDXkxfZtZcEOBft0NZ5SM28xXQdbjg7oSEJvZzw+FmMPM37ew/trTe5/W85rZ2z++NmAZC8IP54wcU2PypbJO6ls2BLWStHFml3Kpvk1oxT72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsm0XIDO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34169f28460so1972505f8f.2;
        Sat, 23 Mar 2024 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711241567; x=1711846367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zHwWmJvNVnVHgF9eedTLMRgyRXaGPOg7/7z0tsQnzY=;
        b=fsm0XIDOhFHyKJwwKM2tpIiC/+SkU40P3TaaCC0Xf8yuiI9AsBD2oKI8jw3DdapjH6
         MCL75gzhvJ6G9XQaSQxT9VArrqHIqRRAgtRX3n7kPZVhR+wsTnNrrw5UePRzQIZrKyGg
         B+d3WzBS1i9O/uD7FMDc4I3QxILmyZhmhoOOdP519M/Sgn0w3E2GpfI59U2Zcszk48Ia
         WLwDHXHyk5O2eTaBPrk9W2MPA859xqiCMhc8aRf/0LGCipsqVn2rvG+xTyCEsaUrokyo
         4GPuKC6k6V7cAypz8CIB/JR+xVMst0V/rjEXc1OQCvvTZOeAOeMYvaetDsDZssdDY2zz
         WZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241567; x=1711846367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zHwWmJvNVnVHgF9eedTLMRgyRXaGPOg7/7z0tsQnzY=;
        b=HK2zN1q8DWdf3FrA4d36rQHXWSkFCd2U68XK64ct3oGugdXUdKEmnj/Q21IgphWjSC
         hv5puzJtJJtYb0pCVcsfS+tWWqv63+Sg2+uBY45djiSVkrs6yymoLlU/NpfXXGcNqwAK
         5jlhV2q3Ayi2Csk7vJ56wtM8+qDUDNwwADl/cU7M4OflauNyaw21GnIw0xXFAYj6aRN8
         0e2jYgcgOO6S3engMQZik/wNb6/UBSSPb+diff9bmHdKV7B/xeGLQvU/ZIEFX15JPRcA
         MxzlRaS9bu3JtsQrNs81m0+EkAoUmSSbT0HHei3r9FLbMluBjMqTpn0GhwWD/ri0O5A2
         AbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpofy8ciJahkLSS5WU4cHd3DjSoGDoCt6qTIG+tj91zQMQoDyNEkAsNxsoEaBGT7L1OmWAh5GKBBFeW6lByKk3SMx0htNDPgcQeIXePPj37WOlBhCUmPdCUlsXPfBet23+lcQUsEU+dPLxKm5JqOFmmhsCBQqOgEfk
X-Gm-Message-State: AOJu0YwMlMeUPI3uh6gNDTMfgQEYAEODera5Tkmplu/lv6SzOlJt+5vh
	CQq/UafrRFoJGNqS0gTZRJ/75j9uQYUjsAEHr+uVpH2j+c1r8G/nxGkmz6eUOs7vwXUuz8rBk5o
	33alU24bQbFPsw5QsHwhaOr/L+Bs=
X-Google-Smtp-Source: AGHT+IHbVlU784EVEe8bw5H/E5EzdKKKSTdMm5NdoN9AHwvKuS+Gs56Itbxy8ll2zCOaBMiYVgXhoqmHPgWTgSUkvnY=
X-Received: by 2002:adf:f142:0:b0:33d:3abb:6db4 with SMTP id
 y2-20020adff142000000b0033d3abb6db4mr1948207wro.69.1711241567324; Sat, 23 Mar
 2024 17:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
 <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com>
In-Reply-To: <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 17:52:36 -0700
Message-ID: <CAADnVQJAa1SREsqz9LY+-1OnbazWC-=O=TPuq-VEWkzp1ckH1Q@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 5:50=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> + Edward
>
> On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi Andrei,
> >
> > looks like the refactoring of stack access introduced a bug.
> > See the reproducer below.
> > positive offsets are not caught by check_stack_access_within_bounds().
>
> check_stack_access_within_bounds() tries to catch positive offsets;
> It does: [1]
>
> err =3D check_stack_slot_within_bounds(env, min_off, state, type);
> if (!err && max_off > 0)
>   err =3D -EINVAL; /* out of stack access into non-negative offsets */
>
> Notice the max_off > 0 in there.
> And we have various tests that seem to check that positive offsets are
> rejected. Do you know what the bug is?
> I'm thinking maybe there's some overflow going on, except that UBSAN
> reported an index of -1 as being the problem.
>
> Edward, I see that you've been tickling the robot trying to narrow the is=
sue;
> perhaps you've figured it out?
>
> If the bug is not immediately apparent to anyone, I would really apprecia=
te a
> bit of tutoring around how to reproduce and get verifier logs.

The repro is right there in the email I forwarded:

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c3871118000=
0

