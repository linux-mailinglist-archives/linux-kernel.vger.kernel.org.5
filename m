Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A47AD1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjIYHjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjIYHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:39:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40593EE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:38:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso37160705ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695627533; x=1696232333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzBL5mZPrug4GhJrNNKgL7YDgX4E0xGifdCmz+2VKp8=;
        b=YtbwGhSjnr5bxfg6S7NZmtBus60k1PU6k/r23ueb4iKxwIWCUFlBe2XONjxl3sji9P
         CzOESlkOmwfjPqUJIWWPz5IJjyivi7UsMfi+H11vk0jeb6GyQy4qWOYQ7VHouEo6hIFy
         jQVmdlOLM3Uqj3SWVk8lvP/tEIClWfZ1AluKqpl2tkHYmqoka42FXkOiHHLv/vAmEtfi
         rs/d8nqhEL3g+7CAE5kG+9x2T3rDuVlE+EK6De7Yb3Q0krajOZIqoOeUW8d7g1HHVOEN
         ySvzotsi7oZ0ocZ3qdCynzaGQQtOiA3+rRTT1ziCkbkWDd+NeC48VHs1bNQ8PhOvMjL8
         glAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627534; x=1696232334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzBL5mZPrug4GhJrNNKgL7YDgX4E0xGifdCmz+2VKp8=;
        b=reGdHlAQsi2s1/DJR+IMbd+5vNUz2WsADR/BEQ0xthLISIMN9Prn65j/D5ZmQ0394I
         fYTsNb5c5ZX8TXy9zKAdgoK1dS7AcmwlSF3tvCwEvZLeMqQ5YAG71AVKVohOiWbk3c6C
         zKcU2ToVpetoDuyaFfMzySiN3FSjlLLwMX/MWezFYgqyz9agwYn2T/fLSqvA2UaxgDiL
         RU1hYoV9f/FRLMttn5eGm+hNJD/2XmzV+Zrffl3fGTbvOjO2iBb1s58JORsLMhxXzYSg
         c2ui2r8I+dDeUAgIrjVSpWI0OItRZw+3YT5Cb2TNbSbIRi24GxHzQsyvpg6mF8RfOrU5
         NsvA==
X-Gm-Message-State: AOJu0Yxn08eGMzskcM37U1Gz7DYQEYzpny7/NPHKlL7+bWcEsZead+LO
        V9MgTGnpuSce1/0QubbIsaVqog==
X-Google-Smtp-Source: AGHT+IHJ7dbhK17CN5P+md1/ZCDciKvs4jN5yIcS41PAcRp+Dau+ypfkJZZlHYzyA7civShES5H6iQ==
X-Received: by 2002:a17:902:7443:b0:1bb:b86e:8d60 with SMTP id e3-20020a170902744300b001bbb86e8d60mr3963012plt.46.1695627533576;
        Mon, 25 Sep 2023 00:38:53 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm8169366plb.75.2023.09.25.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:38:53 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:08:43 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 02/16] RISC-V: Add riscv_get_intc_hartid() function
Message-ID: <ZRE5A5GxF7wU68vt@sunil-laptop>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912174928.528414-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Tue, Sep 12, 2023 at 11:19:14PM +0530, Anup Patel wrote:
> We add a common riscv_get_intc_hartid() which help device drivers to
> get hartid of the HART associated with a INTC (i.e. local interrupt
> controller) fwnode. This new function is more generic compared to
> the existing riscv_of_parent_hartid() function hence we also replace
> use of riscv_of_parent_hartid() with riscv_get_intc_hartid().
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/processor.h |  4 +++-
>  arch/riscv/kernel/cpu.c            | 13 ++++++++++++-
>  drivers/irqchip/irq-riscv-intc.c   |  2 +-
>  drivers/irqchip/irq-sifive-plic.c  |  3 ++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3e23e1786d05..3ce64b3bea4e 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -119,7 +119,9 @@ static inline void wait_for_interrupt(void)
>  struct device_node;
>  int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
>  int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
> -int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
> +
> +struct fwnode_handle;
> +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *hartid);
>  
>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 157ace8b262c..ee583eac3c5b 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -123,7 +123,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
>   * To achieve this, we walk up the DT tree until we find an active
>   * RISC-V core (HART) node and extract the cpuid from it.
>   */
> -int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
> +static int riscv_of_parent_hartid(struct device_node *node,
> +				  unsigned long *hartid)
>  {
>  	for (; node; node = node->parent) {
>  		if (of_device_is_compatible(node, "riscv")) {
> @@ -139,6 +140,16 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
>  	return -1;
>  }
>  
> +/* Find hart ID of the INTC fwnode. */
> +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *hartid)
> +{
> +	/* Extend this function ACPI in the future. */

As per Marc's feedback, we can't use swnode for ACPI irchips. So, there
is no need to create this wrapper function and this patch can be
dropped.

Thanks,
Sunil

> +	if (!is_of_node(node))
> +		return -ENODEV;
> +
> +	return riscv_of_parent_hartid(to_of_node(node), hartid);
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 4adeee1bc391..65f4a2afb381 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -143,7 +143,7 @@ static int __init riscv_intc_init(struct device_node *node,
>  	int rc;
>  	unsigned long hartid;
>  
> -	rc = riscv_of_parent_hartid(node, &hartid);
> +	rc = riscv_get_intc_hartid(of_fwnode_handle(node), &hartid);
>  	if (rc < 0) {
>  		pr_warn("unable to find hart id for %pOF\n", node);
>  		return 0;
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index e1484905b7bd..56b0544b1f27 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -477,7 +477,8 @@ static int __init __plic_init(struct device_node *node,
>  			continue;
>  		}
>  
> -		error = riscv_of_parent_hartid(parent.np, &hartid);
> +		error = riscv_get_intc_hartid(of_fwnode_handle(parent.np),
> +					      &hartid);
>  		if (error < 0) {
>  			pr_warn("failed to parse hart ID for context %d.\n", i);
>  			continue;
> -- 
> 2.34.1
> 
