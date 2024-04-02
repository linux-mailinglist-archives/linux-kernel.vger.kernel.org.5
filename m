Return-Path: <linux-kernel+bounces-127874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666D895219
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C301C21A08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336C1657A7;
	Tue,  2 Apr 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKXZCc0t"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10412032C;
	Tue,  2 Apr 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058196; cv=none; b=CJC9H1adWXjWmw5rkyxmH/C72/lLY3uGh+PVm1m6hfHNm5uyyxunB3jb4QofOT2m7hBrj/7Jua7pmG1s4YCOEj+6xdOWQVcANSelLU04rCq7TnGnlMjtSPi9U+pjdOZJeU3ZzA7Iz02euuF5/FsuI64dwp3FAtXzStkdJQcJLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058196; c=relaxed/simple;
	bh=wfh9sdADz/bkMRKMGA3whYn+hr88GJ3D+Zq/YxNJhsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyufxuymcf3wU+agYEV78iXxwOBD8WsObFb+pe7oMGMJocaf6g5knoJEcJUn8E7UAy1iEit+i1zQmcUdNAc4bfISLN8hJh/Xe9tB/vYY79bmBVyQmBUGm6K8cN2ipIKX8qsr903fIoe4FFhmHK8mbm/WmGgumeUWXkvt8jCA8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKXZCc0t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d80baf621eso31992451fa.1;
        Tue, 02 Apr 2024 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712058193; x=1712662993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfh9sdADz/bkMRKMGA3whYn+hr88GJ3D+Zq/YxNJhsk=;
        b=hKXZCc0tQNtMYBw2U6B3BDHsI8YoIv8aGK4TYW+2P6AarNaWssprfB5FMggn+6XhCQ
         5H6cOxVZTy3th16LG/vH9y3My61ol1xt2o4UCEiyr+luHOxGvgAINst33VkGIXn6CuCc
         rLbWThQGTWqFpYM68SSLvOKC4ZT7RSAX/jLitd7Thin0NLLuKA2BNhnejme7on4W//6b
         JhrbtZf56L48ygv5cTZ8t4AX6iBLGeP2Ky+lhDIoSMnoasoTCwkvm+4JKWkdF/xE9Zdu
         t1SqVT2jBRbemPFh9+ZF4l2II8TMaIP8zJUZX1AfdDulVl1gpO8GqSZM5JJ6b+dP9Vb5
         qc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712058193; x=1712662993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfh9sdADz/bkMRKMGA3whYn+hr88GJ3D+Zq/YxNJhsk=;
        b=kHGMUcclIqxaf6A+DSW3MrG6/LrVOPApiAP6noOJpZhuOnh462lt/uvzBRa7h2XV+L
         3dkOSGE9st1wPKa6ORFaG2JmCu46QwJR+vcl2uitrSRjuUsLvPDQs2p0cC21jctUJlHH
         ZDCngLR8/z3r1ZaUN+dLzVvoHR1z/81ZFT7mJ07DqWEsyPyPgrMUR0F3FaiuQVcHztur
         Cp1UwGKI63cRY0aDiMkIF7aqvu9Dwkq0mo+B4ljea16Dd4PVp5C3gxMV7C+QDfidy4H7
         tj1juUBy7BPL7zvDTTqmVdimdvphqqu+kXZd5kyv7d7BLdgxkO5V5wEk04+mYaOPr5rX
         VXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxtNDeKGZU7K06TzZl8/WzV5gBWDi/AeBLA6UC76BvxIQ1AJAaZ3NvYXJkSnp07EpxhRFXCLDjC53cWpwdLxlJd7ivgbBx/TrpuvoykZvlxzCMvW3YcCGUVv9O41XuuhISNyJiWkFB5jgJ
X-Gm-Message-State: AOJu0YyGh+KbTJ0aCBGUZgtZKWYx3ryalIgf6HUzTpBjbuIyX9+DlTWs
	Eq+SvOv2sLf5BwYv0gyBU0SoQDN1J6D10IohzgUTs4ol0ie1aUYr6vk12NVEtRNdAM5Jb5k7NKP
	JeFFuYoNxEEzVTOPjP0zsBgqyX+c=
X-Google-Smtp-Source: AGHT+IHMiuP3xigqbDcdZMSkqQncGuzQsCB3N3dWLYh/ZbqrYdtCqXXL5aPE//+dkVXzg2TC0TA5QtrXngsIwZkdIH8=
X-Received: by 2002:a2e:7a13:0:b0:2d4:2958:6daf with SMTP id
 v19-20020a2e7a13000000b002d429586dafmr7478985ljc.20.1712058192551; Tue, 02
 Apr 2024 04:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx> <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx> <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx> <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
 <87bk7ux4e9.ffs@tglx> <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
 <878r2ywk3k.ffs@tglx>
In-Reply-To: <878r2ywk3k.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 2 Apr 2024 13:43:00 +0200
Message-ID: <CAFULd4YG21NdF_qNVBGDtXO6xnaYFeRPvKicB=gpgUUqYE=4jw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:07=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Mar 04 2024 at 06:42, Uros Bizjak wrote:
>
> > On Mon, Mar 4, 2024 at 12:49=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> On Sun, Mar 03 2024 at 21:24, Uros Bizjak wrote:
> >> > On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.co=
m> wrote:
> >> >> On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> >> >> > That's so sad because it would provide us compiler based __percpu
> >> >> > validation.
> >> >>
> >> >> Unfortunately, the c compiler can't strip qualifiers, so typeof() i=
s
> >> >> of limited use also when const and volatile qualifiers are used.
> >> >> Perhaps some extension could be introduced to c standard to provide=
 an
> >> >> unqualified type, e.g. typeof_unqual().
> >> >
> >> > Oh, there is one in C23 [1].
> >>
> >> Yes. I found it right after ranting.
> >>
> >> gcc >=3D 14 and clang >=3D 16 have support for it of course only when =
adding
> >> -std=3Dc2x to the command line.
> >>
> >> Sigh. The name space qualifiers are non standard and then the thing
> >> which makes them more useful is hidden behind a standard.
> >
> > With GCC, you can use __typeof_unqual__ (please note underscores)
> > without -std=3Dc2x [1]:
> >
> > "... Alternate spelling __typeof_unqual__ is available in all C modes
> > and provides non-atomic unqualified version of what __typeof__
> > operator returns..."
> >
> > Please also see the example in my last post. It can be compiled without=
 -std=3D...
>
> With gcc >=3D 14. Not so with clang...

Please note that clang-17.0.6 currently fails to compile kernel with
named address spaces [1]. So perhaps kernel can use __typeof_unqual__
(available without -std=3Dc2x) in the hope that clang implements
__typeof_unqual__ in one of its next releases, following the examples
of GCC [2] and MSVC[3].

[1] https://lore.kernel.org/lkml/20240320173758.GA3017166@dev-arch.thelio-3=
990X/
[2] https://gcc.gnu.org/onlinedocs/gcc/Typeof.html
[3] https://learn.microsoft.com/en-us/cpp/c-language/typeof-unqual-c?view=
=3Dmsvc-170

Uros.

