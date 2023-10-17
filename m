Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910A7CBDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjJQIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjJQIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:41:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F323E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:41:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so61342801fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697532064; x=1698136864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB/kfuKzCfr9/00WQN4N9vxRELf8bEUkzHFo66uF28g=;
        b=R3ZF9f1HNyy7HOzN+cTg0IAThBU+IHV8MuZTrM97HH1IrK2VM3FN/mic4pWarQQfO7
         dE6WTJ83n1aDTU/nZ5HnCUORtJ2yAFGiYHTbMthWP4xACRdLolETRTLPwwwtVLRP4OEY
         5x3f9uomRT+eRZOZZKGuPhwXLKnyZbl0pX1xFRjhpA58x++HJ2bAolWERx6bJILdT6n6
         pe/IY+sZyd7TDP+ibYrt3iCEiGHumINC2Bv9nlgrmdifB/Rrf4/JAEjxmh3HoEx316n1
         h/ZvQevyCkhc10wsdJWXWGYeJmm3qw+DPXJ/YbTbCxFrH1Kr2dzVUAg3OAA3WS1VASZi
         aKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532064; x=1698136864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB/kfuKzCfr9/00WQN4N9vxRELf8bEUkzHFo66uF28g=;
        b=e5+4VxhbbeiHC9xXqKbHQsmWH+Vw4g7Bp/JfUdhlgdvA99y5mLMPjr529s4wf99mfR
         PGb3YFb9/fFFIUp3kwpSWQ/6OjUbwK3ToeJQThpIBHjH/M7RKrt+I2BkTj7N5mo9Aeda
         shODZJ3gfm51+3zHCb9YV/UmfRXcmxea95Duio08CHbUAwkcJru3ZvYOjQrI4D858Ysf
         ayNsRVM5nwuoZ+A2WYH2PQ1hSNZIxD7BoiXv4vmfwSCFhzZCe3L3w2gGz+3z0QA4xNLw
         umVhceJou0kqDfDLKSvBhbpWvzO9zEc3dvYaKpztiT4T6nOyy06t0lETpHl/pOAjA66O
         RWIA==
X-Gm-Message-State: AOJu0Yz0EvUdTAfr/+FM0EGqnDdvjSMFv3VowaWLy6xDUOkbGJ5xxcWI
        Y4/yp4+ltrP1nCkGiC20IhzbnQ==
X-Google-Smtp-Source: AGHT+IGhiqrfDB4ZTR0M/BpXYyS+AZ/LIFG8yzd1vQg3LLGnmte00ytOqfmObo/yWeIIK6ortCSl8Q==
X-Received: by 2002:a2e:9214:0:b0:2c2:8f22:d9c2 with SMTP id k20-20020a2e9214000000b002c28f22d9c2mr1361491ljg.22.1697532064466;
        Tue, 17 Oct 2023 01:41:04 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d51c2000000b0032da4f70756sm1164746wrv.5.2023.10.17.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:41:03 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:41:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 3/3] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20231017-e198b2c70475b6f09754d175@orel>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016164958.1191529-4-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:19:58PM +0530, Sunil V L wrote:
> Initialize the CBO variables on ACPI based systems using information in
> RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f1387272a551..55a34f2020a8 100644
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
> @@ -124,13 +126,24 @@ void __init riscv_init_cbo_blocksizes(void)
>  	unsigned long cbom_hartid, cboz_hartid;
>  	u32 cbom_block_size = 0, cboz_block_size = 0;
>  	struct device_node *node;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +
> +	if (acpi_disabled) {
> +		for_each_of_cpu_node(node) {
> +			/* set block-size for cbom and/or cboz extension if available */
> +			cbo_get_block_size(node, "riscv,cbom-block-size",
> +					   &cbom_block_size, &cbom_hartid);
> +			cbo_get_block_size(node, "riscv,cboz-block-size",
> +					   &cboz_block_size, &cboz_hartid);
> +		}
> +	} else {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
>  
> -	for_each_of_cpu_node(node) {
> -		/* set block-size for cbom and/or cboz extension if available */
> -		cbo_get_block_size(node, "riscv,cbom-block-size",
> -				   &cbom_block_size, &cbom_hartid);
> -		cbo_get_block_size(node, "riscv,cboz-block-size",
> -				   &cboz_block_size, &cboz_hartid);
> +		acpi_get_cbo_block_size(rhct, &cbom_block_size, &cboz_block_size, NULL);
> +		acpi_put_table((struct acpi_table_header *)rhct);
>  	}
>  
>  	if (cbom_block_size)
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
