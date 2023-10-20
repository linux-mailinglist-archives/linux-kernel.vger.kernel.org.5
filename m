Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67037D0B31
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376587AbjJTJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376486AbjJTJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:10:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51817B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:10:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d27026dc2so185230a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697793057; x=1698397857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN7Q1zYFQ38fsmyHzWO7ZIp4Ig9tT/jzwkcQr0Xqj8A=;
        b=KQ0ND3rQSf+LbXrATInKhy6VJZckgzePpd9vAWSaRYIwTyJSqe3BBY4QBFDsSAevc8
         LXYmgZIKYxSzlkINw0RRkMLx9tFt2IwvTEWidZfG32EiEnTQRr2SC49rq3fEEgrCp+rx
         w8rnWi1WsI7+QYWSnF/YokEbqj72RwQ7YPOkMVPxpPkBZ2FtjwoY6RgiMq7IH9c1mw8y
         6KJGPvWPTNqV0cV6CJiJV8xB0RCk1aGKV1KeJRv8+q+aLfXWS6i6ERWK9q8mXDbklv0X
         zQpjoTG1aUwetMuFeNpI5SL2w6u/+BLccOs+egKFSyZxC7lqnAYU+czpJrSePLYw/v++
         iC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793057; x=1698397857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN7Q1zYFQ38fsmyHzWO7ZIp4Ig9tT/jzwkcQr0Xqj8A=;
        b=SqM/UQqEtbGV96f+fPF4CoNd+5WQAlfyF/gnnMZDXriDrzk6ezf2OS5FjhW9Zex8fd
         83yG3maHUEpkn2XE77f6Bgc1qkTGM1t8l8olx1gryJ+tHH1dyB2J/IFUEOmtxLnRu296
         YhKAK2FsrXBGJMkNwG8+9OE+onl23nwOTtvE7lfzgTd4vCH7cSGk6Fc5IPJlKLT7x+9E
         Cn7m4qi0A9dgxEknDn6kzzzKocbQru+bZVZJB8qFytRtYlXnrLaJmXSgrvbkBymMcc9X
         hCc8DZyrDdR6S2+NEurCJEDGK8BGj1VFELqDqFz82pNA86OrGhxJJPETSm8HbxsXLMqK
         J52w==
X-Gm-Message-State: AOJu0YybV2jwIVyc2dD7SfIScDyVbCMu02FygG1nd4lKMD4Ije+/V784
        EVO0tulIOlBG3Kw8ayLEZDJwYuSdBKg9CJiN1Qg=
X-Google-Smtp-Source: AGHT+IGgvXJpSJTwUwNN0JjroPfPACz+tVg9jcFQshq7UW1iCYKGpv04e2bFohPpD7QhZs10xuq4pg==
X-Received: by 2002:a17:902:cacc:b0:1ca:8e79:53ae with SMTP id y12-20020a170902cacc00b001ca8e7953aemr1271809pld.1.1697793056844;
        Fri, 20 Oct 2023 02:10:56 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001b9dab0397bsm1061293plb.29.2023.10.20.02.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:10:56 -0700 (PDT)
Message-ID: <706c6df4-4bd1-de52-f04f-8127d243bb89@bytedance.com>
Date:   Fri, 20 Oct 2023 17:10:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        ying.huang@intel.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <9f1dbe7ee1301c7163b2770e32954ff5e3ecf2c4.1697711415.git.zhengqi.arch@bytedance.com>
 <ZTI7DRNdObvSZXFG@gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZTI7DRNdObvSZXFG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 2023/10/20 16:32, Ingo Molnar wrote:
> 
> * Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> In offline_pages(), if a node becomes memoryless, we
>> will clear its N_MEMORY state by calling node_states_clear_node().
>> But we do this after rebuilding the zonelists by calling
>> build_all_zonelists(), which will cause this memoryless node to
>> still be in the fallback list of other nodes. This will incur
>> some runtime overhead.
>>
>> To drop memoryless node from fallback lists in this case, just
>> call node_states_clear_node() before calling build_all_zonelists().
> 
> s/memoryless node
>   /memoryless nodes

Will do.

> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory_hotplug.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index d4a364fdaf8f..f019f7d6272c 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -2036,12 +2036,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>   	/* reinitialise watermarks and update pcp limits */
>>   	init_per_zone_wmark_min();
>>   
>> +	/*
>> +	 * Make sure to mark the node as memory-less before rebuilding the zone
>> +	 * list. Otherwise this node would still appear in the fallback lists.
>> +	 */
>> +	node_states_clear_node(node, &arg);
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks.

> 
> Thanks,
> 
> 	Ingo
