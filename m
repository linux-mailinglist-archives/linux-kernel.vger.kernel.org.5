Return-Path: <linux-kernel+bounces-88743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E239586E603
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DDDB24120
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376BE1E88A;
	Fri,  1 Mar 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Rw3Dwuqs"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12E225D0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311238; cv=none; b=ATjvJWsPVwDMLt4v4cv4KpbmmJ/EIqXqFtThsuSmUmUTUanyTVumyEFztfDOUJMBbrGMCXsTZsQW/z6HgsLNUcdcPNvobi+j+if1tfx/LA+nXN3LHINQzd2o5AX/qY3wiApMF8uapUDpEn/CF80qLao5AaXbns+q92r/6JI8JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311238; c=relaxed/simple;
	bh=1DFl0ZbNmoHHCDx2NBctdiyCsC0l1eSWBPINNTEml0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ1oqAoa14eq6E4PZc0t7acTnHe9wRkf4BRrhUnmTnUzEq/JRkjxsDBaC8/51KZgVa+Fjom6BT7RfIkpv055lXA1TlTz8uzbVJAsYAm4+6q6mBNDsz2I5gpZv4Je/po52fpIGbrv7mdi3XC484GVpuQmeLZ4cauay9AM26scUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Rw3Dwuqs; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c82cab0494so7083439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709311236; x=1709916036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xpVEUPupFJ4mY5Qxb0D2y0+A3GchrSV23FNcC1i+jo=;
        b=Rw3DwuqsCzOiiHT9eSWMkJ0EoDc2l/s02nmZMNiKrWNT0TvusHRfdWpiAQ83kdmuRx
         rUHmdSHs/wzp72ezfdcdGhWx8w8MDKJFExTF/BVL9ObWk8mXTOULJ737uoNBfJxUOken
         AiTV8q3mNkZ1c9K6xH8aKqxzMzX8qXX+PFKtvpMClg/RnXdDgd583FGupCY0obX4Bg/p
         V1/gvvPIdh0MB7Lg1TsUEDxm8w2it0DaUVIor6lX6mHmUv74yizHzVqA9zdpxgEb03ym
         qD722WaHHwtLNJs2904i9eyEUjdJhQEGe1oPLVABAAR/bTjjSvUdERHeHKW2Chwm+RVJ
         dH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311236; x=1709916036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xpVEUPupFJ4mY5Qxb0D2y0+A3GchrSV23FNcC1i+jo=;
        b=PeW6vmnhWg+7/HbTYbV0prCGWQ+YIZZe5v8sX+3mG7nOy0K5t7qXwH+yvKqa7o3/x/
         ZTVTEnfYWGXtlS50CmRUPF8l4j8NbPTgvpnHxJ4zFAK6Ri+Iu1tvjsy5rdUOO1Fo7JjT
         p6WZkxVJh0WyP2cJHu8a5ScncWNecsDq/zV7CorN1W3g+fPLtdwAnN/PHAifqqjTZWos
         jnK51c9oXq7ljxRd/OBYXNq9dpwVTC0u5Opm7RFT0CsrAT7Ztow0+bK1Jq8SHEfS6Hwf
         qQbQAscOTii30aiODHLj3fZGD4umGAFmxeGW6xagHwA5icIs0kVVfKQhFe03xpR/dZ3O
         tOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi5HCfcTu5PaTk2VN4rmi6g0NRSpnCQgePIN1ophuESzyoiZq676eLQLOQOgL/Ualz4BwQCVVw6KyO9PPfO4wyETwCOAAdtfnFWKtU
X-Gm-Message-State: AOJu0YyiT+togc+U08TWuzjhhdd0hJEPvjBHqbE3ysTqoRkmzz0EeWC5
	yT/38HV8QlVQ58HhOZuc3jOEAzaqRFKLap6tB6LOVKnhVQbAposqw9j48CiobxYTjJclCpSmIv+
	r/ApDvIB2w26qnbh5yGkRP+R4Amca064k2m8RRA==
X-Google-Smtp-Source: AGHT+IFA/8ZsTPlrzqpqMe1C7sAim+Tu77L5L4EC5Mu3PiP55/jHP04OSuPWwGne0ZjJhx4bUxIrY3D6GoIF2d46Q1U=
X-Received: by 2002:a92:c24e:0:b0:365:c1fc:dc07 with SMTP id
 k14-20020a92c24e000000b00365c1fcdc07mr2509460ilo.0.1709311235987; Fri, 01 Mar
 2024 08:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214123757.305347-1-apatel@ventanamicro.com>
In-Reply-To: <20240214123757.305347-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 22:10:25 +0530
Message-ID: <CAAhSdy3ObzJHgF0QL9QqKVm37F83HzdF28A5107fm0dLFxoOLQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM RISC-V report few more ISA extensions through ONE_REG
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atishp@atishpatra.org>, 
	Shuah Khan <shuah@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:08=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series extends the KVM RISC-V ONE_REG interface to report few more
> ISA extensions namely: Ztso and Zacas. These extensions are already
> supported by the HWPROBE interface in Linux-6.8 kernel.
>
> To test these patches, use KVMTOOL from the riscv_more_exts_round2_v1
> branch at: https://github.com/avpatel/kvmtool.git
>
> These patches can also be found in the riscv_kvm_more_exts_round2_v1
> branch at: https://github.com/avpatel/linux.git
>
> Anup Patel (5):
>   RISC-V: KVM: Forward SEED CSR access to user space
>   RISC-V: KVM: Allow Ztso extension for Guest/VM
>   KVM: riscv: selftests: Add Ztso extension to get-reg-list test
>   RISC-V: KVM: Allow Zacas extension for Guest/VM
>   KVM: riscv: selftests: Add Zacas extension to get-reg-list test

Queued this series for Linux-6.9

Thanks,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h                |  2 ++
>  arch/riscv/kvm/vcpu_insn.c                       | 13 +++++++++++++
>  arch/riscv/kvm/vcpu_onereg.c                     |  4 ++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c |  8 ++++++++
>  4 files changed, 27 insertions(+)
>
> --
> 2.34.1
>

