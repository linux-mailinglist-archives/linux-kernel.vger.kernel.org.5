Return-Path: <linux-kernel+bounces-15527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC3822D60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8311C202E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFA199D7;
	Wed,  3 Jan 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2aNVlUA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F606199CF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea9db9e12so53396e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704285851; x=1704890651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uQTJsDlXqN3pzqpyIsK1JU1Pq7UhaRv03G2ZeBqzD0=;
        b=A2aNVlUA9B+9lu69CXV81TRW57OQ2RKsTGyS47LWG2A1B6MHRFPuhjXJ5O/0Cw45Tl
         vRA5aPDPxNiQNw9z9QPHc3v7ieV8KovI74hq7thyDb9qZOxm6pRApqdxV+KsevqG2Iez
         VChUOzl60m6QyUtrf2qpf7WHELEOVXnlk23be1mo6QUCzvahi4JPKf7iXtUQMe5IEsIY
         wETWkCcgllpOf28fYUeThUUzgxI6oVrrN6uugtoHk5Ltx2Wcf6X/snoPTGTzcLuzwE64
         nefs+reQpt/eQkpZ/KuX6rJkddOUNABNbf6pnWvJtHMokJyOyi2CFYjMutqSMVQQDYJS
         nAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704285851; x=1704890651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uQTJsDlXqN3pzqpyIsK1JU1Pq7UhaRv03G2ZeBqzD0=;
        b=jyaIzr5M9DI8c3a86mOBwdBbAPkkcKt4jQuSf5JyTkLZwh/rqIh4vigK+6XbAHHQNo
         sUHWu7xvWcXB6xoHs1O13r5u/DKX6Oc919/GTyCT9iboZffkGRBKD97cbItWTo6qZsuY
         5huDB9tplhwMbarAnvLsQgbguas/ZETLbbGyQoeoLe/lf8ps1dJbYOUVSfYSaHhJ3RcR
         Nb590MTndk5lzv1zVGDqQLaSoAA8K8PzZSuFsgWJ4sWYkhc4goxoCs4YBF0lxiVodCf7
         LCsVOJBolHBRTzT3inHRXxxklbdoDNaLTo3Hh8otSFJPZxrPre+XQZqs2RFO0aifeJlP
         SCmQ==
X-Gm-Message-State: AOJu0YypubtzoQnwk0axiNDHLbNuemKzQYkCBoYSSVeenmK0Q1gYmLOP
	PLeICrOaoZaVStiN5SnUyCmx4IpGy447OFt9EG4=
X-Google-Smtp-Source: AGHT+IGoJVsDuzuod4cLACeug4AcAjb//H6om8I04zc9M/LTjOE7bevIl13oaksx6YxjUIehkE8Hx948xd1Oo+c7U2I=
X-Received: by 2002:ac2:5105:0:b0:50e:70b0:6eac with SMTP id
 q5-20020ac25105000000b0050e70b06eacmr6288331lfb.121.1704285850844; Wed, 03
 Jan 2024 04:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102074351.1528009-1-alexs@kernel.org>
In-Reply-To: <20240102074351.1528009-1-alexs@kernel.org>
From: Alex Shi <seakeel@gmail.com>
Date: Wed, 3 Jan 2024 20:43:34 +0800
Message-ID: <CAJy-Amkro1DOth5OxEe3Lnt_Uz84t-0uV191qdO97q6rZN591Q@mail.gmail.com>
Subject: Re: [PATCH] x86/dumpstack: uniform die messages
To: alexs@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 3:42=E2=80=AFPM <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> panic() has a uniform preempt, like "Kernel panic - not syncing:". But
> die() doesn't have.
>
> We died thousands machine with very different reasons. With current die
> messages in dmesg, it's hard to write scripts to collect and anaylis the
> die reasons. So we'd better give die() a uniform preempt to make the
> life of system administrators a bit easier.

Sorry for the typo, s/preempt/prompt/,
And any comments are appreciated!

>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: "H. Peter Anvin" <hpa@zytor.com>
> To: x86@kernel.org
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/dumpstack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index f18ca44c904b..00766e7ac077 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -393,6 +393,8 @@ void oops_end(unsigned long flags, struct pt_regs *re=
gs, int signr)
>  }
>  NOKPROBE_SYMBOL(oops_end);
>
> +#define DIE_PREEMPT    "DIE:\n"
> +
>  static void __die_header(const char *str, struct pt_regs *regs, long err=
)
>  {
>         const char *pr =3D "";
> @@ -405,8 +407,8 @@ static void __die_header(const char *str, struct pt_r=
egs *regs, long err)
>                 pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " =
PREEMPT";
>
>         printk(KERN_DEFAULT
> -              "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_co=
unter,
> -              pr,
> +              DIE_PREEMPT "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xff=
ff,
> +              ++die_counter, pr,
>                IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
>                debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
>                IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
> --
> 2.43.0
>

