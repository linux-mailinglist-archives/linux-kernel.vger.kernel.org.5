Return-Path: <linux-kernel+bounces-99443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76887886D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6625AB21B86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB855466E;
	Mon, 11 Mar 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jGRFXgs0"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E51EB24
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183564; cv=none; b=NCS0dgQmfIDXo+oW3j4rYjMm+OgAiswUTKHePsdEDfG4lTS4WHYx5fQTjo9x3tn0e4tnLoO2JIqTBHSZXVrmo+peQVMAoo2b/rxojxpfm2DBbgfH45+PbHXT0R1p+KNj/6U4ravNynS0X6J5FSbEzoMBT01BNjbKhy7YI6HqOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183564; c=relaxed/simple;
	bh=F7yEjUH2hqaPjpKrV4lv2CTP/Ykmgg4sI9QI5kdnGhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXHNiL/H2RXOwg8g8EWzkj96ijNwVFaj7Ah/WliNqoqiaEUYzcdbgMAFFUCr4JJnQkGPq2RxNiuZ6MuXN6Y6vAPx2Qu41yqnCCc4agxyXYEMftI4LrNNxrvAE+Xxk+0ckr6oL8AGnVjqF+vtmj4APLso6b7Vj3Z89S7c1X38QdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jGRFXgs0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a029c8e76so38960211cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710183561; x=1710788361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7yEjUH2hqaPjpKrV4lv2CTP/Ykmgg4sI9QI5kdnGhY=;
        b=jGRFXgs0cWiZ6HZPjle47s2nerO8sjQvk84tbHj8QMac/dRhZIhtFpgGtVr3QxeiMi
         r4UZK+nu1d2Rdt+PI5f4UN66Z/Y/WwWR7eUqOgPqqdqD3pHEnowg9SHt7dZfhIhJFwHX
         +Qesp7Vh6zsVj6Crg05179bIzww/Qh8R+4tkVr32p047YY8YVIt6pLZvQm4CVFtwLLyd
         zP8qA1C2BLVJFt6VpEW6mYbU7VUTAq1FNEWljiD5TpwTXOWOBBbOTOlQEcbdp4R8oTxG
         r974H38nSGskCzYMAm1vdgiuM3t+rcKggEfxcmNxjq1WdyA+v0FrhgeMvUpeM7HANZgD
         m2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183561; x=1710788361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7yEjUH2hqaPjpKrV4lv2CTP/Ykmgg4sI9QI5kdnGhY=;
        b=cnWuDxC1cPyGg3Hmpq4BZDDwVk4GmMrZXGAcoyE+GaL1wHslI8UyNxewGq0EljHniN
         g4FgP//u4kwrdDUZMD63hjTRUej4uJ44z1ZgcFjmzraTLknbH+ATidFg6ExWCBR4ll+q
         NJq0GZU4C98xIHa//V7cwUkv0INekqM2fSO1GptvFb179XKFKSD3okv1o84wYQOnP9o/
         P3vq/BUuhylvxyr4JAVSD4Isyzw8Vena9OeLp59FCYza/MWIZrhVodwbZlDLaHQmTD3i
         2mXfyrJk6EQB9X1dlFFHeIWIUAQ9tRvokxUO8EHnBa6EHyoHUOgNRxXK72IS6EBgmX7S
         llXA==
X-Gm-Message-State: AOJu0YzJZ1PRPm9R+jRupqo6zHUi0XZqQUlRw03FgYoWMGbGY2Zh+WHi
	7KC1iLacmoKWvKhQQN/ORQtHL+VJgJAIRyxwISrixSamrB/sGMFg+txtex/DQMayfFQuKvpPqN8
	Li/S2cczvQCvlnpYlDFF4B1vaPnJRNchov2oWGw==
X-Google-Smtp-Source: AGHT+IHhWoUziIo/dulgzgVm9eXi+3lXMqItaWWRi6EPNkrmYCmfHTmNck2A3vCarMYvNNFfu4ThbWVSvWRNxjTf1Ys=
X-Received: by 2002:ac8:7d07:0:b0:42f:f7b:f789 with SMTP id
 g7-20020ac87d07000000b0042f0f7bf789mr1493749qtb.40.1710183561602; Mon, 11 Mar
 2024 11:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <CAGudoHERLX=X1r0q7yHM22O9udsR=6M+geix7TR3f8ZzHkb-hQ@mail.gmail.com>
In-Reply-To: <CAGudoHERLX=X1r0q7yHM22O9udsR=6M+geix7TR3f8ZzHkb-hQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 14:58:45 -0400
Message-ID: <CA+CK2bBr2wH4=L39ZthRPUnAjVxMqt80bsZj0NPx9xdH=_Mn0Q@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com, 
	npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:09=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On 3/11/24, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > This is follow-up to the LSF/MM proposal [1]. Please provide your
> > thoughts and comments about dynamic kernel stacks feature. This is a WI=
P
> > has not been tested beside booting on some machines, and running LKDTM
> > thread exhaust tests. The series also lacks selftests, and
> > documentations.
> >
> > This feature allows to grow kernel stack dynamically, from 4KiB and up
> > to the THREAD_SIZE. The intend is to save memory on fleet machines. Fro=
m
> > the initial experiments it shows to save on average 70-75% of the kerne=
l
> > stack memory.
> >
>

Hi Mateusz,

> Can you please elaborate how this works? I have trouble figuring it
> out from cursory reading of the patchset and commit messages, that
> aside I would argue this should have been explained in the cover
> letter.

Sure, I answered your questions below.

> For example, say a thread takes a bunch of random locks (most notably
> spinlocks) and/or disables preemption, then pushes some stuff onto the
> stack which now faults. That is to say the fault can happen in rather
> arbitrary context.
>
> If any of the conditions described below are prevented in the first
> place it really needs to be described how.
>
> That said, from top of my head:
> 1. what about faults when the thread holds a bunch of arbitrary locks
> or has preemption disabled? is the allocation lockless?

Each thread has a stack with 4 pages.
Pre-allocated page: This page is always allocated and mapped at thread crea=
tion.
Dynamic pages (3): These pages are mapped dynamically upon stack faults.

A per-CPU data structure holds 3 dynamic pages for each CPU. These
pages are used to handle stack faults occurring when a running thread
faults (even within interrupt-disabled contexts). Typically, only one
page is needed, but in the rare case where the thread accesses beyond
that, we might use up to all three pages in a single fault. This
structure allows for atomic handling of stack faults, preventing
conflicts from other processes. Additionally, the thread's 16K-aligned
virtual address (VA) and guaranteed pre-allocated page means no page
table allocation is required during the fault.

When a thread leaves the CPU in normal kernel mode, we check a flag to
see if it has experienced stack faults. If so, we charge the thread
for the new stack pages and refill the per-CPU data structure with any
missing pages.

> 2. what happens if there is no memory from which to map extra pages in
> the first place? you may be in position where you can't go off cpu

When the per-CPU data structure cannot be refilled, and a new thread
faults, we issue a message indicating a critical stack fault. This
triggers a system-wide panic similar to a guard page access violation

Pasha

