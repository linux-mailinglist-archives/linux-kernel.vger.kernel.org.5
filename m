Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15134807F01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443092AbjLGC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjLGC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:59:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7956D62
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:59:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so173747b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 18:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701917987; x=1702522787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmFTswpdUJE2rTRRw/ViFE7rnEIJVMFOJnLGTDou500=;
        b=WTqr+Fq4U++vP3QVTIWvyPgQllBcgcZK6oJ2/KknbZJumYOQysogp+WoMIpDtP2ehP
         KHTturc8h4ecu0tJ30BEFet5QGpvN6gjvrV32dbp2i0/fYHrR39KYHKr4SKWwdh9qdZj
         a1WcmY0KvLP8cmSL0RG7ZTkr0Dkv47/ySBJKywPXn1YtrgHDFIQ1Kt1tEkh9gAiU1E7P
         4g16dDkUkYHknerDTYchSJDZclGdvoBndiuNIqfq4/7HCfQDOum4D4g6KPozPhAldubD
         nVrSWYuwuQUQG7P5qFG/bvRKETNUtztPIgc6ouzUoBKCQYkNkoG3j1/x6oyrauBhXhqG
         R57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701917987; x=1702522787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmFTswpdUJE2rTRRw/ViFE7rnEIJVMFOJnLGTDou500=;
        b=MEg19PJZ0HRJ4jJe2XwpqNtcLy+5w2TNVa8RMSvKUhqx9CmapajTVcpk5FdOuREwu3
         3l5aN0C5hsBP6pui/NlrcTuZJYEd1J/FkaurMB0Es2P5rgzfBRvBwXXeP1Z1/teBOD1a
         a58e6vdLNmvyRBq56de2Iy+CkGDUclVBQtnF1eo66Ih6ytTHWrYRcShoat7UoEjpW59P
         dD3VyW4t0oNrhK2/rJxPSDdEW+yhKzwu/YsFruwzyci8JClwvt6P6i1IzKY4snTr6Hsq
         jToW/fLmfHvthfHCA9MJ/lCeUlZY9ZfKbXEkf/IHDVriTXAOmpD0+e+IEGHBoh8KYZQb
         q6EA==
X-Gm-Message-State: AOJu0YwRU22UdKNzCgkxRfsoPDjRgOK1JD/ws7Y2voRoK1Ni2H/lV5Lq
        YsBSReZMUpT0rGmduXVG/cY6g+hQ07g41OMzqco=
X-Google-Smtp-Source: AGHT+IF6coN8MfaVzFORuZNxRFOU6lZR6fn17FZb5urBAAU3XzsEYfnAlXJ92fzrZudE1pF+8aj9kg==
X-Received: by 2002:a05:6a20:4b03:b0:18f:c42c:d735 with SMTP id fp3-20020a056a204b0300b0018fc42cd735mr2065531pzb.99.1701917987375;
        Wed, 06 Dec 2023 18:59:47 -0800 (PST)
Received: from [10.254.104.27] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a005a00b00286be9fb3fdsm154565pjb.40.2023.12.06.18.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 18:59:46 -0800 (PST)
Message-ID: <4b864565-faeb-4814-a803-66a1e54e8ae1@bytedance.com>
Date:   Thu, 7 Dec 2023 10:59:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] mm/zswap: change dstmem size to one page
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <20231206-zswap-lock-optimize-v1-4-e25b059f9c3a@bytedance.com>
 <CAKEwX=M3iYV--kn+TEhLytijAOPH0_077KzvuGBE3+2r7AcW7Q@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=M3iYV--kn+TEhLytijAOPH0_077KzvuGBE3+2r7AcW7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/7 01:12, Nhat Pham wrote:
> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Maybe I missed something, but the dstmem size of 2 * PAGE_SIZE is
>> very confusing, since we only need at most one page when compress,
>> and the "dlen" is also PAGE_SIZE in acomp_request_set_params().
>>
>> So change it to one page, and fix the comments.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index d93a7b58b5af..999671dcb469 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -699,7 +699,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
>>         struct mutex *mutex;
>>         u8 *dst;
>>
>> -       dst = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
>> +       dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
>>         if (!dst)
>>                 return -ENOMEM;
>>
>> @@ -1649,8 +1649,7 @@ bool zswap_store(struct folio *folio)
>>         sg_init_table(&input, 1);
>>         sg_set_page(&input, page, PAGE_SIZE, 0);
>>
>> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
>> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
>> +       sg_init_one(&output, dst, PAGE_SIZE);
> 
> Hmm. This is very weird. It looks very intentional though, so perhaps
> we should consult the maintainer or the original author of this logic
> to double check this?

Yes, it's also weird to me. But it seems to be 2 pages when the zswap code
merged in mm 10 years ago. Hope the maintainer or author could shed some
light on it. :)

> My best guess is for cases where the compression algorithm fails - i.e
> the output (header + payload) is somehow bigger than the original
> data. But not sure if this happens at all, and if the size > PAGE_SIZE
> we don't wanna store the output in zswap anyway.
> 

Agree, so I think one page is enough.

>>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);

And here we just use PAGE_SIZE in the parameter actually.

Thanks!

>>         /*
>>          * it maybe looks a little bit silly that we send an asynchronous request,
>>
>> --
>> b4 0.10.1
