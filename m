Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A36279048C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351442AbjIBArc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIBArb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:47:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C0BE7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=iXI8dt5kDOp0aDpTx1FkhSszrOEc4+OxkmAbG205fiM=; b=tQCEMp1FuvqnJgX0YLD0ewXtYO
        HIR054q3ZOFGYoRL+RxlObDoX+dwZ0bEB7eEaWnLMzGKQP3I2Znfh4WNcKL/HclTE1spsyZt2VS+7
        tU44GLHcLZMe8zOI6uw6DWZiOKSh6PjjDWeCMqX9iX/KX9AtFXLPpb0JbxHpXHhlLeqCjauzm1WbG
        GIXrzOkQg1ZLuxcemj2e1CbLNzGVJ67vjgnVx+Fsvtckkn9tFxAzxsu2MkzqluKL9+nRMvsmcOEHe
        vAqaR2amsnv72afBXyYnxfopVXCWrPeyaB+eMqhekYvP+DHPCBSWRa8T9T6gZrpIP/M2Tm/acvDx0
        FxG+RG9A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qcEnF-000akT-32;
        Sat, 02 Sep 2023 00:47:17 +0000
Message-ID: <13203808-f765-76f9-2cb2-c3657edb14c7@infradead.org>
Date:   Fri, 1 Sep 2023 17:47:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <c9da6ffe-7a58-1efa-f625-41d73346d6a2@infradead.org>
 <CA+V-a8tyUpgDSBrpHBBfWfie4xnR7iKCZben3U5dX1puFu3_1A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+V-a8tyUpgDSBrpHBBfWfie4xnR7iKCZben3U5dX1puFu3_1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for your help.

On 9/1/23 14:12, Lad, Prabhakar wrote:
> Hi Randy,
> 
> On Fri, Sep 1, 2023 at 9:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>>
>> On 9/1/23 04:03, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
>>> enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
>>> avoid any build failures.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>  arch/riscv/Kconfig.errata | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>>> index bee5d838763b..566bcefeab50 100644
>>> --- a/arch/riscv/Kconfig.errata
>>> +++ b/arch/riscv/Kconfig.errata
>>> @@ -2,7 +2,7 @@ menu "CPU errata selection"
>>>
>>>  config ERRATA_ANDES
>>>       bool "Andes AX45MP errata"
>>> -     depends on RISCV_ALTERNATIVE
>>> +     depends on RISCV_ALTERNATIVE && RISCV_SBI
>>>       help
>>>         All Andes errata Kconfig depend on this Kconfig. Disabling
>>>         this Kconfig will disable all Andes errata. Please say "Y"
>>
>>
>> I'm still seeing build warnings/errors after applying all 3 RISC-V
>> Kconfig patches from today (2023 SEP 01).
>>
>> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>>   Depends on [n]: RISCV_ALTERNATIVE [=y] && RISCV_SBI [=n]
>>   Selected by [y]:
>>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]
>>
>> ../arch/riscv/errata/andes/errata.c: In function 'ax45mp_iocp_sw_workaround':
>> ../arch/riscv/errata/andes/errata.c:29:23: error: storage size of 'ret' isn't known
>>    29 |         struct sbiret ret;
>>       |                       ^~~
>> ../arch/riscv/errata/andes/errata.c:35:15: error: implicit declaration of function 'sbi_ecall' [-Werror=implicit-function-declaration]
>>    35 |         ret = sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
>>       |               ^~~~~~~~~
>> ../arch/riscv/errata/andes/errata.c:29:23: warning: unused variable 'ret' [-Wunused-variable]
>>    29 |         struct sbiret ret;
>>       |                       ^~~
>>
>> ARCH_R9A07G043 in drivers/soc/renesas/Kconfig selects ERRATA_ANDES and
>> ERRATA_ANDES_CMO even though RISCV_SBI is not set/enabled.
>>
> 
> You need to apply patch [1] aswell.
> 
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

I tested the failing builds that I had - after applying all 4 patches only,
not each patch separately.

If that is satisfactory, you can add
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
