Return-Path: <linux-kernel+bounces-15693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395682305A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE08285FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9F1BDEC;
	Wed,  3 Jan 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+eM/XMs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B71BDDF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8e0c7f9a8so5971557b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704295144; x=1704899944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mixGhCxFNsjK1/FsJPxtUpDRVUJ3A5zONET6Xrw4qg=;
        b=q+eM/XMsOCmY40JEcCme1n8XFl2ib1dxQVYAVZuQq8ReaJtE0BmBg8/bVxczkW1bmH
         tbJnJqBqouGGu3voxjoGTzFHjRCj34E8xGDeMqaDH3+1XzEhlDIFEbZjClfvvDbMyr0S
         BoKNpfSLNxbCYgDG/32sFBiSl27k7LmCVRlaw3kmIAa0dAlHW5/0dv68nxXOfDiL1rm6
         NjCMn1O8LCF2tOptgEBfyzKIAaD/jeUO00VQKwBG793siBjyauZe9Na0wamWoEKop3ok
         KYc2Lc4z0MYjgznKO/6fUGTz7kIeP2RSIqEGdFjpTDWgqcurNroDQbmsTcXPUE3oEpWJ
         A1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295144; x=1704899944;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3mixGhCxFNsjK1/FsJPxtUpDRVUJ3A5zONET6Xrw4qg=;
        b=Cba1ou5bo1kynDawQJaVpSZS2VifNOnQL/rABzHYC7fO/H2xYN/FUWr+Lo4vjcpxdJ
         BWpubnBr/HCQVw1qGqqa1gHVVsXOKdL3ghch1s2vTkvWo8XZXVhln0OC3ty6yryenpZd
         vHtYN9oo/s+eTGP/DVuns8qhneh/waBWVQJUxw9dMKWxnnRXlFe4G7GGvZqkaqLnDStk
         6vYuWBXKtcy+en8boXFPCGMZ7pMdpJ1u+OOtCLejxwbdkWM365AJrD0l9Q2q8Q++LqZw
         wBTwRzTZY3lRFIiI1bL8Vza/UsHlSvCgOxAi/CPPpXUKT5954SQVeMDaMo1IK8VWhli6
         3Tag==
X-Gm-Message-State: AOJu0YyOs1y0StGC9JPsM5BOMao3HmR/2MhmgxtZoxT1yA6A2H4L7Gt2
	+YY9hDtZBbrXykSlt3/+DOd3Et2RLBoQko2F5w==
X-Google-Smtp-Source: AGHT+IFpHI+G7d1DsDGUzqaus+dSoFyBlUJa9XfJpxyPsdf3is63/25aoOu/fJNw6UCe159iS4D+2tfB0xo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:31e:b0:5d3:56a4:9073 with SMTP id
 bg30-20020a05690c031e00b005d356a49073mr665900ywb.2.1704295143978; Wed, 03 Jan
 2024 07:19:03 -0800 (PST)
Date: Wed, 3 Jan 2024 07:19:02 -0800
In-Reply-To: <3207569.5fSG56mABF@uriel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2285758.taCxCBeP46@uriel> <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
 <3207569.5fSG56mABF@uriel>
Message-ID: <ZZV65qJuJ67E_n9O@google.com>
Subject: Re: x86 SGDT emulation for Wine
From: Sean Christopherson <seanjc@google.com>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024, Elizabeth Figura wrote:
> On Wednesday, December 27, 2023 5:58:19 PM CST H. Peter Anvin wrote:
> > On December 27, 2023 2:20:37 PM PST, Elizabeth Figura <zfigura@codeweav=
ers.com> wrote:
> > >Hello all,
> > >
> > >There is a Windows 98 program, a game called Nuclear Strike, which wan=
ts to
> > >do some amount of direct VGA access. Part of this is port I/O, which
> > >naturally throws SIGILL that we can trivially catch and emulate in Win=
e.
> > >The other part is direct access to the video memory at 0xa0000, which =
in
> > >general isn't a problem to catch and virtualize as well.
> > >
> > >However, this program is a bit creative about how it accesses that mem=
ory;
> > >instead of just writing to 0xa0000 directly, it looks up a segment
> > >descriptor whose base is at 0xa0000 and then uses the %es override to
> > >write bytes. In pseudo-C, what it does is:

...

> > A prctl() to set the UMIP-emulated return values or disable it (giving
> > SIGILL) would be easy enough.
> >=20
> > For the non-UMIP case, and probably for a lot of other corner cases lik=
e
> > relying on certain magic selector values and what not, the best option
> > really would be to wrap the code in a lightweight KVM container. I do *=
not*
> > mean running the Qemu user space part of KVM; instead have Wine interfa=
ce
> > with /dev/kvm directly.
> >=20
> > Non-KVM-capable hardware is basically historic at this point.
>=20
> Sorry for the late response=E2=80=94I've been trying to do research on wh=
at would be=20
> necessary to use KVM (plus I made the poor choice of sending this during =
the=20
> holiday season...)
>=20
> I'm concerned that KVM is going to be difficult or even intractable. Here=
 are=20
> some of the problems that I (perhaps incorrectly) understand:
>=20
> * As I am led to understand, there can only be one hypervisor on the mach=
ine=20
> at a time,

No.  Only one instance of KVM-the-module is allowed, but there is no arbitr=
ary
limit on the number of VMs that userspace can create.  The only meaningful
limitation is memory, and while struct kvm isn't tiny, it's not _that_ big.

> and KVM has a hard limit on the number of vCPUs.
>
>   The obvious way to use KVM for Wine is to make each (guest) thread a vC=
PU.=20
> That will, at the very least, run into the thread limit. In order to avoi=
d=20
> that we'd need to ship a whole scheduler, which is concerning. That's a h=
uge=20
> component to ship and a huge burden to keep updated. It also means we nee=
d to=20
> hoist *all* of the ipc and sync code into the guest, which will take an=
=20
> enormous amount of work.
>=20
>   Moreover, because there can only be one hypervisor, and Wine is a multi=
-
> process beast, that means that we suddenly need to throw every process in=
to=20
> the same VM.

As above, this is wildly inaccurate.  The only KVM restriction with respect=
 to
processes is that a VM is bound to the process (address space) that created=
 the
VM.  There are no restrictions on the number of VMs that can be created, e.=
g. a
single process can create multiple VMs.

> That has unfortunate implications regarding isolation (it's been a dream =
for
> years that we'd be able to share a single wine "VM" between multiple user=
s),
> it complicates memory management (though perhaps not terribly?). And it m=
eans
> you can only have one Wine VM at a time, and can't use Wine at the same t=
ime
> as a "real" VM, neither of which are restrictions that currently exist.
>=20
>   And it's not even like we can refactor=E2=80=94we'd have to rewrite ton=
s of code to=20
> work inside a VM, but also keep the old code around for the cases where w=
e=20
> don't have a VM and want to delegate scheduling to the host OS.
>=20
> * Besides scheduling, we need to exit the VM every time we would normally=
 call=20
> into Unix code, which in practice is every time that the application does=
 an=20
> NT syscall, or uses a library which we delegate to the host (including e.=
g.=20
> GPU, multimedia, audio...)

Maybe I misinterpreted Peter's suggestion, but at least in my mind I wasn't=
 thinking
that the entire Wine process would run in a VM, but rather Wine would run j=
ust
the "problematic" code in a VM.

