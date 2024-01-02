Return-Path: <linux-kernel+bounces-14648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00EF822030
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856A4283C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D2156CF;
	Tue,  2 Jan 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZIjfuL9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AC156C4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9b266183eso3345459b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704215533; x=1704820333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7NXKEgXdHjYVxZjQ+glTnfqrXsU8+TElZVCKqDb078=;
        b=DZIjfuL9DWIPIwy4WPEAPISaeDs/UKwc1lg1WIP2miYD23SMbT9TafLrCLd1DI3D0O
         N92WsLWgsJ5gi1ndmgUrwtA4RpuSTHPR3NEZosUkIRlOotcClCNqih6LumBDKsgks+YB
         qNpUot+qdZLa8DkwCYrBkZg6cyRpgRe/gjavenF0bXZIj4VhZ/50JXTnCQhauASmvEl8
         pdHsgih3aamM7QkwUf/DZkyIHRB/dPxwa4C2lbRZg7Y3rjxCHwbs8X39DDkGIq+hm40X
         KrAn4uPAun5SQqNHD6Jn7PnbgaSBS1MAYp7vcM7++PAaiO6BCg116szHAIbm+5pjiImo
         b0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215533; x=1704820333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7NXKEgXdHjYVxZjQ+glTnfqrXsU8+TElZVCKqDb078=;
        b=iLZZrbhMaatN8+CBeuIEyqD3DE+/NGX8udlWp2w1Rd4yR3f5e3mHqjrS5cJNvPsAUN
         w/l6jcd7aA+AOaeSQTPtJ5ioHgyVZHnn4SZl1OUNJKgjD6sPremPIoNMWZCa5t4exSJA
         1E+Wt+XmyZHzv9woaHjGKDYbmHlICfp2vW9Pc5lOqMYcZWnqN9lxCPDf5uLm74Fq9nh7
         gur43N4iGADphgjwSA3I5ESdf5HLxRDIQbxUyzQd4U+IGTyjIb4pkV4ylT/TkhnHnuOK
         r4TY5eJk+eug4WfC32lA3Qqvgv8pxlfZ0CohVTsxbjiV+6sHVlR5ML9+SiToxpR0jA5I
         iW8g==
X-Gm-Message-State: AOJu0YwWbxiSj2wfO3wgRW7cS1oQDZJWdsYF0V2I77Jh2Pin54RKFJLd
	41cr7gDtoysCrd35c14wluTfPzBop6TFWT3dOw==
X-Google-Smtp-Source: AGHT+IE6F9j1sQba7ivhV7acqtqv+l4AjkJL4kw0OUf5poX7f5CYxUjhY2ZP6zPIDQQIGBJK7ymuyU26AhM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:308f:b0:6d9:ab9d:e3b6 with SMTP id
 bh15-20020a056a00308f00b006d9ab9de3b6mr96612pfb.1.1704215533056; Tue, 02 Jan
 2024 09:12:13 -0800 (PST)
Date: Tue, 2 Jan 2024 09:12:11 -0800
In-Reply-To: <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2285758.taCxCBeP46@uriel> <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
Message-ID: <ZZRD66ilLsX53Vj_@google.com>
Subject: Re: x86 SGDT emulation for Wine
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Elizabeth Figura <zfigura@codeweavers.com>, x86@kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 27, 2023, H. Peter Anvin wrote:
> On December 27, 2023 2:20:37 PM PST, Elizabeth Figura <zfigura@codeweavers.com> wrote:
> >Hello all,
> >
> >There is a Windows 98 program, a game called Nuclear Strike, which wants to do 
> >some amount of direct VGA access. Part of this is port I/O, which naturally 
> >throws SIGILL that we can trivially catch and emulate in Wine. The other part 
> >is direct access to the video memory at 0xa0000, which in general isn't a 
> >problem to catch and virtualize as well.
> >
> >However, this program is a bit creative about how it accesses that memory; 
> >instead of just writing to 0xa0000 directly, it looks up a segment descriptor 
> >whose base is at 0xa0000 and then uses the %es override to write bytes. In 
> >pseudo-C, what it does is:

...

> >Currently we emulate IDT access. On a read fault, we execute sidt ourselves, 
> >check if the read address falls within the IDT, and return some dummy data 
> >from the exception handler if it does [1]. We can easily enough implement GDT 
> >access as well this way, and there is even an out-of-tree patch written some 
> >years ago that does this, and helps the game run.
> >
> >However, there are two problems that I have observed or anticipated:
> >
> >(1) On systems with UMIP, the kernel emulates sgdt instructions and returns a 
> >consistent address which we can guarantee is invalid. However, it also returns 
> >a size of zero. The program doesn't expect this (cf. the way the loop is 
> >written above) and I believe will effectively loop forever in that case, or 
> >until it finds the VGA selector or hits invalid memory.
> >
> >    I see two obvious ways to fix this: either adjust the size of the fake 
> >kernel GDT, or provide a switch to stop emulating and let Wine handle it. The 
> >latter may very well a more sustainable option in the long term (although I'll 
> >admit I can't immediately come up with a reason why, other than "we might need 
> >to raise the size yet again".)
> >
> >    Does anyone have opinions on this particular topic? I can look into 
> >writing a patch but I'm not sure what the best approach is.
> >
> >(2) On 64-bit systems without UMIP, sgdt returns a truncated address when in 
> >32-bit mode. This truncated address in practice might point anywhere in the 
> >address space, including to valid memory.
> >
> >    In order to fix this, we would need the kernel to guarantee that the GDT 
> >base points to an address whose bottom 32 bits we can guarantee are 
> >inaccessible. This is relatively easy to achieve ourselves by simply mapping 
> >those pages as noaccess, but it also means that those pages can't overlap 
> >something we need; we already go to pains to make sure that certain parts of 
> >the address space are free. Broadly anything above the 2G boundary *should* be 
> >okay though. Is this feasible?
> >
> >    We could also just decide we don't care about systems without UMIP, but 
> >that seems a bit unfortunate; it's not that old of a feature. But I also have 
> >no idea how hard it would be to make this kind of a guarantee on the kernel 
> >side.
> >
> >    This is also, theoretically, a problem for the IDT, except that on the 
> >machines I've tested, the IDT is always at 0xfffffe0000000000. That's not 
> >great either (it's certainly caused some weirdness and confusion when 
> >debugging, when we unexpectedly catch an unrelated null pointer access) but it 
> >seems to work in practice.
> >
> >--Zeb
> >
> >[1] https://source.winehq.org/git/wine.git/blob/HEAD:/dlls/krnl386.exe16/
> >instr.c#l702
> >
> >
> 
> A prctl() to set the UMIP-emulated return values or disable it (giving
> SIGILL) would be easy enough.
> 
> For the non-UMIP case, and probably for a lot of other corner cases like
> relying on certain magic selector values and what not, the best option really
> would be to wrap the code in a lightweight KVM container. I do *not* mean
> running the Qemu user space part of KVM; instead have Wine interface with
> /dev/kvm directly.

+1.  Pivoting to KVM would require quite a bit of work up front, but I suspect
the payoff would be worthwhile in the end.

See also https://github.com/dosemu2/dosemu2/tree/devel/src/base/emu-i386.

