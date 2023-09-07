Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F550796F14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbjIGCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIGCtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:49:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA31BE8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:48:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4121788397fso8061081cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694054917; x=1694659717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlwEYNiTM8Cohgu2gjOqDt0be1L8BydneonWvv+KYiQ=;
        b=CXGvr3bn++ZZJ2NA7L4GstdoVuaZHDl+LQFvFY3/p1vYwN1IeMhV/ZAn0wUzNfUSU6
         V7hWOJIzCyEuixmaifSwAEg46htBbdEvoVHmFpqCEoUZ3NdqREapwMLjfloFXf3ewHZ2
         IA4X1XBNor3wRif9Gz82leNCjFandc78a94gG/QL6jly285cDGKIIn6iYYiNRS7QutPk
         H6jd05DYsVg5CuByY7QlVn0ElEbmMA7/l/xsI4djJakDDhXG+cGSiqlGw8K03gESI+KU
         P1jQIKRJoiYvEj4B2mxwY4o5WJqkSRvJ/6ZfbULYqV5Xc8OtRYFN4qM5KBaDQKCHliTi
         Pt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694054917; x=1694659717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlwEYNiTM8Cohgu2gjOqDt0be1L8BydneonWvv+KYiQ=;
        b=H+tciWASKHK3ZTJqQX5juZM84aB1HtPKwGLSWEEkI3EUVzTBU5CUAFx9px08ydbZCe
         Yf7VQKCckE9i2JnntGNJphyxjDlgBFBY1qWXANZaiAFuu8VGfWwpuMfMV2XrkXcUUve4
         hyXMjeo+D1xhIylm06fuTeKnsKTROf5qXMssi28BUSlJXvTgwOo3ycbexFtOyTgpcmzY
         HTrQSND+1txI24RpWKATdYgPkSRICSt4fdwNnuh7F6LrIOz5MuPKZd8vqMtmfSOx70x7
         aYfqRhDGLj5eUUQfrG7kAujU8d9wmPeaK9c0X3xqJ0fJXqZiHsT0nTvWwcmE6Hptzf0b
         sTcQ==
X-Gm-Message-State: AOJu0Yx5nM/0fjbQ19BJK6TTUbrXBbnnmys8jizMreBVgNgSa13nJo6q
        kb9JLr7Cu09EmJbMJswIP/TYbcBabJy6UzKnlDYX+Q==
X-Google-Smtp-Source: AGHT+IFxlfKMLrAkviW1qIhzefmuqsCtQfSLTGBzsN3tPpVhNGe/PhSlkWguR9Zyl6I65Vz43TAi1A==
X-Received: by 2002:a05:622a:1889:b0:410:a562:b420 with SMTP id v9-20020a05622a188900b00410a562b420mr2039164qtc.4.1694054917081;
        Wed, 06 Sep 2023 19:48:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:152:b734:8158:65af? ([2600:1700:2000:b002:152:b734:8158:65af])
        by smtp.gmail.com with ESMTPSA id jd19-20020a05622a719300b00400a99b8b38sm5814949qtb.78.2023.09.06.19.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 19:48:36 -0700 (PDT)
Message-ID: <82a82449-3af0-4756-881a-b31b6b187e6c@sifive.com>
Date:   Wed, 6 Sep 2023 21:48:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] riscv: errata: Add Andes PMU errata
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     ajones@ventanamicro.com, heiko@sntech.de, samuel@sholland.org,
        geert+renesas@glider.be, n.shubin@yadro.com, dminus@andestech.com,
        ycliang@andestech.com, tim609@andestech.com, locus84@andestech.com,
        dylan@andestech.com, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, atishp@atishpatra.org,
        anup@brainfault.org, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-4-peterlin@andestech.com>
