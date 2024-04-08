Return-Path: <linux-kernel+bounces-135304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6789BEA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC64C1C217F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9F6A35D;
	Mon,  8 Apr 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="AKIG5uw5"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42346A340
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578057; cv=none; b=ja8eAxQjG+c7DhZPLODxCEQ+zES+mRvhDXE3R3ri76n0ADOnYV6v681TlzrVhmyAjOEzLcEDu8enk9PEH0ZbCpBTWQXvw2u+L+vMt0Z12tVjRKbfG9BX5diNl0+FIkdu6uO/LgBkd7DPObTZuQI1+2/1p4HD12ROhbSMbp8/ObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578057; c=relaxed/simple;
	bh=ceBSqJ4HrDGpuiUBK8Miv6Kqwd6mxdCXZsrKQfo/3Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG5/2RZoZHjoNn1Vpsd5nB4VUo8E/Zy+KNU6+qiS06fv1gdhvTRC01NEojTPGCwU6UYsU3PwNgqfoHTdoLYooYf0e8Jkb4X70yLaUISd0njCYrLQq+QWERY2v/ySyUPFBFADjVwjQ8ptJSnYHKV39iqkjLICnkaZYGNRtMPDuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=AKIG5uw5; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a205e0f16so4753915ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1712578055; x=1713182855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysPdkHofn0SsqVjUlorA7HM2PSEU9x+PNO7DRN4CxYo=;
        b=AKIG5uw5rtwhEwoCyvfgGm5l8PoazjC89SKQX84++eIYOjvuYK3WS8+nl1ZaSyzDSt
         oxPZ97fh4LOk/IHS95qfiwFLuUDlEogd09xNhPIgQ3sRWKM/vpFb6apkq8y4Bcf8RF/B
         xDJR5keEwZg7g0IpbYLXwSOys8T2ZA+taRmS+o/wBldvMgp8ydJTiVlq59MqoP7emzrW
         LNfMVi8FDvIVtqtVdJNGPQAlYTePX+yt6PIKTz1aqCzIPei7RuzzdTjX9kVbTzAQs8dr
         zLPLHpj3f+8Gy6j34S1vfsbCXol+RYNVvUKhYwiduDMtvIkDMkPNzl+4YfzTGP2339/+
         D3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578055; x=1713182855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysPdkHofn0SsqVjUlorA7HM2PSEU9x+PNO7DRN4CxYo=;
        b=ATw/wKqv7GRd7UWc+LJo0scAkAXYKzEGlWgS+VVayOwHYC/CXudBzYhYhskH47priE
         JfmWXgI40GWaaoupq18h/xAncKwR29CJSFi+yldAkSmKvtltvddtewcHJvPqXLQVwCyI
         eBW2zbYluwuBsQd80jUp358a4YynsjWxTAPYRcCNzNz+7lhqjG6INKz+LWsCC8HywiMm
         +8rbuhg1NtZgGSxTw0/iorUFlUa/2uumKTdn9pVXRzvIR/davr10LeHJhR1gz3gkIpWG
         1a84o1feNk/BhYxX8X9syz1C1h5XslF275biQkzFuCMsHGTDUju3jH/8xZxHNs1IId4D
         BflA==
X-Forwarded-Encrypted: i=1; AJvYcCW/X21mUqS4MvJxHpeZq4kWoPH5rffRMG6onqNAf336+rVn5tx2iNq4WVr4ISg/Hn9S8w5I9DU8bWVyLGT9oIj0PcEAeV25a5NGgiPm
X-Gm-Message-State: AOJu0YxwJRyplNkES60pgddVAadfzRiPV4lLwUE8BjgS44I4gMCQ7jXi
	Ss1KNqwJIXUlnckM4dwM408GDFLA/KAwWy5TNX2TmRwYkimQZk9uXBbuU4jybCDCrlg3NOPaz1c
	ePQme8bzxk8HQw2RQwL5ho5HbgsNS6jlOLGKKEA==
X-Google-Smtp-Source: AGHT+IHUq83zNBHTpl7MmDd5GJ1Gg5JdecBzvdbUwm0GbS2BKl2pv80jCI4+BNP4aYrjw+ttNoV+f0bZ5iomvms7YJo=
X-Received: by 2002:a05:6e02:1568:b0:36a:2872:90d4 with SMTP id
 k8-20020a056e02156800b0036a287290d4mr1779608ilu.26.1712578054731; Mon, 08 Apr
 2024 05:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328031220.1287-1-liangshenlin@eswincomputing.com> <20240328031220.1287-2-liangshenlin@eswincomputing.com>
