Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D167D5B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjJXTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:32:15 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E110CF;
        Tue, 24 Oct 2023 12:32:12 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57d086365f7so2889424eaf.0;
        Tue, 24 Oct 2023 12:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698175932; x=1698780732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os6+F3GIp09jnFtEgn/tBJnXLyDXm9nt1XylEy4/Z3g=;
        b=GBYZUJiXNa6kz75PQ8o86Ak0wOEY7VvAPxXE+aFgFQ/viA0lFcLVRvlmtwyIQI+WCO
         J4rX5Cfat6/iNeWYEw1O0zgeZJ/S4MVsz/TlBGdMzs2Kw0EqzWhHwWBOlEmuPjzGbKao
         wWyk4jHQlm124diYJHK0tuZrWx1dw9ETD1b+dxa3RzUwTKTnJ2Vsct6w1siB08GpFFuG
         AVnPpHj+zvUIYzA4P2qIp1iEtJmxPrSHceIwy1siwmOZkgC2p90JyHqBXBmtqNaizWJm
         B1/7s0P6PTQ/O5uj4PqHW/q8RLzgdIj76DTEiG+ava9d4dnwgpfzoAWKSOX3iJFhHjEC
         O4HA==
X-Gm-Message-State: AOJu0Yz1g1Izwmp5R2Q/4HWJVTigbEZxBKx2/CGplGMXOW8RBEuyKZIN
        S0+6nUfsM89yLOkfmYGSmg==
X-Google-Smtp-Source: AGHT+IE/gA1cCAAiNb3xKq2nVyHtqcUifbh+zRG0kLKKCQJLdsAy/F/D81KmLeh/fOvmOSIBVbSUdQ==
X-Received: by 2002:a4a:3c52:0:b0:57d:e76d:c206 with SMTP id p18-20020a4a3c52000000b0057de76dc206mr14263453oof.1.1698175931658;
        Tue, 24 Oct 2023 12:32:11 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f134-20020a4a588c000000b00584086d7bdfsm2162880oob.20.2023.10.24.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:32:11 -0700 (PDT)
Received: (nullmailer pid 428282 invoked by uid 1000);
        Tue, 24 Oct 2023 19:32:10 -0000
Date:   Tue, 24 Oct 2023 14:32:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [RFC PATCH 1/3] of: reserved_mem: Change the order that
 reserved_mem regions are stored
Message-ID: <20231024193210.GA407269-robh@kernel.org>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
 <20231019184825.9712-2-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019184825.9712-2-quic_obabatun@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:48:23AM -0700, Oreoluwa Babatunde wrote:
> The dynamic allocation of the reserved_mem array needs to be done after
> paging_init() is called because memory allocated using memblock_alloc()
> is not writeable before that.
> 
> Nodes that already have their starting address specified in the DT
> (i.e. nodes that are defined using the "reg" property) can wait until
> after paging_init() to be stored in the array.
> But nodes that are dynamically placed need to be reserved and saved in
> the array before paging_init() so that page table entries are not
> created for these regions.
> 
> Hence, change the code to:
> 1. Before paging_init(), allocate and store information for the
>    dynamically placed reserved memory regions.
> 2. After paging_init(), store the rest of the reserved memory regions
>    which are defined with the "reg" property.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/arm64/kernel/setup.c       |  4 +++
>  drivers/of/fdt.c                | 56 ++++++++++++++++++++++++++-------
>  drivers/of/of_private.h         |  1 -
>  drivers/of/of_reserved_mem.c    | 54 ++++++++++++++-----------------
>  include/linux/of_fdt.h          |  1 +
>  include/linux/of_reserved_mem.h |  9 ++++++
>  6 files changed, 83 insertions(+), 42 deletions(-)

Looking at this a bit more...

> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..6002d3ad0b19 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -27,6 +27,8 @@
>  #include <linux/proc_fs.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +
>  #include <linux/efi.h>
>  #include <linux/psci.h>
>  #include <linux/sched/task.h>
> @@ -346,6 +348,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	fdt_init_reserved_mem();
> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..d51a1176a7b9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -504,7 +504,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  	phys_addr_t base, size;
>  	int len;
>  	const __be32 *prop;
> -	int first = 1;
>  	bool nomap;
>  
>  	prop = of_get_flat_dt_prop(node, "reg", &len);
> @@ -532,10 +531,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  			       uname, &base, (unsigned long)(size / SZ_1M));
>  
>  		len -= t_len;
> -		if (first) {
> -			fdt_reserved_mem_save_node(node, uname, base, size);
> -			first = 0;
> -		}
>  	}
>  	return 0;
>  }
> @@ -564,9 +559,44 @@ static int __init __reserved_mem_check_root(unsigned long node)
>  }
>  
>  /*
> - * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
> + * Save the reserved_mem reg nodes in the reserved_mem array
>   */
> -static int __init fdt_scan_reserved_mem(void)
> +static void save_reserved_mem_reg_nodes(unsigned long node, const char *uname)
> +
> +{
> +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> +	phys_addr_t base, size;
> +	int len;
> +	const __be32 *prop;
> +
> +	prop = of_get_flat_dt_prop(node, "reg", &len);
> +	if (!prop)
> +		return;
> +
> +	if (len && len % t_len != 0) {
> +		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
> +		       uname);
> +		return;
> +	}
> +	base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +	size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +	if (size)
> +		fdt_reserved_mem_save_node(node, uname, base, size);
> +}
> +
> +/*
> + * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory.
> + * @save_only: Option to determine what kind of fdt scan the caller is
> + * requesting.
> + *
> + * The fdt is scanned twice here during device bootup. The first scan
> + * is used to save the dynamically allocated reserved memory regions to
> + * the reserved_mem array. The second scan is used to save the 'reg'
> + * defined regions to the array. @save_only indicates which of the scans
> + * the caller is requesting.
> + */
> +int __init fdt_scan_reserved_mem(bool save_only)

It's generally discouraged to use flags to make a function do 2 
different operations. Splitting it will naturally happen though with my 
next comment.

>  {
>  	int node, child;
>  	const void *fdt = initial_boot_params;
> @@ -589,9 +619,14 @@ static int __init fdt_scan_reserved_mem(void)
>  
>  		uname = fdt_get_name(fdt, child, NULL);
>  
> +		if (save_only) {
> +			save_reserved_mem_reg_nodes(child, uname);
> +			continue;
> +		}
> +
>  		err = __reserved_mem_reserve_reg(child, uname);
>  		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
> -			fdt_reserved_mem_save_node(child, uname, 0, 0);
> +			__reserved_mem_alloc_size(child, uname);
>  	}
>  	return 0;
>  }
> @@ -631,11 +666,12 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  {
>  	int n;
>  	u64 base, size;
> +	bool save_only = false;
>  
>  	if (!initial_boot_params)
>  		return;
>  
> -	fdt_scan_reserved_mem();
> +	fdt_scan_reserved_mem(save_only);
>  	fdt_reserve_elfcorehdr();
>  
>  	/* Process header /memreserve/ fields */
> @@ -645,8 +681,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  			break;
>  		memblock_reserve(base, size);
>  	}
> -
> -	fdt_init_reserved_mem();
>  }
>  
>  /**
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f38397c7b582..e52b27b8392d 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -175,7 +175,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>  }
>  #endif
>  
> -void fdt_init_reserved_mem(void);
>  void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>  			       phys_addr_t base, phys_addr_t size);
>  
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcbddb..13e694f5e316 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -132,8 +132,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
>   * __reserved_mem_alloc_size() - allocate reserved memory described by
>   *	'size', 'alignment'  and 'alloc-ranges' properties.
>   */
> -static int __init __reserved_mem_alloc_size(unsigned long node,
> -	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
> +int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
>  {
>  	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>  	phys_addr_t start = 0, end = 0;
> @@ -212,10 +211,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>  		       uname, (unsigned long)(size / SZ_1M));
>  		return -ENOMEM;
>  	}
> -
> -	*res_base = base;
> -	*res_size = size;
> -
> +	fdt_reserved_mem_save_node(node, uname, base, size);
>  	return 0;
>  }
>  
> @@ -309,6 +305,9 @@ static void __init __rmem_check_for_overlap(void)
>  void __init fdt_init_reserved_mem(void)
>  {
>  	int i;
> +	bool save_only = true;
> +
> +	fdt_scan_reserved_mem(save_only);

This is now called just before unflattening. Why can't it be done right 
after unflattening instead. Then we can use the unflattened API rather 
than the flatten API which is less efficient.

Rob
