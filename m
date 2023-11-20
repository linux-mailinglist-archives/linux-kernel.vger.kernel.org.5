Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077EC7F0D21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjKTIF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKTIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:05:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67429C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so7659865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700467519; x=1701072319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/r7/AHUvU5h9gmXC8cWkhPHDiuLCW3OhU5H88ffb6E=;
        b=c5Urs6HK+5R4uRglqHsTWMmz7EK2bzhvxoO7ZXc+L52FHnIC+MwZUzSvMhxllQNneG
         5tJjWdX4AworNkTtJwRXdJC/Ex4VVoKeuOUpfugx+7i0kcddwkv0wym4YHO8VRNrPDQk
         3DGtpB9hO0UJ+cq5P8ArLMqIaU4PTrbVfiRMNwPJ2EjqI/V28o7DxyvoAFTZCZj339rC
         NfiVcqFl8oyFNrGsRBjEjkdv7/jIakwr/+KRHqiRDtrG/DZgdSgCSzdJAPRuZP+67//i
         xcKwZ4KArv1JPpj84GuaNCJ6MSQK7FWpn9X6u0bK5MAFhWBmAvgS21J+5+sjaiAP9iVl
         5nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467519; x=1701072319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/r7/AHUvU5h9gmXC8cWkhPHDiuLCW3OhU5H88ffb6E=;
        b=bLKGUbonf+SBcGSjuphf3jaX40TPrMsHw6LO99t+kzJuDshOw1QG71lcQ8jqSRPFwE
         Qv0YMQN7XW0e8Qjqu9VB28y8SGwI95XlHX673eoqcPu22CMxG8SehVRn1ZN8Zx2XK9JD
         g8ORX16WZA8ZNO+0oQj0sRe6WVLQJpxDReLU+q4gYP1edzfpYrc9g2f7/eu2h8J+Wqqc
         hnC0BpNYyMHUIuJx0OjGl0F0X0+AJBd7YfEykvASpvecyBghLpsPwh8I5qCCGx7wphXp
         0leJesPTL/j9OuNPKMdmNhX8deFUNSWB92a5m7yX4jNwhKRuEup1bcpQooSFV+N9n/af
         pQMw==
X-Gm-Message-State: AOJu0YxbXUeKgPRSPplVNDTO2rEl8/fNYb0/JF+g8oM1lTdaDp/3lgh1
        d77BgUb+3qB+jGbxEI0bKZjh6w==
X-Google-Smtp-Source: AGHT+IFN4nwCSr0/wD+U66vM10GQFv+Nri9nZ939m/NOfkfbpyvhNkhO8KxhTxplHCfzLfcHQj8ulg==
X-Received: by 2002:a05:600c:6001:b0:408:33ba:569a with SMTP id az1-20020a05600c600100b0040833ba569amr10872487wmb.8.1700467518744;
        Mon, 20 Nov 2023 00:05:18 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b004064cd71aa8sm12586581wmq.34.2023.11.20.00.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:05:18 -0800 (PST)
Date:   Mon, 20 Nov 2023 09:05:17 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
Message-ID: <20231120-639982716fbfd33a6fc144d6@orel>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118033859.726692-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 09:08:56AM +0530, Anup Patel wrote:
> Let us provide SBI debug console helper routines which can be
> shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h |  5 +++++
>  arch/riscv/kernel/sbi.c      | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 66f3933c14f6..ee7aef5f6233 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigned long major,
>  }
>  
>  int sbi_err_map_linux_errno(int err);
> +
> +extern bool sbi_debug_console_available;
> +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr);
> +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr);
> +
>  #else /* CONFIG_RISCV_SBI */
>  static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
>  static inline void sbi_init(void) {}
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5a62ed1da453..73a9c22c3945 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -571,6 +571,44 @@ long sbi_get_mimpid(void)
>  }
>  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
>  
> +bool sbi_debug_console_available;
> +
> +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr)
> +{
> +	struct sbiret ret;
> +
> +	if (!sbi_debug_console_available)
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> +				num_bytes, lower_32_bits(base_addr),
> +				upper_32_bits(base_addr), 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> +				num_bytes, base_addr, 0, 0, 0, 0);
> +
> +	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;

We can't get perfect mappings, but I wonder if we can do better than
returning ENOTSUPP for "Failed to write the byte due to I/O errors."

How about

 if (ret.error == SBI_ERR_FAILURE)
     return -EIO;

 return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;


> +}
> +
> +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr)
> +{
> +	struct sbiret ret;
> +
> +	if (!sbi_debug_console_available)
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
> +				num_bytes, lower_32_bits(base_addr),
> +				upper_32_bits(base_addr), 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
> +				num_bytes, base_addr, 0, 0, 0, 0);
> +
> +	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;

Same comment as above.

> +}
> +
>  void __init sbi_init(void)
>  {
>  	int ret;
> @@ -612,6 +650,11 @@ void __init sbi_init(void)
>  			sbi_srst_reboot_nb.priority = 192;
>  			register_restart_handler(&sbi_srst_reboot_nb);
>  		}
> +		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
> +		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
> +			pr_info("SBI DBCN extension detected\n");
> +			sbi_debug_console_available = true;
> +		}
>  	} else {
>  		__sbi_set_timer = __sbi_set_timer_v01;
>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
