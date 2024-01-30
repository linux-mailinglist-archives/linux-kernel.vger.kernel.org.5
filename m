Return-Path: <linux-kernel+bounces-44344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310A842086
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82761C26DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F80664C9;
	Tue, 30 Jan 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yut0v+AR"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E51664B6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608958; cv=none; b=F5SKr/6QGswh2QIOSXAhnQaEPPwtx05BfbG8n16hbr5ICvqsvBAPTTfHUIw5RHACa6ra5OKIB5N/6tZLVvpxrQSksXsBjO0BVANYLbtLrqMPtrcPxLGkGl1ZIYm3mVQQEh16qEbn+wj3cQl9XDUmAuToAIC31moXhgw9f0ttKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608958; c=relaxed/simple;
	bh=W8/Rk4qSp/sqelgKB3KXmEt+9w3uNGbFNVLPtunhLZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWfP+TlGLfn2mvu3ZxyJLTAAXUZSabacO3QuMTccRhUGVbjXZZzwZwNpeDs5N6k2eoOsEfAI+ayCRzW5vnvBRkYnQh4WirB63bG/detYURPcTf2KdMSNLCqBY2vnuEuH+Fp0cc0u5gh23Go+NzMEmZUHgnzs36CS2LvT/lLz3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Yut0v+AR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-510f37d673aso3032881e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706608953; x=1707213753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kClA8daQckTIvu1OZztRzd8EFBYH/WDKzJCQ35/y4Ao=;
        b=Yut0v+ARusz0ZnFfn4Gbaz6GcZxAzTVvzVzfm1h9WskVdwKuzNfuq5QMu1bpRhCZV9
         qhk6ZcA2Jp7Z8DYQtnBEtuhNN28VY5xTvcC4UXoy3qQ07EJdS0mfdNos1TIREXTH49YJ
         PLDufS4XL9ikJqxo7M3uhqc9ZxNaoOX/evT/xenEQL3DPpIey1uf81cL1K6FZm5STcrY
         AYS/3YJBab0LVXBBiLbQCBAI5N1pkNCHUxzd4TmF1Ss4PP7hrr1XMIAS45E4RO/cHf0K
         IMPmXTiItbKEbtkccCQmNJsbPqpKxI/oGm93+k2PJowgT0xpfiyLAoIVZ8WOKOz5cc14
         7wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608953; x=1707213753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kClA8daQckTIvu1OZztRzd8EFBYH/WDKzJCQ35/y4Ao=;
        b=qbSL2N2uc2laigWa1paL+c6AgskI0fkd5hxc2zUWZy4ZN7QD+5PTRRvnEdkR5p/PfQ
         FnPdmVq0yQrkZK3RtfGdkFnVhnS2aPCTY/TdgGMmmoQpFPXHihAypBjpSZErwbwchKXt
         uhvWiXImc4y9IOSI6VBdKXQEFOna1w1+qMBaekhyvgTfxS9D8BTUMDZlfJGIWbMecpfs
         Z17xjROaQin+jPkeNMEsRyCwWVdyn8xgnDeCLQEnzKBYzKJlbqrwEc0BoqnPkzqsBRoN
         2wo8wGoYi/RGGMAVzrDCapxS5tQIChr0kG+1ZazyETmpgSt7c64Z9PA96DNXMfXakSkg
         3xcg==
X-Gm-Message-State: AOJu0Ywb4Zh9vy2DRtzwvAEGduSoZUzR6pDsLQm8jOT+Cqvh46W46ecL
	bv4j7yUEieQjILYKSHJOFDeTZBnnaUcBnQIL63A03xWyPRXSFelC9ZESBaXSqTA8XErVL9IVW03
	C58woUBpPNudoS2J2IThyxgPyohJpWpjzLqliaA==
X-Google-Smtp-Source: AGHT+IEu4GUw7zdQUbV+R6CcIgnxnw9wAWoqOjcKDwjumwIFhh0v31H+fAq88YVX4N5QfeCdu72T3yofgT9yNyrYMQo=
X-Received: by 2002:a05:6512:61:b0:50e:8eff:3980 with SMTP id
 i1-20020a056512006100b0050e8eff3980mr6148028lfo.30.1706608953505; Tue, 30 Jan
 2024 02:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us> <87le87uulb.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87le87uulb.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 30 Jan 2024 15:32:21 +0530
Message-ID: <CAK9=C2U2mGzTLaXDqyD86bEM4XRc3UmBxRtrd3=+QXXwMK3hjg@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> > Anup Patel <apatel@ventanamicro.com> writes:
> >
> >> The RISC-V AIA specification is ratified as-per the RISC-V internation=
al
> >> process. The latest ratified AIA specifcation can be found at:
> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interru=
pts-1.0.pdf
> >>
> >> At a high-level, the AIA specification adds three things:
> >> 1) AIA CSRs
> >>    - Improved local interrupt support
> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >>    - Per-HART MSI controller
> >>    - Support MSI virtualization
> >>    - Support IPI along with virtualization
> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >>    - Wired interrupt controller
> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generat=
or)
> >>    - In Direct-mode, injects external interrupts directly into HARTs
> >>
> >> For an overview of the AIA specification, refer the AIA virtualization
> >> talk at KVM Forum 2022:
> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizati=
on_in_KVM_RISCV_final.pdf
> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
> >>
> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or hi=
gher).
> >>
> >> These patches can also be found in the riscv_aia_v12 branch at:
> >> https://github.com/avpatel/linux.git
> >>
> >> Changes since v11:
> >>  - Rebased on Linux-6.8-rc1
> >>  - Included kernel/irq related patches from "genirq, irqchip: Convert =
ARM
> >>    MSI handling to per device MSI domains" series by Thomas.
> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH1=
9,
> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@=
linutronix.de/)
> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism=
.
> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
> >>    platform devices.
> >
> > Thanks for working on this, Anup! I'm still reviewing the patches.
> >
> > I'm hitting a boot hang in text patching, with this series applied on
> > 6.8-rc2. IPI issues?
>
> Not text patching! One cpu spinning in smp_call_function_many_cond() and
> the others are in cpu_relax(). Smells like IPI...

Can you share the complete bootlog ?

Regards,
Anup

