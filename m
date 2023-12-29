Return-Path: <linux-kernel+bounces-12903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6281FC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B29F1F246B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00B33F5;
	Fri, 29 Dec 2023 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="joUfx3Iw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F015A2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbd1f9e0b8so782729b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1703814291; x=1704419091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4V1BHEupFQbqBJMrfQMAXq3kLkeflc54O4MuJlc11M=;
        b=joUfx3IwJENjSkDaqCzgDzdXMyaPbNaUVAl7Sce9DiDx1LvCe2Xr/cO5szO7sNsNUY
         4kQ169IsxanN82yl98edssKkiarP6GbXZbOIp6nwzr01vmwYnc/udMTL5UHijIXyqtNx
         dUtGkFq+nBhcov84ft5j8cQBk8UB0PmEYJvvdaS1G11vgNemtZyF7w4VTUHWleqNzwuy
         7lvA7JHva+awCyG3HHsAUK0qB5Iv1ozjFehSI8PtsQaB1NeB5IysdRBAIsm3NzcxW8nd
         IG6nq8eZBvlq3FVTVg5F4msPbfFDLjVxICSVuLSzeaXDsCpqIZwtTTztCjgOGatNtqlJ
         dsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703814291; x=1704419091;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4V1BHEupFQbqBJMrfQMAXq3kLkeflc54O4MuJlc11M=;
        b=S012xKjjPT11nqO6V08OnwyyxmEdnV7XZo0uarqzzYWI7wuXE+cw+05x6TNIptKF1I
         6EGIC5y8t2rnqpNBtKj1Kk49SjJIjBHrl98/g/WMoNSSZo50Rgb+BsQxjAgVsin1mjmH
         qfexItohVb9/rcSKFVDXd2JHHuyLP0FzK/UB1OYNk2VTy13Qsv4vwQfgth02WR2ecdM/
         ztoL7hCwZsZgsfGRCXE4TPDUVE/8jbhNal7jUH1YFvyPDSX91dyXg12fEmWt+1Yz+mKr
         AL37znqikX+b5v917jTJlkDk33qVnn2f6V0wOYAH7jtFqmWDn9wzb9TtPRaaNKmsnuTo
         4OpA==
X-Gm-Message-State: AOJu0YwD21NQf4wee6lE0lZ/+a9lKtDUxK2GY9XdfZz4f+n6sTVlglWa
	ZILpwMCerzzbVdWDTPfNqe8s3opyyygICSR4svEKMxhXV7w=
X-Google-Smtp-Source: AGHT+IEJDPm2HxcdY+IacGVsA8lBK6Lf18NKOW8Wt/2LU5dUqXP+w/AMvLeHFRRdjdIVbKE+YBkJyw==
X-Received: by 2002:a05:6808:3c4a:b0:3bb:ce8b:94b9 with SMTP id gl10-20020a0568083c4a00b003bbce8b94b9mr3240341oib.111.1703814290662;
        Thu, 28 Dec 2023 17:44:50 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id a25-20020aa78659000000b006d9c216a9e6sm7077180pfo.56.2023.12.28.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 17:44:50 -0800 (PST)
Date: Thu, 28 Dec 2023 17:44:50 -0800 (PST)
X-Google-Original-Date: Thu, 28 Dec 2023 17:44:33 PST (-0800)
Subject:     Re: [v1 04/10] RISC-V: Add SBI PMU snapshot definitions
In-Reply-To: <20231218104107.2976925-5-atishp@rivosinc.com>
CC: linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
  anup@brainfault.org, aou@eecs.berkeley.edu, alexghiti@rivosinc.com, ajones@ventanamicro.com,
  atishp@atishpatra.org, Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org, uwu@icenowy.me,
  kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
  Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-bc357c81-f43a-40e2-b4ac-f9c462e4c006@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 02:41:01 PST (-0800), Atish Patra wrote:
> SBI PMU Snapshot function optimizes the number of traps to
> higher privilege mode by leveraging a shared memory between the S/VS-mode
> and the M/HS mode. Add the definitions for that extension and new error
> codes.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index f3eeca79a02d..a24bc4fa34ff 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -122,6 +122,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_STOP,
>  	SBI_EXT_PMU_COUNTER_FW_READ,
>  	SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>  };
>
>  union sbi_pmu_ctr_info {
> @@ -138,6 +139,13 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>
> +/* Data structure to contain the pmu snapshot data */
> +struct riscv_pmu_snapshot_data {
> +	uint64_t ctr_overflow_mask;
> +	uint64_t ctr_values[64];
> +	uint64_t reserved[447];
> +};
> +
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
>
> @@ -234,9 +242,11 @@ enum sbi_pmu_ctr_type {
>
>  /* Flags defined for counter start function */
>  #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
>
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>
>  enum sbi_ext_dbcn_fid {
>  	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> @@ -259,6 +269,7 @@ enum sbi_ext_dbcn_fid {
>  #define SBI_ERR_ALREADY_AVAILABLE -6
>  #define SBI_ERR_ALREADY_STARTED -7
>  #define SBI_ERR_ALREADY_STOPPED -8
> +#define SBI_ERR_NO_SHMEM	-9
>
>  extern unsigned long sbi_spec_version;
>  struct sbiret {

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

