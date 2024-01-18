Return-Path: <linux-kernel+bounces-29833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565383142E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED33281560
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CBC35EF9;
	Thu, 18 Jan 2024 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLu6nWJD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892B35EEC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564796; cv=none; b=qfH8b6IEYVeX0IjSQDykPOsAdPMrNuCsjPDIjzg99lnc9HrxfCf2ktTCa5ESbkxgMA8dzXN07iP0ulK2V0T3UbFjThmp7L7mWujFdVdXqID+xjT335x6ZaUmpbnZ4+jQE8mTNoc4HyEO1FQJP6Z8vQIhMnnXoOqz9/Af738yCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564796; c=relaxed/simple;
	bh=yMXZVovftarfx9nXC5V6swdC+lbaelbqIhMLasAXHIg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jUUC++A2Zdy9xatpmeS6bobiLmrhaGwDMGLF+2+Uy7/NMcqgmC9nWuVlPEEFSBxdyQYn0oIvW1yQXXlSbzuEDOSLbXiCw0fOyNaEXy8AU8G+u76GNAuxNy2k0g7212I6Q9uO6AShJJPdve+SHSqFJZqXB34cd1dautU2y5STRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLu6nWJD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd33336b32so157552891fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705564789; x=1706169589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujxJ36/d8to6tMT+OAXCrMFTALIq+fy5w8TYtBtrzo0=;
        b=kLu6nWJDRrOxcTIWAOdQTf4U4RjtmtfnG11DyrF1FOudQDecAl3hF4mQInqxH8Dw86
         XuOJiBaujla1drUMwKJVuakvQupJczkSpy6PKf0iya00tMEciWpuWeWJEVJV37Dus7tH
         PuX7AtP2mtLOsxyzrSRLBGxIiudPks6CbdNt5D+FwjkHUqsmSk0XJtmVP91s3WNCrlZw
         uYeTfdfn4oML2oetbd5fnHIh1aj1kKAwopn8pCKHO/yRlwTO1b6Zndz6W3VNF5hH0jq5
         lvWV3E2rXlME7NCLDy89vC02Xic85NbhZYEqyK3jbAuuqd0atUqrqx5SfGlYzKHh/zFa
         k8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705564789; x=1706169589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujxJ36/d8to6tMT+OAXCrMFTALIq+fy5w8TYtBtrzo0=;
        b=bHcLAfvC6hIV4uOOq05wpdlicTkx5EcGylL/oGIw7Kfu1V4QMiEYkDws+1Ye8WoRAL
         h+N/nsoOLDWJatnv60paIxy+t3A5MB7Nty5JI36TBgPeM4DLAnJxt8Ejg9S2wawpNQeb
         hcCt/BeW7znoaCkQ85p96XDsC+z+rHagv1ZKFEiY+yDoBkgDWEW1zTJ1jRaRGBksJGn/
         DEusgYXgSvdgXFVKQGdd+amkHQ3ofuVU5UtpWuFKwleZdDpn77FA4rOyXrMX7yAYx5Bk
         npJ5NKBHA43lZBLyjTRb/61pl031WQ8cIbQ2IMw8HgLdkPrDCOxJeHFhuWdUVx1jLARB
         WkgQ==
X-Gm-Message-State: AOJu0YyE/ZAzZxybZjVtqrIXNwtDSZ0stxtBUwV/qCpUDt27+OTZfdHY
	HMOrqVWLG9OgzEwRdlH9wD0oCsbLhvZVzC7YICq1Kgg+OMSmbOGJAj7t9imXRt8vhTOMWU+494T
	/Ka8M8HBlu1Rps5wrAP8Dq+otMP8BfhhUVJKerA==
X-Google-Smtp-Source: AGHT+IHnLdbfvFxRciUug9c9Z2Bvs3MRcujd1nZTRHThbMspw1PVKp6jl1vTAylf9a8Y5iiPHiEUR/cO40jSPcZhwew=
X-Received: by 2002:a2e:b754:0:b0:2cc:5ab2:7f4f with SMTP id
 k20-20020a2eb754000000b002cc5ab27f4fmr249847ljo.103.1705564788917; Wed, 17
 Jan 2024 23:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116234901.3238852-1-avagin@google.com> <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com> <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
