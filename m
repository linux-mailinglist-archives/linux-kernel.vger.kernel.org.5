Return-Path: <linux-kernel+bounces-17218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94E8249F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE49D1F232E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B52C6BA;
	Thu,  4 Jan 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpnWjdwu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE52C6B1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367601a301so741157f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704402058; x=1705006858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEAMqcwvVp1DhUld3ZPVwdQv2+1sf5VUPmdEsVkdBtY=;
        b=SpnWjdwux3KkzMWGFkYybFhMKn+c8ALj5w7SSaR/Itfwums/YjWQKCXlGLANwmvIln
         cJj/rW3XmXVQJOsJvWDCcz/d0kkOniu2DHDOGxDhMqEY3+9m1taqH5qvVzUsmFTRGbqc
         5nPA9o8WHTqDnoy200N99Y7bqNm43yLpLJ35RPKVhILaPmewLFgA0gvzFrygGmVSTn+V
         h5aMxNkl8iHdtoU1XM+DUAcByFgtzqntMwBO2JSsmKwlhZrJUIdTPoyWMC2ZiOrUg9H/
         QgfWsIxOZWyyylUXeDGeNYwk4p9/6QlFKKMBV1dJGRhWfCWqXZb02O5I5VM36BRVcu9w
         SfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402058; x=1705006858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEAMqcwvVp1DhUld3ZPVwdQv2+1sf5VUPmdEsVkdBtY=;
        b=UUguN/YYe5jZICRE/AQNqKFqvEU6phCwM+kNSpouP3NcRDgwWzo9OJvnX+T8Yj/CRC
         SPYQeARBWm1iKlj3lMtLjpeU67Bi8zEKxOfbdEyL84B+kRbWWiaft84A1X/vooOd/GTn
         3iGTqTIAsIwUaKRv8FFuQeK1VsLoG8Sj4SkomVcH523xuE2LBwnrItn56oBOWOg9wc6s
         NXbeZVdGc2B+A1KEub0nUP+FW3yt97lT0uY8EJtJBFpk184x+IyYMFGRpxspifl6YSTw
         fnZT2aMyJNRjMBL9f9sMTuFROg0xUjTO4q2ENo0QS5Lso3HiwfHEz1IE2MbAFTcOWmfV
         +O+A==
X-Gm-Message-State: AOJu0Yw+0oR/CmnBpihtXDzxcNmvh6/Bn2fqFpdOimKFSirAFg8Rs4Bw
	R42dZtQ40DsFlYOvJw9/5DIuz/NPILXL5u0/tZ+ne+hwFjpv
X-Google-Smtp-Source: AGHT+IGnz0hIaUYAe6KC2sXCl+1eMOmFFLbu8uSOJVy5nDv4gYIVlwfMzQZ5FIzzoEeyNT+igRqC/QQCb41ddjC9nWY=
X-Received: by 2002:adf:a450:0:b0:336:ddca:4824 with SMTP id
 e16-20020adfa450000000b00336ddca4824mr404049wra.122.1704402057523; Thu, 04
 Jan 2024 13:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-syscall_64-v1-1-57fe392ef565@google.com>
In-Reply-To: <20240104-syscall_64-v1-1-57fe392ef565@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 4 Jan 2024 13:00:42 -0800
Message-ID: <CAKwvOdn8ivC1xKUCgZznQ1pZ1DeRYNoUEYZPB=LiQjdHpciC+g@mail.gmail.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_64.i via IWYU
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 4:13=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> wr=
ote:
>
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
>
> This change to entry/syscall_64.c resulted in a preprocessed size of
> entry/syscall_64.i from 64003 lines to 24509 lines (-62%) for the x86
> defconfig.
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  arch/x86/entry/syscall_64.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> index be120eec1fc9..9e4a3d8957f3 100644
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -1,12 +1,22 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* System call table for x86-64. */
>
> -#include <linux/linkage.h>
> -#include <linux/sys.h>
> -#include <linux/cache.h>
> -#include <linux/syscalls.h>
>  #include <asm/syscall.h>
>
> +struct pt_regs;
> +typedef long (*sys_call_ptr_t)(const struct pt_regs *);
> +extern const sys_call_ptr_t sys_call_table[];
> +#if defined(CONFIG_X86_32)
> +#define ia32_sys_call_table sys_call_table
> +#else
> +/*
> + * These may not exist, but still put the prototypes in so we
> + * can use IS_ENABLED().
> + */
> +extern const sys_call_ptr_t ia32_sys_call_table[];
> +extern const sys_call_ptr_t x32_sys_call_table[];
> +#endif
> +

arch/x86/include/asm/syscall.h (which you retained) already includes
the typedef for sys_call_ptr_t, and the declaration of sys_call_table,
and everything else.

Was there some additional refactoring that Al mentioned or intended
for you to do here?  Perhaps as part of a series so it's more obvious
to reviewers? You can include a Link: tag (see `git log` for examples)
in a commit message to link back to discussions on lore.kernel.org.
Doing so can help provide more context to reviewers as to //why// or
justification for a change.

Otherwise I'm not sure you need any of these additions (other than
maybe pt_regs).

>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs =
*);
>  #include <asm/syscalls_64.h>
>  #undef __SYSCALL
>
> ---
> base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
> change-id: 20231228-syscall_64-30ba68440a85
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--=20
Thanks,
~Nick Desaulniers

