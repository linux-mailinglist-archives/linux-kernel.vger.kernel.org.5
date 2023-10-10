Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790447C4296
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJJVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJJVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:30:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2694
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:30:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50325ce89e9so8082299e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696973453; x=1697578253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAzEF//inGIlBzVkhdKzvV8vXPjIfYVoMCRuS+tUjs4=;
        b=lUONqf/4QML3uGmmp9dbJsY6Uvy2kNIDSYSwUdzF8Ic/aU9WYLimI4DwC7Nsk9onfL
         JvRIqcjDTPcf2xhJu6R4SBhgO98imNPuzHzsGZBO+jU62hcfQBGnbS5aZ0xK3eGDknyA
         4o0LQnr9F+R61Pkbahi/n6sM96hRYgVGeMbTWqX7deiNyWjDNFvk42oQu+D3BTb/q8K9
         EssQvJmSSUhl881zcLyPmI8jK7ZYr43EVdr+67hhGlDlzR06tw1j+4cTIwvCiYFLgM4+
         kD5J9xUj3U67Au5HckF45oCOn4cUotlOScV2faLRFF/Pxtfk+N/hR9x33tKV0NTK+aOG
         H3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973453; x=1697578253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAzEF//inGIlBzVkhdKzvV8vXPjIfYVoMCRuS+tUjs4=;
        b=RAQ/Vd4CakBhHCD1BKBkW59YbarctnOJme4VdnssYILuBvJ3fOn9ODmjvfLQBkcXQ+
         pACc/QceW++ILfhF9YshNTMIsrBLS7QTsSB9CqXgdw5EB8lBbwHGHQUTNPhn+PYwG3Yx
         0BRIcsrSlxrnFsbeR3oL/YiJPu2MGteEyHbEa2mVigaHNPR16BgbLm6gIhLhnVmp/zwO
         LAsrajufGfVN86JFMOEj6s9FGKcKPA6lTK59IiEyFn/kMVHCMt9Y+6zOnMG60vt8MIK0
         uiFmRBZktKsk32JfkR1Si0PdJ2L6w+yXJjN1jnlcbiv3+5pOdXRnidGBWhYbhj2G7Vwx
         YkMg==
X-Gm-Message-State: AOJu0Yy0XIv8LeU0I9gsYkUqn2YICZR1VFI8AdrL9ICdcUahStwgpWdX
        vvcksmYlt6hu9A7tqbts9ZFg+Q==
X-Google-Smtp-Source: AGHT+IFTY/0B23Zg3tIff5RJggPM3l2BE+B8+vD1QXu89uCUprr/UmDyd2G08W2A3RkJAx4EWwPiCw==
X-Received: by 2002:a05:6512:2511:b0:503:258f:fd1b with SMTP id be17-20020a056512251100b00503258ffd1bmr18608220lfb.18.1696973453606;
        Tue, 10 Oct 2023 14:30:53 -0700 (PDT)
Received: from ?IPV6:2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884? ([2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fa8000000b0050482b29ac9sm1965533lfe.212.2023.10.10.14.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 14:30:53 -0700 (PDT)
Message-ID: <6f381d4c-d908-4f00-89b3-ed3bcb26b143@linaro.org>
Date:   Tue, 10 Oct 2023 23:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey> <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey> <20231009151513.GB3846@monkey>
 <20231009170710.b52f5a6e57c23d5caecce8ab@linux-foundation.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231009170710.b52f5a6e57c23d5caecce8ab@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 02:07, Andrew Morton wrote:
> On Mon, 9 Oct 2023 08:15:13 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>>> This should also be empty and a noop.
>>>
>>> Is it possible that the misaligned kernel image could make these lists
>>> appear as non-empty?
>>
>> Actually, just saw this:
>>
>> https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
>>
>> Will take a look, although as mentioned above prep_and_add_bootmem_folios on
>> an empty list should be a noop.
> 
> Konrad, are you able to test Usama's patch?  Thanks.
I legitimately spent a sad amount of time trying to regain access to the 
remote board farm. Previously I could hit the bug on SM8550, but now I 
can't do it on SM8450, SM8350 and SM8250 (previous gens), with the same 
config.. I have no idea when I'll be able to get access to SM8550 again.

I did test it on the QCM6490 Fairphone 5 that I initially reported this 
on, and neither booting next-20231010 (with your patchset applied) nor 
adding the below patch on top of it seems to work. I can't get serial 
output from this device though to find out what it's unhappy about :/

Konrad
