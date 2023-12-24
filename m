Return-Path: <linux-kernel+bounces-10619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EF81D77C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0C41C20E86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC3814;
	Sun, 24 Dec 2023 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T15Ae/+A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C377EA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F120BC433CA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703381055;
	bh=/H0+iF+fDn9DTrAW4o9tox8uhqnr94eocMPWRFJRU0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T15Ae/+AuOnYFc6GQj3tfN5c8UaAV7WLR512HkGl/SPDPgxKE73XQJoiFRNmkquuW
	 YpUcorvbZh4FeJFfxveoQFJFj1WUaJaAA/Fxk0fNm6lVvaoJDq7pcHcCG2IK7nswf+
	 2RS6/02jRB1AkQq9UBlwjd1iIMIrs3vb/6MaJzMVVCaC/aUmDohu0+8y99KtQdZzaU
	 G6sTCb6MWYl6kPN3brqRrdObKMSxRZGW7CwKQxCH1zzP8C1AHSMj7ZUIQGhS0p9gxB
	 AFJoiC6k79mkDLhR+M2YZPq0MziKmGoLk8uKhIQPTvZLJBkX2qH80/rmEjnx+iw5r2
	 f9i/yk960zRFg==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d4d70eca6so14558835e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 17:24:14 -0800 (PST)
X-Gm-Message-State: AOJu0YwIuenJUbENB8NXK8lYvsaJkYXIEwHTMo66xeiL/vcTOllb51u7
	gLsfCb2reFbRwYstzKNpDFyKsCbPwkAce2rwCqU=
X-Google-Smtp-Source: AGHT+IFV03RN5WCJzhq8Igd5aRzeZ4KAuFjP6kgdpuUrRLl5b1fqLLswglB+c7zzEB8AJXSmZi03yHMQG3vLjaAlLrs=
X-Received: by 2002:a05:600c:748:b0:40c:35fd:be08 with SMTP id
 j8-20020a05600c074800b0040c35fdbe08mr1371260wmn.122.1703381053321; Sat, 23
 Dec 2023 17:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-5-guoren@kernel.org>
 <ZYUZ8QUJxCL93Fgv@LeoBras> <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
 <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com> <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
 <9d4d15e8e3e944b8bd18e8bc1d54f59c@AcuMS.aculab.com>
In-Reply-To: <9d4d15e8e3e944b8bd18e8bc1d54f59c@AcuMS.aculab.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 24 Dec 2023 09:24:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjixePmc8qNJZB+kfyzjVb+NqFHR6GOow-aNhN883CQA@mail.gmail.com>
Message-ID: <CAJF2gTQjixePmc8qNJZB+kfyzjVb+NqFHR6GOow-aNhN883CQA@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
To: David Laight <David.Laight@aculab.com>
Cc: Leonardo Bras <leobras@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "charlie@rivosinc.com" <charlie@rivosinc.com>, 
	"xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "david@redhat.com" <david@redhat.com>, 
	"panqinglin2020@iscas.ac.cn" <panqinglin2020@iscas.ac.cn>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, 
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 6:31=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Guo Ren
> > Sent: 23 December 2023 02:53
> >
> > On Fri, Dec 22, 2023 at 7:52=E2=80=AFPM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Guo Ren
> > > > Sent: 22 December 2023 11:25
> > > ...
> > > > > > +#define TASK_SIZE    (is_compat_task() ? \
> > > > > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > > > I would remove is_compat_task() in the next version because your pa=
tch
> > > > contains that.
> > >
> > > Does TASK_SIZE get used in access_ok() ?
> > > If so the repeated expansion of that 'mess' will slow things down.
> > >
> > > OTOH access_ok(ptr, len) can just check (ptr | (ptr + len)) < 0)
> > > and rely on the page faults for everything else.
> > Or do you want to discuss the bad side effect of is_compat_task()?
> >
> > Yes, test_thread_flag(TIF_32BIT) would slow down access_ok(). But if
> > we use TASK_SIZE_MAX, VA_BITS still needs pgtable_l5_enabled,
> > pgtable_l4_enabled detectation for riscv.
> >
> > It's not only for compat mode, but also Sv39, Sv48, Sv57. All treat
> > TASK_SIZE_MAX as 0x8000000000000000, right? Then:
> > access_ok(ptr, len) can just check (ptr | (ptr + len)) < 0)
> >
> > It's another feature and does not relate to compat mode.
>
> Compat mode just makes it worse...
It's hard to observe.

>
> One possibility would be to save the task's max user address
> in the task structure itself - that would save all the conditionals
> at a cost of an extra value in the task structure.
It would still cause memory load operation, although it is $tp->xxx.
If we want to gain observability benefits, "just check (ptr | (ptr +
len)) < 0)" is better.

>
> There is also the question of whether a normally 64-bit task
> can actually make the compat mmap() system call?
No.

> On x86 that is certainly possible (IIRC wine does it), x86
> userspace can flip between 32bit and 63bit mode without a
> system call.
RISC-V can't do that because it needs sstatux.uxl=3D32/64, which can
only be modified in S-mode.


>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Best Regards
 Guo Ren

