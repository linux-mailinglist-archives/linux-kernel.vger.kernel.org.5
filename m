Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475697803E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357279AbjHRCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357241AbjHRCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:39:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5E273C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:39:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRmKR1MVCz4f3jZf
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:39:07 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP2 (Coremail) with SMTP id Syh0CgCnFmvK2d5k_CjeAw--.56340S2;
        Fri, 18 Aug 2023 10:39:07 +0800 (CST)
Message-ID: <953b0290-a703-2bd8-179b-01442f736768@huaweicloud.com>
Date:   Fri, 18 Aug 2023 10:39:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] lkdtm: use the return value of strim()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
References: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
 <202308170954.B18CCA9@keescook>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <202308170954.B18CCA9@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCnFmvK2d5k_CjeAw--.56340S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47KF15KFyfGFyxAr17GFg_yoW8Aw18pF
        WkXayUCF4UZrWDCFn2qa4qgry0q397trWxWrWUt34rZF9xArW8KF17W3yjgr97Zr48trWY
        kw1Ygr95uws8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/08/18 0:55, Kees Cook wrote:
> On Thu, Aug 17, 2023 at 10:21:17PM +0800, GONG, Ruiqi wrote:
>> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>>
>> Make use of the return value of strim() to achieve left-trim as well as
>> right-trim, which prevents the following unusual fail case:
>>
>>  # echo " EXCEPTION" > /sys/kernel/debug/provoke-crash/DIRECT
>>  sh: write error: Invalid argument
>>
>> Link: https://github.com/KSPP/linux/issues/337
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>  drivers/misc/lkdtm/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
>> index 0772e4a4757e..812c96461ab2 100644
>> --- a/drivers/misc/lkdtm/core.c
>> +++ b/drivers/misc/lkdtm/core.c
>> @@ -242,7 +242,7 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
>>  	}
>>  	/* NULL-terminate and remove enter */
>>  	buf[count] = '\0';
>> -	strim(buf);
>> +	buf = strim(buf);
>>  
>>  	crashtype = find_crashtype(buf);
>>  	free_page((unsigned long)buf);
> 
> Will free_page() still work in this case, though? The address won't
> match the allocation any more...

Yes I noticed that, but I was under the impression that it's fine to do
free_page(paddr + offset_in_page) since the offset is within the page,
and its corresponding struct page can still be found when being freed.
Please let me know if this thought is wrong and I will submit another
version.

> 
> -Kees
> 
>> @@ -318,7 +318,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
>>  	}
>>  	/* NULL-terminate and remove enter */
>>  	buf[count] = '\0';
>> -	strim(buf);
>> +	buf = strim(buf);
>>  
>>  	crashtype = find_crashtype(buf);
>>  	free_page((unsigned long) buf);
>> -- 
>> 2.25.1
>>
> 

