Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712877542E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHIHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHIHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:32:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525C1BE1;
        Wed,  9 Aug 2023 00:32:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLMFR2skRz4f3lfG;
        Wed,  9 Aug 2023 15:31:55 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP4 (Coremail) with SMTP id gCh0CgBXNKfqQNNkPrAmAQ--.25321S2;
        Wed, 09 Aug 2023 15:31:56 +0800 (CST)
Message-ID: <3497b8d9-4fb2-24af-aea2-09cd2c5fc6db@huaweicloud.com>
Date:   Wed, 9 Aug 2023 15:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
 <ZNJuMoe37L02TP20@work> <5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBXNKfqQNNkPrAmAQ--.25321S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xCw18tw1fArW5ury7Awb_yoW5Jry3pF
        1qk3Wakr48JayYgw1xXwnYyr4F934qgF13JrW3G34rGryvqFy7G39YkryY9a4kJwn8uF48
        AF1YgrWagFWDJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/08/09 6:53, Kees Cook wrote:
> 
> [...]
>>>
>>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
>>> index a494cf43a755..b0caad82b693 100644
>>> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
>>> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
>>> @@ -182,12 +182,14 @@ struct ebt_entry {
>>>  	unsigned char sourcemsk[ETH_ALEN];
>>>  	unsigned char destmac[ETH_ALEN];
>>>  	unsigned char destmsk[ETH_ALEN];
>>> -	/* sizeof ebt_entry + matches */
>>> -	unsigned int watchers_offset;
>>> -	/* sizeof ebt_entry + matches + watchers */
>>> -	unsigned int target_offset;
>>> -	/* sizeof ebt_entry + matches + watchers + target */
>>> -	unsigned int next_offset;
>>> +	__struct_group(/* no tag */, offsets, /* no attrs */,
>>> +		/* sizeof ebt_entry + matches */
>>> +		unsigned int watchers_offset;
>>> +		/* sizeof ebt_entry + matches + watchers */
>>> +		unsigned int target_offset;
>>> +		/* sizeof ebt_entry + matches + watchers + target */
>>> +		unsigned int next_offset;
>>> +	);
>>>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> 
> While we're here, can we drop this [0] in favor of []?
> 
> -Kees
> 

There are still quite a lot of zero-element array in
include/uapi/linux/netfilter_bridge/ebtables.h. I will submit another
patch to change them altogether.

>>>  };
>>>  
>>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>>> index 757ec46fc45a..5ec66b1ebb64 100644
>>> --- a/net/bridge/netfilter/ebtables.c
>>> +++ b/net/bridge/netfilter/ebtables.c
>>> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
>>>  		return ret;
>>>  
>>>  	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
>>> -	memcpy(&offsets[1], &entry->watchers_offset,
>>> -			sizeof(offsets) - sizeof(offsets[0]));
>>> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
>> 							^^^^^^^^^^^^
>> You now can replace this ____________________________________|
>> with just `sizeof(entry->offsets)`
>>
>> With that change you can add my
>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>> Thank you
>> --
>> Gustavo
>>
>>>  
>>>  	if (state->buf_kern_start) {
>>>  		buf_start = state->buf_kern_start + state->buf_kern_offset;
>>> -- 
>>> 2.41.0
>>>
> 
> 

