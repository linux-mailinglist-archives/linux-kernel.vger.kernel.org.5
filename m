Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AF7E0ECC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 11:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjKDKe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:34:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DDC191
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:34:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c320a821c4so3063514b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699094071; x=1699698871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=793vjP5xFzS5q/YVkQm+rh9ubPQfWH7sbgMbfQm5teI=;
        b=NTe9ylyC1auP/J/H/dbsAwTWpZfkGBuAANxsdAkaxVfGQyslOF7wn2XulmRClsanH1
         o4CwC8YsRzfcLJLKeCGMhBWhmP2cfOXpMx1W/Zua84fut5Ay8vaMyWY/7pPqZRMB9esY
         Mg/uZExH1qwtroHDxxvebQ7zmJSVK2I9sO4MldJUvyfWbVI0UC3CjqvCm/5w+DlJPbXk
         vIVDj8Vu/AJNXeIdEWcBZPCCTCRPP3O2pRT6xN8T0ZoBOL0E5nRczgixxPVBEQeRl6cj
         W8ddPBvvLk96IiX7gbY3pAEb+IQ2BXeUWPCkPbN1maqi9tdsj2NG/RT/a3+5Gdr+cOpg
         Rusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699094071; x=1699698871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=793vjP5xFzS5q/YVkQm+rh9ubPQfWH7sbgMbfQm5teI=;
        b=fkbf5ygs/2TQQoFwuY/QRwiFa8oz5e77XJVHB7lIfXz+AWliaDnu7DdO09pPOGbPFK
         LeIfu4ZlOAX7E8IZxTBVnI9orIM6AdpV6gpNf3Q7D3/86cbjEfyhUJKEa+0sqUZN9zRP
         q5lAAQRLdS1GA5s7IIX3Utfqj8pZ3soVGnx/7CtyDLypaY9FLY/ljd1o10ZpGSMVqFqn
         1MKKoTAMNxVotS0FUJKLci597mSyxwx3jhcYdVozXyeYOiXWX7A+rIO5MP8kPEAQTnoD
         U61NU6k+TbC7MIMzlnK6mTcudJkWGGeLn77BRYf3MUtQfmlU//rihYVFvNDR0XtqwZlZ
         cZ2w==
X-Gm-Message-State: AOJu0Yzpfv/fitW5W0JKQDiMAN4k8w2ma/xOKpJnJGgPRd+0KolkwCQ8
        Yw9hdVCubz6w7IA95c1N7ZVqdw==
X-Google-Smtp-Source: AGHT+IHNpRaERO8yxlrB6yOdJxYyY4XaKcFzpOI8kXQ8XrP53r7v9yartK1/kQ8TXJTI/HQKzIYO/Q==
X-Received: by 2002:a05:6a00:1311:b0:690:c306:151a with SMTP id j17-20020a056a00131100b00690c306151amr20818875pfu.0.1699094070980;
        Sat, 04 Nov 2023 03:34:30 -0700 (PDT)
Received: from [192.168.3.102] ([104.28.245.205])
        by smtp.gmail.com with ESMTPSA id n15-20020aa78a4f000000b006b4ca26f3c9sm2708169pfa.74.2023.11.04.03.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 03:34:30 -0700 (PDT)
Message-ID: <8e83e099-c689-410a-b889-7d8a299bf4e5@bytedance.com>
Date:   Sat, 4 Nov 2023 18:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] locking/atomic: xtensa: define arch_cmpxchg_local as
 __cmpxchg_local
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     chris@zankel.net, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, palmer@rivosinc.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, mattwu@163.com
References: <20231104090603.4253-1-wuqiang.matt@bytedance.com>
 <CAMo8BfK4zDfdh9-WLq+gg1B47ht5hxhvH_j5veEj6JG38meTuw@mail.gmail.com>
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <CAMo8BfK4zDfdh9-WLq+gg1B47ht5hxhvH_j5veEj6JG38meTuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/4 17:31, Max Filippov wrote:
> On Sat, Nov 4, 2023 at 2:06 AM wuqiang.matt <wuqiang.matt@bytedance.com> wrote:
>>
>> The xtensa architecture already has __cmpxchg_local defined upon the
>> native __cmpxchg_u32 and __generic_cmpxchg_local
> 
> This description does not make clear why this change is needed. Could you
> please expand it to cover the 'why' part?

The purpose of __cmpxchg_local() should be for arch_cmpxchg_local(), similarly
for other architectures like x86/arm/powerpc.

I noticed that arc/hexagon/openrisc/sh don't have arch_cmpxchg_local defined
because my patch triggered an error in kernel building. Then found xtensa's
definition of arch_cmpxchg_local() is not reasonable, so proposed this patch
to improve.

This change is not a must, but an improvement to simply make the codes of
arch_cmpxchg_local() more reasonable.

The patch link that introduced try_cmpxchg_local and triggered building error:
https://lore.kernel.org/all/20231023112452.6290-1-wuqiang.matt@bytedance.com/

>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>> ---
>>   arch/xtensa/include/asm/cmpxchg.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
>> index 675a11ea8de7..956c9925df1c 100644
>> --- a/arch/xtensa/include/asm/cmpxchg.h
>> +++ b/arch/xtensa/include/asm/cmpxchg.h
>> @@ -108,7 +108,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
>>    * them available.
>>    */
>>   #define arch_cmpxchg_local(ptr, o, n)                                         \
>> -       ((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
>> +       ((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),        \
>>                          (unsigned long)(n), sizeof(*(ptr))))
>>   #define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
>>   #define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
>> --
>> 2.40.1
>>
> 
> 