In-Reply-To: <20240328031220.1287-2-liangshenlin@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 8 Apr 2024 17:37:23 +0530
Message-ID: <CAAhSdy0DgW055iV7=_D6iOLr1iVeK9SZmG8hqBG0_hb1z=+07g@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISCV: KVM: add tracepoints for entry and exit events
To: Shenlin Liang <liangshenlin@eswincomputing.com>
Cc: atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:49=E2=80=AFAM Shenlin Liang
<liangshenlin@eswincomputing.com> wrote:
>
> Like other architectures, RISCV KVM also needs to add these event
> tracepoints to count the number of times kvm guest entry/exit.
>
> Signed-off-by: Shenlin Liang <liangshenlin@eswincomputing.com>
> ---
>  arch/riscv/kvm/trace_riscv.h | 60 ++++++++++++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu.c        |  7 +++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 arch/riscv/kvm/trace_riscv.h
>
> diff --git a/arch/riscv/kvm/trace_riscv.h b/arch/riscv/kvm/trace_riscv.h
> new file mode 100644
> index 000000000000..5848083c7a5e
> --- /dev/null
> +++ b/arch/riscv/kvm/trace_riscv.h
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tracepoints for RISC-V KVM
> + *
> + * Copyright 2024 Beijing ESWIN Computing Technology Co., Ltd.
> + *
> + */
> +#if !defined(_TRACE_RSICV_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RSICV_KVM_H

s/_RSICV_/_RISCV_/

> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM kvm
> +
> +TRACE_EVENT(kvm_entry,
> +       TP_PROTO(struct kvm_vcpu *vcpu),
> +       TP_ARGS(vcpu),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, pc)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->pc     =3D vcpu->arch.guest_context.sepc;
> +       ),
> +
> +       TP_printk("PC: 0x%016lx", __entry->pc)
> +);
> +
> +TRACE_EVENT(kvm_exit,
> +       TP_PROTO(struct kvm_vcpu *vcpu, unsigned long exit_reason,
> +                       unsigned long scause),
> +       TP_ARGS(vcpu, exit_reason, scause),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, pc)
> +               __field(unsigned long, exit_reason)
> +               __field(unsigned long, scause)

This is not the right contents describing a KVM exit.

The fields over here should be aligned with "struct kvm_cpu_trap"
so we should have following fields:
    __field(unsigned long, sepc)
    __field(unsigned long, scause)
    __field(unsigned long, stval)
    __field(unsigned long, htval)
    __field(unsigned long, htinst)

> +       ),
> +
> +       TP_fast_assign(
> +               __entry->pc             =3D vcpu->arch.guest_context.sepc=
;
> +               __entry->exit_reason    =3D exit_reason;
> +               __entry->scause         =3D scause;
> +       ),
> +
> +       TP_printk("EXIT_REASON:0x%lx,PC: 0x%016lx,SCAUSE:0x%lx",
> +                       __entry->exit_reason, __entry->pc, __entry->scaus=
e)
> +);
> +
> +#endif /* _TRACE_RSICV_KVM_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace_riscv
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index b5ca9f2e98ac..ed0932f0d514 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -21,6 +21,9 @@
>  #include <asm/cacheflush.h>
>  #include <asm/kvm_vcpu_vector.h>
>
> +#define CREATE_TRACE_POINTS
> +#include "trace_riscv.h"
> +
>  const struct _kvm_stats_desc kvm_vcpu_stats_desc[] =3D {
>         KVM_GENERIC_VCPU_STATS(),
>         STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
> @@ -782,6 +785,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                  */
>                 kvm_riscv_local_tlb_sanitize(vcpu);
>
> +               trace_kvm_entry(vcpu);
> +
>                 guest_timing_enter_irqoff();
>
>                 kvm_riscv_vcpu_enter_exit(vcpu);
> @@ -820,6 +825,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>
>                 local_irq_enable();
>
> +               trace_kvm_exit(vcpu, run->exit_reason, trap.scause);
> +
>                 preempt_enable();
>
>                 kvm_vcpu_srcu_read_lock(vcpu);
> --
> 2.37.2
>

Regards,
Anup

