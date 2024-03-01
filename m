Return-Path: <linux-kernel+bounces-87894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C086DACD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC1B2368E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835D4F8B1;
	Fri,  1 Mar 2024 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="aJlOJzgu"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DE446C8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268165; cv=none; b=LjMc+Oj2quqE8pYrnct8k8dsnl9n/Xvu3NLXY+0EN0MTFRcNGAA59fwF0f6HB0CZPhepEocUfplGhUs3uWOttDwY33mQv3RL2zx8YqSptodlc4G5DSBEGTZX/5RrKigctAgw8SJYbZFkBaTcBNKy28kasm2H4Zp9rAoHWT8jIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268165; c=relaxed/simple;
	bh=H2hnTB5lBI7E2U+Jl5DtMSrqK3/l4VCxpxuTdflPYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n462jBGrrcfd3PwOLRbWgQgp4ALMKmK+IC1UpMduDeOtYNrEyE/bKEsiNtu/kc3+faSd34YDW3fZSrCTenXTjxvWu05zC2IdTwZM4rrgF+727ke8cUUAtHyUzdM5L9my25aEbl8VVdzODPp8hpx2gEbb+4Z/IhsKCrnafxfV7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=aJlOJzgu; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365afa34572so7395145ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268163; x=1709872963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvBduY4sAnPPjxO+Xfm+PRZxCbldlxfEFEFnzNm66ao=;
        b=aJlOJzguOkNb0LTjypIgjXwocUoUWDCgmS7NX80jxLd8AIajEEgkbdl1V/ATjicV6i
         x3cvGq1uDIFZQdU/I2i/Tq5X6Kh439V60Auv44NsEE/RAnXvc9dVHRzb9gfv0VZlmzdf
         /KtZ29/ngd+sADa1MGE5qOgiTOlRbBw4bzukyp3X3YPPmhJ/ROBmoMc/IJEkIe/6myLJ
         FiCEjBe49iDMcznO0MXfU9ws5gowL5AGqSbfOoT4ojru5fqtykJramWUQ45WTXo5F16/
         NQpBPt/Y9juEwKp6KJyeDk9RfN323gTh4+tCw3i4kHkX2AeIT3eR9J0m/eR3DJE78FJX
         u2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268163; x=1709872963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvBduY4sAnPPjxO+Xfm+PRZxCbldlxfEFEFnzNm66ao=;
        b=TnYzLGsvz2l5EiGabcUfNo3kvSR5AuqH9VBmZ5ZpwYrXmmMPxZwdfRKlaPVAgidJy8
         IhOf0h1FJQ7MV0iZ4QpHkmJxU2PM+H9pCxqs5ZRgDSdsd1H2UTbQ9qVQql30/SaHyKKD
         Dv/JSPrjoL7cM/zwL1nImT9JVIka20DYs59MmpBKPtdHZSTTjR0kR/n0xuaEg2+Y7uvt
         3VVlKCj21sTa6vTuH/tKyg3140KvohYNbnFBdPDbcPnh8TKjekvO1CAa8pZx0xid0vb+
         dNG7/JaylhYl+sEMWGj+HeAG+Oip0r4c4rhlf5US1hre33cgUu0NBsPVFknrXBa2JyAY
         Z2Wg==
X-Gm-Message-State: AOJu0YxjquVmEUY6uw+PlbKP/m5S3wXfql+iy+3E/LPyqFGfYWZH/YPV
	GKyPwNU5QamBzQnxLlppQ5ZQf9eGr//V5hXpSXwrsgJzkIsgAhRVi5N2cj8oY8WrV2tkYA0Y25i
	sN+qknCVXVEEUl0cyNQDwhnRlHZmHJC/w6mt6kA==
X-Google-Smtp-Source: AGHT+IEiwLynSQVhGquKm7KUUZTdCWl6lpF6xy6jzlGvVXpd+rZtIhRUJOkknsYJ2UtSLC0OjSs3410EETlKnHWqOKg=
X-Received: by 2002:a05:6e02:1e01:b0:365:1ee3:ca8a with SMTP id
 g1-20020a056e021e0100b003651ee3ca8amr792980ila.29.1709268162757; Thu, 29 Feb
 2024 20:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-12-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-12-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:12:32 +0530
Message-ID: <CAAhSdy3MAMPJDZhRfFXY3d3d3BOpTJiPBAqVRAYKgzYNLFWyXg@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] KVM: riscv: selftests: Add Sscofpmf to
 get-reg-list test
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
> add this extension to get-reg-list test.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8cece02ca23a..ca6d98a5dce5 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_V:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SMSTATEEN:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSAIA:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSCOFPMF:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSTC:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVINVAL:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVNAPOT:
> @@ -406,6 +407,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_ISA_EXT_ARR(V),
>                 KVM_ISA_EXT_ARR(SMSTATEEN),
>                 KVM_ISA_EXT_ARR(SSAIA),
> +               KVM_ISA_EXT_ARR(SSCOFPMF),
>                 KVM_ISA_EXT_ARR(SSTC),
>                 KVM_ISA_EXT_ARR(SVINVAL),
>                 KVM_ISA_EXT_ARR(SVNAPOT),
> @@ -927,6 +929,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> +KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
> @@ -980,6 +983,7 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_fp_d,
>         &config_h,
>         &config_smstateen,
> +       &config_sscofpmf,
>         &config_sstc,
>         &config_svinval,
>         &config_svnapot,
> --
> 2.34.1
>

