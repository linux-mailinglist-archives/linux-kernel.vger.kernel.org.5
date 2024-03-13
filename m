Return-Path: <linux-kernel+bounces-101553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6387A8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E52B20DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594240BE1;
	Wed, 13 Mar 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="KFsa4rZ9"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F63E49D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337469; cv=none; b=tLrFCmOIWhgJKIBmL5jaEmQj8soPLjPj9Aq+zme3mZRseqXI+vQHdSUszTlgTC0evG2jWLBSWxQHWNxR7CK9J8h3pZ2CkybyTxyp6bI3Mw/Nrj2bQLQgShw/wvFS93MYwNs75vo0d8NpAdTmfyaK72KNfLQC06xzSk3iD+B8B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337469; c=relaxed/simple;
	bh=M2mFO+F0SITtuTaOxQT6J0gOG1XCkSqAKDgbIeQQ7J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOn1VlY1TyVgeYL7aDCwJywEYhDGljfGBt6Joy3+q4QsCVgivtSZJXHrok5YpWaTL//+VsqR6iFXEvU2RdhFbdoWGnsfS0n12XZU6A+sTvFSokvThNPEXh7KD0YCF7TDY3kaK/eXxeHTXtNnNadYGSVOVEHjzrdGQEKxoqaJa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=KFsa4rZ9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42efa84f7b5so6397081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710337467; x=1710942267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1unsI42A9OoozSRZhehZbbrOVDAXegi3ZIYJY1GY/YI=;
        b=KFsa4rZ9fEhDiwR66/cbzWnOV+c3GQRwUyBBZw5AxJyBZpBjJV3aSVCZGYYpY7Nu9D
         JhDA4MghvyPr9CfD5cBhoLeajWCAIXZfn4Zjkq5IPd1ba9ztJFPLN8I7LFZPURzvq2so
         8YcBwoi7NKDHYQJvKD5AJLaEg5vRH812diR5yduI388L53o0/DTVgPDD4KIZQcxKk1dd
         R33zRsvpQjLJ3+5n6i0+YLK5ukuqm0lbI1n9kKQw+bQX2gaf+zsdp5q3lpFc0EgUp9rJ
         Z0AwGXKoqd12xi7uMbZpYNzPM4F6wyK1hqFvzajlHYTVHA3VLixMt/JYhGLSm9CaIikq
         zSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710337467; x=1710942267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1unsI42A9OoozSRZhehZbbrOVDAXegi3ZIYJY1GY/YI=;
        b=Qn3exPsRdohgVQYYDmTf4SbX3UjG9ZrfwN+nsiGBgFGMQFir093t5V3oEQotjzkDEq
         KR/SjYae7i6fBoiZN3r3nAylkGlKoQbw0KUGVGgNEQvQV83r1oUPl5aDV11gn6TLyvZg
         qFWn1E19QcEvkmnUDDeDsLyRuawh2Qb87a/Cfs1Xvsdlv+cqpgf1EigovYUmzvrFZI/t
         UXtqWP2RSYb8jYO2nZdx+N0MvAN5e3CeDBnsv2ju4PW31kebHibVGQqd9ceWDQb60jnQ
         aYOkfbJ8vcA9IwWHjRya7Ay2GfuPQwwEJHaheVhHKvSYr9hm/3jcZ1i/45cgoQwbs/In
         1WYQ==
X-Gm-Message-State: AOJu0YzViCKjeNwaFXBeQb/BdwyS38kFZv1BTIhRX4gut3v0W+fqVI9l
	GJ9iM9hMeOCPILzYb/isY+FsusiQ9r4T46CFZLqqy09WVizlW5sqSWWVLgyGfRw4DlEGs27DLfD
	unSy7D+LuqTfew55+gbgO1vow+RP3MVQUy5DnYA==
X-Google-Smtp-Source: AGHT+IE+LvF+pG53KH+24dZ0NQseSIenM5+QuAbESRPftegLLVAhNTGpcBbK43Nn7zGumkmtmUYhNMgvVTy85/c3XU4=
X-Received: by 2002:a05:622a:1a26:b0:42e:f6c2:e68b with SMTP id
 f38-20020a05622a1a2600b0042ef6c2e68bmr4264866qtb.14.1710337467079; Wed, 13
 Mar 2024 06:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <87v85qo2fj.ffs@tglx>
In-Reply-To: <87v85qo2fj.ffs@tglx>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 09:43:50 -0400
Message-ID: <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
To: Thomas Gleixner <tglx@linutronix.de>
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
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Mar 11 2024 at 16:46, Pasha Tatashin wrote:
> > @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
> >       }
> >  #endif
> >
> > +     if (dynamic_stack_fault(current, address))
> > +             return;
> > +
> >       irqentry_nmi_enter(regs);
> >       instrumentation_begin();
> >       notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV)=
;
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index d6375b3c633b..651c558b10eb 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1198,6 +1198,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned=
 long hw_error_code,
> >       if (is_f00f_bug(regs, hw_error_code, address))
> >               return;
> >
> > +     if (dynamic_stack_fault(current, address))
> > +             return;
>
> T1 schedules out with stack used close to the fault boundary.
>
>    switch_to(T2)
>
> Now T1 schedules back in
>
>    switch_to(T1)
>      __switch_to_asm()
>         ...
>         switch_stacks()         <- SP on T1 stack
> !        ...
> !       jmp __switch_to()
> !    __switch_to()
> !       ...
> !       raw_cpu_write(pcpu_hot.current_task, next_p);
>
> After switching SP to T1's stack and up to the point where
> pcpu_hot.current_task (aka current) is updated to T1 a stack fault will
> invoke dynamic_stack_fault(T2, address) which will return false here:
>
>         /* check if address is inside the kernel stack area */
>         stack =3D (unsigned long)tsk->stack;
>         if (address < stack || address >=3D stack + THREAD_SIZE)
>                 return false;
>
> because T2's stack does obviously not cover the faulting address on T1's
> stack. As a consequence double fault will panic the machine.

Hi Thomas,

Thank you, you are absolutely right, we can't trust "current" in the
fault handler.

We can change dynamic_stack_fault() to only accept fault_address as an
argument, and let it determine the right task_struct pointer
internally.

Let's modify dynamic_stack_fault() to accept only the fault_address.
It can then determine the correct task_struct pointer internally.

Here's a potential solution that is fast, avoids locking, and ensures atomi=
city:

1. Kernel Stack VA Space
Dedicate a virtual address range ([KSTACK_START_VA - KSTACK_END_VA])
exclusively for kernel stacks. This simplifies validation of faulting
addresses to be part of a stack.

2. Finding the faulty task
- Use ALIGN(fault_address, THREAD_SIZE) to calculate the end of the
topmost stack page (since stack addresses are aligned to THREAD_SIZE).
- Store the task_struct pointer as the last word on this topmost page,
that is always present as it is a pre-allcated stack page.

3. Stack Padding
Increase padding to 8 bytes on x86_64 (TOP_OF_KERNEL_STACK_PADDING 8)
to accommodate the task_struct pointer.

Another issue that this race brings is that 3-pages per-cpu might not
be enough, we might need up-to 6 pages: 3 to cover going-away task,
and 3 to cover the new task.

Pasha

