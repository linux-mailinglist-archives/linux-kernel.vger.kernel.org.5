Return-Path: <linux-kernel+bounces-26166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63D82DC37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D851F21CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2517748;
	Mon, 15 Jan 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O2IVJPWi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0317736
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso104476466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705332189; x=1705936989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjb6yat6rTIqwLNK7lIYkpvumfmiEIYSpK/Qu84PmCs=;
        b=O2IVJPWiID3yDnL7MA+7TC/NMo+zcAOKRDBN/JDEeAA1TROeQGo6qDmdYUAHvavkuR
         VCuU+cMqOQGwThq30/2uP0YvH3G32lqkOCUcgA1Cr6vKmPO/nymxAvY5wl+CjoSjctuF
         qsur+XFbgL1FW9rFpFvo2WtlMqbQ+JQ7MdROJOxdVHt1Tut7JCOcQfi/tudbzG1TKAv5
         cgNk9SUDAvMdkDxVn0LqU6/nN8q0tYPJ9fcOfsVJnne8lDWxrMEK3OJMBnGvwna+d2DX
         enYRsoNNUoQ9B5jTIRWyv0vLcT1BmL+QtNbeDdDCPMzVOKJUiWWfI9dWkj8LglOtQlgn
         S2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332189; x=1705936989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjb6yat6rTIqwLNK7lIYkpvumfmiEIYSpK/Qu84PmCs=;
        b=qoNSagk9KBiA/T467VOc64EDnlp/kZUTh1W0KwK1EMkrhKM7JM4Pn+JENp3rWIkQnN
         WdjjxZePxz3G9b1zaOgrgq71KzqUxpXIF06EqoMRk3GYY0JIwl+tFDOmyWW87SSR9wun
         ZX3SSf0mwYMeHrXBLiVnMqDwihYRtOW6Tnvzsm26PVD+pf705iD82SC/R6krKkktq8uP
         wuDz8gLbp5kHLdvg/emy2qOP/lQca3jlSa61Kr1X2CkkmItI+XNRLSE3iU2eui1CY9RO
         pzP5yGNl6BotPtQTkJUSqQtbW0yZky1ScP4jNr7inIeTSwCUHvj0HpShB5aM8gTsAdxu
         THWg==
X-Gm-Message-State: AOJu0Yw+YtJ3hWeZiy0Kj2n7OOp06gmYLCPK2MNCO57sIwrlgx+gTPIV
	IixyDaWfkp4lvgDFvspsVP30ozz3KcA1sxjdsRdjw9HTBmQ=
X-Google-Smtp-Source: AGHT+IHA8GBVAlaQ/G9+4YlfpGBti7K7zuQDjbKGggHHhNwvPhvQd31mN7o91Q5SxIzDJNMEKz+DEQ==
X-Received: by 2002:a17:907:3c9:b0:a2c:c648:dd03 with SMTP id su9-20020a17090703c900b00a2cc648dd03mr1381050ejb.110.1705332188553;
        Mon, 15 Jan 2024 07:23:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906488800b00a27aabff0dcsm5467070ejq.179.2024.01.15.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:23:08 -0800 (PST)
Date: Mon, 15 Jan 2024 16:23:07 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 -next 1/3] cpuidle: RISC-V: Move few functions to
 arch/riscv
Message-ID: <20240115-b3536efde6699e67fa15ac65@orel>
References: <20240115101056.429471-1-sunilvl@ventanamicro.com>
 <20240115101056.429471-2-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115101056.429471-2-sunilvl@ventanamicro.com>

