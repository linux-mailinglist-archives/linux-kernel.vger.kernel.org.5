Return-Path: <linux-kernel+bounces-109314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A288177F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F7A1F22B04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCCE8563A;
	Wed, 20 Mar 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD8kXSbR"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B86A010;
	Wed, 20 Mar 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960530; cv=none; b=Mp+kS9aqUt1qZUi9Y5FSk4MBFKRaYBNq4RveJs6NE0GqEpmg/jQdp3aM6ZeHWA2c5uPROVysy1a8v0WcZpEPJn2Fr3KYdDNj1trUo6YPsnDs+hG/KHpI49zXCkdiVOEiZ6uhpDRphjODqimSiyTtsyDuWJgKIJyE9JVeqJ2uB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960530; c=relaxed/simple;
	bh=tFJOpb0JvoYIf7/Tb9EQ8IlbJJno9k0nno8TrWoX04Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oat1Rq/3kuXM8zxhVcXb+/E0ZNh1oBK27EkkXSTxqEFbgYoKiA1ZUunKU/vtGmyERs5oveZHCDQ9Y7jRQg0wqqYJtkhI1EzEhtq6EY+K9JXv4/POY18fX//jUE7L0sqqwmzss9bkut43AkAEQA8WirXpxe0AuHrmdqTb/U6ZOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD8kXSbR; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4739b6ddc94so16549137.0;
        Wed, 20 Mar 2024 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710960528; x=1711565328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3kc8hzKgebH+x6vGwYL+8FHBw8RQ3nELQdeZk5vZEA=;
        b=MD8kXSbRL7KfUEPUqYik4hN498aH7h6N4z7V6TNXQg1KFzu1qDT7VEm5lIW8WpD+LB
         lPzdFWGsY/43kzmgZAkGu3GISR06lqVDhNjBANSQXvF3NAyfv9ph7vFiIhqdcZtShM98
         XXLhmEuGEoKufOascVK8SrwgxX/6CiMAEKmtjgdrPh5+tErvPIBlsZ5gEtLVm1FS4x53
         uQl7VF6Z/u9sASLUIhGyCPMyYzrG7OwIccWKmYhnv4pnHBxot66RPnTyth8uoOgt1e7q
         fXGgRW+h2AlHjevjfnteIDRElJGmXEGBZsfMA8GDZXV4Tnb7HHtgPjednxyNGUdDvfG1
         mm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960528; x=1711565328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3kc8hzKgebH+x6vGwYL+8FHBw8RQ3nELQdeZk5vZEA=;
        b=YoLSuZjb3BInM4yva/i0Lju4EdT8uJLVtr/9Rug3hvi6/LJAIga0H/s/2IcTo+nwAk
         1BhxFTDwMTN5KtuvnbbAxHRNbxq7FvnoV7XjOBWWDwGg9cvatHEAKiva3DQmAuR94chI
         jtMKdI+A7FBxrBBq5btkYzWePbGfBTVAQCExAzwqhsRmA+8PQKX90jHVmmVGGZ47B7Vg
         dIFbK219z59H4ay0/wiGDCnQzQIC77npx/2sY3COkEtIW7YB3WoBiGjRnscHpEuusJVI
         4xL6zq5Cvkb5ZeNALxqzpDs4lISlWQsilcbRfrULzdOmEbVEsQa0QvWhdde4Q0EMmYr+
         dqWA==
X-Forwarded-Encrypted: i=1; AJvYcCUELNLuzLYaBAdbTx/5VZUcEVjw30dboEnR1E7i+SWOd2ihA2sxGEQHLjyP07zY9VXsRkH6fzJBRykPJdiR1IIv/ZBaDKSRxmRrzVnRbblAVHkfC86igo0CocnrHfZPQLxN2+hAdzu+Z/cYAco8mco/2a/ydR6QiKxHb5rMi1zWXgze
X-Gm-Message-State: AOJu0YzWNQWZOC8ECVSRoKNRG3ktf0qoFOrdpBI15b08MtCrlX4g1g0j
	Wuw5TRXi2tIJqm2mFANQF8Db/Cxuqb/pPFhX1Gnifr6upYdTD22fcm2h3oypQNwytVV7zSOqhCD
	iCE3oVwPOSqMlxtk1qxOoqH10VutZqBw+bpw=
