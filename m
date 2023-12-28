Return-Path: <linux-kernel+bounces-12319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFC81F356
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BEDB22787
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17D881E;
	Thu, 28 Dec 2023 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9u8BA4n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF18474
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-427b515c2bbso1142981cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703722666; x=1704327466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+8/BuLzsD57+lMc61ddX8z8AcfRGULMkgo8cesMgKE=;
        b=H9u8BA4nwUQd/ophw4TcV7WFcb3PkZbHsvJ2rb8i0inSMJ9lzhNkrGXOoS8P5C3tav
         i9M6NXe9Dh6Uca/ostV3JEj3EWIcmaZNd/h1/ztegkVYHclOScBCd9TSepb546V9l2Iq
         BGexuRQgZLRCKrTTTWahDuW4O/eB+e/mKypQQHFhczizBmTc3ComGEFZHEI2acC5yBL2
         tgECKPaFWH7EmmnAFSiW1G+1noX5rQWN0OtnIYeitzzcKcQLU5v4Q1FqjjYDFvFgZDOr
         +fYYINDPX/ZJDwOuVtl9ZdLtw5xU+8b8ky1pUrhm+dZy8mrSeliGxC5tgI9l6B3rfxwz
         Bt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703722666; x=1704327466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+8/BuLzsD57+lMc61ddX8z8AcfRGULMkgo8cesMgKE=;
        b=EZNOI0kSJEg5P2tY0w7MLv47qehfAO2HziLDCS4uu4s9OxBkBg/Cu2yMdKD3D+3zbp
         ND+cb7/idFUaLiGEn9cpbO23xyriaS7YjdwgB2XBefxYwnVGLpvZnq+KW2Fre7lyHKP8
         WOFHNcUJpd/KhSN5CbhXSbK0Z2z2rB1jeGDL/U0zahjXLe8lsdTtUXyaoPnnJZNnHJ6Y
         o3SmAg6t3gVvcwEmT79r02/3RN8bdz2+HRQ3xRpb3bqK23YfLR2Xn9p1rZQ5K6OTRj/i
         IL8KRY6aI4fJG+j6XeijOIuAyVXnl6R9KAGqc65Sj+m/Fg36yuhGYtAo64ynr5Duu6Lc
         D57Q==
X-Gm-Message-State: AOJu0YxkuGvQPfoxdFXxEJGlOgtxl5jSmtkKcWpmrKqZ7jFtgEe7xCY6
	CTCheZlevN1kVdyheJmH8V3CafNwCExFja4TKBs7AXwgE+Ga
X-Google-Smtp-Source: AGHT+IE9hPKxsfSZJZ4QMlrexCnwChPJftMlgzyUG48Jhm/2kwHFG909QbIXm9wYquch7HcLDa4rHK47z45Bbnro924=
X-Received: by 2002:ac8:7d0e:0:b0:41c:e312:cbd2 with SMTP id
 g14-20020ac87d0e000000b0041ce312cbd2mr915671qtb.29.1703722666556; Wed, 27 Dec
 2023 16:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-syscall32-v1-1-9621140d33bd@google.com> <20231227233444.GH1674809@ZenIV>
In-Reply-To: <20231227233444.GH1674809@ZenIV>
From: Tanzir Hasan <tanzirh@google.com>
Date: Wed, 27 Dec 2023 16:17:34 -0800
Message-ID: <CAE-cH4qJKrgN6W-JrdiVw8dR-Bso1P0R0koWtw8CmNCYDHDM6w@mail.gmail.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 3:34=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Dec 27, 2023 at 10:38:41PM +0000, Tanzir Hasan wrote:
> > This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
> > the include list, changing indirect includes to direct includes. IWYU i=
s
> > implemented using the IWYUScripts github repository which is a tool tha=
t
> > is currently undergoing development. These changes seek to improve buil=
d
> > times.
> >
> > This change to entry/syscall_32.c resulted in a preprocessed size of
> > entry/syscall_32.i from 64002 lines to 47986 lines (-25%) for the x86
> > defconfig.
> >
> > Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> > ---
> >  arch/x86/entry/syscall_32.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index 8cfc9bc73e7f..66db11fe8a1c 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -4,7 +4,7 @@
> >  #include <linux/linkage.h>
> >  #include <linux/sys.h>
> >  #include <linux/cache.h>
> > -#include <linux/syscalls.h>
> > +#include <linux/ptrace.h>
> >  #include <asm/syscall.h>
>
> Really?  What do we need linux/ptrace.h for?  Because if it's
> struct pt_regs for the generated externs, we might as well have
> just said
> struct pt_regs;
> and that would be it.
>
> <digs around a bit>
>
> As the matter of fact, all you need out of those includes is this:
>
> struct pt_regs;
> typedef long (*sys_call_ptr_t)(const struct pt_regs *);
> extern const sys_call_ptr_t sys_call_table[];
> #if defined(CONFIG_X86_32)
> #define ia32_sys_call_table sys_call_table
> #else
> /*
>  * These may not exist, but still put the prototypes in so we
>  * can use IS_ENABLED().
>  */
> extern const sys_call_ptr_t ia32_sys_call_table[];
> extern const sys_call_ptr_t x32_sys_call_table[];
> #endif

I see that only pt_regs is necessary and I understand this approach.
I was wondering if using this approach would reduce readability.
Once we add the snippet, the file builds even after removing the
following lines:
#include <linux/linkage.h>
#include <linux/sys.h>
#include <linux/cache.h>
#include <linux/ptrace.h>
#include <asm/syscall.h>

It is possible to remove them all, but do you think any should be kept?

Best,
Tanzir

