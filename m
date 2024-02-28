Return-Path: <linux-kernel+bounces-84646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0A86A976
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E78B23625
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DA25635;
	Wed, 28 Feb 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oICL3Cbn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13371DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107339; cv=none; b=BC9NNpN93HpY6Bv0qfS659V+66x6QvdvIoFg/v2SJFmvVvTJ92iy8iMza48BoTmcgWZYZlg77UTdd2FD22/hpA/8r50L2HsyrFHgUtO4ufF1Rsznx2JcchHnXWbfB91OTPTP9KwFqfwKCAbAhriq2J5OZg3zH9vTI8yA7QDHEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107339; c=relaxed/simple;
	bh=tYJuevDGogk+ALUek28REBMm+UYW1ZBzy6FRGG/Dz8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cyB6jAKN4y6p52ZQmKPtwHiuIJKtCJDM/Tb93FbHtOCnQtVpf2HfHsEpKatjUFxk5rgwuVK12ve2FPwBXaCspwq2Df65xsQ9C6rhEvbwaBwFa4mAlC+asV7m2YPjiWkQ+hFQKpUhLSnqetY6rgWnWtNwf82bkEYWD4v7/9teCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oICL3Cbn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e55731af5cso842619b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709107336; x=1709712136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihZBz7OwN5ETOgMmy5LVC1SqPJA8PdSxZfkW50G4hxc=;
        b=oICL3Cbnzfvga9CJGm1SHiBFvwQo9Bdn7R+IEN0Ci27ARgO599ykPk41mnE5II+okQ
         Q9KuJmXbacio/TltyOkrp8Bz5Ge/rfXTom0K80YV2bg3jwz5hHIbcXhRFz6+u/UVoNHM
         7OXZ03OvTsWPm+GyFEO8TNI80ABC8cKPTNSUrb+FUDbzrLKSn66PXvVGU8A7wtf0LNxk
         71OdKPpm8GW8gJMgm0GK3+qeLhZSV8JwrByEqIv2Hxvkj7ReX5mVZtwlF5nfiY31XYtx
         h568wz1qi0YTXq6fvghwHVJPooAimjfJdOOa8FwZaHsc81b94jFfX2etIzpg2YvuZoug
         S14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107336; x=1709712136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihZBz7OwN5ETOgMmy5LVC1SqPJA8PdSxZfkW50G4hxc=;
        b=qpaJVu18hm/rB1gIkDq6fzGaQ0pyaxrqAdKaU+jMEXdQM/zdMw/GB1xG+5ZqmKFDgj
         CIwL85dJVG/tZjw7J/UUlPMsLsTH6KxAl8VaSk6kuCI5PAdMEDC7T/tHp8kfcuivnZqv
         DGCz2RCCgOUc19SaTsQ2WNRBPIVyWV6yPMs8bEjS4HeFYU/JKukDFXjJLwMqEVBI4Ypm
         K3Yq3i818hPlCqm0gUa9t75XbAkA0SMvAZ7iP0YaTy7klOpPVg1tpvl2Y5VOZsvmCGMp
         5ow4dSZt08j84nxqPIsjTH6j6pswU+BnX9JGq8S2n+B4L4RVfYt1HLXRBxKjOi2o2dFI
         ZCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSzOjL4FbGJQPPR87wZHie/d7B538ZMVVizh7glmM1Zs3WLYFsJZn1PbH3llwMjjTvgG9czUhTGaZLPiPD4lxR656bZ477KqPt5Oy6
X-Gm-Message-State: AOJu0YxqJWVRE3G7UZOPVrjetVLORxM+UmnY3sqtOXXrNZvSgFHJYb+y
	6EGdBdQmetdeSRAF0w66LEB7MhhoJUQTAEONyjmGVo+1+tHEjFGjtcLNyQ1foEs=
X-Google-Smtp-Source: AGHT+IG0hIgUBsBFWAzvziUqfTJGoXEYw1oTO8UUN72MDxoUA1WaSDnmDxqIvlF5IiMIpnjt92pXzw==
X-Received: by 2002:a05:6a00:320b:b0:6e4:f32a:4612 with SMTP id bm11-20020a056a00320b00b006e4f32a4612mr10099798pfb.16.1709107336044;
        Wed, 28 Feb 2024 00:02:16 -0800 (PST)
