Return-Path: <linux-kernel+bounces-15773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3982318D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A51B23B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E261C6A1;
	Wed,  3 Jan 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B26drKpT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5721C68E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso10278279f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704300634; x=1704905434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8qj9LLTaa3LyoC7NJsfeCbrmfVY1SENx7bd1fNAz/o=;
        b=B26drKpTpsehMjGux6bg03PkS4t+xfLRMpnaYfE56XW9DdcRiOFRsCbyqu6FUMtzSE
         ko6QsVtfoc4rBjwn8tDxe1hl4cY9s8lUZFIjVZZAcTqBsd6gnTgGuZhhm9s0TjoS8lap
         9GejGrNZtAXWV149D5uzio42RduVyeEgFkI6uxYS7OTyg0wjW/f+I8y41dl9c89IpYoF
         /6PgyLPVy4M2uWDmwyX65O2xZsqr2EA3neBWbiKBfUoF//1+cHV3UoOu0PdstOvzCq31
         qNOO9iLVd485ohzzhS9maLKJ2PjldQZRyIbLR4XAT8ErD7OxDbXfXd4xzDsLDY61XM1T
         6UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300634; x=1704905434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8qj9LLTaa3LyoC7NJsfeCbrmfVY1SENx7bd1fNAz/o=;
        b=dg4RifUzZGJBp8FQxqXnKAUb7/fMynuMvTOjPjPyQYQy1yIj7zW8jyPyl1hb0gp3VE
         w0t3Eb9AfHagWdYg3UEcXFYuSE0+73cJLBfM17GjGNPRgw4SEZ4S4DIrxzsYuA7bS0e1
         domBcT2fPe044BAO2FdcRVj1AjvHEoMfcxq82yZiTt7SqvuOFJtWCKBMlt0NDlgYUKw7
         PfnWBXmBwd7prsqrIkSLkA9cgZq/cRAJ1o7F4t+nRjkqU0NHUaNlBm3Wt4T/mEDZkNMM
         5u48kq1pCtzNiZCn247vvaTzHctD0dE0nJPWQsPmLueCM8d8IANBdBUUwm1dI54KDEpp
         kj9Q==
X-Gm-Message-State: AOJu0YxoSvcv8Qx5/w6fNO3IjUJQfQ3ZAfMmo0XGlvi+z4JOHlj48Vdd
	nPCEWJGerDk1Kxmh4Ofj7pOqlwT+z1hx73eE2VQju8/sfmCP
X-Google-Smtp-Source: AGHT+IFNldFQ4Ekd/9hAkgFof+yediaDi67d4DKeiI/9kvveDCGn42r8gdubpoTgPe07Pf4zH6H99anPJwbz/MQDEtI=
X-Received: by 2002:adf:ef05:0:b0:336:5493:c8fa with SMTP id
 e5-20020adfef05000000b003365493c8famr5056173wro.60.1704300634270; Wed, 03 Jan
 2024 08:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-syscall32-v1-1-9621140d33bd@google.com>
 <20231227233444.GH1674809@ZenIV> <20231228004550.GJ1674809@ZenIV>
In-Reply-To: <20231228004550.GJ1674809@ZenIV>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 3 Jan 2024 08:50:19 -0800
Message-ID: <CAKwvOdn2Tm6C4Q-GWfh7e2N8rQKAHYyGM9Cn6vb1CUzCORiaAg@mail.gmail.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tanzir Hasan <tanzirh@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 4:45=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Dec 27, 2023 at 11:34:44PM +0000, Al Viro wrote:
>
> > That's _it_.  The same goes for syscall_64.c and syscall_x32.c.
> > Oh, and lose the __visible/asmlinkage junk in there - none of that
> > stuff is used from asm these days.  See the patch below -
> > Untested But Should Work(tm):
>
> Unfortunately, there's this in kernel/trace/trace_syscalls.c:
>
> unsigned long __init __weak arch_syscall_addr(int nr)
> {
>         return (unsigned long)sys_call_table[nr];
> }
>
> How is that supposed to work for anything biarch?  Including
> amd64 with CONFIG_COMPAT enabled?

commit f431b634f24d ("tracing/syscalls: Allow archs to ignore tracing
compat syscalls")

added a comment block about ARCH_TRACE_IGNORE_COMPAT_SYSCALLS, which
is defined for x86 in arch/x86/include/asm/ftrace.h.

The implementation of arch_syscall_addr for mips is quite complex;
dependent on quite a few different configs.

--=20
Thanks,
~Nick Desaulniers

