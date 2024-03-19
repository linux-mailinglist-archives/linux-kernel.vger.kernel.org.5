Return-Path: <linux-kernel+bounces-107839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E890688025F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DD3282D89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558AD8BFC;
	Tue, 19 Mar 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jG6gJ4Uc"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796879ED
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865978; cv=none; b=T6WnQuCxjEfvbQaO7BiN841EN1MAr1NOcD0MMDMzJmIpZmfGL3YfwcX72hjmuH1XwbV/bjArJJyRVEqt+H1DB44emOwwvppNJAho9eO/sVH1kyrI8arim/U0y+8XcB0ag6CgxRv2A2uLzwSO/nGiU++MCzdgtgA60+FMtyE6EG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865978; c=relaxed/simple;
	bh=ZnRtcWh8K1w/8xKey5YSMgQutuXCU6Sf7FK+HahS5NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5KWr93CH6UgMjxDEvy4D/OTPYPdVEofy9h/EImpasavaTO8sHqYRcGemm4OouUi3OSPaSXGc4VOt0bNBKGBwjbyseuKjFHXN8o3V2DGZLGm2eOZhmg3nNk2t6g/eplUymBXa3CbXTM08p/GYfXdDVmKFipQJoXEg1Z8mraBU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jG6gJ4Uc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430ddb1a227so9618031cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710865975; x=1711470775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzek8Gf7DG6ZMdD1Al+3PbmxtLzp1kN+e70/4S3zho0=;
        b=jG6gJ4UcU7Vt3RpPMy2tPO69t6Pw7dL76mr/GA/8SfwR/h0gE2ATe6/WXhKYQmtfQT
         EzIlEHBpyZedM2xEUel2ZeJ8/cD4Ov7BrmhuIiInDe8izYuv/Seguq90F1z76LRQxSI5
         qvX+Z4BruIsnPAkVEurumMOfzwAVCot3J00uyP0mYV4hI6p6TxfNCZbxHFJVUGaXEvIB
         x782V7J7l2JuumXMMSm4FnRcCU2wif01IbEIJ1r4itXzP4yzMv0KH+k4F5F6QXlvNrgT
         i1NJDimh8Yfy2wrh2L2hIAjXuZRq1wRIG80M0pMhUzoRvxkIY71NpIytYS3M4FkR8pK3
         eWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865975; x=1711470775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzek8Gf7DG6ZMdD1Al+3PbmxtLzp1kN+e70/4S3zho0=;
        b=rZ/Bz6JZVhV17aZQWvxVERKS83dOQn+Y3/vPS3GtM/LqAq0PNZpycLcYeKIL49cKrQ
         AWCaPj4nXA4hn39UjHErnXDWFIuPP2kkkC4MwWCyIFVmic4L5ukw/hi1sWM4U53g5a8O
         Uu+5n5q9awRZlmRZjhOShVIy0OsOTx/qkxcqoX+h4pnwq9O1N4nRNoszAZrrD7VoKoCl
         VhXciDrpYGp+ZlN/YIkISGUKYdy4j1o4t3pncdxS0Oaco1NIb7jWbkxq+xcdesVc8vxH
         TPZXGA7TIhijyOreklq0KPV5Bpg7aVkr6zPk7+lboMRTZEkqm7HAdHuj7c1/vM0Bb1Ck
         BV7g==
X-Gm-Message-State: AOJu0Yy6jWMLpuWQtm/OmZrKyfHS7jQMFMtA0otYPsYJ9xc3J7WVupoq
	qrE3CutoOqHhtcK7t0XJuGAkh1YnjG+xQMT57oxH6KSURQDrvzFtD34iC/B73vDrMvCo7Zb9J+G
	PCgb8hj1j0iqHBwCt0fwPfj3qLhVSg9FzgSUJBg==
X-Google-Smtp-Source: AGHT+IF3il8rC6AkOG+mwJ0bGCtUPSJ60cvvJqjTmASvQRVnBM9H20Un/qh1I6wqhVVsobUZyQNc5uYuSU7SYSVnows=
X-Received: by 2002:a05:622a:52:b0:430:e945:b119 with SMTP id
 y18-20020a05622a005200b00430e945b119mr2480646qtw.43.1710865975570; Tue, 19
 Mar 2024 09:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-4-pasha.tatashin@soleen.com> <1af02bc8-1b20-4508-909d-342f3b06bf78@wanadoo.fr>