X-Google-Smtp-Source: AGHT+IHHMBzJxvqxFSVFgSTPKSJn7ba2A2kXEEjNVmqdH0a0PCDskoseFwovKGJtH7rif3zQaet5AETl1OVj1yNlRL4=
X-Received: by 2002:a05:6102:4c10:b0:476:76d8:49b with SMTP id
 jy16-20020a0561024c1000b0047676d8049bmr9593457vsb.11.1710960527098; Wed, 20
 Mar 2024 11:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320001656.10075-1-21cnbao@gmail.com> <20240320124207.0c127947@canb.auug.org.au>
 <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com> <20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
In-Reply-To: <20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 07:48:36 +1300
Message-ID: <CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chris Zankel <chris@zankel.net>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:49=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 20 Mar 2024 16:24:30 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > Hi Stephen,
> > Thanks for reviewing.
> >
> > On Wed, Mar 20, 2024 at 2:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
org.au> wrote:
> > >
> > > Hi Barry,
> > >
> > > On Wed, 20 Mar 2024 13:16:56 +1300 Barry Song <21cnbao@gmail.com> wro=
te:
> > > >
> > > > diff --git a/Documentation/process/coding-style.rst b/Documentation=
/process/coding-style.rst
> > > > index 9c7cf7347394..8065747fddff 100644
> > > > --- a/Documentation/process/coding-style.rst
> > > > +++ b/Documentation/process/coding-style.rst
> > > > @@ -827,6 +827,13 @@ Macros with multiple statements should be encl=
osed in a do - while block:
> > > >                               do_this(b, c);          \
> > > >               } while (0)
> > > >
> > > > +Function-like macros should evaluate their parameters, for unused =
parameters,
> > > > +cast them to void:
> > > > +
> > > > +.. code-block:: c
> > > > +
> > > > +     #define macrofun(a) do { (void) (a); } while (0)
> > > > +
> > >
> > > Maybe add some comment about using a static inline function for these
> > > simple versions instead, if at all possible, (it is suggested just
> > > above this section) since that will still type check arguments.
> >
> > right, what about adding the below section together with the above (voi=
d) cast?
> >
> > +Another approach could involve utilizing a static inline function to r=
eplace
> > +the macro.:
> > +
> > +.. code-block:: c
> > +
> > +       static inline void fun(struct foo *foo)
> > +       {
> > +       }
> > +
>
> Stronger than that please.  Just tell people not to use macros in such
> situations.  Always code it in C.

While I appreciate the consistency of always using "static inline"
instead of macros,
I've noticed numerous instances of (void) macros throughout the kernel.

arch/arm64/include/asm/cpuidle.h:#define arm_cpuidle_save_irq_context(c) (v=
oid)c
arch/arm64/include/asm/cpuidle.h:#define
arm_cpuidle_restore_irq_context(c) (void)c
arch/loongarch/include/asm/io.h:#define iounmap(addr) ((void)(addr))
arch/mips/include/asm/cop2.h:#define cop2_save(r) do { (void)(r); } while (=
0)
arch/mips/include/asm/cop2.h:#define cop2_restore(r) do { (void)(r); } whil=
e (0)
arch/mips/include/asm/cop2.h:#define cop2_save(r) do { (void)(r); } while (=
0)
arch/mips/include/asm/cop2.h:#define cop2_restore(r) do { (void)(r); } whil=
e (0)
...

I'm uncertain whether people would find it disconcerting if they completely
deviate from the current approach.

If you believe it won't pose an issue, I can proceed with v3 to eliminate
the first option, casting to (void).

Thanks
Barry

