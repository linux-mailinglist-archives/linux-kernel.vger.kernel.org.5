Return-Path: <linux-kernel+bounces-55856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CE84C288
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629511C24AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED503EEDB;
	Wed,  7 Feb 2024 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUwecNC6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8CDF6B;
	Wed,  7 Feb 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273238; cv=none; b=KSCqnQxUvk7i82HReHsKTn6qzdDl064jbvh/xPQpSRy/3J53gFj12UTTtWnxmnUXEztJilpXYAXz0rks5ThNly85Kvuo2OFgs7Vatt7jO0foCmwV9Xp2+UyrcMP1iA2YBF1fY9YKLfTmLm2GWvm6weD64uFTzLOJiZ9h7o4jkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273238; c=relaxed/simple;
	bh=FyceU2eHMfysVKsT/OrXrhu6WUjbuKxbsD6vVXGxNow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNs2AUZgqDHbM1gkavPF8J3WFSzEl9zgP8DO6bxz/am36JhOJ/I/xWDXOZpfrZgrVwzOQBveQ0fx+m0k6zHGtYEscj74EJZHJjAuGBlp++QdEtQDe1yiu+V/MtL2Qny4uJnfIXRLkMCoOHQEvvY8TR500BCf8/bs3EEfHRBf10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUwecNC6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso996165e9.0;
        Tue, 06 Feb 2024 18:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707273234; x=1707878034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+Q4NQwKDcD01hGprXBdfsI7JEBYKxrIkg4MZMex5wo=;
        b=NUwecNC6fyKn55Lz0uZQERka3oAr7C9BLNKjB5OrgSAqwNKRUnEpebh7YjBPqkQWYu
         NLOkWRoHyUMVyjefNXnS3n+jBhpAXvqBsh8F3cvCrDyFQxISOy4iKV8hku+wkDJhxHb+
         GpaIujuDhq0/Kli5/sUzDv76DXgovh4mOFPx/rmXWqYNjsOZt7vgderlxU7CGUAJcwJ2
         WtkBvU1T3NQef5m7CuvpAjVm/D/xruyRCDSCpEEx+zPAGlEo+iYZaykbHFCEjPdtNPSI
         0HNoSg5d5mXWOl/QETmbT8/NY5RBlmezPpOL/2mQp2iBibrS8E8NDri3k37s3JCs+26C
         aZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707273234; x=1707878034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Q4NQwKDcD01hGprXBdfsI7JEBYKxrIkg4MZMex5wo=;
        b=Zfaq1m6CaS4pPWt7lc+D7ioZEN5rBaExZvQ4Po/h/kJezkBWZdsFguMRdkZo3mSdj7
         uIK/NX9S+CdoqhV2u1RWT7b/aHihuuvb+ywlwcE/X90fjK1z7mjGKMHPnPTN3Ee3NlJH
         tiCTrSYayTA78AaccSyIMINclC93iNys91DTt9GWfZeJDJ59yHulsG8y/5OOFMgE5l2W
         EdtFoBnO+CAAltOdESIoVi6Rfmq1lDXjJfAkOa87moJeiAjqsCp6cjQZmjTK2Ld+GdsA
         5XSAl0vmPaNHNlYte+0i8RXa22mOV5FZIS3BTfYdKrmSvwoQRAJRTsgwnRc+OyOmIGS8
         6RtA==
X-Forwarded-Encrypted: i=1; AJvYcCXc5YShe0bYTxxm1YzoGLe0YJg7T+9ViMr8aX3e2ZknhXP9C5nL1ZVgTSVT4K8lx058EXOuXiqXnaLITHwBaYYokIdXaog5TJ3oN8J5/2eK8wtKpFNDwNYlCNtUSL9pCXKTo6hG4OaUP17/J70MVL0I
X-Gm-Message-State: AOJu0YwAe4NaixEmDW2rQsYnvsXsJLZhNlWIyWYqS1LJjfVk6S1Q8qta
	8TFO5Nh3YN5e5sWt5kdKjfGpB35W/EzUa4c5yh5k4Lx2bhqmvm7BBrrh+pXDoTaKDV2Z2/naoXF
	+DHbWI8UbPwFIrZifn/bNUzGqsT0=
X-Google-Smtp-Source: AGHT+IEzRqFvqiUKAQ9scnameYfeycMjX60u1pRN26hUVAC8Arj3/CA5aYsJu6C3iYvtNTy0/hHE+VgtCyZJzeTmT3w=
X-Received: by 2002:a5d:6b89:0:b0:33b:481f:7e91 with SMTP id
 n9-20020a5d6b89000000b0033b481f7e91mr2493987wrx.39.1707273234319; Tue, 06 Feb
 2024 18:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N> <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJNi4rMiGcP4wdA=1dSOXwYXOKSCWnN8FYxBaFdaAXBqAU_ePQ@mail.gmail.com>
 <xhsmhjznigcdr.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <CAJNi4rPHhEMGbv9ndKxFLdTvdN9a3HBiRkT4jtTp0bOTYvWq0Q@mail.gmail.com>