Received: from [172.16.0.12] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79825000000b006e56d880015sm328472pfl.140.2024.02.28.00.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:02:15 -0800 (PST)
Message-ID: <6810b450-2c1b-4f0d-b241-1179c1df6805@rivosinc.com>
Date: Wed, 28 Feb 2024 00:02:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: RISCV: Fix panic on pmu overflow handler
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, atishp@atishpatra.org, anup@brainfault.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20240228053822.2610915-1-fei2.wu@intel.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240228053822.2610915-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 21:38, Fei Wu wrote:
> (1 << idx) of int is not desired when setting bits in unsigned long
> overflowed_ctrs, use BIT() instead. This panic happens when running
> 'perf record -e branches' on sophgo sg2042.
> 
> [  273.311852] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098
> [  273.320851] Oops [#1]
> [  273.323179] Modules linked in:
> [  273.326303] CPU: 0 PID: 1475 Comm: perf Not tainted 6.6.0-rc3+ #9
> [  273.332521] Hardware name: Sophgo Mango (DT)
> [  273.336878] epc : riscv_pmu_ctr_get_width_mask+0x8/0x62
> [  273.342291]  ra : pmu_sbi_ovf_handler+0x2e0/0x34e
> [  273.347091] epc : ffffffff80aecd98 ra : ffffffff80aee056 sp : fffffff6e36928b0
> [  273.354454]  gp : ffffffff821f82d0 tp : ffffffd90c353200 t0 : 0000002ade4f9978
> [  273.361815]  t1 : 0000000000504d55 t2 : ffffffff8016cd8c s0 : fffffff6e3692a70
> [  273.369180]  s1 : 0000000000000020 a0 : 0000000000000000 a1 : 00001a8e81800000
> [  273.376540]  a2 : 0000003c00070198 a3 : 0000003c00db75a4 a4 : 0000000000000015
> [  273.383901]  a5 : ffffffd7ff8804b0 a6 : 0000000000000015 a7 : 000000000000002a
> [  273.391327]  s2 : 000000000000ffff s3 : 0000000000000000 s4 : ffffffd7ff8803b0
> [  273.398773]  s5 : 0000000000504d55 s6 : ffffffd905069800 s7 : ffffffff821fe210
> [  273.406139]  s8 : 000000007fffffff s9 : ffffffd7ff8803b0 s10: ffffffd903f29098
> [  273.413660]  s11: 0000000080000000 t3 : 0000000000000003 t4 : ffffffff8017a0ca
> [  273.421022]  t5 : ffffffff8023cfc2 t6 : ffffffd9040780e8
> [  273.426437] status: 0000000200000100 badaddr: 0000000000000098 cause: 000000000000000d
> [  273.434512] [<ffffffff80aecd98>] riscv_pmu_ctr_get_width_mask+0x8/0x62
> [  273.441169] [<ffffffff80076bd8>] handle_percpu_devid_irq+0x98/0x1ee
> [  273.447562] [<ffffffff80071158>] generic_handle_domain_irq+0x28/0x36
> [  273.454151] [<ffffffff8047a99a>] riscv_intc_irq+0x36/0x4e
> [  273.459659] [<ffffffff80c944de>] handle_riscv_irq+0x4a/0x74
> [  273.465442] [<ffffffff80c94c48>] do_irq+0x62/0x92
> [  273.470360] Code: 0420 60a2 6402 5529 0141 8082 0013 0000 0013 0000 (6d5c) b783
> [  273.477921] ---[ end trace 0000000000000000 ]---
> [  273.482630] Kernel panic - not syncing: Fatal exception in interrupt
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>   drivers/perf/riscv_pmu_sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..335171db9647 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -731,14 +731,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>   		/* compute hardware counter index */
>   		hidx = info->csr - CSR_CYCLE;
>   		/* check if the corresponding bit is set in sscountovf */
> -		if (!(overflow & (1 << hidx)))
> +		if (!(overflow & BIT(hidx)))
>   			continue;
>   
>   		/*
>   		 * Keep a track of overflowed counters so that they can be started
>   		 * with updated initial value.
>   		 */
> -		overflowed_ctrs |= 1 << lidx;
> +		overflowed_ctrs |= BIT(lidx);
>   		hw_evt = &event->hw;
>   		riscv_pmu_event_update(event);
>   		perf_sample_data_init(&data, 0, hw_evt->last_period);

Thanks for the fix.Can you modify the other two instance of 1<< as 
pointed by Alex as well. They are harmless because 32 counters supported 
at max but improves the code quality.
With that:
Reviewed-by: Atish Patra <atishp@rivosinc.com>


