Return-Path: <linux-kernel+bounces-154751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DFA8AE085
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BA6283F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CD5644F;
	Tue, 23 Apr 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0W+v8/c"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A200535DB;
	Tue, 23 Apr 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862970; cv=none; b=REsfvcocK/DF95GvH3DNJ357me03DjFE2shmGkObiOr2B7rAFDqT5JSHVTRygxSeHiIVGLGFUlM/BYtalG2KTKEdqsn7yS25tPAA7OCZs626yID+L7iM7IhqdVjwpJ0Mvq/y/N4uztaLYDLzF7vaqXqHbPqMVInmgwZ9kJSel8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862970; c=relaxed/simple;
	bh=Tf1WAE083iqElmWUjgIU3qiP70v7umc//U+zy4dFFjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjyZMdUObff9i9O5nd5dQUIXPHv1X2cSeuj12ouCAcb61wOsvwKZ2m/+3bl1R11LNCeLuEk7k4xe9mehPOjAjtJK0AvRyJ9jk1xz8aNwVwoipTj5STSQH3HRhwEN/zV1Xo0dKxqEdgj5OOnzubDTkNJ5JDUpt/DQIemvJg3eJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0W+v8/c; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ae6c8745ffso802684a91.2;
        Tue, 23 Apr 2024 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713862968; x=1714467768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXsOnG+unFLFOLCvhsKIlfWgz2bxnXfsLh7JooJSg6o=;
        b=V0W+v8/cOLxU3jH/RQyn2sz/K7z2CWF4V6XxFi+NOhXaXCYcEk7iERWbWuVoIdzQqA
         CkySKC/vvqtsVq8MJf9ieU8a1YPvmSp6A91VItbqHvTXst6KQxYdRTdg4JE52O15HJKq
         zY3Sd54/Xa+jvADHeryDXkJNZDOB5TXGf9mDHSkdWMlegmhkIA00tI/a9jZVeuw1fVrI
         MBh7R31n2F5oY5TAfFWh7eXDArFrrpN2lxdfEeQ0aI8bAw+00fpOl0f9jr0QC329PX/N
         8yYzxu36phfm+F4sUKEUQrUgn+rtbcX53aqXQOjimjF1JBAomx91AxwCudb4fcuz2Fac
         zYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713862968; x=1714467768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXsOnG+unFLFOLCvhsKIlfWgz2bxnXfsLh7JooJSg6o=;
        b=daq8BQWQxdPDr0V+jxNTs3ufQ77AnXrwKXjcL6xLg1TYivd//uLEkIUtkZo7ES20/u
         XPWp7p3VLNnJwVAADba4VG8QoeqAcNs4lcxGbVqvq6d15NUQtecqOdUTl/7Dv0LOlf8G
         4pN8ou6oJlGQ+FQngBIGlIusLRKIS+GczHpUl+ns1sZ9y0MHkUa1Q9XdIOd4zgYL4F/u
         NCH5oir8z3odEGLw27NetMSpSIic4aa45xPbCpddTn+5JxmY4hHMri9CNI36R361yVtl
         v3iH1CR6fOEke8ZEtBdeWQQVoL/YZNgp8QVIgo+LhVsBgEg9MICFCFuqy7qGmrfYXXch
         x+RA==
X-Forwarded-Encrypted: i=1; AJvYcCV1m1j5kyYDbjyRo8QaeQ87QJrwLEOVZ7B7BelF/hCs8g9V455AHYikxbbwNZ6jekkQlxbR0mAHTIJ7mkr+yLaHCenB
X-Gm-Message-State: AOJu0Yw5VzZZYUNYCbFohTTAMIlgsVrKsAW5qHXJJO5p8BGJZdVPpt+a
	DW2M1VfQAMjKMMcNVuofsZ+gkJFq4Zzc3QW1W35QHzcXQjciq1asnPqXQzo3NV5MK1vadP+MRc9
	zqtqSDGAfmU4BKBiI+7/cNC0yugo=
X-Google-Smtp-Source: AGHT+IH6xJKCgpblnzG46n84QQ0mtRzKqpyXpmK/5Twj2PbdrB/ocRSHnvU7H4hol4gFBTRZ1F+F9NHe/J6n2w/pAls=
X-Received: by 2002:a17:90a:5310:b0:2a2:97ce:24f5 with SMTP id
 x16-20020a17090a531000b002a297ce24f5mr12622248pjh.35.1713862968530; Tue, 23
 Apr 2024 02:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
 <20240328075318.83039-10-jiangshanlai@gmail.com> <ZiZEcBEvK8NOQvwU@localhost.localdomain>
In-Reply-To: <ZiZEcBEvK8NOQvwU@localhost.localdomain>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 23 Apr 2024 17:02:35 +0800
Message-ID: <CAJhGHyBMYDWbRYp86wBu3x6Ry8HM2yiZxNv_WATwhzV+OO+ZFA@mail.gmail.com>
Subject: Re: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Nadav Amit <namit@vmware.com>, 
	Breno Leitao <leitao@debian.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Frederic

Thanks for reviewing.

On Mon, Apr 22, 2024 at 7:05=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:

> > +
> > +/* We use the MSB mostly because its available */
>
> I think you can safely remove the "We " from all the comments :-)

The file is mainly copied from arch/x86/include/asm/preempt.h.
I will rephrase sentences in later iterations.

>
> > +#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED  0x80000000
>
> How about RCU_PREEMPT_UNLOCK_FASTPATH ?


I'm not good at naming. But the MSB really means exactly the opposite
of current->rcu_read_unlock_special and I think "UNLOCK_SPECIAL_INVERTED"
fits the meaning.

>
> > +
> > +/*
> > + * We use the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit as an inverted
> > + * current->rcu_read_unlock_special.s such that a decrement hitting 0
> > + * means we can and should call rcu_read_unlock_special().
> > + */
> > +#define RCU_PREEMPT_INIT     (0 + RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED)
>
> Or simply:
>
> #define RCU_PREEMPT_INIT     RCU_PREEMPT_UNLOCK_FASTPATH
>
> Or you can even remove RCU_PREEMPT_INIT and use RCU_PREEMPT_UNLOCK_FASTPA=
TH directly.

"0" means the initial rcu_preempt_count is 0 for the initial task.

> > +
> > +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> > +
> > +#endif /* __ASM_RCU_PREEMPT_H */
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> > index ba8cf5e9ce56..0b204a649442 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -1992,9 +1992,10 @@ static __init int setup_clearcpuid(char *arg)
> >  __setup("clearcpuid=3D", setup_clearcpuid);
> >
> >  DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) =3D {
> > -     .current_task   =3D &init_task,
> > -     .preempt_count  =3D INIT_PREEMPT_COUNT,
> > -     .top_of_stack   =3D TOP_OF_INIT_STACK,
> > +     .current_task           =3D &init_task,
> > +     .preempt_count          =3D INIT_PREEMPT_COUNT,
> > +     .top_of_stack           =3D TOP_OF_INIT_STACK,
> > +     .rcu_preempt_count      =3D RCU_PREEMPT_INIT,
>
> #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT ?
>
> Thanks.

Fixed in V2:
https://lore.kernel.org/lkml/20240407090558.3395-1-jiangshanlai@gmail.com/

Thanks
Lai

>
>
> >  };
> >  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
> >  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
> > --
> > 2.19.1.6.gb485710b
> >

