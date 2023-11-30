Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA447FF7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjK3REe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjK3REc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:04:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160CD7D;
        Thu, 30 Nov 2023 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wSqy0hl8ZT3+9h1bJsk1M8ldjSvDnJV7+3F0R1CUdo0=; b=tzIkJcCYDXdMzyT27WbjnR5MkQ
        5PDWa7mdvzjYOxU6D+j91fZXxGryt7Cq4IWR0CEKj7O06eA15jeZWDwFa/ZfLBGqxtta3zl78B/V4
        7gukNDmQUVJlhZvsrduWvM+rlGl25rLHzUtWemS6fWXW9fsd5nWF7Q8dPI4Cr74Hvq2Ja8qgzJDXX
        WoZDAHgxXpEmwgygthk9tVIP7/eFDpnBpfuHch1iw7ef3pOP8vuBBQYgAaX4VT5Fn/AeX0bE3wT3e
        yaAeh+pNprIJym0ZZQwet/Jkrh9qQdqDLgEv9hq3fLFC5dvgK9+m4cCEGkAHaKbPtnv4nnSNJv+hn
        ap1JfNRQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8kSl-00BSYN-0d;
        Thu, 30 Nov 2023 17:04:31 +0000
Message-ID: <7372f74b-ad5a-4545-9d48-b5eed9005557@infradead.org>
Date:   Thu, 30 Nov 2023 09:04:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 22 (riscv: DMA_GLOBAL_POOL)
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
References: <20231122145257.6f668afa@canb.auug.org.au>
 <24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org>
 <20231130-mothproof-tripod-fe35364591ee@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231130-mothproof-tripod-fe35364591ee@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 08:35, Conor Dooley wrote:
> On Wed, Nov 22, 2023 at 02:37:43PM -0800, Randy Dunlap wrote:
>>
>>
>> On 11/21/23 19:52, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20231121:
>>>
>>
>> on riscv 32-bit:
>>
>> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
>>   Selected by [y]:
>>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && !RISCV_ISA_ZICBOM [=n] && RISCV_SBI [=y]
>>
>> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
>>   Selected by [y]:
>>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && !RISCV_ISA_ZICBOM [=n] && RISCV_SBI [=y]
> 
> DMA_DIRECT_REMAP is selected by the T-HEAD CMO erratum.
> DMA_GLOBAL_POOL by the Andes CMO erratum.
> 
> We could do
> 
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 0071864c2111..d8723fdf1e55 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -339,6 +339,7 @@ if RISCV
>  
>  config ARCH_R9A07G043
>  	bool "RISC-V Platform support for RZ/Five"
> +	depends on !DMA_DIRECT_REMAP
>  	depends on NONPORTABLE
>  	depends on RISCV_ALTERNATIVE
>  	depends on !RISCV_ISA_ZICBOM

OK, that works for me.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy
