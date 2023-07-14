Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E5D7530CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjGNE5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:57:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634CD26B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:57:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbe35e028aso2849935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689310630; x=1689915430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5SgvJ0LD0GcBCOp6O6JeKYbZ8IbtnmLIrX6XHzA0Sk=;
        b=G8vqvtEYCFRJEuXZ8WyY3+VfH/Krm1g0Qf/thUZorLKaK4NY1jbqK2ugnZnDGytz/Y
         HNYbm0WakKw7drxW3EM56putLjpDPJReEipbtt8Kfz4bC9e1WMMUqVwMEvTjyf7noAOE
         W8uNcNtuwqrYGcmuaHLVNY4H0CQKDVPBpyW97V/TBm3Z2/JTqfaVJ5IvP26Mv6CFpIFx
         P7lf/qsT62Br9wcQ96yOzCCdVTTxpdD9tlyNsMoVcsqL/erw9X6QKK2bJZLakkLUvdIa
         bqkCfWBajFVYFN9V05hVeukGTVrbkMakXpuq47Lj5lEFmblq87ZgUK6JkTpyG+IR3tvC
         vtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689310630; x=1689915430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5SgvJ0LD0GcBCOp6O6JeKYbZ8IbtnmLIrX6XHzA0Sk=;
        b=BewnRTebK3bSNQBcjn24kZMsGTOHg0m6xWCpejGHW+2aCeDs9JvwiIFCPSkp5M+GNw
         QsdglBFX61xLmKh/mI7sL08tjZHgzneih9pdXe9PeNyoLptalDVqo92s5ko4Ip2yW0XX
         AE7XWqtB+RW50TaEoRDi5P1z67oSO0vz4Uu69Glsz/ZXzhHHX2//mIuT++tEH4yFD3+/
         7e67M1NKaDVZg4h0VSSFwrqpCe+K3mWzStUFe2bNJ5VBykBV0a1UiFOo3gIFctdYWmAG
         41GV4hRaRB7iKGMbUPJiueKTeu3650o0JeFi9XfyAWWJulozuM2YYrXsliZjY4gFc3KX
         JXbg==
X-Gm-Message-State: ABy/qLbjGm6cZfWGADOnkl4AZNDozHmdAhjw6fmGbXCZc3TThrdfCswN
        AQgSfLIri2Wkcz7ne9Gmyks=
X-Google-Smtp-Source: APBJJlG02bCqPvM2yGYWYaYSoqWswRjgV3Xcw4QX+96AaAA5SqRrHq9vkSIK+8B0xmqaUcx1xn4eWw==
X-Received: by 2002:a05:600c:4746:b0:3fb:b29b:61c3 with SMTP id w6-20020a05600c474600b003fbb29b61c3mr3145799wmo.1.1689310629565;
        Thu, 13 Jul 2023 21:57:09 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fa968e9c27sm528321wmk.9.2023.07.13.21.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 21:57:09 -0700 (PDT)
Message-ID: <3b0804ad-bc6c-2f1c-5e67-4505b3da3d40@gmail.com>
Date:   Fri, 14 Jul 2023 06:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/12] Staging: rtl8192e: Rename variable pBA
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZK84sYjc9uHIWZcr@basil>
 <724b252e-0c72-6c77-4817-aee8d87a99cb@gmail.com> <ZLC3w4tjw16LwuEa@basil>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZLC3w4tjw16LwuEa@basil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 04:49, Tree Davies wrote:
> On Thu, Jul 13, 2023 at 11:54:40PM +0200, Philipp Hortmann wrote:
>> On 7/13/23 01:35, Tree Davies wrote:
>>> Rename variable pBA to pba in order to Fix checkpatch
>>> warning: Avoid CamelCase
>>>
>>> Signed-off-by: Tree Davies<tdavies@darkphysics.net>
>>> ---
>>>    drivers/staging/rtl8192e/rtl819x_BAProc.c | 106 +++++++++++-----------
>>>    drivers/staging/rtl8192e/rtllib.h         |   2 +-
>>>    2 files changed, 54 insertions(+), 54 deletions(-)
>>
>>
>> Hi Tree,
>> the p is typically for pointer. This is not wanted when you change the name.
>> But ba is is in use....
>>
>> Bye Philipp
> 
> Thanks Philipp,
>                                                                       
> A few thoughts...
> Looking at occurances of pBA, they all appear as local variable
> declarations of struct ba_record, mostly as function params.
>                                                                       
> I also see what you mentioned, as BA being already taken in
> rtl819x_BAProc.c:394 and line 292, but I don't 'think' that renaming them
> both to ba will result negatively(?).
> 
> Agreed, let's wait on Greg.
> 
> Cheers!
> Tree
> 

Hi Tree,

it is not so much about the compiler or if it works this way. When I 
read a program I often use Ctrl+Shift+F what shows me all variables in 
one folder (driver). I expect that I then always see one variable for 
one use and do not have to do a one by one decision if this belongs to 
the one content or to the other.

Please consider "readability" is important for kernel code.

Thanks for your support.

Bye Philipp