In-Reply-To: <1af02bc8-1b20-4508-909d-342f3b06bf78@wanadoo.fr>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Mar 2024 12:32:18 -0400
Message-ID: <CA+CK2bB-7fUnMXcRLma60J-wFZ9Y-W45O0okU2fseuh-VxG8fA@mail.gmail.com>
Subject: Re: [RFC 03/14] fork: Clean-up naming of vm_strack/vm_struct
 variables in vmap stacks code
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:42=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 11/03/2024 =C3=A0 17:46, Pasha Tatashin a =C3=A9crit :
> > There are two data types: "struct vm_struct" and "struct vm_stack" that
> > have the same local variable names: vm_stack, or vm, or s, which makes
> > code confusing to read.
> >
> > Change the code so the naming is consisent:
>
> Nit: consistent
>
> >
> > struct vm_struct is always called vm_area
> > struct vm_stack is always called vm_stack
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   kernel/fork.c | 38 ++++++++++++++++++--------------------
> >   1 file changed, 18 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 32600bf2422a..60e812825a7a 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -192,12 +192,12 @@ struct vm_stack {
> >       struct vm_struct *stack_vm_area;
> >   };
> >
> > -static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
> > +static bool try_release_thread_stack_to_cache(struct vm_struct *vm_are=
a)
> >   {
> >       unsigned int i;
> >
> >       for (i =3D 0; i < NR_CACHED_STACKS; i++) {
> > -             if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) !=3D NUL=
L)
> > +             if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm_area) !=
=3D NULL)
> >                       continue;
> >               return true;
> >       }
> > @@ -207,11 +207,12 @@ static bool try_release_thread_stack_to_cache(str=
uct vm_struct *vm)
> >   static void thread_stack_free_rcu(struct rcu_head *rh)
> >   {
> >       struct vm_stack *vm_stack =3D container_of(rh, struct vm_stack, r=
cu);
> > +     struct vm_struct *vm_area =3D vm_stack->stack_vm_area;
> >
> >       if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
> >               return;
> >
> > -     vfree(vm_stack);
> > +     vfree(vm_area->addr);
>
> This does not look like only a renaming of a variable. Is it?
>
> If no, should there be a Fixes tag and should it be detailed in the
> commit description?

This change is only for readability purposes. vm_stack is stored in
vm_area, so vfree(vm_stack) equals to vfree(vm_area->addr), but is
hard to read. I will add it to changelog.

>
> CJ
>
> >   }
> >
> >   static void thread_stack_delayed_free(struct task_struct *tsk)
> > @@ -228,12 +229,12 @@ static int free_vm_stack_cache(unsigned int cpu)
> >       int i;
> >
> >       for (i =3D 0; i < NR_CACHED_STACKS; i++) {
> > -             struct vm_struct *vm_stack =3D cached_vm_stacks[i];
> > +             struct vm_struct *vm_area =3D cached_vm_stacks[i];
> >
> > -             if (!vm_stack)
> > +             if (!vm_area)
> >                       continue;
> >
> > -             vfree(vm_stack->addr);
> > +             vfree(vm_area->addr);
> >               cached_vm_stacks[i] =3D NULL;
> >       }
> >
> > @@ -263,32 +264,29 @@ static int memcg_charge_kernel_stack(struct vm_st=
ruct *vm)
> >
> >   static int alloc_thread_stack_node(struct task_struct *tsk, int node)
> >   {
> > -     struct vm_struct *vm;
> > +     struct vm_struct *vm_area;
> >       void *stack;
> >       int i;
> >
> >       for (i =3D 0; i < NR_CACHED_STACKS; i++) {
> > -             struct vm_struct *s;
> > -
> > -             s =3D this_cpu_xchg(cached_stacks[i], NULL);
> > -
> > -             if (!s)
> > +             vm_area =3D this_cpu_xchg(cached_stacks[i], NULL);
> > +             if (!vm_area)
> >                       continue;
> >
> >               /* Reset stack metadata. */
> > -             kasan_unpoison_range(s->addr, THREAD_SIZE);
> > +             kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
> >
> > -             stack =3D kasan_reset_tag(s->addr);
> > +             stack =3D kasan_reset_tag(vm_area->addr);
> >
> >               /* Clear stale pointers from reused stack. */
> >               memset(stack, 0, THREAD_SIZE);
> >
> > -             if (memcg_charge_kernel_stack(s)) {
> > -                     vfree(s->addr);
> > +             if (memcg_charge_kernel_stack(vm_area)) {
> > +                     vfree(vm_area->addr);
> >                       return -ENOMEM;
> >               }
> >
> > -             tsk->stack_vm_area =3D s;
> > +             tsk->stack_vm_area =3D vm_area;
> >               tsk->stack =3D stack;
> >               return 0;
> >       }
> > @@ -306,8 +304,8 @@ static int alloc_thread_stack_node(struct task_stru=
ct *tsk, int node)
> >       if (!stack)
> >               return -ENOMEM;
> >
> > -     vm =3D find_vm_area(stack);
> > -     if (memcg_charge_kernel_stack(vm)) {
> > +     vm_area =3D find_vm_area(stack);
> > +     if (memcg_charge_kernel_stack(vm_area)) {
> >               vfree(stack);
> >               return -ENOMEM;
> >       }
> > @@ -316,7 +314,7 @@ static int alloc_thread_stack_node(struct task_stru=
ct *tsk, int node)
> >        * free_thread_stack() can be called in interrupt context,
> >        * so cache the vm_struct.
> >        */
> > -     tsk->stack_vm_area =3D vm;
> > +     tsk->stack_vm_area =3D vm_area;
> >       stack =3D kasan_reset_tag(stack);
> >       tsk->stack =3D stack;
> >       return 0;
>

