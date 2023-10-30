Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313B7DB1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjJ3B5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3B5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:57:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A7C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c434c33ec0so28324355ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698631042; x=1699235842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xif9jDPurtABn3HmPh5sIxcHhWec17MHw8DajCplY0A=;
        b=D28F8iOiKRffHEkDGxvc967AMbxu8gWhW9phwcrmsJ4/v4C8d3r26nhr4+dzqCFLpY
         C38uOE1gC4kwWerQWwNw+taL2+MYBOOJgtNcm329w+3bvYLjfx1YETIJusi9e49OBVjF
         n0PuS5nXcU1gnqyF0urja3HeMZ6QHGZb6fSsqLkRKTdBDh4KIzfwlkXhg/2dLh3TGQBa
         YTAlwb0lKOrCBrSpkrSSjZ4mDykAeJXA1TZs4o475iUcosUdebl7KhvuRjyWDwHAsble
         LsMRX0cO1olrWMa+wsuZDWpVi30dVMBTwMrVTQRSz/US9BjAMhuzijLS7HI/cEQj5lCv
         BCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698631042; x=1699235842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xif9jDPurtABn3HmPh5sIxcHhWec17MHw8DajCplY0A=;
        b=HPLkio8JPBgNmgIDj7XEtaAUZymH62LY3iuXLgJOQf1OScN6/fPI6aqEN0pAPicnUu
         sM+3oZFGrtAFN+4eM4exrjm4z9NlRjW/d9u81DuGlmiDC1Ofoz6580SVtXcNy6qwCBI+
         Mxk4407/IBr7m9yz1KDHTnNTAJ80zBvjh+UXRaD6Ed7tdIqOQcae3YE84lFX34VdWVhf
         Zh9o3sqG3/cs1YKe6mMY2gfj999ANKXagxnmUU6xnhyc/5jpLSPh8Bn8YjlCScsfLr2I
         ZyUkWhLfj2LnjUkETBM+ZNkFPl3bWyEpe6VlO7s/YZCVZNw1rdYN7a5cMSRuCaD6iCID
         dbqw==
X-Gm-Message-State: AOJu0YxXdN/kG7xr4SYeitThz6OoaaubDXeW2m4dD+MnVp63F829chyI
        wTirS5n7mlfzfuWZeIeN2WJXxg==
X-Google-Smtp-Source: AGHT+IFDRz4WnbsPgSxMMAXHuMvgLNb0gqV8+5oze1PDalgoZIBtZswTC95vR83MTlruakctGmi/tg==
X-Received: by 2002:a17:90a:b004:b0:280:4f82:68ac with SMTP id x4-20020a17090ab00400b002804f8268acmr794061pjq.24.1698631042181;
        Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a1a0a00b0027909a8994fsm7169127pjk.13.2023.10.29.18.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 18:57:21 -0700 (PDT)
Message-ID: <59bf8835-6d07-4336-aa95-d39928dd43ab@bytedance.com>
Date:   Mon, 30 Oct 2023 09:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
 <b579d68f-f2ec-42ef-8366-6878c9930e0c@roeck-us.net>
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <b579d68f-f2ec-42ef-8366-6878c9930e0c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/30 01:05, Guenter Roeck wrote:
> On Mon, Oct 23, 2023 at 07:24:52PM +0800, wuqiang.matt wrote:
>> The objpool_push can only happen on local cpu node, so only the local
>> cpu can touch slot->tail and slot->last, which ensures the correctness
>> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
>> of try_cmpxchg_acquire).
>>
>> Testing with IACA found the lock version of pop/push pair costs 16.46
>> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
>> is improved to 1.019 times of the lock version for x86_64 systems.
>>
>> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
>> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
>>
>>                   1T         2T         4T         8T        16T
>>    lock:    29909085   59865637  119692073  239750369  478005250
>>    local:   30297523   60532376  121147338  242598499  484620355
>>                  32T        48T        64T        96T       128T
>>    lock:   957553042 1435814086 1680872925 2043126796 2165424198
>>    local:  968526317 1454991286 1861053557 2059530343 2171732306
>>
>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> 
> This patch results in
> 
> lib/objpool.c:169:12: error: implicit declaration of function 'arch_cmpxchg_local' is invalid in C99
> 
> or
> 
> lib/objpool.c: In function 'objpool_try_add_slot':
> include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'


This patch was already reverted from probes/for-next by Masami Hiramatsu.
Then we will rework it after the arch_cmpxchg_local issue is resolved.

> for various architectures (I have seen it with arc, hexagon, and openrisc
> so far).
> 
> As usual, my apologies for the noise if this has already been reported
> and/or fixed.

We are working on it and the fix is in discussion.

> Guenter

Regards,
wuqiang
