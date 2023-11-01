Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A877DE494
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjKAQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:27:23 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2893DFD;
        Wed,  1 Nov 2023 09:27:19 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.206) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 1 Nov
 2023 19:27:11 +0300
Subject: Re: [PATCH fixes 2/3] MIPS: Loongson64: Enable DMA noncoherent
 support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Huacai Chen <chenhuacai@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
 <20231101-loongson64_fixes-v1-2-2a2582a4bfa9@flygoat.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f1d9a544-bb08-f78a-2a27-437cb9261a16@omp.ru>
Date:   Wed, 1 Nov 2023 19:27:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231101-loongson64_fixes-v1-2-2a2582a4bfa9@flygoat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.206]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/01/2023 16:16:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181058 [Nov 01 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.206
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/01/2023 16:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/1/2023 2:02:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 2:39 PM, Jiaxun Yang wrote:

> There are some Loongson64 systems come with broken coherent DMA
> support, firmware will set a bit in boot_param and pass nocoherentio
> in cmdline.
> 
> However nonconherent support was missed out when spin off Loongson-2EF
> form Loongson64, and that boot_param change never made itself into
> upstream.
> 
> Support DMA noncoherent properly to get those systems work.

   Working.

> 
> Cc: stable@vger.kernel.org
> Fixes: 71e2f4dd5a65 ("MIPS: Fork loongson2ef from loongson64")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[...]

> diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
> index 035b1a69e2d0..c454ef734c45 100644
> --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
> +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
> @@ -117,7 +117,8 @@ struct irq_source_routing_table {
>  	u64 pci_io_start_addr;
>  	u64 pci_io_end_addr;
>  	u64 pci_config_addr;
> -	u32 dma_mask_bits;
> +	u16 dma_mask_bits;
> +	u16 dma_noncoherent;
>  } __packed;
>  
>  struct interface_info {
> diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
> index c961e2999f15..df0e92cd3920 100644
> --- a/arch/mips/loongson64/env.c
> +++ b/arch/mips/loongson64/env.c
> @@ -13,6 +13,8 @@
>   * Copyright (C) 2009 Lemote Inc.
>   * Author: Wu Zhangjin, wuzhangjin@gmail.com
>   */
> +
> +#include <linux/dma-map-ops.h>
>  #include <linux/export.h>
>  #include <linux/pci_ids.h>
>  #include <asm/bootinfo.h>
> @@ -147,8 +149,13 @@ void __init prom_lefi_init_env(void)
>  
>  	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
>  	if (loongson_sysconf.dma_mask_bits < 32 ||
> -		loongson_sysconf.dma_mask_bits > 64)
> +		loongson_sysconf.dma_mask_bits > 64) {

   Please indent this line differently, so it doesn't blend
with the following line (either start it in the same column
as the *if* expression above, or add 1 more tab).

>  		loongson_sysconf.dma_mask_bits = 32;
> +		dma_default_coherent = true;
> +	} else

   The kernel style dictates that you need to add {} on the *else*
branchh too.

> +		dma_default_coherent = !eirq_source->dma_noncoherent;
> +
> +	pr_info("DMA coherent: %s\n", dma_default_coherent ? "on" : "off");

   Maybe "Coherent DMA: %s\n"?

[...]

MBR, Sergey
