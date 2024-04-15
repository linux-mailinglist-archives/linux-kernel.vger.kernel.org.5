Return-Path: <linux-kernel+bounces-145273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30D8A51BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFA4B24128
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59595824BB;
	Mon, 15 Apr 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nU9w49NQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88208249B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187964; cv=none; b=JBdYPNEfz2HvRW4S+9FvR1hDs5IsBIiGVo15jwfjd3HvZ03BOgJmYIyyE3mepIM4x+l7fAZKrGE5MbhvUsby3rrAWSyUCFrpCbFANb/dD9jztXXyQDbEQCaVIlTo59o5uW909a+78hHQ0vaPHCb7jUXfY5Am/WHV7pYGCQr2PEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187964; c=relaxed/simple;
	bh=47KwHEpTElLjbNjsJm1t+l/GmTOAMw2E7SYcceePcgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvhSWXv/1KK2VjxCq3GCuhuI9XOkfNcaQAvuwcD3ExAyXCS3a551KHZcCQAH7x2uipR9iU4qwAA9bzFo2uhTRqJIm/3GpzJjA1+Nd/TT1jlIvm+Jrv397Pd/w6Cb5ZhdJWzW8CFhai8UX3GYpJejdxKGQV5oX3QewHY3edEiSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nU9w49NQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417e327773cso20384815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187958; x=1713792758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfFnCtrCdaYweGdW7b/X7wLS8PykVIhbaLaFH/3RBKs=;
        b=nU9w49NQHErlj7en2YVewwMkkuyN5GNZRdA5Pjb5N3S6X+hU/jqGHRnr+wZIPJn920
         /yLtevOK7anbMssCvpBcu7UBJK+p9eCiI/f7RD2EgxKCDyCmoESvGna963VWvLDfRaUE
         16rSPIJtwxATBv+9dxcnGbvPFmdJTeIegpF/zrXHLCAH/LWJJPuw2k6SS9pJrMZAz92y
         IjNjTTpr1v0HHmC6cxothAk3m7P6rWIyv9fsOEZ3CM4OvwZqO1Tf0ws9t/2RFiA4Wx6H
         FgMA9abW2KOUTkpy3GfhdSLlOpk5GKF3SJmJwHA8WjfyFcuubsGjfmmCluWrdCPe5hJc
         y7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187958; x=1713792758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfFnCtrCdaYweGdW7b/X7wLS8PykVIhbaLaFH/3RBKs=;
        b=kwsS/xFdQEQNvTFpxvVVyX5kaPrjlhXhgGb1SVXNM4eLjllP7aN4f26v+39UbGtNuR
         /v01tf+uk723BozijCvM51FHI/WA2udxLROG9s1AyyHD0T50jN5AoyCNBeoAxDIWp0Lh
         T7UwoJsmcVNPL65JqQ0493GnZlaokHr/UeHNKTi5af4FDVtwDIxvWy/bhG4Mtf1kyS1M
         WO2U1Wb3Bv6285cNIVsq/NnYcZKfiX7tRG27O5dsBVY1dwSdUi4CXBkf9unyW5RCSPVp
         Gq7oQHlPnBvERB4IAdTyUTjxJWrPpKRodGANIdMTr0syqBSEgajM7hku4umFc03U3gkr
         j2cg==
X-Gm-Message-State: AOJu0Ywf0cieReyuZM0ryDTkP8nPcLyakTqKUFWvw74q6T9m9p1lclLO
	7fbsVCrrtqEnPbsgILHmrxLJXbh2JyDl98U9iAkCeBvk8t55wf2ixZYYUgBDqNw=
X-Google-Smtp-Source: AGHT+IFoZFoMz1NB27raXr0+F36UbAh0bYI/huPwqdYpnuJ5dY1VU+ZBhab3Ez4blLLhX5Tys86QcQ==
X-Received: by 2002:a05:600c:5115:b0:418:5e81:415f with SMTP id o21-20020a05600c511500b004185e81415fmr2552795wms.14.1713187958349;
        Mon, 15 Apr 2024 06:32:38 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b00414659ba8c2sm16357094wmq.37.2024.04.15.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:32:37 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:32:37 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 22/24] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240415-f6d8638ff922ccd58d1abf41@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-23-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-23-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:50PM -0700, Atish Patra wrote:
> Verify PMU snapshot functionality by setting up the shared memory
> correctly and reading the counter values from the shared memory
> instead of the CSR.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../testing/selftests/kvm/include/riscv/sbi.h |  25 +++
>  .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 144 ++++++++++++++++++
>  3 files changed, 181 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index 6675ca673c77..1b995481a3fa 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -8,6 +8,12 @@
>  #ifndef SELFTEST_KVM_SBI_H
>  #define SELFTEST_KVM_SBI_H
>  
> +/* SBI spec version fields */
> +#define SBI_SPEC_VERSION_DEFAULT	0x1
> +#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
> +
>  /* SBI return error codes */
>  #define SBI_SUCCESS				 0
>  #define SBI_ERR_FAILURE				-1
> @@ -33,6 +39,9 @@ enum sbi_ext_id {
>  };
>  
>  enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> +	SBI_EXT_BASE_GET_IMP_ID,
> +	SBI_EXT_BASE_GET_IMP_VERSION,
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
>  enum sbi_ext_pmu_fid {
> @@ -60,6 +69,12 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> +struct riscv_pmu_snapshot_data {
> +	u64 ctr_overflow_mask;
> +	u64 ctr_values[64];
> +	u64 reserved[447];
> +};
> +
>  struct sbiret {
>  	long error;
>  	long value;
> @@ -113,4 +128,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  
>  bool guest_sbi_probe_extension(int extid, long *out_val);
>  
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +					    unsigned long minor)
> +{
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));

Same parentheses comment as the other patch.

Thanks,
drew