Content-Language: en-US
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230907021635.1002738-4-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 9:16 PM, Yu Chien Peter Lin wrote:
> Before the ratification of Sscofpmf, the Andes PMU extension
> implements the same mechanism and is compatible with existing
> SBI PMU driver of perf to support event sampling and mode
> filtering with programmable hardware performance counters.
> 
> This patch adds PMU support for Andes 45-series CPUs by
> introducing a CPU errata.
> 
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  arch/riscv/Kconfig.errata            | 13 ++++++++
>  arch/riscv/errata/andes/errata.c     | 45 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 43 ++++++++++++++++++++++++--
>  drivers/perf/riscv_pmu_sbi.c         | 20 +++++++++----
>  4 files changed, 111 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 92c779764b27..a342b209c169 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -21,6 +21,19 @@ config ERRATA_ANDES_CMO
>  
>  	  If you don't know what to do here, say "Y".
>  
> +config ERRATA_ANDES_PMU
> +	bool "Apply Andes PMU errata"
> +	depends on ERRATA_ANDES && RISCV_PMU_SBI
> +	default y
> +	help
> +	  The Andes 45-series cores implement a PMU overflow extension
> +	  very similar to the core SSCOFPMF extension.
> +
> +	  This will apply the overflow errata to handle the non-standard
> +	  behaviour via the regular SBI PMU driver and interface.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  config ERRATA_SIFIVE
>  	bool "SiFive errata"
>  	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> index d2e1abcac967..19256691f1ba 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -56,11 +56,54 @@ static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigne
>  	return true;
>  }
>  
> +static bool errata_probe_pmu(unsigned int stage,
> +			     unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_PMU))
> +		return false;
> +
> +	if ((arch_id & 0xff) != 0x45)
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	return true;
> +}
> +
> +static u32 andes_errata_probe(unsigned int stage,
> +			      unsigned long archid, unsigned long impid)
> +{
> +	u32 cpu_req_errata = 0;
> +
> +	if (errata_probe_pmu(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_ANDES_PMU);
> +
> +	return cpu_req_errata;
> +}
> +
>  void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  					      unsigned long archid, unsigned long impid,
>  					      unsigned int stage)
>  {
> +	struct alt_entry *alt;
> +	u32 cpu_req_errata = andes_errata_probe(stage, archid, impid);
> +	u32 tmp;
> +
>  	errata_probe_iocp(stage, archid, impid);
>  
> -	/* we have nothing to patch here ATM so just return back */
> +	for (alt = begin; alt < end; alt++) {
> +		if (alt->vendor_id != ANDES_VENDOR_ID)
> +			continue;
> +		if (alt->patch_id >= ERRATA_ANDES_NUMBER)
> +			continue;
> +
> +		tmp = (1U << alt->patch_id);
> +		if (cpu_req_errata & tmp) {
> +			mutex_lock(&text_mutex);
> +			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> +					  alt->alt_len);
> +			mutex_unlock(&text_mutex);
> +		}
> +	}
>  }
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 56ab40e64092..bb4c276e2c7f 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -13,7 +13,8 @@
>  
>  #ifdef CONFIG_ERRATA_ANDES
>  #define ERRATA_ANDES_NO_IOCP 0
> -#define ERRATA_ANDES_NUMBER 1
> +#define ERRATA_ANDES_PMU 1
> +#define ERRATA_ANDES_NUMBER 2
>  #endif
>  
>  #ifdef CONFIG_ERRATA_SIFIVE
> @@ -150,15 +151,51 @@ asm volatile(ALTERNATIVE_2(						\
>  #define THEAD_C9XX_RV_IRQ_PMU			17
>  #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
>  
> +#define ANDES_RV_IRQ_PMU			18
> +#define ANDES_SLI_CAUSE_BASE			256
> +#define ANDES_CSR_SCOUNTEROF			0x9d4
> +#define ANDES_CSR_SLIE				0x9c4
> +#define ANDES_CSR_SLIP				0x9c5
> +
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
> -asm volatile(ALTERNATIVE(						\
> +asm volatile(ALTERNATIVE_2(						\
>  	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
> -		CONFIG_ERRATA_THEAD_PMU)				\
> +		CONFIG_ERRATA_THEAD_PMU,				\
> +	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
>  	: "=r" (__ovl) :						\
>  	: "memory")
>  
> +#define ALT_SBI_PMU_OVF_CLEAR_PENDING(__irq_num)			\
> +asm volatile(ALTERNATIVE(						\
> +	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
> +	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
> +#define ALT_SBI_PMU_OVF_DISABLE(__irq_num)				\
> +asm volatile(ALTERNATIVE(						\
> +	"csrc " __stringify(CSR_IE) ", %0\n\t",				\
> +	"csrc " __stringify(ANDES_CSR_SLIE) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
> +#define ALT_SBI_PMU_OVF_ENABLE(__irq_num)				\
> +asm volatile(ALTERNATIVE(						\
> +	"csrs " __stringify(CSR_IE) ", %0\n\t",				\
> +	"csrs " __stringify(ANDES_CSR_SLIE) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 9a51053b1f99..8b67f202d2ae 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -687,7 +687,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	event = cpu_hw_evt->events[fidx];
>  	if (!event) {
> -		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
>  		return IRQ_NONE;
>  	}
>  
> @@ -701,7 +701,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	 * Overflow interrupt pending bit should only be cleared after stopping
>  	 * all the counters to avoid any race condition.
>  	 */
> -	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
>  
>  	/* No overflow bit is set */
>  	if (!overflow)
> @@ -773,8 +773,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  
>  	if (riscv_pmu_use_irq) {
>  		cpu_hw_evt->irq = riscv_pmu_irq;
> -		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> -		csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
> +		ALT_SBI_PMU_OVF_ENABLE(riscv_pmu_irq_num);
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
>  
> @@ -785,7 +785,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	if (riscv_pmu_use_irq) {
>  		disable_percpu_irq(riscv_pmu_irq);
> -		csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_DISABLE(riscv_pmu_irq_num);
>  	}
>  
>  	/* Disable all counters access for user mode now */
> @@ -809,6 +809,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  		   riscv_cached_mimpid(0) == 0) {
>  		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
>  		riscv_pmu_use_irq = true;
> +	} else if (IS_ENABLED(CONFIG_ERRATA_ANDES_PMU) &&
> +		   riscv_cached_mvendorid(0) == ANDES_VENDOR_ID) {
> +		riscv_pmu_irq_num = ANDES_RV_IRQ_PMU;
> +		riscv_pmu_use_irq = true;
>  	}
>  
>  	if (!riscv_pmu_use_irq)
> @@ -821,7 +825,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  		return -ENODEV;
>  	}
>  
> -	riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
> +	if (IS_ENABLED(CONFIG_ERRATA_ANDES_PMU))
> +		riscv_pmu_irq = irq_create_mapping(
> +			domain, ANDES_SLI_CAUSE_BASE + riscv_pmu_irq_num);
> +	else
> +		riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);

If the code here needs to be different, then it must check that it is actually
running on an Andes core, not just that the errata Kconfig option is enabled.

However, I suggest setting riscv_pmu_irq_num to the real IRQ number:
  riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMU;
and then adding a new variable for the mask:
  riscv_pmu_irq_mask = BIT(riscv_pmu_irq_num % BITS_PER_LONG);
which handles the large IRQ number somewhat more generically, and reduces the
number of bit operations needed elsewhere in the driver.

Or we could use IRQ chip operations here instead of direct CSR acccess. But
maybe the direct CSR access is needed for performance?

Regards,
Samuel

>  	if (!riscv_pmu_irq) {
>  		pr_err("Failed to map PMU interrupt for node\n");
>  		return -ENODEV;

