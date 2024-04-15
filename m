Return-Path: <linux-kernel+bounces-144973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33A8A4D65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA46B2332A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFB5D756;
	Mon, 15 Apr 2024 11:13:54 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E605D49F;
	Mon, 15 Apr 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179634; cv=none; b=XP5oVhDVoqDHIHyeLkPOz7lOJxWY/HQvIomNHTc2eRr/XFQO7CsrpWt6DBfkT92ftg8ls3/bgBKXYsd418IfaVJfvzhAcCNVuJzZUmLgUr0KrgMdCKNAp2pejSBlW2ZGDmcFANDOhrFRVjArDP4dzcyWdm8p435PL53XsGLtU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179634; c=relaxed/simple;
	bh=DY1D/jrwts1nB0lRaeb1r4vr8r9BEL2IO+BWI1tSCig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx+uYLQUkDAfVhPNuhz5wC5n6COBSUauJiLkPA5xKOaoYgctE6KOIzGB+J089PaRR0L+mwtfOabCzDwv9Cq4dDCsQYmcMiCh2qKzS3gTarz/VFDPKHKFMdSM/O680ceSrmq2w+zioheGGWOxrUTOhtlVwFoNUqMYbk+6/n0Pd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61816fc256dso25395617b3.0;
        Mon, 15 Apr 2024 04:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179631; x=1713784431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FWGxEu0VgX/lOXKA/j3W5EIIVimlFBayhs7POLjK7Q=;
        b=VcmQl6Kyd+B2XAzfWz8o7NLFMXqx2/yM7/dKpiGPu7Pm8yzU0gKTwjfqa5pvJ9DPe2
         njV2pvfb181H40iLJLmODkpwTJ3EKyK4QFaLThxmoLYiELDf9iV39TpLa1iKjSW7pKaA
         fzl8CV6HduUu/FAsTp8vVJC5i8a8W+5kpgP1m8apEmdpufr0OWWKNjqu35Peev7NkujL
         2uiAVTFfmGO6mEvZ/4YUHErA4x+og17zCIdYjJdOGC9itgIpPpOYAUD9ZWUBQ6flRCIj
         6Dfue3PlqonhQZ1ETKahTZeWhHmLTEVq5/AfHOpByJ9b0o88BPMGm58dEYH14iQIGlp0
         43DA==
X-Forwarded-Encrypted: i=1; AJvYcCUHjVSn7uYmePK8pkgX6iohFcXMoMgo8D8WBjqSvjgS5se++S1GTBb9XqKeTzDKQ2Gj56WnN5EDbYK6fNr/6x3c5xnVVC1fqZ82dLfeZ5YlgUI8biog+LbSe93CW/OTJVTnq68TDSxBxxB19MiNhZHtgj10VWrittB4j1iAxqBvb30TDusEqgu2hnU=
X-Gm-Message-State: AOJu0Yx4yfyQ6KolE5WpNMiOHUWwt9E0wtuoAfJ8Es1D1+9oS6UuQw9Z
	/NeFPRCTa5nrrWkhnT6I4+EoMNbciuaMB7lEWKIBj6fncBDtCt/QNEVmFg/G
X-Google-Smtp-Source: AGHT+IEZzJIBEAzV75fQm6Uh2aF1dVbmWQAbEUbjCls69hJliNK06kgOQMMk86eafHUAt3Ihy61WbQ==
X-Received: by 2002:a81:e305:0:b0:618:5b27:e12b with SMTP id q5-20020a81e305000000b006185b27e12bmr8128819ywl.7.1713179630889;
        Mon, 15 Apr 2024 04:13:50 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id p11-20020a817e4b000000b00617bcab1236sm2012343ywn.35.2024.04.15.04.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:13:49 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6114c9b4d83so23296037b3.3;
        Mon, 15 Apr 2024 04:13:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa20YUNj1ao5lShwg2aqaaVwIMOFdDdFRjaKo7dw/YHpZ1eLPljUTcH33ACaJW8BkGqwEKyk++0yKt03Yi4FPUu/nVgW5wOxTd190Xb++D29/n13+MoqWqijs6duVhTaOVGbnY+lrVu802UFleen9EZqi2kuaI0Ih2qLvXBLv9RqgdUDAk1B70cwM=
X-Received: by 2002:a25:8211:0:b0:de1:1af9:c7ea with SMTP id
 q17-20020a258211000000b00de11af9c7eamr7177258ybk.1.1713179629348; Mon, 15 Apr
 2024 04:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409175108.1512861-1-seanjc@google.com> <20240409175108.1512861-2-seanjc@google.com>
In-Reply-To: <20240409175108.1512861-2-seanjc@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Apr 2024 13:13:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjB2g+fN8dxcmHUjKhzDChPpwcf8hMCbf=arOK5MkOuQ@mail.gmail.com>
Message-ID: <CAMuHMdVjB2g+fN8dxcmHUjKhzDChPpwcf8hMCbf=arOK5MkOuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Tue, Apr 9, 2024 at 7:51=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Initialize cpu_mitigations to CPU_MITIGATIONS_OFF if the kernel is built
> with CONFIG_SPECULATION_MITIGATIONS=3Dn, as the help text quite clearly
> states that disabling SPECULATION_MITIGATIONS is supposed to turn off all
> mitigations by default.
>
>   =E2=94=82 If you say N, all mitigations will be disabled. You really
>   =E2=94=82 should know what you are doing to say so.
>
> As is, the kernel still defaults to CPU_MITIGATIONS_AUTO, which results i=
n
> some mitigations being enabled in spite of SPECULATION_MITIGATIONS=3Dn.
>
> Fixes: f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for your patch, which is now commit f337a6a21e2fd67e
("x86/cpu: Actually turn off mitigations by default
for SPECULATION_MITIGATIONS=3Dn") in v6.9-rc4.

This causes the following suspicious messages on R-Car H3:

        CPU features: kernel page table isolation forced OFF by mitigations=
=3Doff
        spectre-v4 mitigation disabled by command-line option
        spectre-v2 mitigation disabled by command line option
        spectre-v2 mitigation disabled by command line option

and R-Car V4H:

        CPU features: kernel page table isolation forced OFF by mitigations=
=3Doff
        spectre-v4 mitigation disabled by command-line option
        spectre-bhb mitigation disabled by command line option
        spectre-bhb mitigation disabled by command line option

Interestingly, no mitigations are disabled on the command-line.

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