In-Reply-To: <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jan 2024 23:59:37 -0800
Message-ID: <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:52=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/17/24 14:30, Andrei Vagin wrote:
> > On Wed, Jan 17, 2024 at 11:34=E2=80=AFAM Dave Hansen <dave.hansen@intel=
com> wrote:
> >> Seems like the real problem here is that the fault_in_readable() doesn=
't
> >> match the XRSTOR.  It's going to continue to be a problem as long as w=
e
> >> don't know what memory XRSTOR tried to access.  We can try all day lon=
g
> >> to precalculate what XRSTOR _will_ do, but that seems a bit silly
> >
> > I don't understand this part. The behavior of XRSTOR is well-defined
> > by CPU specifications, allowing us to easily precalculate the memory it
> > will attempt to access. What does it mean "we don't know what memory
> > XRSTOR tried to access"?
> >
> > xrstor restores only features that are set in fx_sw->xfeatures.
>
> XSAVE is a big old pile of fun.  Someone is confused here and that
> someone might be me.  Let me walk through my logic a bit.  Maybe you can
> point out where I've gone wrong. :)

I could be wrong too, so thank you for looking at this and helping to
find the right solution.

>
> Take a look at the "Legacy Region of an XSAVE Area" in the SDM.
>
>         The x87 state component comprises bytes 23:0 and bytes 159:32.
>         The SSE state component comprises bytes 31:24 and bytes 415:160.
>         The XSAVE feature set does not use bytes 511:416; bytes 463:416
>         are reserved.
>
> and the next section:
>
>         The XSAVE header of an XSAVE area comprises the 64 bytes
>         starting at offset 512 from the area=E2=80=99s base address:
>         ...
>         Bytes 7:0 of the XSAVE header is a state-component bitmap (see
>         Section 13.1) called XSTATE_BV.
>
> XRSTOR accesses memory based on XSTATE_BV (and XCOMP_BV which should be
> irrelevant here).  So we're looking for something at 512 bytes up in the
> XSAVE buffer.
>
> Let's have gdb help us out a bit.  Where is sw_reserved?
>
> (gdb) print/d &((struct fxregs_state *)0)->sw_reserved
> $4 =3D 464
>
> Where does XRSTOR itself look?
>
> (gdb) print/d &((union fpregs_state *)0)->xsave->header.xfeatures
> $5 =3D 512
>
> (xfeatures aka. XSTATE_BV)
>
> There _was_ a reason once upon a time that the kernel started sticking a
> copy of XSTATE_BV in 'sw_reserved'.  I just forget what it is at the
> moment.  It's horribly confusing to it laid out like this, but the SDM
> is pretty clear: "the XSAVE feature set does not use bytes 511:416".
>
> "fx_sw" is actually a software-defined and software-only-consumed area
> of the XSAVE buffer, thus the '_sw'.  Nothing in the '_sw' section tells
> us how the hardware will behave.

I think you don't take into account the requested-feature bitmap (RFBM),
which is the logical-and of edx:eax and XCR0. In our case, edx:eax
is set to the value of fx_sw->xfeatures.

>
> >> because the CPU knows where the fault happened.  It told us in CR2 and
> >> all we have to do is plumb that back to fault_in_readable().
> >
> > I considered this option as well, but then I decided that this approach
> > is better. The most important aspect is that it always rejects bad
> > buffers, allowing a user space to detect an issue even when a fault
> > isn't triggered. I believe proper handling of xrstor page faults could
> > be a valuable additional improvement to this change. If we detect a
> > fault outside of a provided buffer, we can print a warning to signal
> > that check_xstate_in_sigframe is incomplete.
>
> I'm not really following the logic there.  What's the downside of taking
> the fault?

Let's consider a scenario where someone messed up with an fpu state on a
signal frame. With my approach, a mistake can be promptly detected.
However, if we incorporate the page fault handling of xrstor, a mistake
will only be identified if xrstor triggers a fault. In cases where a
buffer is allocated in a large memory mapping, xrstor may silently read
memory beyond the buffer. Next time, a page beyond a buffer might be
swapped out, xrstore triggers a fault leading to application crashes.

Thanks,
Andrei

