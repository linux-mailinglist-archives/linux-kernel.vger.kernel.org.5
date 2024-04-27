Return-Path: <linux-kernel+bounces-160840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC78B4370
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5289283B18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2597364AE;
	Sat, 27 Apr 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GWRkU0Qr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACC3839D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180634; cv=none; b=c38tJCRDUp3ykply4E7CwST/RPdFT9WMIJNNYxgjE9oYT9fBmY/edOpDGriczhniO7ew9GG9emv2ZciK1ITf7Haapd5WyinQoEgzXRO0OiGe4sd1Y4zDmYQmPg0/sndqoZmuYbp5tW1pUO4Fw6wrpllGw1HHY1uP6OC8r437CKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180634; c=relaxed/simple;
	bh=wJNk9kr2TzKyrGXJeG1VDeeDuXeeF1deBgQLxDjI94I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJMBDl0Fn46KhV9zDftwuSi7qbzLIkxlmrB+BIuwHHT5USzhkz0mFlRn/GSwVlR/DE/ZNwVANF0UZEX8/mjEUyblqnY8ZPUKN1ytrTW2zsNX9M7jzp35YpGoaQxtQWC33zmZI1m2A/1UpZQqq1QMgyd5zMXnvvcM88brt2nSzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GWRkU0Qr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eab16c8d83so21857025ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714180631; x=1714785431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFg92GezPFh0mv6IYrarbWQAPQNkfvXf7+vfg6UWTLc=;
        b=GWRkU0Qr+iY+PtykxFJC9cRKyiBvuEeaZoKyJtmNkY807WV0bhGG6iTSGmFUwwfx8Y
         xlqRMbdkuJjCu0OkJUrzJuRjZWN7tt71v792uml0x9srP0XpFooEuqPXFMhibsOIouye
         VA7Sy+eduQRBkxCTO7Nmpz4tH0m6FNwXLRIuY1K5O2eQ4Xni3HaDmAmDO0yLKfISQjoq
         0SI3+0GrLysD2JZ2BVTAq3x8n/iuI+5q1lf2ScEkYfZguuiX7oQ9EjUTtFeo2LUCssmu
         cZATIOlf5eHtM/++Bh+SSbmlPNID1KE0jZQOcpnZsONfpEb62Unk1lr19fy3QyJWum7q
         VRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714180631; x=1714785431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFg92GezPFh0mv6IYrarbWQAPQNkfvXf7+vfg6UWTLc=;
        b=Kd6+UTrl+IhccIfAaQ2FaBYsVFQaZcsTQvu+IZUbHY0QUjiQUiHKTxeO1w3av7FoOZ
         SgE6oLofZH1lTn7nbhW1OLNNcMsR5C61uteuMulNOGt18Dmq9eUBQYvzhbF8zch9ok/f
         YH96LYt1Lg1OjAAKeZxGRnrUPMtN/BNR2TdyuQY6zzoZk3g1TMi3/rWosikg/8t43dSs
         FIAW2v70OdJai9I82cSxhJBF3tEBH7bq2pD9a0XvjESm/qCjnjhTpopotayisYIHVZgg
         VFDLW2TQRblq25Mr7Q3wSOHbcuoDtSnVjG4AVmvgA5iqXk32TW5SwIcH7oleYBPy6N/O
         QVBw==
X-Forwarded-Encrypted: i=1; AJvYcCU9R6AHW50Em8TEiZec4A9H0ImaTQlFDvY/A4d3QGyMR/jkk9vxeOsOdHD9+zoDpdTNZa0g9k7VH5fv5yiO6fvl1vXabDeLL2Pvf5yR
X-Gm-Message-State: AOJu0Yx1qcRdRUlBvQl7QBpdrr964IDS6/rEW0x0iQ5Zlt627MgxN9A+
	qPnCsEK4/XWp2bIaGF3SxxGCPi23vG39xIZUfl6KTKjm1J4aL+gxh4lSvhY12NI=
X-Google-Smtp-Source: AGHT+IFShfk0g+JEaLyl2jF/RXq/ZXlGfv0o6Yy5A1krdr9Ne2WG7D/ikaciV2cGwvKkdC2eOZn6Qg==
X-Received: by 2002:a17:903:11c8:b0:1eb:7dc:7097 with SMTP id q8-20020a17090311c800b001eb07dc7097mr3484408plh.48.1714180631148;
        Fri, 26 Apr 2024 18:17:11 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e3e081d07esm16424391plb.179.2024.04.26.18.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 18:17:10 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:17:08 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, Ved Shanbhogue <ved@rivosinc.com>
Subject: Re: [RFC PATCH 6/7] riscv: kvm: add SBI FWFT support for
 SBI_FWFT_DOUBLE_TRAP_ENABLE
Message-ID: <ZixSFLZYZaf8BKHP@debug.ba.rivosinc.com>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
 <20240418142701.1493091-7-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418142701.1493091-7-cleger@rivosinc.com>

