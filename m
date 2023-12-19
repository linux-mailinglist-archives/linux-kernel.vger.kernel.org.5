Return-Path: <linux-kernel+bounces-5863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D481908C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C01C24710
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0C38F94;
	Tue, 19 Dec 2023 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bvE3cIP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762B38DF5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4026661276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703013520; x=1703618320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk2WOblYJMsl3hzTJZL7x+a3eKwopbV7abftu0jaO3o=;
        b=2bvE3cIP9WLqH3jxFHYx8WGEXiBcMIHTsBFjQ0vJQ0VDKGwcGUXZUblGqb74e4LMU8
         AoFyG/o310lTCk/JxALjDMFmgM8B9C2huzSFMVSdT1xUH2s4PyWfWLXGe+VYnl+ljPsa
         hhoWaO/uimwlzVpZxIJ0gCvP2zypE52fBmRX5ZCIdFiGX+F8y1MoFzTn8Z0nfWAcYC2w
         JJtm1el9IqjYeVjX8DFTVnjq/drjpXTuyCWKQ7JEQhUtzhuU6fBFv4HIQojeMF8dhUbT
         IHb2dZO4+DsjadmBMhgMGj+I/DBll1+iA/nJORoFgZN1PIgiTRcqWj5+S73klOHbIz4g
         5aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013520; x=1703618320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk2WOblYJMsl3hzTJZL7x+a3eKwopbV7abftu0jaO3o=;
        b=Hjj8+baeTNl8+X/K6Wqtq+aBCl9c13FwvxxAQNpmIUkjmwwh9fsK8Eru//0lUs4nsr
         vEY8melp/wHdIs52HgPESVwhkp5EUqKoqyXHFTPOXxPzH/ac+m947B9jni1TEUu+CFyd
         tVkDNhvC809D169gtHMJ7DDDXSxOYEcSPwA+89iwXkm+ps+MLQqo4PlpDkzE9VlnkORq
         PUz7sTYf1DdtY1cdBmTRsbtTTXBqTRgo/qf96Vb3hvhutuYaMoyrUMga6rq/vT48fTKD
         73Hoa+29Uy4G5Vsa5U15qrx0c/YQ4Q+a/XSGj90AiFCwz/c76cqkusI0/aYVCJQv2JXO
         jvOA==
X-Gm-Message-State: AOJu0YzsD1hnP9aiA7OFb9qxNwjDvEYIzQ/Q/ZWl6ZwDa6a137i9V/Nv
	nPmnbi+zgbn59yPJFWB+MyYJrYRhSoZhsR0x5hrZzA==
X-Google-Smtp-Source: AGHT+IEQnJH2FyDceXOzOBMy4ilQPUAbQxXDL6OLSAh4zACKDqdNbLqCjwWUh4R2wa3Q2YxVRYIHrhk3t3bA+xnDWvc=
X-Received: by 2002:a25:fc20:0:b0:dbc:dea7:19a8 with SMTP id
 v32-20020a25fc20000000b00dbcdea719a8mr6143146ybd.121.1703013520291; Tue, 19
 Dec 2023 11:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312191507.348721d2-oliver.sang@intel.com> <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
 <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
In-Reply-To: <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 19 Dec 2023 11:18:02 -0800
Message-ID: <CABCJKufi2_BcSwc+j=L9VMwGVteSFX509RO6QCC3g-ZtRo5cGQ@mail.gmail.com>
Subject: Re: [linus:master] [x86/entry] be5341eb0d: WARNING:CPU:#PID:#at_int80_emulation
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, kernel test robot <oliver.sang@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, xen-devel@lists.xenproject.org, 
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:21=E2=80=AFAM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 19 Dec 2023 at 01:58, Borislav Petkov <bp@alien8.de> wrote:
> >
> > Looking at the dmesg, I think you missed the most important part - the
> > preceding line:
> >
> > [   13.480504][   T48] CFI failure at int80_emulation+0x67/0xb0 (target=
: sys_ni_posix_timers+0x0/0x70; expected type: 0xb02b34d9)
> >                         ^^^^^^^^^^^
>
> So I think the issue here is that sys_ni_posix_timers is just linker
> alias that is used for any non-implemented posix timer system call.
>
> See:
>
>   #define __SYS_NI(abi, name)                                            =
 \
>         SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
>
> and this all worked fine when the actual call to this was done in
> assembly code that happily just called that function directly and
> didn't care about any argument types.

Yes, that's exactly the issue.

> But commit be5341eb0d43 ("x86/entry: Convert INT 0x80 emulation to
> IDTENTRY") moved that call from assembly into C, and in the process
> ended up enabling CFI for it all, and now the compiler will check that
> the function types match. Which they don't, because we use that dummy
> function (I don't think they do in general).
>
> I don't know what the best fix is. Either CFI should be turned off for
> that call, or we should make sure to generate those NI system calls
> with the proper types.

Probably the easiest fix would be to use SYSCALL_DEFINE0 for
sys_ni_posix_timers, and for architectures that implement syscall
wrappers, change sys_ni_posix_timers references to
__<abi>_sys_ni_posix_timers.

Something like this should fix the issue for x86, but it looks like
arm64, riscv, and s390 would need similar syscall wrapper changes:

diff --git a/arch/x86/include/asm/syscall_wrapper.h
b/arch/x86/include/asm/syscall_wrapper.h
index fd2669b1cb2d..ed38265cad27 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -87,7 +87,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *r=
egs);
        }

 #define __SYS_NI(abi, name)                                            \
-       SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
+       SYSCALL_ALIAS(__##abi##_##name, __##abi##_sys_ni_posix_timers);

 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)                                          \
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8..d58f976ec926 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -22,7 +22,7 @@
 #include <asm/syscall_wrapper.h>
 #endif

-asmlinkage long sys_ni_posix_timers(void)
+SYSCALL_DEFINE0(ni_posix_timers)
 {
        pr_err_once("process %d (%s) attempted a POSIX timer syscall "
                    "while CONFIG_POSIX_TIMERS is not set\n",

Sami

