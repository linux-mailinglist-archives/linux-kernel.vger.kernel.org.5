Return-Path: <linux-kernel+bounces-18183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B35F8259C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B391C2355A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30734CF6;
	Fri,  5 Jan 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3mZXhIj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDD34CEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336f2c88361so1645590f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704478277; x=1705083077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ckZzl5nI71sMgrcg5hmYGh32os7XULQPyA9x2GFAA=;
        b=T3mZXhIj+xKA/1nqNYDS82q6ZwgiKFt7Tmrs2r5Xjf0fi1/4683w1IWK+FxBLLx4Lw
         6zCLkZfvqWfLICcGKbCvj70MZs/BQnaWc7crPijw1tJ1NCUY7wl/KnvJyXqmBvl7faNQ
         9mH/gASrGns/nlzHAtcx+3H3ZwwwMU7ReVhgaDp2Fel9MQonjKL+d67yxmpXazrtUvz9
         s+TIyIIDEsOLhL++B7VmXhPn6kXgGw4PzWntcLfSejCU/RMKldzyDgnZlS2aRRE9zRtW
         91ULVWAFed0vnK/3G+ULXuZi0wDmm6fmTH88y7s1CwtSAkU6D9ok2PJD9ymPuNLWgaxi
         XwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704478277; x=1705083077;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ckZzl5nI71sMgrcg5hmYGh32os7XULQPyA9x2GFAA=;
        b=pLwY619OrcfraVyplnZMWy4u4qJlX/ApRuB/8ELGTuayNsgkOiyAUwhd9uZgMGR7LU
         y5O7f5DvlDjHYlHtti2Sjy97JoLXC3D1c+fgVVTCJXoOYIm7RoFBGG8qUN5b5v6ToJdp
         CgR77kwiD6JrisiADmpzSzFRJKuj2OdZ6rB581J7FE8yCN0VKBu2ssZbhnUIwI92rYNQ
         fvNOSksIltuOUcw2SwwAm5mYKskcFfmuSsuel3xUTnLUE9xMs2mRoc97Hv/2FFSLQzTb
         X7VxX8iaM3+pM2WIgcSuQ/GjFNRO73utIL7pazCPRJg/TQTuW0MAfiNKGLJdKwY2WbmI
         Ub7g==
X-Gm-Message-State: AOJu0YxOVne457CzLV71yrmtoInCDgIWsDKA6Ql7HeJCUe2ItiWgus5m
	IMul9lEA4+ESO11x78tjiC9TD4yK1vd3zaxhxBIggeXm83qREaPaxyr6Af1Tj/dQ
X-Received: by 2002:adf:ea0a:0:b0:337:58ba:d16a with SMTP id
 q10-20020adfea0a000000b0033758bad16amt818751wrm.54.1704478277360; Fri, 05 Jan
 2024 10:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-syscall_64-v1-1-57fe392ef565@google.com>
In-Reply-To: <20240104-syscall_64-v1-1-57fe392ef565@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 5 Jan 2024 10:11:02 -0800
Message-ID: <CAKwvOdnKi9wABg4YxDocQ_WH0b2n14aiyP_2kfVWadPix=_AJg@mail.gmail.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_64.i via IWYU
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
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

Generally question to the CC list. Does anyone know //why//
sys_call_table is defined as asmlinkage?

I don't see why `extern "C"` or __attribute__((regparm(0))) would be
necessary here, but maybe I'm missing something?

I don't think that's necessary to refer to //data// defined in C from
inline asm.  Nothing in Documentation mentions this.

And honestly those two seem conflated IMO.  UAPI headers make sense to
use extern C.

assembler defined functions called from C should have regparm set so C
callers know about the i386 calling convention change.

Those seem orthogonal to me; do we ever have cases where BOTH make sense?
--=20
Thanks,
~Nick Desaulniers

