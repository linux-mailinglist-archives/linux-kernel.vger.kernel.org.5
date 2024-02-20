Return-Path: <linux-kernel+bounces-73056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226BF85BCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806151F2361E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798556A02D;
	Tue, 20 Feb 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="xIIhYiQI"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5169E1A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434589; cv=none; b=aTwcTTLoE4QJ1ksOOp51WrkHKlmSe121StLMxNOwN0Ev7uIouMdmX52hH/YeRD3OYfyLP8R9v6euHLEJ3GF+Q+jl1ESPW4IMG517ysFzc/S4sROcEbkRZ5ffQZQcLn+L0TfitGzVJ4AxZaFJyvLIN8v6UZ3JLxvq8vWWDpKfO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434589; c=relaxed/simple;
	bh=mbh5TbkJ6o9UjgpjqTeYt/lAcGo/dPj4834WfXG+FOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8HvTVCR8O+UAsVRr/eLIrKJtSwPt9xFux+gwHm/SalQVFgbZdkOp5p9QcPGI7mRWogMpE/wMX5aanpuJiDxJ9aNuPGiCD0kWMInotFo6QxGjIl1/3vZ64jmernXPs+u5j+9KkxInf/B6jjJqOOkRDjZg9At+cZOjPPCo+OCOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=xIIhYiQI; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36523b9fa11so8821775ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708434586; x=1709039386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20voKxE+jWNuTLz3X5MuseyKDNhrLXnhCuKfseH4ExI=;
        b=xIIhYiQI0dBWYNfbTa0eOZqm/1Vg0KAinODQFEUcaM0jTq7OC61drvZP2cG+h2m3JJ
         K6iqLKsibAdbeStM2uvjr8nDmCvr3a5VTNUY31xTD8zQ40SlNCqc6ijoud2uSHXis3Sb
         iiJToLSXIHQ34F7zbUmeNEqOUk8oWjQ5rXyNtUe9qFX5oHRZhKEbY8eVLrQMempekQsB
         ImVl8WOIOQbUfWBLpUH0puBZzKQqLDeHawVX2XV7bIkCQrfi6yHPqA3jHt3EqIYoPdlx
         /ONjtVD0bG/+oxt94I3nuDi2bF8JdMrKVho1uF6w4dHQnj+9i4zUe+wfEaleaIGDhDXO
         e6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434586; x=1709039386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20voKxE+jWNuTLz3X5MuseyKDNhrLXnhCuKfseH4ExI=;
        b=dZvclwxdZmowwVHTpOCQTeiiYXTpJCa6LZZ+n9Tyn+xQXStwmLEj4blgLeR6yr9P2r
         3biX1YkUMPKiMzr3lONHEKLcn4rJ7VdKdzGzeSyk8Abvfm35wuKGS52uFkTcvO4OdohK
         FOyE8+ocs00NzrWZ29lxYYqP66ZCRL0h4Ta5jztZKwEnt8/+BtH9C1yLuHivC5H+KcoJ
         LAIqV86phIWEwlRtm+kp8msVesscBR0V3VrmYOxpJhM6vOfreWM1yu5IZPjyrSsh/t2n
         k5JjCHpv7A4jlLNONVm7NnXykELOS7whTmMhFSjnzY7UEWk6scTe2dOoHDcfFtM/IOlU
         trKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtbV8OtvKCwOHyEoGJB+1MkThE4AfC5nMSgJ4FfR0QcKVa6NluGFj4sZl8r8g+5peQLBuKuV9J5zRA4x//eUUhKnj9pnmhXxM1aaFj
X-Gm-Message-State: AOJu0Yy8Dryi79bSzYLZMhxVPbvgKQT9fFi4D7jF8si5gUze9FQJ4u0u
	LuKvB1QmHhxBVmhOuAB/fCLv2lMxMbVI9w8B6zFaf4YCpn/1ZONO+rDBVgp/hCFtiQMoFAQS00J
	qFIGyxvaV4EcCXp9q6qF53Y+IXGkutbflfjvfdA==
X-Google-Smtp-Source: AGHT+IG41ou30YJCOaxfxdNlKINx1EJpgmhDcnqm4VJu+XqIGtYblfps8b9oCfMT10q7hZCaSRX5MiHJxIyxF63cy3s=
X-Received: by 2002:a05:6e02:154f:b0:363:8560:977d with SMTP id
 j15-20020a056e02154f00b003638560977dmr21841871ilu.3.1708434586491; Tue, 20
 Feb 2024 05:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com> <87edd7fj3d.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87edd7fj3d.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Feb 2024 18:39:34 +0530
Message-ID: <CAAhSdy1mDnE0Z5hs+LHrSUmQzEBC3EHF2TfU=Bd416RacgbjeA@mail.gmail.com>
Subject: Re: [PATCH v13 00/13] Linux RISC-V AIA Support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The RISC-V AIA specification is ratified as-per the RISC-V internationa=
l
> > process. The latest ratified AIA specifcation can be found at:
> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrup=
ts-1.0.pdf
> >
> > At a high-level, the AIA specification adds three things:
> > 1) AIA CSRs
> >    - Improved local interrupt support
> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >    - Per-HART MSI controller
> >    - Support MSI virtualization
> >    - Support IPI along with virtualization
> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >    - Wired interrupt controller
> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generato=
r)
> >    - In Direct-mode, injects external interrupts directly into HARTs
> >
> > For an overview of the AIA specification, refer the AIA virtualization
> > talk at KVM Forum 2022:
> > https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizatio=
n_in_KVM_RISCV_final.pdf
> > https://www.youtube.com/watch?v=3Dr071dL8Z0yo
> >
> > To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or hig=
her).
> >
> > This series depends upon per-device MSI domain patches merged by Thomas=
 (tglx)
> > which are available in irq/msi branch at:
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> >
> > These patches can also be found in the riscv_aia_v13 branch at:
> > https://github.com/avpatel/linux.git
> >
> > Changes since v12:
> >  - Rebased on Linux-6.8-rc5
> >  - Dropped per-device MSI domain patches which are already merged by Th=
omas (tglx)
> >  - Addressed nit comments from Thomas and Clement
> >  - Added a new patch2 to fix lock dependency warning
> >  - Replaced local sync IPI in the IMSIC driver with per-CPU timer
> >  - Simplified locking in the IMSIC driver to avoid lock dependency issu=
es
> >  - Added a dirty bitmap in the IMSIC driver to optimize per-CPU local s=
ync loop
>
> Thanks, Anup.
>
> I will take it for a spin, with Alex' v1 of the stop_machine()/ftrace
> IPI fix.
>
> The defconfig change (12/13)breaks a bunch a builds:
> https://patchwork.kernel.org/project/linux-riscv/list/?series=3D827706
>
> Download the logs here:
> https://github.com/linux-riscv/linux-riscv/suites/20917102160/logs?attemp=
t=3D1
> and grep for '##[error]'

You need to pull-in 14 dependent patches which Thomas has merged
in his irq/msi branch at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git.

Regards,
Anup

