Return-Path: <linux-kernel+bounces-112548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04D887B63
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D8D1C20FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184DC33F7;
	Sun, 24 Mar 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItqIjY5L"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08B81E;
	Sun, 24 Mar 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246359; cv=none; b=EtjMgwHCs/jcnizINBnu+N93g6QAvCaoiKWOSAioyHZ0SzmJtmUqH4OGwFS4KAxshyqtiPM03Dic8sHACKGpRoRj4cvPmcHzv+LJ1o2Ziew7q72B+BrOqkhBmcCqa8pRs0Y44PXgByz1Pmv8KNP8XbJmtN5IMKPGBxN5D/w2rz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246359; c=relaxed/simple;
	bh=ovHUKz8Xzqtw0vfM9uEg01DKZBo+9/U+IEf7Cmmf4X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGTHHKGyKXdcd+HmlcrblBmjMAGwfyOp0zdJSQwE8iyCjElXeZkGQkPixs1J4axOZQMw/ealQs0DhzpkkguNP6MWzkeQGy0AQeE+ZvH/YF5PHM4KDUk3u2NFOdDuz5H9wD7ETc0C808r1+nWUH0Ky9BGIAY3tOnIWS2JrMZCf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItqIjY5L; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bc753f58eso3991841a12.3;
        Sat, 23 Mar 2024 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711246356; x=1711851156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHFyLHQgXPjbo6X2x+pg5cZRKKgfaicsQUJCH3BgxQg=;
        b=ItqIjY5L9G4l/EolYckTAegP2/t89zzCBmoZYS2JG2KPkFKTFXRF6gvUG1NPdCOrM0
         hevpKSPYg3En4sF6/YtVrpG9UtorMa7ub8sbE/HDC7fuuVYRugSr4HfFsOqHyhpKB922
         U4XgmbQGLDKR5+//BIyuQNcDWcxWxa2ul+D47Mua1mlU6vnQg2GRhUGqjkkn87Garm50
         PrWUO5qR62MtP7p6ZLZoex/SCIpo0sPOidsD0ETFB1CsNSHrL/wgP1idNLsclzn09GOB
         MksMY7kk7j6klxs7W3/zmDXyo3WcI7qezvGwvVchcZFskxKzPdcDv9hc0eq3gkB06Qoq
         HZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711246356; x=1711851156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHFyLHQgXPjbo6X2x+pg5cZRKKgfaicsQUJCH3BgxQg=;
        b=Xh9JSN11nGuc74Uz15ldRiU3/MPMaGy5N8GSZtPxC+o7y/hxtdy2GwTql8A+V5BplS
         3h+nlEczCHQJ2KHPknnVmKWFhkDDeN/H+4jHIi/WG8xomraY2Hr6tTNfqZHHT8oiE2zc
         GR1StWC/yRGhiKq5LqYX9E1VBNJTYmRsO+eJzT15clnRxjBhix2PL1TZmrov9Cw72NSh
         s3nyHEVYGD9OYMn+PRn+JiGaRuRC537QVIFT/8AH1r/wlNrPhAoEhM3mKVy+eVuyhX1Q
         rexoCxcD7vxj29YsQjKx/qkpCbERN/fkj5lBtHROjuUjLF9GVXGtyELr8rFt0z6zKTD6
         lQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUvRhbVe9nxlR4Iuc50vXNgQIXqBt8Ri/Ln6IO+RfGbt2pCxzHuWcrZk4ksYvV+CSWwcjgX6754gBRyifylS4twUHS8arwgpCiLOQva5qwCILGZTiX2k0rX4UBhZ5pcEhO7BPD7+Bi7LJrocBD/VsJIQUzMj0A2lyng
X-Gm-Message-State: AOJu0YwXl3E0BkURQd9xzndrwj2a8H6uVZDx6xxKVo16ZAm9sDVlkEal
	ibjDAnLHrGVhWOzcMAF1v4Q0mausLwIAQeZ+oefUuU0FYHI5wZ+4gTnlpCdv6+IFNcPIb03rEOp
	3/pU2LHj8yhgS4+BVu0qUAhK/UxI=
X-Google-Smtp-Source: AGHT+IE3n/ABSUmQrtfhds4VBheKUGJxl8W+GXZYl4WJsJsQR1l0p3vVcyqk0Xk5a+Al6NQVoeJTBbmKlDhWEPmrs30=
X-Received: by 2002:a50:ab49:0:b0:56b:ed78:f58 with SMTP id
 t9-20020a50ab49000000b0056bed780f58mr2235343edc.33.1711246355828; Sat, 23 Mar
 2024 19:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
 <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com> <CAADnVQJAa1SREsqz9LY+-1OnbazWC-=O=TPuq-VEWkzp1ckH1Q@mail.gmail.com>
In-Reply-To: <CAADnVQJAa1SREsqz9LY+-1OnbazWC-=O=TPuq-VEWkzp1ckH1Q@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sat, 23 Mar 2024 22:12:23 -0400
Message-ID: <CABWLseuLmAys-YuyFVeug+XR0_xjZROvgRTXz3U6cNiT+pBX0g@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Sat, Mar 23, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 23, 2024 at 5:50=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > + Edward
> >
> > On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Hi Andrei,
> > >
> > > looks like the refactoring of stack access introduced a bug.
> > > See the reproducer below.
> > > positive offsets are not caught by check_stack_access_within_bounds()=
.
> >
> > check_stack_access_within_bounds() tries to catch positive offsets;
> > It does: [1]
> >
> > err =3D check_stack_slot_within_bounds(env, min_off, state, type);
> > if (!err && max_off > 0)
> >   err =3D -EINVAL; /* out of stack access into non-negative offsets */
> >
> > Notice the max_off > 0 in there.
> > And we have various tests that seem to check that positive offsets are
> > rejected. Do you know what the bug is?
> > I'm thinking maybe there's some overflow going on, except that UBSAN
> > reported an index of -1 as being the problem.
> >
> > Edward, I see that you've been tickling the robot trying to narrow the =
issue;
> > perhaps you've figured it out?
> >
> > If the bug is not immediately apparent to anyone, I would really apprec=
iate a
> > bit of tutoring around how to reproduce and get verifier logs.
>
> The repro is right there in the email I forwarded:
>
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c38711180=
000

I understand, but how does one go from this to either BPF assembly,
or to running it in such a way that you also get verifier logs?

