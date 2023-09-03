Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192F4790AD7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 07:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjICEzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 00:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjICEzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 00:55:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D280CC5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 21:55:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso3193235ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 21:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693716904; x=1694321704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+U5CPjOKyPGHDpwnXP0B3NDICrZc2hSQHMD9gvWWzQ=;
        b=KEpqyDuSD13aFfriIa6Gh0EZ18ZuWmrF41R2zOE8WBE+FTwcBfvFcb3FJQcm4wVknZ
         KYuAvyedxxv1z8wIF8CjSB7GCMTCuT9JCp0DGb2sahR+4hVi3VHaAOKM+YJ7HE2VWLuQ
         kp0yeab6pN8yej7irYjltklWWPRfKDWu7L2peIzP874AVo4+jxxsHL93wW1Z0A4+lJgi
         1MssAmhjlzmq4ZCDOe5yxBXC0LWF/JtW5SA4TVo/DFisna7MKywq/qSnlnHs9X1x/iJ7
         uh0gGJ9W2VpB+ZZnINIxSl5vdDHL4WQTXmNK74dtgy6IpipezGtbq00+zlV/3v9X1d4M
         hhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693716904; x=1694321704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+U5CPjOKyPGHDpwnXP0B3NDICrZc2hSQHMD9gvWWzQ=;
        b=aRnGOdRSy/e0GGrjBI20MDbS1F1xP2O/oqUqL1rq5mLb1cf69j5niyQzxWOL3DvqUC
         pfYVDMnScxVlI5K5aK80K/b5GpztVsq1SnkNFy8JLNmn73R1384SblZOCXIJ+Qu2RQRF
         mfcR4Nc3yU1MVcD9lnVOR4Qex+vpwfI1OJ83yFXhzNT3MWDD4Bxiiwi8DolV+vprf2rq
         vu1owPxiq5B+sx6DbmDXZkh5/z4iohFSw2x20sFOEPVP93pNdYnVFUReTq7hmOSyKeCJ
         bALkkca4IOVBTn9lJ4sn2j+56B+miT8LKGr8YjxUHPHTq5fYHJIXUleLQDBSrLvMzhyA
         Oe1w==
X-Gm-Message-State: AOJu0YzoYYlu6VGD/WvcIXpShpb5U1IpBRp63ZZNtZhovwCgFHtiv0u6
        rpk3vfP0PE+XqAn/9hY/l2OAdQ==
X-Google-Smtp-Source: AGHT+IEZm84G9mzAoT4L/Z2t61RZFgqR47NnzrcVfwzvXzIuo/vipgN26tmwI1A7WWb/kkbrm2Z/rg==
X-Received: by 2002:a17:902:ef93:b0:1c1:dbd6:9bf6 with SMTP id iz19-20020a170902ef9300b001c1dbd69bf6mr5878849plb.41.1693716904671;
        Sat, 02 Sep 2023 21:55:04 -0700 (PDT)
Received: from [10.254.83.51] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001bc2831e1a9sm5301651plb.90.2023.09.02.21.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 21:55:04 -0700 (PDT)
Message-ID: <229c6f8d-b89b-1b85-8408-089c4cdf32a9@bytedance.com>
Date:   Sun, 3 Sep 2023 12:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware
 sockets under pressure
To:     Simon Horman <horms@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com>
 <20230901135932.GH140739@kernel.org>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230901135932.GH140739@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon, thanks for reviewing!

On 9/1/23 9:59 PM, Simon Horman wrote:
> On Fri, Sep 01, 2023 at 02:21:28PM +0800, Abel Wu wrote:
>> @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   	if (sk_has_memory_pressure(sk)) {
>>   		u64 alloc;
>>   
>> -		if (!sk_under_memory_pressure(sk))
>> +		/* Be more conservative if the socket's memcg (or its
>> +		 * parents) is under reclaim pressure, try to possibly
>> +		 * avoid further memstall.
>> +		 */
>> +		if (under_memcg_pressure)
>> +			goto suppress_allocation;
>> +
>> +		if (!sk_under_global_memory_pressure(sk))
>>   			return 1;
>> +
>> +		/* Trying to be fair among all the sockets of same
>> +		 * protocal under global memory pressure, by allowing
> 
> nit: checkpatch.pl --codespell says, protocal -> protocol

Will fix in next version.

Thanks,
	Abel

> 
>> +		 * the ones that under average usage to raise.
>> +		 */
>>   		alloc = sk_sockets_allocated_read_positive(sk);
>>   		if (sk_prot_mem_limits(sk, 2) > alloc *
>>   		    sk_mem_pages(sk->sk_wmem_queued +
>> -- 
>> 2.37.3
>>
>>
