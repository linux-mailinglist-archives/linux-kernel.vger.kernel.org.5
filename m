Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE97B7207
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbjJCTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbjJCTuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:50:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABAA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:50:05 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7740cedd4baso97874485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696362604; x=1696967404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9OkhUo6mnx7uMIpcoe9v3PNzerEgkLVZ1kjAanFY00=;
        b=L5z291MEp/0QlzL5FPorR8t2lgGPAcyBfSqpEmMzwWs92WqGXCZV32S2g4Tb1ySil6
         HMk619IE+Z1IubB0pirMf2qIKgmuiR9j03847YxmP7LXkGMKyeux+0gAXYOQHiCQ9bDa
         aC6z2+AI+TlqR9yzBH9Sr89+4aZYu5wJEGp9Aj1n/zMW9TEDnzgVV1undogUUh77Zmmh
         3ZUlb+2pzdtm+apeW4xOqG3gRUOvp7ZyxveD4J+ouFtwMdtcbpnug9pX9UPQ3SWSIdaT
         4/siVOrzO1ARvcwoN6hYDt/cnVHhWPHPF0NbVoxWKJC5u61eAJvMwHriaB05TbHGcygJ
         3oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362604; x=1696967404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9OkhUo6mnx7uMIpcoe9v3PNzerEgkLVZ1kjAanFY00=;
        b=hSbtfSsfydMTQfpw4GRZV1LSnillcl6BODwkplqCsRumMTZISV5AdlA6a0ub4dUSqC
         BSQxIJLNHbefEBfwk0cr3cIML86/2WSf+hK2aZfNcKrkzFO2zj67c7U2BcKPEYCNq0r/
         PWrrOB09njJyqapGa2sq1gGPElQnqctyix/K81ogZCU7gBzmPZPGOMJlGvEPazTj9I2U
         uxiRBBieHWy7hW9d/WE/6yjWI9LIzNZSZj8eu+66bpKHvrMSUsupoaBnBz8e3vNQpE6Q
         Jqeg2HHF8SEqczjXOCHyOn4Xb2dI4hrggqgyUywDpMy4nA/L4rf6bmJ2BgwfKQeeTTV7
         p5Pg==
X-Gm-Message-State: AOJu0Yxm6/nYYCIHBlXcYCmP+XL+fQBGzo5mWfDeqvuUdhWuI6zUYc4a
        txrR/Uk9aT2bIstNCLiQQA+OKg==
X-Google-Smtp-Source: AGHT+IHKlAb603cnYVhyI7LkeQ3EvgkO8pVwRUeUeHR6q3Zma2WC1Hx+7BvLiQhDqysFF1Yi+ovDCg==
X-Received: by 2002:a05:620a:17a3:b0:765:aac3:7667 with SMTP id ay35-20020a05620a17a300b00765aac37667mr618062qkb.0.1696362604333;
        Tue, 03 Oct 2023 12:50:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6022:6438:e898:6c27? ([2600:1700:2000:b002:6022:6438:e898:6c27])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007756fe0bb17sm717260qkm.19.2023.10.03.12.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:50:03 -0700 (PDT)
Message-ID: <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
Date:   Tue, 3 Oct 2023 14:50:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO variables
 on ACPI systems
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230927170015.295232-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 12:00 PM, Sunil V L wrote:
> Using new interface to get the CBO block size information in RHCT,
> initialize the variables on ACPI platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f1387272a551..8e59644e473c 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <asm/acpi.h>
>  #include <asm/cacheflush.h>
>  
>  #ifdef CONFIG_SMP
> @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
>  	unsigned long cbom_hartid, cboz_hartid;
>  	u32 cbom_block_size = 0, cboz_block_size = 0;
>  	struct device_node *node;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +	unsigned int cpu;
> +
> +	if (!acpi_disabled) {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
> +	}
>  
> -	for_each_of_cpu_node(node) {
> -		/* set block-size for cbom and/or cboz extension if available */
> -		cbo_get_block_size(node, "riscv,cbom-block-size",
> -				   &cbom_block_size, &cbom_hartid);
> -		cbo_get_block_size(node, "riscv,cboz-block-size",
> -				   &cboz_block_size, &cboz_hartid);
> +	for_each_possible_cpu(cpu) {
> +		if (acpi_disabled) {
> +			node = of_cpu_device_node_get(cpu);
> +			if (!node) {
> +				pr_warn("Unable to find cpu node\n");
> +				continue;
> +			}
> +
> +			/* set block-size for cbom and/or cboz extension if available */
> +			cbo_get_block_size(node, "riscv,cbom-block-size",
> +					   &cbom_block_size, &cbom_hartid);
> +			cbo_get_block_size(node, "riscv,cboz-block-size",
> +					   &cboz_block_size, &cboz_hartid);

This leaks a reference to the device node.

> +		} else {
> +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> +						&cboz_block_size, NULL);

This function loops through the whole RHCT already. Why do we need to call it
for each CPU? Can't we just call it once, and have it do the same consistency
checks as cbo_get_block_size()?

In that case, the DT path could keep the for_each_of_cpu_node() loop.

Regards,
Samuel

> +		}
>  	}
>  
> +	if (!acpi_disabled && rhct)
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +
>  	if (cbom_block_size)
>  		riscv_cbom_block_size = cbom_block_size;
>  

