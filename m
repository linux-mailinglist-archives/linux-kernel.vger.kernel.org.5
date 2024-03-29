Return-Path: <linux-kernel+bounces-124296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619B89153A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1291F1C22381
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA41B94D;
	Fri, 29 Mar 2024 08:39:53 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419113AF9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701593; cv=none; b=XrJIRa9z15BHTztp86X6b6PRyP+D6Co803Z3EHHttI/UbQztbHMOr6LrHcadQr6YDtceT9RVkamWHGmROnE+AY14/PGUUAX6MTw2KFJfWUClMwliHqb8EOMcrGqu/F5LbIRnVjQV8PxNRoVfWc4gZXvEbp+CQNrs1n/bKhqERpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701593; c=relaxed/simple;
	bh=GR3x12krJXOXWvG/BBTxB9091fvn1PewsYR2Rzs/mFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4hlFp4Z1VrVHeVcjyap4Z2zWJCLIdyV2EdJruJF6qHEIEElRHcu7EYMBUjY5fP5S5yfQSw0OR8upia4gXqn0cWLryGqZzWIsY8XAu24WJIuNwPah7xbBrD9b3hg0GsfIExLZ7OTJddAB3L5B9ezpQ4cBPd13vl81HyL/PGKHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a046c5262so17742457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711701589; x=1712306389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hkLfUozsxdncT8HuF2o4O/3RcsP/sGMaEklDCCLn1M=;
        b=rp1BmGk/UEEgfT2+neWIP0nAD8BYMKbNZtw0G3EnOYaLtzfziziaGaTPRRZpyPNnAm
         CMRdmFc17OukRgoSkoNRUEsJSgOU77U81ahMXuLt+vpL6riqwqAd5c4IijS9nWKly6XX
         7yjnF9ArB/106YUFJnL4/ALoDTq0iYp56qd6L9gIDKynTC05QPLffILMZ8n/glpt2ISq
         s2+T/4uHsQxMVXSprq8XVfYiA6YQ6xj2T+4pZW0MHlbFBp40/5yImMROUwhA2+u7oJhS
         FN6OdO3Y4eUYNgTlycOvtFeQLNHxHPeCArDnh2hQFwF39wWjZJHkqwuUTJniKwP3E1pU
         1gRw==
X-Forwarded-Encrypted: i=1; AJvYcCVa41dv5g6lB7UeX41bIYURX4gzd+WzBplxdJIIcmGgAV/LjKTgLxCmVQPBmvfj4uST3WXcdbjynaPyvJ4wbMD0xlcneA70Ym5GDdvR
X-Gm-Message-State: AOJu0Ywn965tKK6Y5AcqNfetBYJbxH8S3IYsiR/g8LscmTUmxn2M84+1
	GvGEgm7rMfQKF0nktSZkZCQD604YzIqqTqRK5zNLLmksZUvlFdxMqdQs7HXjZ1w=
X-Google-Smtp-Source: AGHT+IFEXMrklwhh+i+8jsTuUWt2GgstsMUUgLPP/PsE+c05qIJuWNkBoPuYT9GMhsc8zaJ9xWe4qA==
X-Received: by 2002:a0d:efc3:0:b0:608:d1b3:30ac with SMTP id y186-20020a0defc3000000b00608d1b330acmr1840556ywe.30.1711701589043;
        Fri, 29 Mar 2024 01:39:49 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id fl4-20020a05690c338400b00611314e881asm17972ywb.25.2024.03.29.01.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 01:39:48 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ddda842c399so351247276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:39:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqFgwJItviMDaQAlLMMj4QtA0OGB69DqLbJJSG25JGLooWgQifHOVO6lpYt9Njm/qO5GXzAQyky8zl5dZNK0QcIo8dSuiBdrBI+u47
X-Received: by 2002:a25:83c5:0:b0:dcc:ae3:d8a0 with SMTP id
 v5-20020a2583c5000000b00dcc0ae3d8a0mr1625934ybm.48.1711701588203; Fri, 29 Mar
 2024 01:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403291057.uo43Mlue-lkp@intel.com>
In-Reply-To: <202403291057.uo43Mlue-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Mar 2024 09:39:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPyz+bZ43Nu-iq_K0GnWbtP3oiXCt22cQSyMvMhQ=A2A@mail.gmail.com>
Message-ID: <CAMuHMdWPyz+bZ43Nu-iq_K0GnWbtP3oiXCt22cQSyMvMhQ=A2A@mail.gmail.com>
Subject: Re: arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_LOG_BUF_SHIFT'?
To: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:19=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   8d025e2092e29bfd13e56c78e22af25fac83c8ec
> commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define CONFIG_PAGE=
_SIZE_*KB on all architectures
> date:   3 weeks ago
> config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/202403=
29/202403291057.uo43Mlue-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240329/202403291057.uo43Mlue-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403291057.uo43Mlue-lkp=
@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/m68k/include/asm/thread_info.h:6,
>                     from include/linux/thread_info.h:60,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/m68k/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:79,
>                     from arch/m68k/include/asm/processor.h:11,
>                     from include/linux/sched.h:13,
>                     from arch/m68k/kernel/asm-offsets.c:15:
>    arch/m68k/include/asm/page_mm.h: In function 'virt_to_pfn':
> >> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undecla=
red (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?

This is the same issue I mentioned to Arnd in IRC before: as no
platform is enabled, none of the MMU_* options, and thus none of
the HAVE_PAGE_SIZE_* options, is selected.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

