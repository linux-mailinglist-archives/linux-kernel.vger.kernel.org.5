Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C67775159
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHIDZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHIDZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:25:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0721BF1;
        Tue,  8 Aug 2023 20:25:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLFnN5LKmz4f3wQh;
        Wed,  9 Aug 2023 11:25:44 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP1 (Coremail) with SMTP id cCh0CgA3sy84B9NkGt0JAQ--.33760S2;
        Wed, 09 Aug 2023 11:25:45 +0800 (CST)
Message-ID: <b78cdc3b-8e08-6c75-de8e-15946789056f@huaweicloud.com>
Date:   Wed, 9 Aug 2023 11:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
 <ZNJuMoe37L02TP20@work>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <ZNJuMoe37L02TP20@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgA3sy84B9NkGt0JAQ--.33760S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr15Gr4rAw48Gw1kuFyxGrg_yoWkJrX_Aw
        srZr97GrWjya4Dtr45J39xXrn3XwnYvFy7WryIqrW8ZwnxJr1jk39rXr9Yvw1rJryxCr4U
        ArZ3GF98Gw1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
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


On 2023/08/09 0:32, Gustavo A. R. Silva wrote:
>
> [...]
>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>> index 757ec46fc45a..5ec66b1ebb64 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
>>  		return ret;
>>  
>>  	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
>> -	memcpy(&offsets[1], &entry->watchers_offset,
>> -			sizeof(offsets) - sizeof(offsets[0]));
>> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
> 							^^^^^^^^^^^^
> You now can replace this ____________________________________|
> with just `sizeof(entry->offsets)`
> 
> With that change you can add my
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thank you
> --
> Gustavo
> 

Will do. Thanks for the suggestion & review!

>>  
>>  	if (state->buf_kern_start) {
>>  		buf_start = state->buf_kern_start + state->buf_kern_offset;
>> -- 
>> 2.41.0
>>

