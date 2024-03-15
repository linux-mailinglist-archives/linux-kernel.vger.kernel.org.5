Return-Path: <linux-kernel+bounces-104012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D6C87C7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8398D1F22B84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC837DF58;
	Fri, 15 Mar 2024 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="N0Afq1Uf"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A097DF42
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472476; cv=none; b=ZGi7izQhCfFl+/xo4Ka4jsn1iGO6xlKd/xkMBr0NyDytDWgIKjp9UZ6+r5Hk1Ad90eFutcnef+kMBGkV5deNAdQC1fHGhsf7VfyaAzUZFmPbnS0n6qeWXvEufTSg14BbZ4RsKDKyPReq4SE0bpfIJYt7LFtmvv2AyICddRYX3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472476; c=relaxed/simple;
	bh=VobLpNMwR1j6KiM8Tjp5hnXMiVCDHRuZ75c/cHU52ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHCQb46h8fsnCsicpCzDno64RHVQioEZmOR71bFTqA5HSCev0cGauWoQV+xxty04DSC54N8nupVBbhuSeaM7wLcng+/4A9LPzXJXOrKeGR79g/0otgT1B2w9dLUEZ7zL28kYCuB7w5I6tpjJsORVKf19NOvySv/8X3on4JLTipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=N0Afq1Uf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a5a11b59dso18375337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710472473; x=1711077273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kltlRsU//wSb9eRIerjBP4RsEfMtLq7gwv46ptQ/oTs=;
        b=N0Afq1Uf0Pws19q0KoB2HBAd6Iy/zu+XBJUkO6+p/H0J0pOIWrX6OMbxxemQthF6tN
         w+lIjRRooozlbAjmqLtPsum2rSeqwIzrqVx00eEIa+E9aH9ZFtWB2GgMRhm81Hq+8n1p
         BU0RaK0V/8QXA49xVqgZFg8xcOtJryiicCcZaNHaV41U5t6yi1eczp4SV4+RPOJdMHWM
         EIi9DtvLqssPybkZT6P1Cnh7NupmA+PzA1yfDI/LzopF0YlDQVPpJSFBbAySSpOW17QC
         Pyjc+2QS2inQaM+FncmuCLRY4ZHeV9ffExi+3yzhhZpweWDe8cJtDDOC3thSvZ4D6pLc
         YJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710472473; x=1711077273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kltlRsU//wSb9eRIerjBP4RsEfMtLq7gwv46ptQ/oTs=;
        b=dwg1cZ3RYQsLaiHKxFsCPhE0/PgYlTfGeVdShEAIw8jEzOOz9upCxnKacVrUuAPkX1
         LdmZwojvUopR758St1zNophydg4XRvc1H2SSa8dT07nO83rk9uZZtpaK+C4RNjXF+SZR
         PNgCDN0NM7GECYwuJFvHHVfI1Kh7XASXFo3xqHOHBKdNYzzGnchT+oGkAgRr3D/nLXo6
         n7hqdUu2N5DAiOg1yz4/PkXiDVxyt02LhQG8jkHXKu1XF9z2jlgl3GUXbPLt7KbAgfSH
         pFHF3eQixX6SnFmRDpXmk8HYVnuNJlHWWRPGfR7ivw4PhSm+2OrgeUu6y2pXeaU607BF
         gEMA==
X-Forwarded-Encrypted: i=1; AJvYcCWNiQ8bcbVPkaE2MBPTeNNtut7HZyEFAm+UyiUdv9Fv06yadaOOpM2A9xX1UatN1U6g/SzdUU8WXIQvc6NfQiaLQdb901/MXOeZWInd
X-Gm-Message-State: AOJu0Yxiy9r417+qGWKAOlnBZSyC4KoVv/kDAISyzV5Al9bb26tCem7w
	k2xgoqTKCu7SkNtHnqGmGA9doemasKaGlizk5oj8+IlR74Ok3cY6ZV23CxBZZaMdMggLdEkj1OR
	x7UrbC58qKOdzZHJSYjr0yGS9EcHZoAxuRPiE5g==
X-Google-Smtp-Source: AGHT+IEZOzGrgTsuOx4rBel1EyOKlek8kFa0ONghcC5HsoRs52ve5zNEZFcAwjiKbm17kuVvOQfsjM1ZMaJeQJAWF+Y=
X-Received: by 2002:a81:d244:0:b0:609:ef6d:9b30 with SMTP id
 m4-20020a81d244000000b00609ef6d9b30mr3129892ywl.4.1710472473294; Thu, 14 Mar
 2024 20:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42> <ZfNWojLB7qjjB0Zw@casper.infradead.org>
In-Reply-To: <ZfNWojLB7qjjB0Zw@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 23:13:56 -0400
Message-ID: <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>, 
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

On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> > > > Second, non-dynamic kernel memory is one of the core design decisio=
ns in
> > > > Linux from early on. This means there are lot of deeply embedded as=
sumptions
> > > > which would have to be untangled.
> > >
> > > I think there are other ways of getting the benefit that Pasha is see=
king
> > > without moving to dynamically allocated kernel memory.  One icky thin=
g
> > > that XFS does is punt work over to a kernel thread in order to use mo=
re
> > > stack!  That breaks a number of things including lockdep (because the
> > > kernel thread doesn't own the lock, the thread waiting for the kernel
> > > thread owns the lock).
> > >
> > > If we had segmented stacks, XFS could say "I need at least 6kB of sta=
ck",
> > > and if less than that was available, we could allocate a temporary
> > > stack and switch to it.  I suspect Google would also be able to use t=
his
> > > API for their rare cases when they need more than 8kB of kernel stack=
.
> > > Who knows, we might all be able to use such a thing.
> > >
> > > I'd been thinking about this from the point of view of allocating mor=
e
> > > stack elsewhere in kernel space, but combining what Pasha has done he=
re
> > > with this idea might lead to a hybrid approach that works better; all=
ocate
> > > 32kB of vmap space per kernel thread, put 12kB of memory at the top o=
f it,
> > > rely on people using this "I need more stack" API correctly, and free=
 the
> > > excess pages on return to userspace.  No complicated "switch stacks" =
API
> > > needed, just an "ensure we have at least N bytes of stack remaining" =
API.

I like this approach! I think we could also consider having permanent
big stacks for some kernel only threads like kvm-vcpu. A cooperative
stack increase framework could work well and wouldn't negatively
impact the performance of context switching. However, thorough
analysis would be necessary to proactively identify potential stack
overflow situations.

> > Why would we need an "I need more stack" API? Pasha's approach seems
> > like everything we need for what you're talking about.
>
> Because double faults are hard, possibly impossible, and the FRED approac=
h
> Peter described has extra overhead?  This was all described up-thread.

Handling faults in #DF is possible. It requires code inspection to
handle race conditions such as what was shown by tglx. However, as
Andy pointed out, this is not supported by SDM as it is an abort
context (yet we return from it because of ESPFIX64, so return is
possible).

My question, however, if we ignore memory savings and only consider
reliability aspect of this feature.  What is better unconditionally
crashing the machine because a guard page was reached, or printing a
huge warning with a backtracing information about the offending stack,
handling the fault, and survive? I know that historically Linus
preferred WARN() to BUG() [1]. But, this is a somewhat different
scenario compared to simple BUG vs WARN.

Pasha

[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714-100000@hom=
e.transmeta.com

