Return-Path: <linux-kernel+bounces-1554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D77814FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40641C21ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B63FE2F;
	Fri, 15 Dec 2023 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="sjudvEJG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E313EA6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9f8578932so702446a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1702667418; x=1703272218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUQt64cxTRekczJujRwSGMZNUaofXXGwCuQbCkI4cV0=;
        b=sjudvEJG64A78oWCIDBRX5yRdxPFiilOoyNN2ITLeMpg8zuMt1jw1Z/4QzsmvjAA3e
         JoRTzEJnvBZtELPW7lGxlS97liB3rOgIJP+jcssttyWS9yVvhkXDHbzi3V+AD4KuAmc3
         OpBnS/Q2PGvM0MmshLLLlgrNlErB7SFp6AXGghzL6+3J1MIjiTUiA43xqCiufrY0NAiT
         g7qiWCsD9Qk5dSeFBx2H9kVBN9EyOwREbJp+KPLaINgPJ5Tkm14HS8sVkW7S/8rTxNxk
         jizt1EjIOTKRHtsrm+jn0uqSP48msvEH4ZHG49Mq+iK4T2I10TdJsYotvuIk9KyRrB3G
         k75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667418; x=1703272218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUQt64cxTRekczJujRwSGMZNUaofXXGwCuQbCkI4cV0=;
        b=aOADY85BkNFwdjWtQKQQKYZqIatn7KV+AsfRGF/jyN1Q+/JW7UGih2FXSFFMgLmkKU
         NvUYZ9l/Fy7uh9SPEmUGP1BQVlj2z2QnCVxhmfUMxtW7KGNtdoXEUVbuDgbVG0Vw5NcT
         OblgV4hPA29oVJOMiP4z8ffo6v0ZjKcKAP3/2g6DdeXND+AECopIzVdnQvqpSc3pvzt1
         do1qJ3ECcc5clqjjntRsHSDsS96gPKOY/vFgCwWFkhhOYSBwrfjSfA2k1GzC0S3wu6jf
         jcJTJTtV2ydk5p8pdSGKJ5D3Fplx4mDZJizwR+/2MCa7wRXiKQJQrXBJw/ATKlJAAQvA
         Zc8Q==
X-Gm-Message-State: AOJu0YxjVV1uGz7nHnBJvKPWSOTHJgy09gfwDOau6j/1ascd7qTmU9Ja
	SbFg1TOL7jqLwo1g2NVzZe4VDjVg4SBjUWDuE6zxVg==
X-Google-Smtp-Source: AGHT+IEggW6PgLUr0D4F6at7LeGq7cNUnBzwvFQmAEXQLpk+KIbEII5GosSI41SopHRLHkeCwP7H1/F/pNrFVx39YsY=
X-Received: by 2002:a9d:6187:0:b0:6d9:e32e:fb0d with SMTP id
 g7-20020a9d6187000000b006d9e32efb0dmr11579063otk.20.1702667418223; Fri, 15
 Dec 2023 11:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
 <ZXsvl7mabUuNkWcY@google.com> <CAO7JXPihjjko6qe8tr6e6UE=L7uSR6AACq1Zwg+7n95s5A-yoQ@mail.gmail.com>
 <ZXth7hu7jaHbJZnj@google.com> <CAO7JXPhQ3zPzsNeuUphLx7o_+DOfJrmCoyRXXjcQMEzrKnGc9g@mail.gmail.com>
 <ZXuiM7s7LsT5hL3_@google.com> <CAO7JXPik9eMgef6amjCk5JPeEhg66ghDXowWQESBrd_fAaEsCA@mail.gmail.com>
 <ZXyFWTSU3KRk7EtQ@google.com> <CAO7JXPgH6Z9X5sWXLa_15VMQ-LU6Zy-tArauRowyDNTDWjwA2g@mail.gmail.com>
 <ZXyS5Xw2J6TBQeK3@google.com>
In-Reply-To: <ZXyS5Xw2J6TBQeK3@google.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 15 Dec 2023 14:10:06 -0500
Message-ID: <CAO7JXPgKXv0D3XZzFwgLuSpta6Nou0HZMLEjSpYUYnv9FUphnw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Dynamic vcpu priority management in kvm
To: Sean Christopherson <seanjc@google.com>
Cc: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Suleiman Souhlal <suleiman@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, David Vernet <dvernet@meta.com>, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:54=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Dec 15, 2023, Vineeth Remanan Pillai wrote:
> > > You are basically proposing that KVM bounce-buffer data between guest=
 and host.
> > > I'm saying there's no _technical_ reason to use a bounce-buffer, just=
 do zero copy.
> > >
> > I was also meaning zero copy only. The help required from the kvm side =
is:
> > - Pass the address of the shared memory to bpf programs/scheduler once
> > the guest sets it up.
> > - Invoke scheduler registered callbacks on events like VMEXIT,
> > VEMENTRY, interrupt injection etc. Its the job of guest and host
> > paravirt scheduler to interpret the shared memory contents and take
> > actions.
> >
> > I admit current RFC doesn't strictly implement hooks and callbacks -
> > it calls sched_setscheduler in place of all callbacks that I mentioned
> > above. I guess this was your strongest objection.
>
> Ya, more or less.
>
> > As you mentioned in the reply to Joel, if it is fine for kvm to allow
> > hooks into events (VMEXIT, VMENTRY, interrupt injection etc) then, it
> > makes it easier to develop the ABI I was mentioning and have the hooks
> > implemented by a paravirt scheduler. We shall re-design the
> > architecture based on this for v2.
>
> Instead of going straight to a full blown re-design, can you instead post=
 slightly
> more incremental RFCs?  E.g. flesh out enough code to get a BPF program a=
ttached
> and receiving information, but do NOT wait until you have fully working s=
etup
> before posting the next RFC.
>
Sure, makes sense.

> There are essentially four-ish things to sort out:
>
>  1. Where to insert/modify hooks in KVM
>  2. How KVM exposes KVM-internal information through said hooks
>  3. How a BPF program can influence the host scheduler
>  4. The guest/host ABI
>
> #1 and #2 are largely KVM-only, and I think/hope we can get a rough idea =
of how
> to address them before moving onto #3 and #4 (assuming #3 isn't already a=
 solved
> problem).

Agreed. Will start with the kvm side and keep you posted on the progress.

Thanks,
Vineeth

