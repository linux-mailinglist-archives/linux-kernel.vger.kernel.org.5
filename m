Return-Path: <linux-kernel+bounces-97255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E518767A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C00F1F22080
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE301241E2;
	Fri,  8 Mar 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgoSEAE9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A854366;
	Fri,  8 Mar 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912970; cv=none; b=Fivub/gMSk8cT3a0Ey4JlcllYLZOsStzBwhdlOSeLzSdXeUTsOicn9YBcV59rycD6pxNUrFUD72s/UaIwJzc+VwXusokB0TPkPk3i0nrPj0I31eQOajiYnJpJ2X6V8YbGgj/H8jAv2KTblToG7LMXM2+CaZjKnvF74HcbGOv+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912970; c=relaxed/simple;
	bh=91DpN+5jqCtFxdFAdJyx2F5lCUgsbaBUIGnQ7cQW6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugm6K51lnGuAVj/QuB3VESIxpYdW8qNFnVBugAnpCfhTBNRYGblALjCsaCLI50YIqiC+q/upoT7rOkCWTWkRi5i5Gtt8j17uxf9NbeXZQNNvoHDM2PyXJXjlLiur+s/vofrSQDm/gDw5bDUIq8kNGjnfAM1+bQQLl4TFwYLF9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgoSEAE9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5134d7e16a8so2011381e87.3;
        Fri, 08 Mar 2024 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709912967; x=1710517767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld+4cFJiCUpIgeEmlpcazZFkXkoYjxiqrgcd7maZMKE=;
        b=EgoSEAE9Kc+Kl86M1QHBI+dh3gMT7xzuPaKchZ2ptb+McrNa2b+9LKdat87/kh4uhh
         B9URnxqCGr9CtBC+/EqgzbZqi0ekr9LjgOkAAMNL4TG1U84UnfXB8D9+ZnxgFjm9yRZi
         XnBXky1JQaf1RcrKFhxEeIMBSi17vJ5XGcRnbZVMWEImTYuhgWCeEFKHkhtrG9e5bTGC
         RcS51hmIZtE5AVZm6+MXJoUSSjF6NUeN9R5oKhmpN3sFqSEpNCkclkIGe+YxjV22O8dj
         Tc+FekWR4kvOlk3GCM+Khf8+RIIH4asWg8yy72r49rrI1Na4do+jdDCu+CojYgadDFrd
         53NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709912967; x=1710517767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+4cFJiCUpIgeEmlpcazZFkXkoYjxiqrgcd7maZMKE=;
        b=fS/xzeLfV6GTmOTJfuLVkZZTiVUj3dDIfjIFZefQpE/Zx0+gp0x42FDWJMAtQd9Zzw
         YseoAs+6n9sLlpM+iPow2HynDsSNxP1Y/mjPaNrI6raB2hTN1U9wV3u++JQvYecK0M3U
         SbwGaAg1aErD3YccDbjICErxEDZZKt53dYNvQ85OflycchRF2XnehyYRfQdkI5DcIbhW
         Nin7qj96zDIvZTQnM0RkhHZ9JiEya2EssmeFMcW24Vs9JPGF4/USjcbbCW3IiDCn6P5H
         t7NXw1NFdpZgriWR062403mElY1ABfFIYQzqBLz2z+MVRverPsEnuTV9Bp17s5mndNtS
         5s9A==
X-Forwarded-Encrypted: i=1; AJvYcCVUDjEsXsqSGO+TYVvp/kSWoY5yversnkZunvqiXBoeQ7duPwjOcTpsPF3O685TVOGECOnjgkRdsMlBSRUf4zr4ipkCD9zkugYpvTjBMDSQMpJDVFwdYfN1iEoNdOtNwVhRVd+ilp060w==
X-Gm-Message-State: AOJu0YyhmykZGIDNtl6MdgnS9jqvbrPX5+tKE0NDDiymvunFl5i35V7I
	ffXMmclbG37ZRcWsKogfF2eEBljIfBxzomCjgMYJsuTKgeAVXib9ImW8RC6zMdf07tNNLm9qa6D
	emb+wkicZJSLTGy4Pku+EvRx0xzM=
X-Google-Smtp-Source: AGHT+IGPyssiDhhfcu2ArxzuzahLXmqh8jRRtzzOKzL6wiSwUy7U9ClXjqn4LMqSqv3rNw24PwXN+9uNqUZrMxSzDL4=
X-Received: by 2002:a05:6512:3d09:b0:513:3309:cc62 with SMTP id
 d9-20020a0565123d0900b005133309cc62mr4774260lfv.47.1709912966304; Fri, 08 Mar
 2024 07:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsVni7x6AuP97i10oxcusUrB4+m2wpM4Z3mTzWsnMz-Mg@mail.gmail.com>
 <8f69d1f2-0ce3-4851-a784-c76b274dd9ff@app.fastmail.com> <CA+G9fYvhxJ_Tokrc3zxgP4UNjrRXjhxjfqMtSbMOoURCF1GjmQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvhxJ_Tokrc3zxgP4UNjrRXjhxjfqMtSbMOoURCF1GjmQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 07:49:14 -0800
Message-ID: <CAADnVQJLhKPA1MGtpqDwAnSDrCXBd1dxoCor2RwD22a-VLpiKA@mail.gmail.com>
Subject: Re: arm64: WARNING: at mm/vmalloc.c:315 ioremap_page_range
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Christoph Hellwig <hch@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mm <linux-mm@kvack.org>, 
	linux-next <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 6:24=E2=80=AFAM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> On Fri, 8 Mar 2024 at 17:34, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Mar 8, 2024, at 12:53, Naresh Kamboju wrote:
> > > The following warning was noticed while boot arm and arm64 devices.
> > > The below log is extracted from arm64 ROCK Pi 4B while booting and
> > > another issue is kernel oops noticed while testing selftests:  kvm:
> > > memslot_perf_test.
> > >
> > > 1) WARNING: CPU: 1 PID: 201 at mm/vmalloc.c:315 ioremap_page_range
> > > 2)  Unable to handle kernel NULL pointer dereference at virtual addre=
ss
> > >   Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > >   Kernel panic - not syncing: Oops: Fatal exception in interrupt
> > >
> > > Please find steps to reproduce, logs and config file links below.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> <trim>
>
> > The warning was added by commit 3e49a866c9dc ("mm: Enforce
> > VM_IOREMAP flag and range in ioremap_page_range.").
> >
> > This indeed uses a special memory area at a fixed physical address,
> > but I don't see where the vm_struct comes from.
>
> Thanks for your explanation.
>
> > No idea here, but it seems unrelated to the first one.
>
> I will reproduce this issue a few more times and get back to you.

See the proposed fix:
https://lore.kernel.org/bpf/CAADnVQLP=3DdxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=
=3DaRgCPQ@mail.gmail.com/

but Christoph believes a different approach is necessary:
https://lore.kernel.org/bpf/Zeso7eNj1sBhH5zY@infradead.org/