In-Reply-To: <CAJNi4rPHhEMGbv9ndKxFLdTvdN9a3HBiRkT4jtTp0bOTYvWq0Q@mail.gmail.com>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Wed, 7 Feb 2024 10:33:38 +0800
Message-ID: <CAJNi4rNC3zNi8RywzxXiVLfxVVuCfV_x1GbAXhT+h4DJ5ZrF7A@mail.gmail.com>
Subject: Re: Question about the ipi_raise filter usage and output
To: Valentin Schneider <vschneid@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, nico@fluxnic.net, 
	mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:28=E2=80=AFAM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> On Tue, Feb 6, 2024 at 5:39=E2=80=AFPM Valentin Schneider <vschneid@redha=
t.com> wrote:
> >
> > You should have access to the generic fields which include the CPU from
> > which the event happens. Any of "CPU", "cpu" or "common_cpu" would matc=
h
> > this.
> >
> > So if you're on a recent enough kernel (v6.6 or above AFAICT), you shou=
ld
> > be able to do something like so:
> >
> >   trace-cmd record -e 'ipi_raise' -f 'CPU & CPUS{7-42}' ./foo.sh
> >
> > If you just want to match a single CPU, or are on an older kernel, this
> > should work as well:
> >
> >   trace-cmd record -e 'ipi_raise' -f 'CPU =3D=3D 42' ./foo.sh
> >
> > For example on a QEMU x86 environment:
> >
> >   # trace-cmd record -e 'call_function*' -f 'CPU & CPUS{3}' hackbench
> >   Running in process mode with 10 groups using 40 file descriptors each=
 (=3D=3D 400 tasks)
> >   Each sender will pass 100 messages of 100 bytes
> >   Time: 0.396
> >   CPU0 data recorded at offset=3D0x738000
> >       0 bytes in size
> >   CPU1 data recorded at offset=3D0x738000
> >       0 bytes in size
> >   CPU2 data recorded at offset=3D0x738000
> >       0 bytes in size
> >   CPU3 data recorded at offset=3D0x738000
> >       4096 bytes in size
> >
> >   # trace-cmd report
> >   CPU 0 is empty
> >   CPU 1 is empty
> >   CPU 2 is empty
> >   cpus=3D4
> >             <idle>-0     [003]    29.704387: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    29.704388: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    29.705950: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    29.705951: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    29.706462: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    29.706463: call_function_single_exit:=
 vector=3D251
> >          hackbench-962   [003]    29.706501: call_function_single_entry=
: vector=3D251
> >          hackbench-962   [003]    29.706502: call_function_single_exit:=
 vector=3D251
> >          hackbench-955   [003]    29.706521: call_function_single_entry=
: vector=3D251
> >          hackbench-955   [003]    29.706522: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.101812: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.101814: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.101897: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.101898: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.101985: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.101986: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.102072: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.102072: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.102161: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.102161: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.102250: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.102251: call_function_single_exit:=
 vector=3D251
> >             <idle>-0     [003]    30.102372: call_function_single_entry=
: vector=3D251
> >             <idle>-0     [003]    30.102372: call_function_single_exit:=
 vector=3D251
> >
> >
> >   CPU 0 is empty
> >   CPU 1 is empty
> >   CPU 2 is empty
> >   cpus=3D4
> >           <idle>-0     [003]  1067.718304: call_function_single_entry: =
vector=3D251
> >           <idle>-0     [003]  1067.718309: call_function_single_exit: v=
ector=3D251
> >
> > and that behaves the same as
> >
> >   trace-cmd record -e 'call_function*' -f 'CPU =3D=3D 3' hackbench
> >
> Thanks, # trace-cmd record -e 'ipi' -f 'CPU=3D=3D10 || CPU=3D=3D11' -f
> 'reason=3D=3D"Function call interrupts"' works:
> CPU0 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU1 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU2 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU3 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU4 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU5 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU6 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU7 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU8 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU9 data recorded at offset=3D0x336000
>     0 bytes in size
> CPU10 data recorded at offset=3D0x336000
>     4096 bytes in size
> CPU11 data recorded at offset=3D0x337000
>     4096 bytes in size
>
> # trace-cmd report
> CPU 0 is empty
> CPU 1 is empty
> CPU 2 is empty
> CPU 3 is empty
> CPU 4 is empty
> CPU 5 is empty
> CPU 6 is empty
> CPU 7 is empty
> CPU 8 is empty
> CPU 9 is empty
> cpus=3D12
>           insmod-8519  [010] 170847.580062: ipi_raise:
> target_mask=3D00000000,00000bff (Function call interrupts)
>           <idle>-0     [011] 170847.580070: ipi_entry:
> (Function call interrupts)
>           <idle>-0     [011] 170847.580071: ipi_exit:
> (Function call interrupts)
>           insmod-8519  [010] 170847.580078: ipi_raise:
> target_mask=3D00000000,00000bff (Function call interrupts)
>           <idle>-0     [011] 170847.580080: ipi_entry:
> (Function call interrupts)
>           <idle>-0     [011] 170847.580080: ipi_exit:
> (Function call interrupts)
>           insmod-8519  [010] 170847.580282: ipi_raise:
> target_mask=3D00000000,00000002 (Function call interrupts)
>           insmod-8519  [010] 170847.580329: ipi_raise:
> target_mask=3D00000000,00000800 (Function call interrupts)
>           <idle>-0     [011] 170847.580331: ipi_entry:
> (Function call interrupts)
>           <idle>-0     [011] 170847.580343: ipi_exit:
> (Function call interrupts)
>
> BTW: where does 12 come from in 'cpus=3D12' :-)

Hmmm, please ignore the BTW, it should be the cpu total number in the syste=
m...

