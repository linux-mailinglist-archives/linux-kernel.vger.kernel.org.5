Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E589E76DF75
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHCEll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:41:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090522D71
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:41:34 -0700 (PDT)
X-QQ-mid: bizesmtp71t1691037685tpxaqjs6
Received: from [192.168.2.11] ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 12:41:24 +0800 (CST)
X-QQ-SSF: 00200000000000904000000A0000000
X-QQ-FEAT: uSN+FHkLExbDiJTi143NrDb+JoCVhp+kkT70Y8vCNNWvRQRLSdThgIfID1eaO
        H667Uvy/u+Z89sv8YYl7it6N3hSoAoARRqFywMhchPN0PT0IxYpdOd9ODwkFwZKbJjk/TRm
        yz8yqD7o19abFNNgXGNQ3uukvzxXtbNMsQ7tM/7cnMCZ1gjJNcKxao+GJsY5V4IISXMWktD
        KyEoe+aloCRUV8IWNdUoYMz6nGCwBZM5XfEceE3BUFWMnPjuldvgq0D3zEQzQm6uNLhxMtm
        /r8lsMQ++5tBNarnmOdiOomtYNJ5Hf4EI+cH1VhfjOAuYmhMsaIMXfy9izYx2iNqe6vxJGW
        XWNDtWuCFytdbKBELMBBFhEM02MhMiGbVghGKC2i+vs3rLXgXw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9874323047209275138
Message-ID: <4CC3DEEB40C0DEC3+d4d7dfc3-0e9b-9185-d72a-419b36fc1f53@tinylab.org>
Date:   Thu, 3 Aug 2023 12:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: pmac32: enable serial options by default in
 defconfig
Content-Language: en-GB
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
References: <bb7b5f9958b3e3a20f6573ff7ce7c5dc566e7e32.1690982937.git.tanyuan@tinylab.org>
 <88334e42-a3c2-dab5-fdcb-91305d672e5b@csgroup.eu>
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux@weissschuh.net, w@1wt.eu,
        npiggin@gmail.com
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <88334e42-a3c2-dab5-fdcb-91305d672e5b@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On 8/2/2023 9:58 PM, Christophe Leroy wrote:
>
> Le 02/08/2023 à 15:41, Yuan Tan a écrit :
>> [Vous ne recevez pas souvent de courriers de tanyuan@tinylab.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Serial is a critical feature for logging and debuging, and the other
>> architectures enable serial by default.
>>
>> Let's enable CONFIG_SERIAL_PMACZILOG and CONFIG_SERIAL_PMACZILOG_CONSOLE
>> by default.
>>
>> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Can this patch be merged into v6.6? There's another patch depends on it :)

Best regards,

Yuan Tan

>> ---
>>    arch/powerpc/configs/pmac32_defconfig | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
>> index 019163c2571e..3aae79afb9d9 100644
>> --- a/arch/powerpc/configs/pmac32_defconfig
>> +++ b/arch/powerpc/configs/pmac32_defconfig
>> @@ -176,8 +176,9 @@ CONFIG_MOUSE_APPLETOUCH=y
>>    # CONFIG_SERIO_I8042 is not set
>>    # CONFIG_SERIO_SERPORT is not set
>>    CONFIG_SERIAL_8250=m
>> -CONFIG_SERIAL_PMACZILOG=m
>> +CONFIG_SERIAL_PMACZILOG=y
>>    CONFIG_SERIAL_PMACZILOG_TTYS=y
>> +CONFIG_SERIAL_PMACZILOG_CONSOLE=y
>>    CONFIG_NVRAM=y
>>    CONFIG_I2C_CHARDEV=m
>>    CONFIG_APM_POWER=y
>> --
>> 2.34.1
>>
