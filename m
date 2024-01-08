Return-Path: <linux-kernel+bounces-19039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEEA82671D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D755E281BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983367465;
	Mon,  8 Jan 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byp5a365"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D957F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336788cb261so1341097f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704677348; x=1705282148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4/ImgrVn500fYf+pZOgi0NiVJH/UHbc5pjYLxHng6Y=;
        b=Byp5a365JmAleQ+TNYVgZncVx8YhZEoAn/uX9uEg/48C7rrJ2ax/3apxn+k+W+TpJx
         kIh31h9Oke+FpdskBkJuisRnGL/hiR0kaUCyc4p1wAaTTWnaD5FGEi5gaZUXbnKqWmpL
         q3Uo7t+hjbTrSIkbsj/wKvTdpiW7vR/vZPLP1cQTBob5wY2SLqb03onov6YM2t5h1g+8
         Yi/hq3vBBKFh629S2VawbUGEQltWz9ujjQutaoBHUgSbv9lellq+flGpvtkOIQ6cNRXf
         PfTxukzjmpwpSO1lvPT/iKX+yP8iRqr6CZcWPYepGuQwpXBLVQdmAweWKcFY/kqzGyS+
         vIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704677348; x=1705282148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4/ImgrVn500fYf+pZOgi0NiVJH/UHbc5pjYLxHng6Y=;
        b=xG90Rpyctmwk3uX9hyDPVb1q2sa/qFGomdHHQfquupUtx6+t+KAWM/Xgz5tAfyMlL3
         v55ul+98wOA/EwbQMlJoOKr9m8GU7HdkBFUNWFMtBnrQkO4fCyEDJLHeyonXVgy/Nzke
         VrHRG+QdZ1B0//BDp7nMVRsoHKPbaos0qwPThWqFgrkeCNzOb+HHARtzRYiHi1k1f92R
         QSdl+f0D7Fj5NCtCGwN4S/Kctf+vyCe/RX3pPnj5wxklv/BhOOd2F+6BRSDTjwvZxHTj
         vw1nH1pf6ep4pKSkt2dgg1if9Cdc4jRg+FW71jQK5JCKpmu/BFTn1tawH8fm3BCmdvtS
         YXKQ==
X-Gm-Message-State: AOJu0Ywrszzp6lTm+TJMDA4m2z8oz2449snA+uPvAsd0No8G/l9jPW5e
	P9bk2glT8EwD4KJq3zM5DpRPS60JaRM9zGyAHWGL62d+CCM=
X-Google-Smtp-Source: AGHT+IH7MCyL6fErDRVJbY5DGIBDYbNaDrhcmshh0xd9Qnk2KoJIcXooW5OYrPse6J+kViYg5OY0V2EKooKW3ZoA6h0=
X-Received: by 2002:adf:ec4b:0:b0:336:a5db:e7cf with SMTP id
 w11-20020adfec4b000000b00336a5dbe7cfmr1593157wrn.47.1704677348119; Sun, 07
 Jan 2024 17:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com> <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 8 Jan 2024 09:28:56 +0800
Message-ID: <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Mark Rutland <mark.rutland@arm.com>
Cc: gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Jan 5, 2024 at 2:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Tue, Jan 02, 2024 at 04:53:53PM +0800, richard clark wrote:
> > Ah, the driver is trying to use the native gcc built atomic ops like:
> > __sync_val_compare_and_swap, but it seems the native aarch64 doesn't
> > provide these builtin atomic primitives while they are in the cross
> > compile toolchain.
> > The issue can be resolved by replacing the
> > **__sync_val_compare_and_swap** with **atomic_cmpxchg**.
>
> Yup, that's the right thing to do; drivers *shouldn't* use the builtins
> directly, and *should* use the kernel's native atomic*() API.
>
Right, that's the way I did to fix that.
>
> > But don't know why the native aarch64 toolchain doesn't have those
> > builtin atomic functions...
>
> I suspect this is down to your toolchain enabling -moutline-atomics by de=
fault;
> that expands the builtins into calls to out-of-line functions. I suspect =
your
> cross-compile toolchain doesn't enable that by default.
>
> As above, since nothing should be using the builtins, we don't implement
> out-of-line versions nor do we override the option.
>
AFAIK, the native build for the kernel will not link to the libc.so
but the userland application does, the builtin atomic primitives are
implemented in the glibc:
target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep __aarch64_=
cas4
0000000000130950 l     F .text 0000000000000034 __aarch64_cas4_relax
0000000000130a10 l     F .text 0000000000000034 __aarch64_cas4_rel
0000000000130990 l     F .text 0000000000000034 __aarch64_cas4_acq
seems the '__sync_val_compare_and_swap' used in the application will
be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
complain it will
link to an 'undefined reference'. But interesting, why the
cross-compile kernel will not generate the 'undefined reference', the
cross-compile/build kernel will link to the glibc?


>
> Mark.
>
> > On Tue, Jan 2, 2024 at 11:29=E2=80=AFAM richard clark
> > <richard.xnu.clark@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I have a strong power arm64 box, and the linux distro is ubuntu 22.04=
,
> > > the native gcc version is:
> > >
> > > $ gcc --version
> > > gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > This is free software; see the source for copying conditions.  There =
is NO
> > > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE.
> > >
> > > It will abort the kernel build with the complaint by 'make Image':
> > > ld: Unexpected GOT/PLT entries detected!
> > > ld: Unexpected run-time procedure linkages detected!
> > > ld: ID map text too big or misaligned
> > > ld: drivers/net/nvidia_eth.o: in function `osi_lock_irq_enabled':
> > > osi_hal.c:(.text+0x3cc): undefined reference to `__aarch64_cas4_sync'
> > > ...
> > >
> > > But the cross-compile with aarch64-linux-gnu-gcc on the x86 box
> > > doesn't show the above error message.
> > > Any comments/suggestions? Thanks very much!
> > >
> > > Richard
> >

