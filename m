Return-Path: <linux-kernel+bounces-99493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF25878927
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EAB21621
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36556773;
	Mon, 11 Mar 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="i/a+gg+O"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DB56766
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186992; cv=none; b=gDvQBzFvqC7WvKTWiAUPNSb/AmF03kioLubOGooXkOhAGsaPItL04vWK/QD+/OhahtNlqw5qqWdJhwIcNZi2mJdkcQWKRSwchfXCEe6Mrhv0kTUb7zdmYYssnm6dzoG8fPahbzgmgaMCRyhUtS8R99oLcM0UszmKy5GPTln73Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186992; c=relaxed/simple;
	bh=YRFm8guDoMid/mxSvNcM8QjAPDxTDyzD3pj5oMVoDeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBZz1rcapGs3ub0Dbww0c6SUbkEbdRwc5uk6LJAoHJ9uCxrpugsnVkc4jJSu+8lTGtmaWRgiyNsLAjLiDCNISPm+4zIuVlc7cSJFoJJdt4LOrieAlB73CjkAaa8vrQ+1CpzDNdoGjhlNCOEZeFG28HfOgdrfYyHAzhtZ127yO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=i/a+gg+O; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so3690984b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710186990; x=1710791790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmgJJqXMrdbM+pt+OzFLOUDYx+oBh9Zqe5YEPFFSayY=;
        b=i/a+gg+OIDBxxKf9532q3ISo78KqjGNn/4YcKkWv2aiqzyGvcBIrfFb2kp3RuNTNFa
         NFt6zCZFNlXDjOc8SeUmGRwWybOr0Uog35TJ478Awn/QIKEZOA4cYHQpZu5MvUJKbZCT
         YrAL3DTlKpeP05AtGQMopkdWpfaWQZtgh+gl0aanUXFtaDJ9fsf3cJT3cjw7jUAwbw2V
         rO+uoxOw/ZRsH5SpC7DvpuY+b/x4bUaOsBKlRuIsy1djX5YM0xioDiydlbfteAE+0MGH
         SE4yzBZi262WRPmc+bRy+YJnjjtZplSbaab1lB5y6sIr66t2hxDj2+jHGT8XxnA0vkWP
         pEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186990; x=1710791790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmgJJqXMrdbM+pt+OzFLOUDYx+oBh9Zqe5YEPFFSayY=;
        b=AI8DQn2DwrlBuYTpdHATngH4S8t9bvWpZxMWxnwI42Fo7Bspu4wCYkOIHVFO1VEhDo
         ODQphZLJ64IKuWCy9vfhPJk46WecMlRFE2EFCyB6IsjFNRAI+Wxg2eQEvsL36Ls5vxWp
         qAUMS74qMprDQ643HoN6cucUVO97x6GhRJ+8QAXCXobtYR2uxPGxWq4qftf5y/IHFW3+
         u32w4CPXSMJXg8oyiUzBI6+Wtbf+ZKKDqCGYrUR8Dky/HmkM2ezSOxMfsO60caZald/8
         wyC8lyNmYSCarEsatdMlITAfeJ9dVY/bXCe3/b17bymdTImyQYk9rUd881DOH0aSQA1u
         xsfA==
X-Gm-Message-State: AOJu0Yz4TPEJq58OwPh//2N2kuDkpJxkDWHW0wjF4/EBfROSDAuf73kD
	vcrKY5F5mbFlE7ywP1o4Ky9qpV3ULqCWKG1eg+TXuw3QwEOaQ5bENR1SbiTl42QtmSrZAXyoOIt
	eHYQWfTeB/0FpRi6URHpISJ+w8q+7t30CsHiVQA==
X-Google-Smtp-Source: AGHT+IHjdxiMoOTXgmWwHh/swBSwcy+2TOMCnw5OaLYqo+ev86zJ92hBDhWjZOUT7N2vQygfOUpljF32Ly5gE+32DWk=
X-Received: by 2002:a05:6358:2909:b0:17b:ed9a:3b00 with SMTP id
 y9-20020a056358290900b0017bed9a3b00mr9019502rwb.14.1710186990234; Mon, 11 Mar
 2024 12:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-11-pasha.tatashin@soleen.com> <4f77c04b-5fe3-4618-aaaf-7bcc6058591e@infradead.org>
In-Reply-To: <4f77c04b-5fe3-4618-aaaf-7bcc6058591e@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 15:55:53 -0400
Message-ID: <CA+CK2bByuY2ADbar9s_kph_meaDdVSDh5YtXFZJKaoH506Y8hA@mail.gmail.com>
Subject: Re: [RFC 10/14] fork: Dynamic Kernel Stacks
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:32=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> just typos etc.
>
> On 3/11/24 09:46, Pasha Tatashin wrote:
> > The core implementation of dynamic kernel stacks.
> >
>
> ...
>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/Kconfig                     |  34 +++++
> >  include/linux/sched.h            |   2 +-
> >  include/linux/sched/task_stack.h |  41 +++++-
> >  kernel/fork.c                    | 239 +++++++++++++++++++++++++++++++
> >  kernel/sched/core.c              |   1 +
> >  5 files changed, 315 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index a5af0edd3eb8..da3df347b069 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1241,6 +1241,40 @@ config VMAP_STACK
> >         backing virtual mappings with real shadow memory, and KASAN_VMA=
LLOC
> >         must be enabled.
> >
> > +config HAVE_ARCH_DYNAMIC_STACK
> > +     def_bool n
> > +     help
> > +       An arch should select this symbol if it can support kernel stac=
ks
> > +       dynamic growth.
> > +
> > +       - Arch must have support for HAVE_ARCH_VMAP_STACK, in order to =
handle
> > +         stack related page faults
>
>             stack-related
>
> > +
> > +       - Arch must be able to faults from interrupt context.
>
>                                  fault
>
> > +       - Arch must allows the kernel to handle stack faults gracefully=
, even
>
>                       allow
>
> > +         during interrupt handling.
> > +
> > +       - Exceptions such as no pages available should be handled the s=
ame
>
>                                                             handled in th=
e same
>
> > +         in the consitent and predictable way. I.e. the exception shou=
ld be
>
>             consistent
>
> > +         handled the same as when stack overflow occurs when guard pag=
es are
> > +         touched with extra information about the allocation error.
> > +
> > +config DYNAMIC_STACK
> > +     default y
> > +     bool "Dynamically grow kernel stacks"
> > +     depends on THREAD_INFO_IN_TASK
> > +     depends on HAVE_ARCH_DYNAMIC_STACK
> > +     depends on VMAP_STACK
> > +     depends on !KASAN
> > +     depends on !DEBUG_STACK_USAGE
> > +     depends on !STACK_GROWSUP
> > +     help
> > +       Dynamic kernel stacks allow to save memory on machines with a l=
ot of
> > +       threads by starting with small stacks, and grow them only when =
needed.
> > +       On workloads where most of the stack depth do not reach over on=
e page
>
>                                                      does
>
> > +       the memory saving can be subsentantial. The feature requires vi=
rtually
>
>                                    substantial.
>
> > +       mapped kernel stacks in order to handle page faults.
> > +
> >  config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >       def_bool n
> >       help
>
>
>
> > +/*
> > + * This flag is used to pass information from fault handler to refill =
about
> > + * which pages were allocated, and should be charged to memcg.
> > + */
> > +#define DYNAMIC_STACK_PAGE_AQUIRED_FLAG      0x1
>
>                               ACQUIRED
> please

Thank you Randy, I will address your comments in my next revision.

Pasha

>
>
>
> --
> #Randy

