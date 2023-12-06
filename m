Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485418075ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378531AbjLFRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjLFRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:00:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B51D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yJsFNn6bxRvypUst0hU4StBfKL8hvANcLo4YwGGRK1g=; b=IYEKtFAFCxzUALthJ9Q+GOzjSd
        HJ5+akHIzs/03HgK39YaysIzN21wjdO753OHedk5YtxvkvXkOnyJyFG2hT4oLD7PmdDexlMB0okcu
        YgwXoCmVZhp8FR6w1K/eSWQAGb6b/SIN4VvaqKcLe9Qd/dAR36JN39xOE0QOBu1SZMQ2tXfI8HaOH
        LdF83+If9YxU4YJrry47YVus8aRokVnAAFJULJA/s8dc6YjuAEUu2BWDwdb/o0haCjdHwIIfsaH0s
        kWN6A/s9au54+NoqJTmo1kpjKXBO2GLKFp10LFCC5mtGh6t5FZ/JqKPbXLlxa0ZgYOTaiNMvS7aXA
        uj98gcdg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAvGJ-00Apsm-1J;
        Wed, 06 Dec 2023 17:00:40 +0000
Message-ID: <7b27e5db-16b8-400e-a94b-a36f65205654@infradead.org>
Date:   Wed, 6 Dec 2023 09:00:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Support rv32 ULEB128 test
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122-module_fixup-v2-1-dfb9565e9ea5@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231122-module_fixup-v2-1-dfb9565e9ea5@rivosinc.com>
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

Hi,

On 11/22/23 15:35, Charlie Jenkins wrote:
> Use opcodes available to both rv32 and rv64 in uleb128 module linking
> test.
> 
> Fixes: af71bc194916 ("riscv: Add tests for riscv module loading")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/1d7c71ee-5742-4df4-b8ef-a2aea0a624eb@infradead.org/
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> ---
> Support module linking tests on rv32 toolchains with uleb128 support.

I'm still seeing build errors on this test module.

Can someone get this patch merged, please?

Thanks.

> ---
> Changes in v2:
> - Drop patch covered in different series
> - Link to v1: https://lore.kernel.org/r/20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com
> ---
>  arch/riscv/kernel/tests/module_test/test_uleb128.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/tests/module_test/test_uleb128.S b/arch/riscv/kernel/tests/module_test/test_uleb128.S
> index 90f22049d553..8515ed7cd8c1 100644
> --- a/arch/riscv/kernel/tests/module_test/test_uleb128.S
> +++ b/arch/riscv/kernel/tests/module_test/test_uleb128.S
> @@ -6,13 +6,13 @@
>  .text
>  .global test_uleb_basic
>  test_uleb_basic:
> -	ld	a0, second
> +	lw	a0, second
>  	addi	a0, a0, -127
>  	ret
>  
>  .global test_uleb_large
>  test_uleb_large:
> -	ld	a0, fourth
> +	lw	a0, fourth
>  	addi	a0, a0, -0x07e8
>  	ret
>  
> @@ -22,10 +22,10 @@ first:
>  second:
>  	.reloc second, R_RISCV_SET_ULEB128, second
>  	.reloc second, R_RISCV_SUB_ULEB128, first
> -	.dword 0
> +	.word 0
>  third:
>  	.space 1000
>  fourth:
>  	.reloc fourth, R_RISCV_SET_ULEB128, fourth
>  	.reloc fourth, R_RISCV_SUB_ULEB128, third
> -	.dword 0
> +	.word 0
> 
> ---
> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
> change-id: 20231117-module_fixup-699787d9c567

-- 
~Randy
