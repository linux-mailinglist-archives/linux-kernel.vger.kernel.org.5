Return-Path: <linux-kernel+bounces-112557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E048887B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107241C20B57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802A4439;
	Sun, 24 Mar 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9dM9ETP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DD19E;
	Sun, 24 Mar 2024 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711248925; cv=none; b=pTmh0jy4ALUgFbZ9IvPioXMyTsHRoowIvTrgzv1Ehpq/lcLaK4Gm2R9AYXU5vLzqVMoH+ZgvKuLS0TA76l+LtJwfmaGPW47m4dBPbNMuD7wWSqt2/3e5TAD8lETy5kraLTh9YTmzN7via52qmM4yjH2KHTzjxv7QcPwNLHk36OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711248925; c=relaxed/simple;
	bh=Ylqipv0aylv4Kc246MypnpDjmK5L3+lEli5iv4IS/ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y47LrwBc9aJczqhmVtWz4NoyQy3iNUHItA8ks+u/6FBNnAum0g4JF95fHtKmHQ7Y71XMIdEy301dCBQb/Lx3hK8exF9gMzdLQGj3eknGcwGjDg1lGAlPJaULPXIp4zSp0sKGTZ4RGGczVg+LdOuIa3tIGLYZiuxeMq02Kd85hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9dM9ETP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso2296480f8f.2;
        Sat, 23 Mar 2024 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711248922; x=1711853722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehPPaGZ2VlG11XjWw/8qFi0hbIsIzlYM6U19gWcBRU8=;
        b=U9dM9ETPAJ2ewA+VrA7KjLTFdEKTBQRP6MlI1K4uI90mLiNvEeCATFqWrDcPqwOBqC
         HqmqE1HIToXpEjRZMMp1IiJUUMJ7pK7uxvhH1MYJKoDvrBuTFs3dgVuy1AVczF6A1hpb
         XzNcaUoW2G6LWbe2OJmE0a38LqhBqWA1ySg9bc4DfcbMnV2z8iSD4YoUkdIoZL5+MSUu
         lG5ZQonsHfA18rHak91tXsxIu3rDQRZMzs9KWui3pvAaCPHYMNRjWdKOpYL49Tz0TRkz
         H9lrrtZA3GE+3cNhlthOpLpJjbnWGumF/4NSTWxtQv+FzVt11AeycPe0Z06fDNlmJjtg
         CG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711248922; x=1711853722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehPPaGZ2VlG11XjWw/8qFi0hbIsIzlYM6U19gWcBRU8=;
        b=Dz0BPvP41aK2a2QqlzX9jmCP1tSfqsvuzDwEaBbFjykxHAqXwV9zt3Gw0g/CvGLQ6u
         cGeFqj7uVeUQlB7wzDO8u1gGaiiX3ydBed/KKNi9p1Cf5GgeU/EotL9++8Sal0dLfhpF
         vzeDsQ6Mb8cT7kiz4ykyRku/QIilf7IqUDZe7u00jcsb2kmEZxFyCVg84kx0m7+T1URV
         PLLQ/a8HJ1e4IwuA+JLs+wdYvim2ANfFBoueUPrUtvpkfe2LYIyWQhsWLE8vD7+Kd5Oi
         Uy52HzJwRntrwTw8hoiCMXgjlSZS0DK8nvTWs77tR/Y82p50YowncqKwh9xEaIroOWNM
         4uvA==
X-Forwarded-Encrypted: i=1; AJvYcCUSvpshDXwQTvr2n486xH9sitTuPcuMDDlWH0j6LtMIg0mIrI5ccuPqX3DPteDD535W5waBR4NWOpFWNWN0SqKrMuMSfnjmvLE3RkBeH5YJ4yQEwaOtI1OFLX7hXl9ClVg/pH9YOmF7FDETzutzJFRZpjlqivqxx0QY
X-Gm-Message-State: AOJu0YwstX9wgfZM07yWWSyZ+w1PGx/ZEOUMFQRtyzGiBQ8/FIVIT6iC
	edPMKER/QWYbce9BUaZn+DoGuY8Soo4KjxCglYpM+JwKOUUoX7cdfNPqy42SJlKH2T+eT+Wu6F9
	vLv0l21NAv/Hr54fnJokaJspMEIc=
X-Google-Smtp-Source: AGHT+IGGUPfaF6Yz+LwVSV0pqbrXQCEjpSjVEw5XWStzRVz0IeFdF/+6OiU9nEzC9KY5LAws1LhgupWfofVKj3ihH3I=
X-Received: by 2002:a05:6000:244:b0:341:bffe:e5b8 with SMTP id
 m4-20020a056000024400b00341bffee5b8mr2100555wrz.27.1711248921760; Sat, 23 Mar
 2024 19:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
 <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com>
 <CAADnVQJAa1SREsqz9LY+-1OnbazWC-=O=TPuq-VEWkzp1ckH1Q@mail.gmail.com> <CABWLseuLmAys-YuyFVeug+XR0_xjZROvgRTXz3U6cNiT+pBX0g@mail.gmail.com>
In-Reply-To: <CABWLseuLmAys-YuyFVeug+XR0_xjZROvgRTXz3U6cNiT+pBX0g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 19:55:10 -0700
Message-ID: <CAADnVQ+oqe6EtC8rc9TSFeUPE1Rbf11Oi-CfTyDxfXT9qM0Vpg@mail.gmail.com>
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

On Sat, Mar 23, 2024 at 7:12=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> On Sat, Mar 23, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Mar 23, 2024 at 5:50=E2=80=AFPM Andrei Matei <andreimatei1@gmai=
l.com> wrote:
> > >
> > > + Edward
> > >
> > > On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > Hi Andrei,
> > > >
> > > > looks like the refactoring of stack access introduced a bug.
> > > > See the reproducer below.
> > > > positive offsets are not caught by check_stack_access_within_bounds=
().
> > >
> > > check_stack_access_within_bounds() tries to catch positive offsets;
> > > It does: [1]
> > >
> > > err =3D check_stack_slot_within_bounds(env, min_off, state, type);
> > > if (!err && max_off > 0)
> > >   err =3D -EINVAL; /* out of stack access into non-negative offsets *=
/
> > >
> > > Notice the max_off > 0 in there.
> > > And we have various tests that seem to check that positive offsets ar=
e
> > > rejected. Do you know what the bug is?
> > > I'm thinking maybe there's some overflow going on, except that UBSAN
> > > reported an index of -1 as being the problem.
> > >
> > > Edward, I see that you've been tickling the robot trying to narrow th=
e issue;
> > > perhaps you've figured it out?
> > >
> > > If the bug is not immediately apparent to anyone, I would really appr=
eciate a
> > > bit of tutoring around how to reproduce and get verifier logs.
> >
> > The repro is right there in the email I forwarded:
> >
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c387111=
80000
>
> I understand, but how does one go from this to either BPF assembly,
> or to running it in such a way that you also get verifier logs?

Adding logs to repro.c is too hard, but you can
hack the kernel with printk-s.

Like the following:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..d158b83ed16c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7179,6 +7179,7 @@ static int check_stack_range_initialized(
                        return -EFAULT;
                }

+               printk("slot %d %d spi %d\n", slot, slot % BPF_REG_SIZE, sp=
i);
                stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE]=
;


shows that spi and slot get negative: -1, -2, ...

