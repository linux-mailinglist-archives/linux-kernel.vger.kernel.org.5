Return-Path: <linux-kernel+bounces-78085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAB860EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565811C229DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04C5C8FB;
	Fri, 23 Feb 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="tMAU1rSz"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453705D749
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681992; cv=none; b=SZPf1elMmnhW8UwV3KYMA1XS4yYipbQk9ZAMEXkhqnWil1eKML+Rwdt4/xEcMkzis/pGEo8N8CL3z4lbl+P3A6T9+yWnLgSnEYYs+Fqg89H4bjaLTPdfXm6j3X111BlxAVMuHOAV63+fsc8App3tXN+ZdQ/LIkuATR+YcPbCrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681992; c=relaxed/simple;
	bh=7XCzh+uIMXJ+5MTJLWpvUyIlSnKKlRPx/XGiT+6Op5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3mG1OKJjF3bpbu6PIsgxmSZe1DtPF6oA+LZ0xu6C7FM7itqDiTU9FpJ0Ir5cxfvEhu73OieEfhmCMNHAf0a72+WREWM4l/Ct2KOrdGmBGQ4Zf09rd0fDhcPHlJYYDG5K1BeHTPts3O4i6fgRHnn4MWC7CBv3b1CaZzeUzlaGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=tMAU1rSz; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beda6a274bso22845239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708681990; x=1709286790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwITkJOkxJi4tf5gcg3IMghI+TXnjRRJ7mlrP6U+6fo=;
        b=tMAU1rSzw35qFUutm02Fyqz1eMiGuPMpzOPknR+Ant0YpJeeJONGiLuwo08PXyJbSm
         G83gPgXkJHg1XhDVWsc0TbBgp+H6sQMI7ai221cPv0u+PME0VYhSSwZLR5/RPrImpre/
         mGTLMrj0Lvi0nX6t4ynjLEFJYfxb+c+VbTcG//k1PQixmxp9V1pywp+TH0/sDRxlVrUa
         fgGprFRx3RZ2c/3XPM4mYZoVVMMLQDOfEnHt4WFAp1iTx5ObhdOD3xnSy2i3WrlgRTFz
         j9wSL+zsLU80B287bQ1JCphdtCtrjOt2IjKnntR4+y01a6JOgvlODxB5T3qCmdj2B4CO
         RXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681990; x=1709286790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwITkJOkxJi4tf5gcg3IMghI+TXnjRRJ7mlrP6U+6fo=;
        b=wgKG8fi0qzsKH7nkm0HdnGNvC2qi6Glf2IOpSB8shlaIesZtP9Pk5P893e4cTDJgec
         uzq4SycmpDOKc2dI63+seRfzJTj+oFj9yhdwWjWsT6DBHnV/A/OwkjIs72SXf+ic/qvt
         pVmbx4XJX/E0XTY92goXuwNdRITeETobXbp2x2ozJcr2aRo6Vnp8I34H87oAumzWBgxr
         wgEKsNoi9ikZvwxDiHeO2TTNIvZPOz+fP/G8bDO42Zk4u2q2XvQrmeoGnzkJi+k28z9Z
         FyFMCXdFp5PHRq1ULl6gx/KQh8hQnodQI+nnr8LtwaV8BVSzeVi9ZE0dS9v/slkiGq0k
         5QKA==
X-Forwarded-Encrypted: i=1; AJvYcCXEeynOgWmnG74xQ0WOYKIdRQXHHfGJQdC1EWtjUmx7u6VMQgS9s7voC1pfX++3+FEgZF8mgzkBOMljoBTBp7/I6ll+9BOxqDV59UVD
X-Gm-Message-State: AOJu0Yy6Bki+D7bfs2yx8Wwtxn7s9tUIxJ4pl0iN/5XP69vuuvUfbSjD
	Ze2eRQn3RvnnViXxsgun96YoJfzKUWxBx8QeYyen4KaStEBnTT3LZ9nzjbV0bbrZ1UqDiVIZ8Zo
	KCvXs7CVQi0af4KBr8Ap/1HvPFvtCkbFubLfrwA==
X-Google-Smtp-Source: AGHT+IFEMrjyUct3LRVpsNuoU0mxhXWWWiTu7G911BntzOGl/Oh/Kjz2rfYKPmZurgFzXi9TrTc+zlN+3LwG3NAjrOo=
X-Received: by 2002:a92:c56e:0:b0:365:2aa7:9407 with SMTP id
 b14-20020a92c56e000000b003652aa79407mr1592046ilj.17.1708681990333; Fri, 23
 Feb 2024 01:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-12-apatel@ventanamicro.com> <87a5nreg94.ffs@tglx>
In-Reply-To: <87a5nreg94.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Feb 2024 15:22:59 +0530
Message-ID: <CAAhSdy1jdHsuwRhbRgig98-AVDOGwp_XxHurg9o3Rsj1AVOqbA@mail.gmail.com>
Subject: Re: [PATCH v14 11/18] irqchip: Add RISC-V incoming MSI controller
 early driver
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Feb 22 2024 at 15:09, Anup Patel wrote:
> > +     /*
> > +      * Setup cpuhp state (must be done after setting imsic_parent_irq=
)
> > +      *
> > +      * Don't disable per-CPU IMSIC file when CPU goes offline
> > +      * because this affects IPI and the masking/unmasking of
> > +      * virtual IPIs is done via generic IPI-Mux
> > +      */
> > +     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irqchip/riscv/imsic:start=
ing",
> > +                       imsic_starting_cpu, imsic_dying_cpu);
>
> This is not really correct. IPIs should be working right away when a CPU
> comes online and on the unplug side until it really goes offline.
>
> So this wants to be in the starting range, i.e. between CPUHP_AP_OFFLINE
> and CPUHP_AP_ONLINE. No?

Yes, it has to be as early as possible but I was not sure about
introducing yet another driver specific CPUHP_AP_xyz state
considering CPUHP_AP_ONLINE_DYN worked fine.

Since you suggested, let me introduce
CPUHP_AP_IRQ_RISCV_IMSIC_STARTING in the next revision.

Regards,
Anup

