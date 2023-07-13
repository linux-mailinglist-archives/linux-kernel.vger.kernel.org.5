Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4977515C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGMBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGMBZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:25:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E61FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:25:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570877f7838so691537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689211504; x=1691803504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqHFSQOzO/XxaRJXgZdmByKAXPqRNRjyMIQrSCq8enU=;
        b=TR1zcSgLsGdmzMtZo6rrfSeyFREsDN1hEgUGIQnsUj6D/y4MixnzaKm0TUUXUraFwe
         2F0LDbtwW4iuL6ZL9pCKL4rUTrOqCSCZZRR9ZFV0WoW1dkCim58yW/WWVsrghjNXlKHI
         5KYpB2Da5i3luvXCWoava16QYYilQTAcmlSJnvpc2sIm3Zmk+G7Gv5Hr7YveQ4qOK4to
         SO/jex5T3nRzAkV4ClyWpLIIFaLioFJ+90gVR7MVjnXN8KDSJ8xzKMchFpyrSqxTLhyk
         ZfvVMbaN1aMIp7RpifwWEHhDY2vrz2gUCcIuHkwiugM9TNL+d82KgwTlzLyGMlc0psdx
         VCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689211504; x=1691803504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DqHFSQOzO/XxaRJXgZdmByKAXPqRNRjyMIQrSCq8enU=;
        b=F03f+xscBGI4HKnF7maAD+QMJ8fscewas2n70mt/lHxDnUe78Icrx4ybWOZI6pc9lA
         6Q8QtY5qitTotlS9ApaNJ7MxlPvNpdAY60jUwqsOCH9NbHaeNqQ7Whce7G9ycJiQmAc8
         SsdW09CAegDEVobRExEn1hE23FCdGgHyqviMKQ7zf/LsJrhngNaSateld1ES11felTNy
         zapRCrhcZIgk0sbGCii4PmWHN9mgCW1nuDpKWbNbdZBLaV3gfjRLICEXi1t5HH32AZOp
         kIvHFbhDT0rCfDHOvOT6RcBkFXjaf99tLTCq2Ym4WjqASaeRxlI8RP72G9aTOByjf4s4
         EsFg==
X-Gm-Message-State: ABy/qLaiedwKXx1KjLIw/mhMrKTNlnDIo2ow7LU3R2RNsBCjEOMbRuWe
        pogIOqkyf4RjQNTVa3pg0pUFJJxR2lA=
X-Google-Smtp-Source: APBJJlHMBHkj00RvSRUYQ/QogWDePOSIDqsqlln4XBVpRRSHweZVWOWEEd9nwa8rVbMVL9IY//hSLg==
X-Received: by 2002:a0d:e615:0:b0:565:e48d:32cf with SMTP id p21-20020a0de615000000b00565e48d32cfmr366971ywe.7.1689211504176;
        Wed, 12 Jul 2023 18:25:04 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902b60e00b001ac591b0500sm4599862pls.134.2023.07.12.18.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 18:25:03 -0700 (PDT)
Message-ID: <ced7dc06-bbc9-afa1-6973-b992871eac11@gmail.com>
Date:   Thu, 13 Jul 2023 09:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: correct pt_level name via pgtable_l5/4_enabled
To:     Palmer Dabbelt <palmer@dabbelt.com>, alex@ghiti.fr
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alexghiti@rivosinc.com, Bjorn Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-05add620-8132-496a-a514-4b78c78b3694@palmer-ri-x1c9a>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <mhng-05add620-8132-496a-a514-4b78c78b3694@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/12 21:58, Palmer Dabbelt 写道:
> On Tue, 11 Jul 2023 04:14:10 PDT (-0700), alex@ghiti.fr wrote:
>> Hi Song,
>>
>>
>> On 11/07/2023 12:52, Song Shuai wrote:
>>> The pt_level uses CONFIG_PGTABLE_LEVELS to display page table names.
>>> But if downgrading page mode from kernel cmdline in 64BIT, it will
>>> give a wrong name.
>>>
>>> Like, using no4lvl for sv39, ptdump named the 1G-mapping as "PUD"
>>> that should be "PGD":
>>>
>>> 0xffffffd840000000-0xffffffd900000000    0x00000000c0000000         
>>> 3G PUD     D A G . . W R V
>>>
>>> So select "P4D/PUD" or "PGD" via pgtable_l5/4_enabled to correct it.
>>>
>>> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the 
>>> command line")
>>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>>> ---
>>>   arch/riscv/mm/ptdump.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
>>> index 20a9f991a6d7..cfdd327981ee 100644
>>> --- a/arch/riscv/mm/ptdump.c
>>> +++ b/arch/riscv/mm/ptdump.c
>>> @@ -384,6 +384,11 @@ static int __init ptdump_init(void)
>>>
>>>       kernel_ptd_info.base_addr = KERN_VIRT_START;
>>>
>>> +#ifdef CONFIG_64BIT
>>> +    pg_level[1].name = pgtable_l5_enabled ? "P4D" : "PGD";
>>> +    pg_level[2].name = pgtable_l4_enabled ? "PUD" : "PGD";
>>> +#endif
>>
>>
>> You don't need the #ifdef here as pgtable_lX_enabled are always declared.
>>
>>
>>> +
>>>       for (i = 0; i < ARRAY_SIZE(pg_level); i++)
>>>           for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
>>>               pg_level[i].mask |= pte_bits[j].mask;
>>
>>
>> The Fixes tag is wrong to me, if satp mode is restricted by the hardware
>> itself (not from the command line), the same problem happens. Maybe that
>> should be the sv48 introduction patch? Or the sv57? It will be more
>> cumbersome to backport with the sv48 introduction though as this patch
>> won't apply as-is.
> 
> Sometimes it's easier to base the fix on the original offending commit 
> and then forward-port it via a merge, I haven't looked at this one to 
> know for sure though.
> 
>> Otherwise, you can add:
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks.
> 
> Song: do you have a v2 that addresses the comments?
> 
Here is V2 :

https://lore.kernel.org/linux-riscv/20230712115740.943324-1-suagrfillet@gmail.com/
>>
>> Thanks,
>>
>> Alex

-- 
Thanks
Song Shuai
