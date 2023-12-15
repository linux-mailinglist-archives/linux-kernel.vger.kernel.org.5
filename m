Return-Path: <linux-kernel+bounces-1475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5019814F46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7582844B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4543011D;
	Fri, 15 Dec 2023 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScvxSPRt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CF30104
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e33a2f0cacso15279577b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702662887; x=1703267687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqL/+PQxtD2SuJ+ds8ijf5c1eBZNUOinrnvlGfUp2Vk=;
        b=ScvxSPRteBjmpxbBCeUZL5vXVqxbLl8VVbZyN3DZAIsIBv9PhxumpUgpnlFv7jn8oj
         zbeEFpQkaAD0aNhjAAX69CLcajUEaxuWHTcBNodCYKyx0XZ4Swrxv6L+PcIbBJlxu8AZ
         XaUJsi4qacPBP1ho5ia1sfaFBXqfqk2H4L83WUhOjTyJ83dLPA3H857Uj0UJu7LHrtEp
         n4oEMtHJbCUJjGe1uBa7NjZs8TP/5BJXCtE0TR+muhBw7YQ0QRxBE/upV+sbxqUWzg9E
         CBr9caDHwa3V5WMVwHo8cHcHGwIQJhxi2H4IbbSfccmFIDcgNFXgCMmf1Ly923pfnU79
         rSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702662887; x=1703267687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqL/+PQxtD2SuJ+ds8ijf5c1eBZNUOinrnvlGfUp2Vk=;
        b=BN+rwdgs+Jfbc2W+g3vPzkjo0/YARFN7I14JISBho6E0IJuP+TBuSeAlgMoAU8Jnj3
         mE/eqRFffgEKCB4iaizwYjB0Ke/ft2NwqEnvkxAH953VSRtp6txXz5yif/sx/Zz/NyE7
         zb68CMqXQ3Xy/2cWpacIYiqSqjyoys0GwoiwOd+IknrXhQX9glxJHZprC43hGQtx99pd
         q0Qs9YapWbmf6+fmCXM0LcA1zAtDGEmthZefRjuxpaA7f2GOrtjRZEiw770OYAX5AzlN
         D+mW9JUjVsewP0gf41mHH0c0KP5XYdrnIbeIZHxmhXq31Rsli/Hy0dE+rSV9TxyU0mkh
         fsuw==
X-Gm-Message-State: AOJu0Yz9NBkTno2246DjtUJqCLV2TtxDSrZS5p17xH2cQTiTtYH1PuO4
	Esg2PYp7/p3onlrrNT6mvq47HNLP7KA=
X-Google-Smtp-Source: AGHT+IFWBObteEun2vkoo/efmhIHBiZy4fw+uEFUgKZqya0QsPH6aHV8LDFaGzsqHS1mFqr8mvF0sx/NXP8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:14d:b0:db5:3aaf:5207 with SMTP id
 p13-20020a056902014d00b00db53aaf5207mr212769ybh.3.1702662886829; Fri, 15 Dec
 2023 09:54:46 -0800 (PST)
Date: Fri, 15 Dec 2023 09:54:45 -0800
In-Reply-To: <CAO7JXPgH6Z9X5sWXLa_15VMQ-LU6Zy-tArauRowyDNTDWjwA2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
 <ZXsvl7mabUuNkWcY@google.com> <CAO7JXPihjjko6qe8tr6e6UE=L7uSR6AACq1Zwg+7n95s5A-yoQ@mail.gmail.com>
 <ZXth7hu7jaHbJZnj@google.com> <CAO7JXPhQ3zPzsNeuUphLx7o_+DOfJrmCoyRXXjcQMEzrKnGc9g@mail.gmail.com>
 <ZXuiM7s7LsT5hL3_@google.com> <CAO7JXPik9eMgef6amjCk5JPeEhg66ghDXowWQESBrd_fAaEsCA@mail.gmail.com>
 <ZXyFWTSU3KRk7EtQ@google.com> <CAO7JXPgH6Z9X5sWXLa_15VMQ-LU6Zy-tArauRowyDNTDWjwA2g@mail.gmail.com>
Message-ID: <ZXyS5Xw2J6TBQeK3@google.com>
Subject: Re: [RFC PATCH 0/8] Dynamic vcpu priority management in kvm
From: Sean Christopherson <seanjc@google.com>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
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
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 15, 2023, Vineeth Remanan Pillai wrote:
> > You are basically proposing that KVM bounce-buffer data between guest and host.
> > I'm saying there's no _technical_ reason to use a bounce-buffer, just do zero copy.
> >
> I was also meaning zero copy only. The help required from the kvm side is:
> - Pass the address of the shared memory to bpf programs/scheduler once
> the guest sets it up.
> - Invoke scheduler registered callbacks on events like VMEXIT,
> VEMENTRY, interrupt injection etc. Its the job of guest and host
> paravirt scheduler to interpret the shared memory contents and take
> actions.
> 
> I admit current RFC doesn't strictly implement hooks and callbacks -
> it calls sched_setscheduler in place of all callbacks that I mentioned
> above. I guess this was your strongest objection.

Ya, more or less.  

> As you mentioned in the reply to Joel, if it is fine for kvm to allow
> hooks into events (VMEXIT, VMENTRY, interrupt injection etc) then, it
> makes it easier to develop the ABI I was mentioning and have the hooks
> implemented by a paravirt scheduler. We shall re-design the
> architecture based on this for v2.

Instead of going straight to a full blown re-design, can you instead post slightly
more incremental RFCs?  E.g. flesh out enough code to get a BPF program attached
and receiving information, but do NOT wait until you have fully working setup
before posting the next RFC.

There are essentially four-ish things to sort out:

 1. Where to insert/modify hooks in KVM
 2. How KVM exposes KVM-internal information through said hooks
 3. How a BPF program can influence the host scheduler
 4. The guest/host ABI

#1 and #2 are largely KVM-only, and I think/hope we can get a rough idea of how
to address them before moving onto #3 and #4 (assuming #3 isn't already a solved
problem).

