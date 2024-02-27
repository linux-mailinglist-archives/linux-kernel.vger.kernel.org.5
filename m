Return-Path: <linux-kernel+bounces-84005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7092886A13F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB26A1F20F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289014F972;
	Tue, 27 Feb 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Ghe4a1rZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DF14F965
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067422; cv=none; b=BW7tzGvjthvICXVjAdZhP6kEBsVgmGliz2MrYsEx5dp2pT9mc+nk1+25G4TYqjfGNDyCs83ni6V1EpCiWKCq4DzFyitEEfmriQPTGR5XC68DWFf2XpP1j1X+qD1RW1LoYnIJYLUDsbMP1wjdDoPZT5DBgUrrZtqsYvl1k9cBIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067422; c=relaxed/simple;
	bh=gJZBinDyWIvm+ZDABf7fPqFPDqpvWRUG2+D8GQZexY8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=XMIZmMleoB/NF7oG6eyE4PFx7gGHdq5pa0YiqhfPnfI/W3ftc3Lx1FqNHZHnqfu7bzGblX6WECIQdXuVIKwhbFHE0FF9jJpOs126Y/Mz4gMbuFtriH3f2Yd90Q73oi/RP0HgUH/jQ6A3D52WCPWYmieC8sRltGXKnmZaexwYxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Ghe4a1rZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d94b222a3aso48725545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709067420; x=1709672220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOB62dL9qN724Ecj/YLdjEDiS5KjiWcStv5/TyEIX7s=;
        b=Ghe4a1rZSOCzmmHgwJlt9LAjnEyR+wG18+SvtxJkpS9CEYoZqha8Rx9C429kgKW/8u
         G1/xZvmHw9I1EnnatwxuvfcFYAx401Kc5Uyc/cqPb2FqZ5N9HKDlnE0JCocCVcWK2MRP
         kOqLH5QMp/OSojM9bYFR62U65GMCzaSkcUYVckoR3OMEiR/Fdr2xkbXMrMU6OAG0q41P
         Y+w2wLL3/gkTjHQ6L/XYCi7cheokiZkIdzTWBEdUni/Y5iRXHN5NzQOK5ZDyIM4gh5bF
         gwBwEoaeaznKcXNHHxsXstoYdmSZFeQmr3x6QUAN1ZbtwcmVOoFyMDRmEXel5KI0mogx
         17lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067420; x=1709672220;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOB62dL9qN724Ecj/YLdjEDiS5KjiWcStv5/TyEIX7s=;
        b=mXI5Ec7HjOnbtDyDrYEgRoo2QxnaptCvooKPoBOWsozyZ4ZiIX+iaNjhNd0HMojaWe
         vuz0JAzNbOeqFM1GiG+v2kjrVmSra85Zw6NyPFEIiihOFiPZgTbSz1BIqeFt4QZpIBPx
         RGOY2zTVKo0pdNhZY57PD63sMfN9C85dxE74yERDYlPpRwBc+98T3NA2o+nuaejGCbeK
         3WTNZFksVgjIPQ3Mr2FY4YnYYPg+OS1hyfpO/50R6K+LAq/qZcwWPFFaY1omAfQUzZQE
         65np7JDIqYh0WW5vRBXBMGk7OizRiy9fQls9bmPlzWKDbhLdKeipEKSxbCb6B87anlu6
         NBgg==
X-Forwarded-Encrypted: i=1; AJvYcCWIolGWhxrlO4d98HXT/NRT3DJZT64xYKXclV4ne3phugbd1Ot7hr8Ssiq623TiYemxFUARUwz32jeRga8Q+z+69+5qaEMqxsFY1OWe
X-Gm-Message-State: AOJu0YzNS5i+XYxnUTJc0lwuZF7YwvY2IbMeyBvqSFj79TN/S/m9BAWc
	l54UCjAfqZe9OvyM9QajHEoCoKTt0WF1Cq3PpfDrYKCZ/HR++1oJtTJ40JfF2/w=
X-Google-Smtp-Source: AGHT+IF0DxTx3AxrLX1ryR9GF2gpsn7xPqrDvqd55MwEJEeBh4CVMCZzNgNnxt9s/ka4wUYMDn5FYw==
X-Received: by 2002:a17:903:1212:b0:1d9:3bb5:2819 with SMTP id l18-20020a170903121200b001d93bb52819mr13900313plh.34.1709067419669;
        Tue, 27 Feb 2024 12:56:59 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id ja9-20020a170902efc900b001dbb06b6138sm1940276plb.252.2024.02.27.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:56:59 -0800 (PST)
Date: Tue, 27 Feb 2024 12:56:59 -0800 (PST)
X-Google-Original-Date: Tue, 27 Feb 2024 12:56:51 PST (-0800)
Subject:     Re: [PATCH v2,RESEND 1/2] drivers: perf: added capabilities for legacy PMU
In-Reply-To: <6ad96656-3cf4-4e22-8a18-cfde5c31cfc1@ghiti.fr>
CC: vadim.shakirov@syntacore.com, linux-riscv@lists.infradead.org,
  atishp@atishpatra.org, anup@brainfault.org, Will Deacon <will@kernel.org>,
  Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-320add25-610e-4e86-a266-55a5f0b52087@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 11:26:20 PST (-0800), alex@ghiti.fr wrote:
> On 27/02/2024 18:00, Vadim Shakirov wrote:
>> Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
>> does not provide sampling capabilities
>>
>> Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
>> does not provide the ability to disable counter incrementation in
>> different privilege modes
>>
>> Suggested-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
>> ---
>>   drivers/perf/riscv_pmu_legacy.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
>> index 79fdd667922e..a85fc9a15f03 100644
>> --- a/drivers/perf/riscv_pmu_legacy.c
>> +++ b/drivers/perf/riscv_pmu_legacy.c
>> @@ -117,6 +117,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>>   	pmu->event_mapped = pmu_legacy_event_mapped;
>>   	pmu->event_unmapped = pmu_legacy_event_unmapped;
>>   	pmu->csr_index = pmu_legacy_csr_index;
>> +	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>> +	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
>>
>>   	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>>   }
>
>
> I see here that Atish added its RB:
> https://lore.kernel.org/linux-riscv/CAOnJCUJ-eE+zbXH0yBX_QBK2ep779q=wNCSrc+BJfzUb+zBCaw@mail.gmail.com/
>
> So I add it here (hopefully b4 won't complain, I don't know):
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

It says

NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Atish Patra <atishp@rivosinc.com>
     Msg From: Alexandre Ghiti <alex@ghiti.fr>
NOTE: Rerun with -S to apply them anyway

Should show up on fixes in a bit, assuming it gets through the testing.

>
> And I'd say the fixes tag for this one is:
>
> Fixes: 9b3e150e310e ("RISC-V: Add a simple platform driver for RISC-V
> legacy perf")
>
> Thanks,
>
> Alex

