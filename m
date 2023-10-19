Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208307CF26E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjJSIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbjJSIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:23:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361ACD62
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:22:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so1267328b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697703765; x=1698308565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBEy7gSiU0+0c7M+OZvJ3yKqLBUnItq/dYHJApdvQlI=;
        b=ju7fEpr4zh1i6vrKnn15l3SF2zpbdNWvEkzQ8tOKY2AsE3FFMVdjtTAjmst/yMwPqH
         y1aGOshPJoEgBjO2DxLORwfP40H2i/SLKXr9qNyTWaEcYFMCxlnVX0z6RvVs+MQTtyUH
         febLxnQ37Z65IkFUssNl+R25Zs/7Yz1+56t4FIXq1dkXAq6EdfmE1j0SRW3wU9Mgv7nu
         WUV7hmICPwPm7YFGLU5JTbqxlf4STsbeKxtDfQV9+psnjdg1WJexm/hP2Im60sSqP4aM
         WbInvqjCWkdKMA38AZWOOmPVf1cxsSeEEfv8cZO4g88TtGFC/9V8CR0hgNVbFq34dbaz
         B0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703765; x=1698308565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBEy7gSiU0+0c7M+OZvJ3yKqLBUnItq/dYHJApdvQlI=;
        b=aJLOjzyVGqalmaPhwguGw1K7hTvkmYLBsOu73VrDvfqm7mERLRgAKNbVrgijSJ931g
         3sP70UBbzgCI1fRaPoXWj2p96IYoWF0Z8QLHPDKuajn1Wd6rLqUQ9c3MS8HL/NgUTbn5
         Rc5gunXKdP8a76cDZBPAzOr/EecFfRvLw9v+Rj39NTKxglmE1yMIcyYSZwr55tSq3qS6
         Uyzt+YurZP2F/CQu3Q2DNMffRn0sXjUiHAWGpvxi6uztgM5YmrH20SLe6U6fev8U9Gx9
         QSFVDGNvkZz9O2TuTJtfULKgCy5mnKUq6DPOaJXanAYGM8EeLU+g3uSqO+0NtrHbTeHP
         er+g==
X-Gm-Message-State: AOJu0YzCuKwdapqUBnsKVIswNsZloW9CF0aj8EAcdwAhZDo3WL3DozrF
        YycGJFiTCRiV65IHINCd90kOAw==
X-Google-Smtp-Source: AGHT+IHuxck6QYzmYBG0Z5btMfAfwn4hXk/uf/qqfa0rPXVaCvcAbnFSQ2es0Qi1eZOcw5JtbzK0Ow==
X-Received: by 2002:a05:6a20:93a6:b0:17a:d292:25d1 with SMTP id x38-20020a056a2093a600b0017ad29225d1mr1528798pzh.6.1697703765600;
        Thu, 19 Oct 2023 01:22:45 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001c5fc11c085sm1282027plc.264.2023.10.19.01.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 01:22:45 -0700 (PDT)
Message-ID: <b7bca04e-0665-f80a-94b6-b8d857edfce1@bytedance.com>
Date:   Thu, 19 Oct 2023 16:22:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: drop memoryless node from
 fallback lists
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, vbabka@suse.cz,
        mhocko@suse.com, willy@infradead.org, mgorman@techsingularity.net,
        mingo@kernel.org, aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1697687357.git.zhengqi.arch@bytedance.com>
 <32c12381941f347ebafb9cb5bc9f0a4a535ff646.1697687357.git.zhengqi.arch@bytedance.com>
 <66e16a28-2d04-4b2c-88a8-692edf587f02@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <66e16a28-2d04-4b2c-88a8-692edf587f02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023/10/19 16:11, David Hildenbrand wrote:
> On 19.10.23 09:36, Qi Zheng wrote:
>> In offline_pages(), if a node becomes memoryless, we
>> will clear its N_MEMORY state by calling node_states_clear_node().
>> But we do this after rebuilding the zonelists by calling
>> build_all_zonelists(), which will cause this memoryless node to
>> still be in the fallback list of other nodes. This will incur
>> some runtime overhead.
>>
>> To drop memoryless node from fallback lists in this case, just
>> call node_states_clear_node() before calling build_all_zonelists().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory_hotplug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index d4a364fdaf8f..18af399627f0 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -2036,12 +2036,12 @@ int __ref offline_pages(unsigned long 
>> start_pfn, unsigned long nr_pages,
>>       /* reinitialise watermarks and update pcp limits */
>>       init_per_zone_wmark_min();
>> +    node_states_clear_node(node, &arg);
>>       if (!populated_zone(zone)) {
>>           zone_pcp_reset(zone);
>>           build_all_zonelists(NULL);
>>       }
>> -    node_states_clear_node(node, &arg);
>>       if (arg.status_change_nid >= 0) {
>>           kcompactd_stop(node);
>>           kswapd_stop(node);
> 
> Probably worth a comment.
> 
> /*
>   * Make sure to mark the node as memory-less before rebuilding the zone
>   * list. Otherwise this node would still appear in the fallback lists.
>   */

OK, will add it in the v3.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

> 
