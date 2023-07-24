Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4F75E9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGXCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGXCUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:20:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93769185
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:20:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E64DE0;
        Sun, 23 Jul 2023 19:21:01 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C943F6C4;
        Sun, 23 Jul 2023 19:20:15 -0700 (PDT)
Message-ID: <a361a1c9-58a4-398b-7b18-9e65e2726f14@arm.com>
Date:   Mon, 24 Jul 2023 07:50:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] arm64: Remove unsued extern declaration
 init_mem_pgprot()
To:     YueHaibing <yuehaibing@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230720143555.26044-1-yuehaibing@huawei.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230720143555.26044-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 20:05, YueHaibing wrote:
> commit a501e32430d4 ("arm64: Clean up the default pgprot setting")
> left behind this.

This commit indeed left the declaration behind.

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/mmu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 4384eaa0aeb7..94b68850cb9f 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -64,7 +64,6 @@ extern void arm64_memblock_init(void);
>  extern void paging_init(void);
>  extern void bootmem_init(void);
>  extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
> -extern void init_mem_pgprot(void);
>  extern void create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>  				   phys_addr_t size, pgprot_t prot);
>  extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