On Mon, Jan 15, 2024 at 03:40:54PM +0530, Sunil V L wrote:
> To support ACPI Low Power Idle (LPI), few functions are required which
> are currently static functions in the DT based cpuidle driver. Hence,
> move them under arch/riscv so that ACPI driver also can use them.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/suspend.h    |  3 ++
>  arch/riscv/kernel/suspend.c         | 47 +++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 41 +------------------------
>  3 files changed, 51 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 02f87867389a..5c7df5ab7a16 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -55,4 +55,7 @@ int hibernate_resume_nonboot_cpu_disable(void);
>  asmlinkage void hibernate_restore_image(unsigned long resume_satp, unsigned long satp_temp,
>  					unsigned long cpu_resume);
>  asmlinkage int hibernate_core_restore_code(void);
> +bool is_sbi_hsm_supported(void);
> +bool sbi_suspend_state_is_valid(u32 state);
> +int sbi_suspend(u32 state);
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 239509367e42..a3b2e7e16a98 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -128,4 +128,51 @@ static int __init sbi_system_suspend_init(void)
>  }
>  
>  arch_initcall(sbi_system_suspend_init);
> +
> +static int sbi_suspend_finisher(unsigned long suspend_type,
> +				unsigned long resume_addr,
> +				unsigned long opaque)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
> +			suspend_type, resume_addr, opaque, 0, 0, 0);
> +
> +	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
> +}
> +
> +int sbi_suspend(u32 state)

Now that this is exported, I'd name it riscv_sbi_suspend.

> +{
> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +		return cpu_suspend(state, sbi_suspend_finisher);
> +	else
> +		return sbi_suspend_finisher(state, 0, 0);
> +}
> +
> +bool sbi_suspend_state_is_valid(u32 state)

Also riscv_ prefix here.

> +{
> +	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
> +	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
> +		return false;
> +	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
> +	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
> +		return false;
> +	return true;
> +}
> +
> +bool is_sbi_hsm_supported(void)

This I would rename to riscv_sbi_hsm_is_supported

> +{
> +	/*
> +	 * The SBI HSM suspend function is only available when:
> +	 * 1) SBI version is 0.3 or higher
> +	 * 2) SBI HSM extension is available
> +	 */
> +	if (sbi_spec_version < sbi_mk_version(0, 3) ||
> +	    !sbi_probe_extension(SBI_EXT_HSM)) {
> +		pr_info("HSM suspend not available\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
>  #endif /* CONFIG_RISCV_SBI */
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index e8094fc92491..a7f06242f67b 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -73,26 +73,6 @@ static inline bool sbi_is_domain_state_available(void)
>  	return data->available;
>  }
>  
> -static int sbi_suspend_finisher(unsigned long suspend_type,
> -				unsigned long resume_addr,
> -				unsigned long opaque)
> -{
> -	struct sbiret ret;
> -
> -	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
> -			suspend_type, resume_addr, opaque, 0, 0, 0);
> -
> -	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
> -}
> -
> -static int sbi_suspend(u32 state)
> -{
> -	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> -		return cpu_suspend(state, sbi_suspend_finisher);
> -	else
> -		return sbi_suspend_finisher(state, 0, 0);
> -}
> -
>  static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>  					     struct cpuidle_driver *drv, int idx)
>  {
> @@ -206,17 +186,6 @@ static const struct of_device_id sbi_cpuidle_state_match[] = {
>  	{ },
>  };
>  
> -static bool sbi_suspend_state_is_valid(u32 state)
> -{
> -	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
> -	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
> -		return false;
> -	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
> -	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
> -		return false;
> -	return true;
> -}
> -
>  static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
>  {
>  	int err = of_property_read_u32(np, "riscv,sbi-suspend-param", state);
> @@ -607,16 +576,8 @@ static int __init sbi_cpuidle_init(void)
>  	int ret;
>  	struct platform_device *pdev;
>  
> -	/*
> -	 * The SBI HSM suspend function is only available when:
> -	 * 1) SBI version is 0.3 or higher
> -	 * 2) SBI HSM extension is available
> -	 */
> -	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
> -	    !sbi_probe_extension(SBI_EXT_HSM)) {
> -		pr_info("HSM suspend not available\n");
> +	if (!is_sbi_hsm_supported())
>  		return 0;
> -	}
>  
>  	ret = platform_driver_register(&sbi_cpuidle_driver);
>  	if (ret)
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

