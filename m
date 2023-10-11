Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51287C4F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJKJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJKJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:36:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BC99D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:36:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso4157885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697016967; x=1697621767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iy3XKYHuwy+ceJmp/ioJKl+KTznxwRVeCCbyOJ3Sxxw=;
        b=H240cv2Ux9EJD8Kx+l0q6ehE9vqeRYvK1YrHZbgiztQErZetf1QjJ9sfJe4A1FBJGW
         NqhIpw1AevOaXzwMj7AL6Te3+3R1FfXzFt+97LSu802hqZhaGA0zfXnz/AK8/5iw6/H8
         A/jYPora/VWi+lOHQcGVXddRGgF/P8vRkvxqO6u2XO0M/xtU1kWBI4HbEuMD46ty6jjE
         TdQnMoTcXd0Qzxjiuo4+qt5gr3h24UtVf3+1ltP/0EnSat2TqJWtwQ8+rpZaXxvP0P4m
         no9yI16WPK8eSmMb/xFxQ+9L/ARJCKSWb+oAZ9LI9q575NicGkMK8Qqz0FrJxISMg5WY
         YaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016967; x=1697621767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy3XKYHuwy+ceJmp/ioJKl+KTznxwRVeCCbyOJ3Sxxw=;
        b=KaFPvZ5cKwKhbecE16rlnutHSsCrF+ZoTtDrnbf5Umz1x1vnQ0Rx54ah1V76WR81x4
         ycTaFwD9Nk40pyfUAnrHboI6Xqv3QKfZMs79B+uUADCDS5tFm7+i7tp8uMYR1VdRjZLw
         JCCXB/muanQakmPzSowEyt9Hh3qSUP4uVfGbkeMB8ADXWMrN3ZbrE0N7bkkXKdBYUH3s
         ufyiEc+p8232fGM9vixKQ7b5XRaoBIFYbZavnn1D44r0jA4M4IuBZ2S0MPa4yDQO+zXn
         Tz/8lnAJ93zaCbzHgKmIv2RbQv/z/Nv/1QaXE+KIDGaHB7er+90XesZANX0fMt5r9kAi
         lHZg==
X-Gm-Message-State: AOJu0Yw+h0HkFZdjz7czIpBd0wNZ7fKtohkx2RT/OOUbJ9Tl1Q/jw7DF
        53RZOks6JWrwcZOKGErm9uYhJ1I0Zk7pLxRoRZY=
X-Google-Smtp-Source: AGHT+IHd7KH3Sp3F80DRbyiSWarxbMqSKkR+9jJcoPpq9fyPdrSif8sxEN25goGim1sZLy+QHEKSUg==
X-Received: by 2002:adf:f984:0:b0:314:314e:fdda with SMTP id f4-20020adff984000000b00314314efddamr15842477wrr.23.1697016967381;
        Wed, 11 Oct 2023 02:36:07 -0700 (PDT)
Received: from [172.30.204.44] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003fbe791a0e8sm16376359wml.0.2023.10.11.02.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:36:06 -0700 (PDT)
Message-ID: <67b34aed-6e0f-400f-a150-1969c5478f4b@linaro.org>
Date:   Wed, 11 Oct 2023 11:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Usama Arif <usama.arif@bytedance.com>
References: <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey> <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey> <20231009151513.GB3846@monkey>
 <20231009170710.b52f5a6e57c23d5caecce8ab@linux-foundation.org>
 <6f381d4c-d908-4f00-89b3-ed3bcb26b143@linaro.org>
 <20231010214533.GC279095@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231010214533.GC279095@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 23:45, Mike Kravetz wrote:
> On 10/10/23 23:30, Konrad Dybcio wrote:
>>
>>
>> On 10/10/23 02:07, Andrew Morton wrote:
>>> On Mon, 9 Oct 2023 08:15:13 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>>>> This should also be empty and a noop.
>>>>>
>>>>> Is it possible that the misaligned kernel image could make these lists
>>>>> appear as non-empty?
>>>>
>>>> Actually, just saw this:
>>>>
>>>> https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
>>>>
>>>> Will take a look, although as mentioned above prep_and_add_bootmem_folios on
>>>> an empty list should be a noop.
>>>
>>> Konrad, are you able to test Usama's patch?  Thanks.
>> I legitimately spent a sad amount of time trying to regain access to the
>> remote board farm. Previously I could hit the bug on SM8550, but now I can't
>> do it on SM8450, SM8350 and SM8250 (previous gens), with the same config.. I
>> have no idea when I'll be able to get access to SM8550 again.
>>
>> I did test it on the QCM6490 Fairphone 5 that I initially reported this on,
>> and neither booting next-20231010 (with your patchset applied) nor adding
>> the below patch on top of it seems to work. I can't get serial output from
>> this device though to find out what it's unhappy about :/
> 
> Sorry for causing you to spend so much time on this.
No worries, that was my explanation for why it took me so long to 
respond again..

> 
> As mentioned in the reply to Usama's patch, the root cause seems to be
> the locking.  So, the real change to test is the locking changes in
> that thread; not Usama's patch.
Ack

Konrad