On Thu, Apr 18, 2024 at 04:26:45PM +0200, Clément Léger wrote:
>Add support in KVM SBI FWFT extension to allow VS-mode to request double
>trap enabling. Double traps can then be generated by VS-mode, allowing
>M-mode to redirect them to S-mode.
>
>Signed-off-by: Clément Léger <cleger@rivosinc.com>
>---
> arch/riscv/include/asm/csr.h               |  1 +
> arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  2 +-
> arch/riscv/kvm/vcpu_sbi_fwft.c             | 41 ++++++++++++++++++++++
> 3 files changed, 43 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>index 905cdf894a57..ee1b73655bec 100644
>--- a/arch/riscv/include/asm/csr.h
>+++ b/arch/riscv/include/asm/csr.h
>@@ -196,6 +196,7 @@
> /* xENVCFG flags */
> #define ENVCFG_STCE			(_AC(1, ULL) << 63)
> #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
>+#define ENVCFG_DTE			(_AC(1, ULL) << 59)
> #define ENVCFG_CBZE			(_AC(1, UL) << 7)
> #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
> #define ENVCFG_CBIE_SHIFT		4
>diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>index 7dc1b80c7e6c..a9e20d655126 100644
>--- a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>+++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>@@ -11,7 +11,7 @@
>
> #include <asm/sbi.h>
>
>-#define KVM_SBI_FWFT_FEATURE_COUNT	1
>+#define KVM_SBI_FWFT_FEATURE_COUNT	2
>
> struct kvm_sbi_fwft_config;
> struct kvm_vcpu;
>diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
>index b9b7f8fa6d22..9e8e397eb02f 100644
>--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
>+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>@@ -9,10 +9,19 @@
> #include <linux/errno.h>
> #include <linux/err.h>
> #include <linux/kvm_host.h>
>+#include <linux/riscv_dbltrp.h>
> #include <asm/sbi.h>
> #include <asm/kvm_vcpu_sbi.h>
> #include <asm/kvm_vcpu_sbi_fwft.h>
>
>+#ifdef CONFIG_32BIT
>+# define CSR_HENVCFG_DBLTRP	CSR_HENVCFGH
>+# define DBLTRP_DTE	(ENVCFG_DTE >> 32)
>+#else
>+# define CSR_HENVCFG_DBLTRP	CSR_HENVCFG
>+# define DBLTRP_DTE	ENVCFG_DTE
>+#endif
>+
> #define MIS_DELEG (1UL << EXC_LOAD_MISALIGNED | 1UL << EXC_STORE_MISALIGNED)
>
> static int kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
>@@ -36,6 +45,33 @@ static int kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
> 	return SBI_SUCCESS;
> }
>
>+static int kvm_sbi_fwft_set_double_trap(struct kvm_vcpu *vcpu,
>+					struct kvm_sbi_fwft_config *conf,
>+					unsigned long value)
>+{
>+	if (!riscv_double_trap_enabled())
>+		return SBI_ERR_NOT_SUPPORTED;

Why its required to check whether host has enabled double trap for itself ?
It's orthogonal to guest asking hypervisor to enable double trap.

Probably you need a check here whether underlying FW supports handling double
trap.

Am I missing something here?

>+
>+	if (value)
>+		csr_set(CSR_HENVCFG_DBLTRP, DBLTRP_DTE);
>+	else
>+		csr_clear(CSR_HENVCFG_DBLTRP, DBLTRP_DTE);

I think vcpu->arch.cfg has `henvcfg` field. Can we reflect it there as well so that current
`henvcfg` copy in vcpu arch specifci config is consistent? Otherwise it'll be lost when vCPU
is scheduled out and later scheduled back in (on vcpu load)

Furthermore, lets not do feature specific alias names for CSR.

Instead let's keep consistent 64bit image of henvcfg in vcpu->arch.cfg.

And whenever it's time to pick up the setting, pick up logic either perform the writes in
henvcfg. And if required it'll perform henvcfgh too (as `kvm_arch_vcpu_load` already does)

>+
>+	return SBI_SUCCESS;
>+}
>+
>+static int kvm_sbi_fwft_get_double_trap(struct kvm_vcpu *vcpu,
>+					struct kvm_sbi_fwft_config *conf,
>+					unsigned long *value)
>+{
>+	if (!riscv_double_trap_enabled())
>+		return SBI_ERR_NOT_SUPPORTED;
>+
>+	*value = (csr_read(CSR_HENVCFG_DBLTRP) & DBLTRP_DTE) != 0;
>+
>+	return SBI_SUCCESS;
>+}
>+
> static struct kvm_sbi_fwft_config *
> kvm_sbi_fwft_get_config(struct kvm_vcpu *vcpu, enum sbi_fwft_feature_t feature)
> {
>@@ -111,6 +147,11 @@ static const struct kvm_sbi_fwft_feature features[] = {
> 		.id = SBI_FWFT_MISALIGNED_DELEG,
> 		.set = kvm_sbi_fwft_set_misaligned_delegation,
> 		.get = kvm_sbi_fwft_get_misaligned_delegation,
>+	},
>+	{
>+		.id = SBI_FWFT_DOUBLE_TRAP_ENABLE,
>+		.set = kvm_sbi_fwft_set_double_trap,
>+		.get = kvm_sbi_fwft_get_double_trap,
> 	}
> };
>
>-- 
>2.43.0
>
>

