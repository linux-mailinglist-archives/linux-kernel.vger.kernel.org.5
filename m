Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C77BC900
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJGQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJGQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:06:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3AC2;
        Sat,  7 Oct 2023 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VZ4kcoqQ9YTUKz/bWlIB+CayC4kkrmXmIfZVAUvHPtc=; b=susPAjK8QuI+p9JXVgqO2BEDVm
        tuVi4UOdZFnphceY5wN8zgkfsN8O2klVJ3AQnsxvuzQyBmCZIJBIRMVYaRHylOmnPlpZ+80nBiv5a
        ZI5vz3fO0rKyi7x11ukxd4z0cgSHJStiPzwFmYeqFPbgukctzT5ec8Y8oOAtSrDHPkx4ue6fk/oUZ
        +bs0xs/KVgd+w4UcFJm0gDJJb00wCfOd5I/BeXlkv/Yc3SbN0ksBzUjCdklCw4OY8srQFM9EjNRrs
        fU23vOWutNHO8LrrQDqcQKta8bBqxVZbf+j+aPt9Cd6MsC+tBcAFa3XJHTKQ0ocRvah88I1HuUKS1
        DpZk2xzQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qp9p5-007iOO-00;
        Sat, 07 Oct 2023 16:06:35 +0000
Message-ID: <ff4bbd33-e494-4db2-93e2-59d1a866d7cf@infradead.org>
Date:   Sat, 7 Oct 2023 09:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 6 (riscv: andes)
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231006153809.2054a0f8@canb.auug.org.au>
 <09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org>
 <20231007-poach-refute-b84fe5b7431a@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231007-poach-refute-b84fe5b7431a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 10/7/23 03:56, Conor Dooley wrote:
> On Fri, Oct 06, 2023 at 05:28:27PM -0700, Randy Dunlap wrote:
>>
>>
>> On 10/5/23 21:38, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20231005:
>>>
>>
>> on riscv 64bit:
>>
>> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>>   Depends on [n]: RISCV_ALTERNATIVE [=n] && RISCV_SBI [=y]
>>   Selected by [y]:
>>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_SBI [=y]
>>
>> ../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
>>    59 | void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>>       |                                                      ^~~~~~~~~
>>
>>
>> Full randconfig file is attached.
> 
> Riiight. XIP_KERNEL is enabled, which means no alternatives are
> permitted, but that R9A config option selects the Andes errata, which in
> turn depends on alternatives.
> 
> I suppose we could do something like (untested):
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 7b74de732718..6fe85255e2ce 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -343,7 +343,7 @@ config ARCH_R9A07G043
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>         select DMA_GLOBAL_POOL
> -       select ERRATA_ANDES if RISCV_SBI
> +       select ERRATA_ANDES if (RISCV_SBI & RISCV_ALTERNATIVE)

s/&/&&/ and then this works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

>         select ERRATA_ANDES_CMO if ERRATA_ANDES
>         help
>           This enables support for the Renesas RZ/Five SoC.

-- 
~Randy
