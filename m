Return-Path: <linux-kernel+bounces-44456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41949842237
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A491F2E4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D267741;
	Tue, 30 Jan 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxOJjVm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554967744;
	Tue, 30 Jan 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612706; cv=none; b=Ybsn7zVgGSQ0EU4ned0wPMGXvI3A7fyMJt26W3JACXXB990FEEebCjrUy0si1l9dukEMz+0kfcoGB1xuNJbXPLi7EGsphfWuQt3zx8mfy3HRa6uu0JIiomshEWb4JsWKZMsLUqRxw4h98NYtDZ1LDRo3H6rcmvvNI7XZgMvHOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612706; c=relaxed/simple;
	bh=FPjSOL02faexuB1BXgC53k3A0QdD2xtS7r/hZoVFvuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iIkNsLkOa5IUa4dsLHBitktWXRobRDX3LLOd7adTjrKucBQEvZidRVbIQXxRIzblE3jcQO55vQ0klUlZe0H0jF6SJaSxMBWy990hxzyyQUHXUn+y4AVdIX7d93z0PTvbim/uI89yd8+iRA9ME/DtsTxAjmestdlERrI7clSuswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxOJjVm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADE6C43390;
	Tue, 30 Jan 2024 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706612706;
	bh=FPjSOL02faexuB1BXgC53k3A0QdD2xtS7r/hZoVFvuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KxOJjVm6NHVWWyv4OU761WsEmvvTaK6AOVZGXGhBf9XEa1cDPvJyCzSF9QIN48pTV
	 aLj2ji8j9E/eLnA/qq2NSzICbbhzCx+ODRyqZeuDTzL8ccCSqldHmOL/Q15HHJmEPB
	 3mrR4IrUI9LC9loqptLEpno3boG4XmZgTabp+w5k//pwoSjP1Z0hCW0SrXjsbg1upV
	 bkDtprS0umWUo2av/zR8GIqlruORVPB/KwALEup+/cdEWpoFinhVOnFLcmmq5q7c4C
	 6PaMOashVJ4kIUTYzBZgsNoTvhz3YDfKF4dqXSpF1RyxX9dMVYeutQp5m0z7jg4Keu
	 H6Piw0AEBelAg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2U2mGzTLaXDqyD86bEM4XRc3UmBxRtrd3=+QXXwMK3hjg@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
 <87le87uulb.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2U2mGzTLaXDqyD86bEM4XRc3UmBxRtrd3=+QXXwMK3hjg@mail.gmail.com>
Date: Tue, 30 Jan 2024 12:05:03 +0100
Message-ID: <87le87w080.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>
>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >
>> >> The RISC-V AIA specification is ratified as-per the RISC-V internatio=
nal
>> >> process. The latest ratified AIA specifcation can be found at:
>> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interr=
upts-1.0.pdf
>> >>
>> >> At a high-level, the AIA specification adds three things:
>> >> 1) AIA CSRs
>> >>    - Improved local interrupt support
>> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >>    - Per-HART MSI controller
>> >>    - Support MSI virtualization
>> >>    - Support IPI along with virtualization
>> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >>    - Wired interrupt controller
>> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI genera=
tor)
>> >>    - In Direct-mode, injects external interrupts directly into HARTs
>> >>
>> >> For an overview of the AIA specification, refer the AIA virtualization
>> >> talk at KVM Forum 2022:
>> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizat=
ion_in_KVM_RISCV_final.pdf
>> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>> >>
>> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or h=
igher).
>> >>
>> >> These patches can also be found in the riscv_aia_v12 branch at:
>> >> https://github.com/avpatel/linux.git
>> >>
>> >> Changes since v11:
>> >>  - Rebased on Linux-6.8-rc1
>> >>  - Included kernel/irq related patches from "genirq, irqchip: Convert=
 ARM
>> >>    MSI handling to per device MSI domains" series by Thomas.
>> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH=
19,
>> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233=
@linutronix.de/)
>> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanis=
m.
>> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>> >>    platform devices.
>> >
>> > Thanks for working on this, Anup! I'm still reviewing the patches.
>> >
>> > I'm hitting a boot hang in text patching, with this series applied on
>> > 6.8-rc2. IPI issues?
>>
>> Not text patching! One cpu spinning in smp_call_function_many_cond() and
>> the others are in cpu_relax(). Smells like IPI...
>
> Can you share the complete bootlog ?

Here: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d22501


