Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F279FC50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjINGwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:52:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D2CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:52:28 -0700 (PDT)
X-QQ-mid: bizesmtp66t1694674308t5grj0hy
Received: from [10.4.6.71] ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 14:51:44 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: QityeSR92A1mgVQ1XhhOgX/qTsqmJVLJ7VlmlQ3v1R2RSAEbV4tpASXMJp4g2
        yGFGg5xIL3mrCSntp03UvnjCgfi7+CyZZsjhD62l4W2UthZFj6hCCoRBLIcdSEJ6/vuV+lT
        Ic0jLhbFaMKt5QDTyM7x7VtqSOyEzlqH0OrxXDmIiNQ7K4cu3b4qmR9K99wliy3iQSADrle
        lpuqHw+IhAIXQVnssRND95on4lPUPHi3/Jaepea9VthPflXPomLIUHxBCl5rc8eSUh51x+x
        qQISC9P/FeE+Dmsal4yU9HjxUjWjQfcuh9CYnYGhz5Jt85x56CQXOcZw3cfjaDRNyXOtfj9
        irew9dQ49ErHnWb1kjDxT/vA9A318kZbmTUkIwui7+eONoWPtQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3595057428919100681
Message-ID: <A1D410BE9DD1128F+45f92224-dc0f-0bfd-d122-fbbcac48eaf3@tinylab.org>
Date:   Thu, 14 Sep 2023 14:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, samuel@sholland.org,
        rppt@kernel.org, suagrfillet@gmail.com, panqinglin2020@iscas.ac.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
 <CAJF2gTRHbvwyZR_qUNsc3E9X=Y1H7yTcZo3NLgXQ45=jm1jbTg@mail.gmail.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAJF2gTRHbvwyZR_qUNsc3E9X=Y1H7yTcZo3NLgXQ45=jm1jbTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/14 12:59, Guo Ren 写道:
> On Wed, Aug 9, 2023 at 11:11 AM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>
>> From: Song Shuai <suagrfillet@gmail.com>
>>
>> Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
>> the comment of CONFIG_PAGE_OFFSET should be updated too.
>>
>> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> ---
>>   arch/riscv/include/asm/page.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> index b55ba20903ec..53c00164c042 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -33,8 +33,8 @@
>>   #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> Why not remove CONFIG_PAGE_OFFSET and define PAGE_OFFSET_L2 ?
>
CONFIG_PAGE_OFFSET holds the first memory address regarding the 
different CONFIGs (MMU,32BIT,64BIT).

As for 64BIT, it actually represents "PAGE_OFFSET_L5" for Sv57 page mode 
defaultly. And the real page mode may be downgraded from kernel cmdline 
or restricted by the hardware, so the PAGE_OFFSET_L3/L4 was defined to 
set the real PAGE_OFFSET.

IIUC, the "PAGE_OFFSET_L2" you specified might be the "PAGE_OFFSET_L5" I 
previously mentioned,
If not, the PAGE_OFFSET_L2 semantically means the page offset for 
32BIT's default Sv32 page mode,and it has already been held in 
CONFIG_PAGE_OFFSET too.

So IMO there is no need to touch CONFIG_PAGE_OFFSET in this context.

Please correct me If I'm wrong.
>>   #endif
>>   /*
>> - * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
>> - * define the PAGE_OFFSET value for SV39.
>> + * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
>> + * define the PAGE_OFFSET value for SV48 and SV39.
>>    */
>>   #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
>>   #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
>> --
>> 2.20.1
>>
> 
> 

-- 
Thanks
Song Shuai

