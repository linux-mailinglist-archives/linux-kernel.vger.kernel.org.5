Return-Path: <linux-kernel+bounces-44073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF54841CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B971C23643
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDA53E29;
	Tue, 30 Jan 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWMHD4uk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EA55E43;
	Tue, 30 Jan 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601123; cv=none; b=d5kx+ElwGHBJo2Yjgeiv3263gGVLGoOzyizUzJEbtVFwTsn42vXK3fk9RPxaQrk4VBvfe4fuDqklWIYh8dzxErAOG4EyJttSV0FpxBXJbha6oiMZ0BQ/763kQ3KM47uRNshiu47oA22VxXEHY/ocDD4935tiA9QOmFo6lBSSgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601123; c=relaxed/simple;
	bh=GLh8dsTxNo9L/3+mC7DJTQzGc6JkyJok3IVl4QHNXYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RngDFqS0x4Toe4i2/3+MwiNo9+MeGR7TinF+RDmEWjBzQBiahBCR6EtpqkmI3xk6RwCDCUzJnEqKAV1jI7Ir8HMtWeBXaktPCeuPqRqrfrSIbG/9ulqio3pF4/5jDcHEXceaHFlOAzWNeN3zE3zQre3i1WfnVbKW9GLFjXxXf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWMHD4uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B316EC43390;
	Tue, 30 Jan 2024 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706601123;
	bh=GLh8dsTxNo9L/3+mC7DJTQzGc6JkyJok3IVl4QHNXYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FWMHD4ukg84VQQPcUzdvYkTpZEolvS89PLEDeqEObNoHN6dL7wtbGcKftgA5f0MnW
	 uck/JCMbyizznWP9cehzht1F7w3uyMnGd59ivYIhMQrNY/kdrHevXcgDae+uAzjbfV
	 SHzW91Hnj4ixeD1cFhI7ivDYTkGxdJypmFkNCjRz8Mce3Ax6SIygyjfzJ7KuzAMGU1
	 xBy+9KZ7NQ7/rlbKIViFDqfVMM16BBLd5XgHkRlDOaJ2WKUnVJYI35CKEaJ/5YDnWT
	 HKh5jfb388949enb8epNogYKvqi7b9ve3VWDIkKwMV/fZIs9oySE6JSqz69xM2MRJK
	 vjE8q+tzh/h9A==
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
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
Date: Tue, 30 Jan 2024 08:52:00 +0100
Message-ID: <87le87uulb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Anup Patel <apatel@ventanamicro.com> writes:
>
>> The RISC-V AIA specification is ratified as-per the RISC-V international
>> process. The latest ratified AIA specifcation can be found at:
>> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupt=
s-1.0.pdf
>>
>> At a high-level, the AIA specification adds three things:
>> 1) AIA CSRs
>>    - Improved local interrupt support
>> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>>    - Per-HART MSI controller
>>    - Support MSI virtualization
>>    - Support IPI along with virtualization
>> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>>    - Wired interrupt controller
>>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>>    - In Direct-mode, injects external interrupts directly into HARTs
>>
>> For an overview of the AIA specification, refer the AIA virtualization
>> talk at KVM Forum 2022:
>> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization=
_in_KVM_RISCV_final.pdf
>> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>>
>> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or high=
er).
>>
>> These patches can also be found in the riscv_aia_v12 branch at:
>> https://github.com/avpatel/linux.git
>>
>> Changes since v11:
>>  - Rebased on Linux-6.8-rc1
>>  - Included kernel/irq related patches from "genirq, irqchip: Convert ARM
>>    MSI handling to per device MSI domains" series by Thomas.
>>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH19,
>>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@li=
nutronix.de/)
>>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism.
>>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>>    platform devices.
>
> Thanks for working on this, Anup! I'm still reviewing the patches.
>
> I'm hitting a boot hang in text patching, with this series applied on
> 6.8-rc2. IPI issues?

Not text patching! One cpu spinning in smp_call_function_many_cond() and
the others are in cpu_relax(). Smells like IPI...

