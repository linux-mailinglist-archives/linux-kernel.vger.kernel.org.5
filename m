Return-Path: <linux-kernel+bounces-105278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C725887DB4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A87FB21672
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA11BC43;
	Sat, 16 Mar 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="PznjpXGb"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8B168BE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710616717; cv=none; b=LHi4mdnd5vYdC3mKZu7vyKnde2HUBdw5mOHROZy6/4D5gpMSk0MHR49MJouwM48ZuhyYM1HAHd2mvZ4OTPQoLlULT9MZepJJm5mXSA5zsVvhlgVzrJ2Jvfl2n1BM+5peF3XHplL6kexuU2t5L51CYpsS4U78xXjownxcE/+Vo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710616717; c=relaxed/simple;
	bh=0/HEkRLMF8PQalDt3Ea2N38GuL3TFIgweg+xWLCZBW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DApqiq6XodI2s9wuSPYkprSTDpVk9VEnoUxReRaFws5CRnM2nrxZmhw6WPto8ImSHO/oT4kQvjKrUbyz0MpIwvtGFkYtZz0nzHwr+dwrxUwUShRnR5E50qW+KJtJQhHUlFfJ0F6v6qoEYhg3RpPVy/UE5o/SoFSVXaa2GwF3FzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=PznjpXGb; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783045e88a6so227545285a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710616715; x=1711221515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHULfTfAKa7+vagdsuVNuBp2O5vjXv7Mii+l4GG9MeA=;
        b=PznjpXGbi56uPMMnFw/AMZ6KB0QMKFsmhimL4SAnlLORb6LBr6WRbpnfi0p11Hvz2V
         5BpIZ0kqYTliyl2UuGpddZGsnQYEb8uvejuCIcGIUWRK+y9k2EGGgmbxqcEFyONBIJob
         oIMPGf0bj0Wx9KFxMXHpCp8dS9a5RJMd4+DoQXDsJqYHZ1oqiUjibZVxXd54VHwwM0HJ
         V5WchMLGrlLi7/OhiUqJVHug0zb04h1k+knjzW3dn84kuNK1z21+thMtGs4pKRhOE8rq
         7gDwdUPq/xzO48ncpbWD1/tKSKVFU+1i7w5+zsUoCkH+UaScrv4QHOir/ApX9GUnIjC3
         c7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710616715; x=1711221515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHULfTfAKa7+vagdsuVNuBp2O5vjXv7Mii+l4GG9MeA=;
        b=RWJXntj3zoizwtIDkVmfmzuuKPrshuW1BSrLj+W+BPTv1E4SBQ7ASlqNXM0h/BmveM
         WlalxJV+Hb2iOzRN7NKzmSRuGXDU2KbdxD3E0owDQ6/dhPgXyxB3aDBgV5+1kT3Eb8Q+
         50jZuubquSRIgqyGbsQsJQlUqqv4tymW3+b3YsrmuH+ct6r9vdfsrBH6BiHbwOQu+WBC
         znPku4YayervkzrXo2eGod/+fGa4aGstfZaYQr8/0dGIbDdd7JyjxexVYh6rtH4UYq1O
         hkHUcWsLvfCqSkpJvWTWYvJqSZddrSu2lptSa1hWffh66F0tVgogU08noWp/cwhFm1SM
         ogOA==
X-Forwarded-Encrypted: i=1; AJvYcCXZWSSoSC4k6wC+0ST0rTTkhfooeiSHYASZAL5Hv7mNpNQW5rizns54TkkIMUJdgTLSyOfqgmdk0p6G8wKuUdM0jhFIDazQ33dRUFhs
X-Gm-Message-State: AOJu0YydDlOQUgLl0O43ckLlMEKiY7xV2xF6z7T0Fa/ZgA7QariDlthG
	thR8QCMYLW7WCBXCeZRMXOIoTXUCJs1sAtEm3ujjkU64uWcld3KFI5JJMykbQIbmd/YEUal04ji
	JkKrdGGKRqIdQTJIUtkFQzSiB/u5Q5HT/CPAvsg==
X-Google-Smtp-Source: AGHT+IGlePJmBiz3YZoHmDuLZOXVxdtk19dG95lfRudzm9Y3ulwqFfldVvMJd4H1NSzuACxuC68Uzuh/qPUxNqxmbqM=
X-Received: by 2002:a05:622a:344:b0:42e:fa7c:291c with SMTP id
 r4-20020a05622a034400b0042efa7c291cmr8844027qtw.13.1710616714891; Sat, 16 Mar
 2024 12:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
