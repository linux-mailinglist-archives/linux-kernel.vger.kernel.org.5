Return-Path: <linux-kernel+bounces-72950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256D85BB02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63CF1F22D26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449067C58;
	Tue, 20 Feb 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5MYsN1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF167C50;
	Tue, 20 Feb 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429978; cv=none; b=Zl2Ga8AIDww05vf5jpSDEibi48PAqyCTkk+fm5chsJNNOx1mnoceU9Hda7IfK6EM21mfUMxCi6A+251A34s9ImHaEZ8PV9NtTrAQ3Cdpd+RHOYNG7gZe+Pg/2oz2pGxpt2tSuwvvf8SN+B1x7aBewo7vQJPimDLaR8HaVK7xeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429978; c=relaxed/simple;
	bh=Y2qkFn4bmXwXYca1c369pPVRRLBO5myyrH01GFN0MQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fR7N1h6BhnZbFKzU0TT2kIz0fCj/leQJsX3X8GN1Z5fUCAU80HJOyAcMQYiK9Q+9v/xZKxdvoHVvlh5kjIm8WLLVvY2kdx2/TlYAw/4yVda4EtchXiQgxlJZzZk24I7+OCQwHYkCeji1qZgUfcLC2HouVWJNXj4cRzR+VHDV/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5MYsN1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B23C433F1;
	Tue, 20 Feb 2024 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429978;
	bh=Y2qkFn4bmXwXYca1c369pPVRRLBO5myyrH01GFN0MQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a5MYsN1vtLZTOY5660h0Xo0rFMc3tCbDWIt+5wHztoZ4og8nhpngw6bDAa20TckhI
	 EWKSotFxQ9zYrmPACHTJ/RwEuIzxknCSAW8M6rPX086hTTJrIvwk+tMOelrQs79f8p
	 2rPAq1ProW7T4M5egPPsDCM2o4a9yLPyAu0Ov/vGgKmW1p4dkr6lMmgYcExIQlZCLm
	 90iIVEd8Ouvsrn17NyhabgE3FGaYIOo31mEvCJeBSNIE88U2qSeJaSzZMtwEwyRlf8
	 eLAmm6COiGVSfADwiTubn1ho8NxuBXyVVLhnnmm8nXtNkKO3Z6pfkCFaKGtEp/bpF8
	 HcRd9MKWfQyTA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v13 00/13] Linux RISC-V AIA Support
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 12:52:54 +0100
Message-ID: <87edd7fj3d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>
> For an overview of the AIA specification, refer the AIA virtualization
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_=
in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>
> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or highe=
r).
>
> This series depends upon per-device MSI domain patches merged by Thomas (=
tglx)
> which are available in irq/msi branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>
> These patches can also be found in the riscv_aia_v13 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v12:
>  - Rebased on Linux-6.8-rc5
>  - Dropped per-device MSI domain patches which are already merged by Thom=
as (tglx)
>  - Addressed nit comments from Thomas and Clement
>  - Added a new patch2 to fix lock dependency warning
>  - Replaced local sync IPI in the IMSIC driver with per-CPU timer
>  - Simplified locking in the IMSIC driver to avoid lock dependency issues
>  - Added a dirty bitmap in the IMSIC driver to optimize per-CPU local syn=
c loop

Thanks, Anup.

I will take it for a spin, with Alex' v1 of the stop_machine()/ftrace
IPI fix.

The defconfig change (12/13)breaks a bunch a builds:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D827706

Download the logs here:
https://github.com/linux-riscv/linux-riscv/suites/20917102160/logs?attempt=
=3D1
and grep for '##[error]'

Bj=C3=B6rn

