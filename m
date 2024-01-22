Return-Path: <linux-kernel+bounces-32573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A2835D65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC637B27E99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3339FD1;
	Mon, 22 Jan 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fieyY9GM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2C3B18E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913558; cv=none; b=DQlFLtodxNbn33Kz6533fcQr9aPwaHnrpzy0HUjBgmI9VlhJ4ge778FVzCaTeRUSGS8xSo89uxz0AZn1ha7uKoKYHYpCC4Jj1pSmLMe9+C4umMMoBKj473XpD8KmiGY1jlGgetQ04r637aM94W9z4MwODYeAaaono+xFou3n0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913558; c=relaxed/simple;
	bh=SAvwupzHZ8fTdQG9uVBatImfaNOaWKZmEUWtiZJM6oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNBngRY4wZ57InsreLCvNmSKjt8OEVpltXsu0uSSjUE9prkWZClempZHF+ZLv7m7tGoXWAwLQEE1Q+RrHixiz/pj5qzfkjOgU/Xgw1dgNBmScMe1a9WQ4yMqikVIgtNxh46dLkC6KUiZLeSYFqh62g7IkB6llbgkhyHvWs8pdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fieyY9GM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so37428215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705913554; x=1706518354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDgjWNmpHGcLjhWhbYgEl2BM2gqjNGoDHZlZQG5Aexw=;
        b=fieyY9GM76gpyRKU4xxFyfPLHAXZOr0DY4pLpF2gZ8uCKPZ/MeN8wdddDnO1pHyasE
         mCsZBNv9V4LSQcDYxVyNjeyc+is65wuVyTKWIDBpPFgx/+5nRYnrMcq9Y6Hdf7ZKluOJ
         mQvHgioR8T7CWspNyaQ/s3P3/EtjWMyHhHsm1t6KCP+1+sXcQwmMkiJH6gQKLDHenOzd
         FSOCGQGqwfM4Di/Pz9B3lx7NPJRtYZ+desEFAQyLAoYoDKwX6ujAmzBDEgMa0vYy3gN1
         cEbpRFeBbi1q3uNgiVsCkKxHMRseAdfSf+PX4SFyeogRkRpS96DNEsCzX7hmrbYmIsZg
         YTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913554; x=1706518354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDgjWNmpHGcLjhWhbYgEl2BM2gqjNGoDHZlZQG5Aexw=;
        b=Kni20i/ao6D45OltHUqTF5gGddbRU3vUavL7KLNCI9oabpZuuGFCmHyFw4UPHo0kA6
         OcLjA7BDWQ3peEFHDmdWaFwawMhqW1xCA1tHQSd24cbPPujxp9AAK/Hf/m8cbx91ADYF
         zUfBFnMZT/xt29XfXhVlyEgNptyvCaZk96VKyfAW+n1cQnoAtf6VlzZraL01LH+AfW1f
         kXvAvxKDKCvI2b6a7jmAiJHBajT1QiKhR/EZDc5pTKTrEQbLJm8O7NcLFGXesHv6dCMv
         usgkOQcI14B2JWZ7z+bD+Q5iLs+7k3NSFeItQsrcSqo4/TcgGXOnGUYKSP98VD5TN/qF
         9iwA==
X-Gm-Message-State: AOJu0YxIvzHm2HP2dCemovPk/qoGhz8+D8UbNkY5rp83lCETCfUrJSmT
	BzLEdkeuTAbMLfCYNunS/1PNtEMCW+eDBdBMSDQisEK1VGBG7EtJEzCk9pV2KcQ=
X-Google-Smtp-Source: AGHT+IHLi8v5vp+9OccJW5ihsH8HwK7pVU8S7xEx6MszBLdPgyWAl7kcOkj2bNJKF6wUT6V3XI5ylg==
X-Received: by 2002:a05:6000:1191:b0:337:c0f3:962b with SMTP id g17-20020a056000119100b00337c0f3962bmr2015519wrx.113.1705913554662;
        Mon, 22 Jan 2024 00:52:34 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a11-20020adfe5cb000000b00337d92e8b9csm9115501wrn.109.2024.01.22.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:52:34 -0800 (PST)
Date: Mon, 22 Jan 2024 09:52:33 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Erick Archer <erick.archer@gmx.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: Use kcalloc() instead of kzalloc()
Message-ID: <20240122-7b031613b2ae1d7dfa1edfd7@orel>
References: <20240120135400.4710-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120135400.4710-1-erick.archer@gmx.com>

On Sat, Jan 20, 2024 at 02:54:00PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
> 
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89920f84d0a3..549a76e34c4e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -901,8 +901,7 @@ static int check_unaligned_access_all_cpus(void)
>  {
>  	unsigned int cpu;
>  	unsigned int cpu_count = num_possible_cpus();
> -	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> -				     GFP_KERNEL);
> +	struct page **bufs = kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);
> 
>  	if (!bufs) {
>  		pr_warn("Allocation failure, not measuring misaligned performance\n");
> --
> 2.25.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