In-Reply-To: <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 16 Mar 2024 15:17:57 -0400
Message-ID: <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	x86@kernel.org, bp@alien8.de, brauner@kernel.org, bristot@redhat.com, 
	bsegall@google.com, dave.hansen@linux.intel.com, dianders@chromium.org, 
	dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com, 
	hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashin@soleen.c=
om> wrote:
> >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >>
> >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> >> > > > Second, non-dynamic kernel memory is one of the core design deci=
sions in
> >> > > > Linux from early on. This means there are lot of deeply embedded=
 assumptions
> >> > > > which would have to be untangled.
> >> > >
> >> > > I think there are other ways of getting the benefit that Pasha is =
seeking
> >> > > without moving to dynamically allocated kernel memory.  One icky t=
hing
> >> > > that XFS does is punt work over to a kernel thread in order to use=
 more
> >> > > stack!  That breaks a number of things including lockdep (because =
the
> >> > > kernel thread doesn't own the lock, the thread waiting for the ker=
nel
> >> > > thread owns the lock).
> >> > >
> >> > > If we had segmented stacks, XFS could say "I need at least 6kB of =
stack",
> >> > > and if less than that was available, we could allocate a temporary
> >> > > stack and switch to it.  I suspect Google would also be able to us=
e this
> >> > > API for their rare cases when they need more than 8kB of kernel st=
ack.
> >> > > Who knows, we might all be able to use such a thing.
> >> > >
> >> > > I'd been thinking about this from the point of view of allocating =
more
> >> > > stack elsewhere in kernel space, but combining what Pasha has done=
 here
> >> > > with this idea might lead to a hybrid approach that works better; =
allocate
> >> > > 32kB of vmap space per kernel thread, put 12kB of memory at the to=
p of it,
> >> > > rely on people using this "I need more stack" API correctly, and f=
ree the
> >> > > excess pages on return to userspace.  No complicated "switch stack=
s" API
> >> > > needed, just an "ensure we have at least N bytes of stack remainin=
g" API.
> >
> >I like this approach! I think we could also consider having permanent
> >big stacks for some kernel only threads like kvm-vcpu. A cooperative
> >stack increase framework could work well and wouldn't negatively
> >impact the performance of context switching. However, thorough
> >analysis would be necessary to proactively identify potential stack
> >overflow situations.
> >
> >> > Why would we need an "I need more stack" API? Pasha's approach seems
> >> > like everything we need for what you're talking about.
> >>
> >> Because double faults are hard, possibly impossible, and the FRED appr=
oach
> >> Peter described has extra overhead?  This was all described up-thread.
> >
> >Handling faults in #DF is possible. It requires code inspection to
> >handle race conditions such as what was shown by tglx. However, as
> >Andy pointed out, this is not supported by SDM as it is an abort
> >context (yet we return from it because of ESPFIX64, so return is
> >possible).
> >
> >My question, however, if we ignore memory savings and only consider
> >reliability aspect of this feature.  What is better unconditionally
> >crashing the machine because a guard page was reached, or printing a
> >huge warning with a backtracing information about the offending stack,
> >handling the fault, and survive? I know that historically Linus
> >preferred WARN() to BUG() [1]. But, this is a somewhat different
> >scenario compared to simple BUG vs WARN.
> >
> >Pasha
> >
> >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714-100000@=
home.transmeta.com
> >
>
> The real issue with using #DF is that if the event that caused it was asy=
nchronous, you could lose the event.

Got it. So, using a #DF handler for stack page faults isn't feasible.
I suppose the only way for this to work would be to use a dedicated
Interrupt Stack Table (IST) entry for page faults (#PF), but I suspect
that might introduce other complications.

Expanding on Mathew's idea of an interface for dynamic kernel stack
sizes, here's what I'm thinking:

- Kernel Threads: Create all kernel threads with a fully populated
THREAD_SIZE stack.  (i.e. 16K)
- User Threads: Create all user threads with THREAD_SIZE kernel stack
but only the top page mapped. (i.e. 4K)
- In enter_from_user_mode(): Expand the thread stack to 16K by mapping
three additional pages from the per-CPU stack cache. This function is
called early in kernel entry points.
- exit_to_user_mode(): Unmap the extra three pages and return them to
the per-CPU cache. This function is called late in the kernel exit
path.

Both of the above hooks are called with IRQ disabled on all kernel
entries whether through interrupts and syscalls, and they are called
early/late enough that 4K is enough to handle the rest of entry/exit.

Pasha

