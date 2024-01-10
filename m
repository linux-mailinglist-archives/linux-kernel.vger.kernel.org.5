Return-Path: <linux-kernel+bounces-22515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C9829EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016D61C226D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DB4CE12;
	Wed, 10 Jan 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n4EFIs1N"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AD4CE04
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ce3e5bc2afso870106241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704906872; x=1705511672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47+kebr9NR02suN55GcRoFoS4Z36G90GbJxMRtrcWos=;
        b=n4EFIs1NvSq88XGEkWTtpyXV4NZKyU4LgFsRo/qzo6xrDdrSy03020rw8n1MoW2qQ6
         uKIjxWkXsPvnKCjDIMnQV2/2jAwBxfayEqIYK92Rq43QqAvfptfaJhEGBPs1VaqzG9BK
         4C8lWwR+CCEt9LzAgJOh3ziHXaSn8Ye1kZ7Wgli/XbiETGUXBvly06eQ378nAPSmttmz
         5KJ+m9M9yU9ZN8CtNrOdAzDTp7O/fvtdolL47SE2P8F+/BoRr1SVbOhoWIXTX1K6H0WF
         zYzt6YLFGw5mm+18nJuI5Hvwf7eLWqooawxBd65SrhCZJEANDd2CcdyIOrC8ElFnCX/L
         6WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704906872; x=1705511672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47+kebr9NR02suN55GcRoFoS4Z36G90GbJxMRtrcWos=;
        b=H0Fcg7mzOOfigxGncPQ0ovtdqwcISNewAUu1qIVee3lSHOHErL12lGNXKkLNbe6L3B
         1trECQUyYe1X55z6knGTkgbeXn+YxG9djVEtEVw01ZSNC1CF2OEgHW1rSrimUPWxoIO2
         sInyOIbB5R3yotepbZHIm6iwU/IfIZk/QT5zcta1ObbZaHAr9iR2sL77oYAOLj6uVK5W
         0bENWcNUvXDadR3WQ29NewhtcX3wjQomVIZZGiV+c0xwJocLIVFDvcZCIsnlFhdjFwX2
         dLrwpBYyQks+CoT+D9FrTlTzuaCjMlkgAispkqC/PmRRgp1qN0QDm1MiRZsnzmw8be2H
         iFAw==
X-Gm-Message-State: AOJu0YySEPuO9KpUtu7XM4E0U3a8npwFWSmkdU1IvutaUPPMYM/Y/oQP
	p054IDuvxKEca8hB7uo+D6jG+iMPpopmIEe4xkjEgUdYCALp
X-Google-Smtp-Source: AGHT+IFt1ee4CI7VwM2yjMu1duupkUufXWQXpIrbOUtpjd6BP29CJhH30mLzrPKRhF2RYm/k+dF9QfffZ9W9SCkGk58=
X-Received: by 2002:a05:6122:4b01:b0:4b7:177a:25e4 with SMTP id
 fc1-20020a0561224b0100b004b7177a25e4mr1141463vkb.9.1704906872057; Wed, 10 Jan
 2024 09:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110012640.1335694-1-kevinloughlin@google.com> <ZZ6DSdaaoYKzgp4K@tassilo>
In-Reply-To: <ZZ6DSdaaoYKzgp4K@tassilo>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 10 Jan 2024 09:14:21 -0800
Message-ID: <CAGdbjmJcQeLWroBkbRC-cFQ6OuMHONsGLzpUrrA5k3uc8Rzkmw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/sev: x86/sev: enforce PC-relative addressing in clang
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ze Gao <zegao2021@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:45=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Wed, Jan 10, 2024 at 01:26:39AM +0000, Kevin Loughlin wrote:
> >
> > While an attempt was made to force PC-relative addressing for certain
> > global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
> > for example), PC-relative addressing must be pervasively-enforced for
> > SEV/SME global variables that can be accessed prior to page table
> > fixups.
> >
> > To avoid the error-prone approach of manually referencing each SEV/SME
> > global variable via a general form of snp_cpuid_get_table(), it is
> > preferable to use compiler flags for position-independent code (ex:
>
> But if gcc doesn't support it then it doesn't work.
>
> It seems your approach with incompatible execution models between
> the compilers is just a recipe for future patches only working
> on one of the compilers because most code submitters probably
> won't test both.
>
> It would be better to at least use a unified execution model, if you want
> to extend the hack and not fix the underlying issue.

Fair point; while gcc (unlike clang) appears to currently generate
PC-relative accesses to these vars, the patch in its current state
would not account for gcc's behavior potentially changing in the
future.

On that note, I do have another version of this patch that abstracts
snp_cpuid_get_table() into a macro along the lines of...

#define GET_RIP_RELATIVE_PTR(var) \
({  \
 void *ptr; \
 asm ("lea "#var"(%%rip), %0" \
      : "=3Dr" (ptr) \
      : "p" (&var)); \
 ptr; \
})

..and uses this new macro to access all SEV/SME global variables (not
just the cpuid_table). It's similar in nature to `fixup_pointer()`
(currently defined in arch/x86/kernel/head64.c) but doesn't require us
to pass around `physaddr` from `__startup64()`. This wouldn't
introduce any new execution model changes between clang vs gcc and
would be consistent with the kernel's current approach of relying on
developers to manually apply fixups for global variable accesses prior
to kernel relocation. I can send an RFC v2 for the
GET_RIP_RELATIVE_PTR() version of this patch.

