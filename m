Return-Path: <linux-kernel+bounces-147348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094218A72C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE341F22B85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E237B134425;
	Tue, 16 Apr 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3WiSbUOg"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760A133422
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290788; cv=none; b=gX2ERxjLBwIE98FF15IWr1xOU32yyqIsq/+zZ3R8G98SPzNKgCUmsvWX8Q3NnnFYPqwa7YmyE4TQQwiFZggx2vqlG+oPRR9iyYHuG+P5pZc8JJrvA60xqBnspcWmqDar5kFyOjSUncyCRPL7tru+x64S+WVWcDazEKwNCxA4e54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290788; c=relaxed/simple;
	bh=VdqVOpZIL0fa9mVOgGIk+Lor9GrP68BM7xHeuG4nZQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNomBQZpsH0ZLoLPVWYCGnkt7fxoAND6gLhO6qh9FLkqnoHI/r3rPWaGUD/zEUrTgEPiY++VNJ5Znr4mhLSc0Qz7gwwNAevVp78gujCSEhmQjsdgzoV9XQlBFINcxsTxdUdvLG+zx2SGUr67RDbCeIfUoj0VuFFZWUJqQDwWV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3WiSbUOg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso3919673b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713290785; x=1713895585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmNr0h+4BuFUgpk/HTyKfOa7gEFZOVHeubFTNh0tBVI=;
        b=3WiSbUOgIAU2ltjs/JbKrrhsLecPRq0SFb9jf6G8LFY3NJC0UabU9QjXC6ueHXYvwZ
         hM5SGaOBqLx4Nor/Pw6fMr60HiHMEo70kjey5MA8/4IxxRSbt8LRJOhHQveswBsT1fxM
         S0ZHTciEHUSXCGCrYHXS+ShOQ3kAFA2Dt9/k1xPLlzYm/29u03AKki6NAF88rmPxmSMQ
         wcFCfCceqJOUgVNnr+IEUqbbNAFrqYc7o57pmVC379KrfMYd+E8ctoX1xtaswbad/UZD
         J4geTNGw4qtBwu8+rlWATaGBppMke4q/HhsvB+9K4FzROWS9vNsU2t5NDfX+G4vgefN4
         GX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290785; x=1713895585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmNr0h+4BuFUgpk/HTyKfOa7gEFZOVHeubFTNh0tBVI=;
        b=O0GPrwvvd0ExWy3qxBMGm+DGBe0xYGEXvcQw01GtaNsOSqMC4SGMRO8Zbz0xi1ShpB
         XgrdMq4FOUKRZ+R33iQRznKtc/SnnusReDQ+v5W7lD9NS93/R+y0719e5quc17qP+fW/
         YlOyzfWqC5LK5oqCeikv2tNHO+9kvG7C4D15vw33E6ccso6gkgwgYIUY8rcX0FQ8MY+O
         FMprMYBLdupQRcaQvBV3Ke0f7SyE4hQSpUbeUb6kluFlsY6C//OzqR0d3trAuQRMNaGq
         xm8bivfDaJX90j7xcZMrAs7ml3Ib0jgRtmp6z98O4WEB2Mh8S+jXYnRj3ePJI38TTCP2
         wAZg==
X-Forwarded-Encrypted: i=1; AJvYcCVKx6x+dPDqIewfBIcZXqk/YyUB0/PRlSGA7IVElYzOcutDWSBEend6MS4buWGN96Y6LhDRtGlpcxNQKEWR5gDooGMfpXSHY2CR4FEL
X-Gm-Message-State: AOJu0YxgrwJ6Biln/o9sH1FW/Fx1AfXlKMSwGXACQaY5A1QoQXm/+w+1
	oyciPFOM2c0udSiX6obzcaaj6VgWhhHzsXwHyJYeQONYQr8oi/vC/xyafyqJmDc=
X-Google-Smtp-Source: AGHT+IHrpAn2SwOIF/uXmMPZ5Ood25h2i+Ow5WsbzJxkS/YGJA0jpJQwONosrjVsQ+4tatk4S4Af+Q==
X-Received: by 2002:a05:6a20:d49b:b0:1a9:a3ed:1786 with SMTP id im27-20020a056a20d49b00b001a9a3ed1786mr13368970pzb.38.1713290785329;
        Tue, 16 Apr 2024 11:06:25 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id bg8-20020a1709028e8800b001e4344a7601sm9969996plb.42.2024.04.16.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:06:24 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:06:21 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Zhao Ke <ke.zhao@shingroup.cn>
Cc: paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn, shenghui.qu@shingroup.cn
Subject: Re: [PATCH] Use bool value in set_cpu_online()
Message-ID: <Zh6+HZnsgh9ncvPj@ghost>
References: <20240318065404.123668-1-ke.zhao@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318065404.123668-1-ke.zhao@shingroup.cn>

On Mon, Mar 18, 2024 at 02:54:04PM +0800, Zhao Ke wrote:
> The declaration of set_cpu_online() takes a bool value. So replace
> int here to make it consistent with the declaration.
> 
> Signed-off-by: Zhao Ke <ke.zhao@shingroup.cn>
> ---
>  arch/riscv/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 519b6bd946e5..3f7c274653ab 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -229,7 +229,7 @@ asmlinkage __visible void smp_callin(void)
>  	riscv_ipi_enable();
>  
>  	numa_add_cpu(curr_cpuid);
> -	set_cpu_online(curr_cpuid, 1);
> +	set_cpu_online(curr_cpuid, true);
>  
>  	if (has_vector()) {
>  		if (riscv_v_setup_vsize())
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thank you!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


