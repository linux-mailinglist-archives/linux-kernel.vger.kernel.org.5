Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0584D77DA80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbjHPGdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbjHPGcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:32:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA891BF8;
        Tue, 15 Aug 2023 23:32:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQdbf33KWz4f3mVw;
        Wed, 16 Aug 2023 14:32:30 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6l9bdxkDoJRAw--.17149S3;
        Wed, 16 Aug 2023 14:32:30 +0800 (CST)
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
 <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
 <20230816033418.GD681074@google.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <5e30961c-f449-2a1b-ad92-c9720c5884e8@huaweicloud.com>
Date:   Wed, 16 Aug 2023 14:32:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230816033418.GD681074@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6l9bdxkDoJRAw--.17149S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr17uFyxZrWDuFWUtrW3Awb_yoW3Krc_Gr
        yfuw4DCa1Yq3ZIya1DCr4YqFZIg3yqqrs3J39Fyr1fZ3s5XrWUZr18GF97Zw1xXws3t3sr
        Ar9Yqa48ZFZ5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/16 11:34, Sergey Senozhatsky wrote:
> On (23/08/16 11:20), Leizhen (ThunderTown) wrote:
>>> IMHO, this is pretty bad interface.
>>>
>>>   + From the user POV:
>>>
>>>     It is far from clear what values will be passed for the given
>>>     printf format. It can be docummented but...
>>>
>>>
>>>   + From the security POV:
>>>
>>>     The compiler could not check if the printk() parameters
>>>     match the format. I mean if the number of types of
>>>     the parameters are correct.
>>
>> Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
>> Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
>> from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.
> 
> Linus quite likely will dislike (with passion) the idea of using %px.

OK, thanks.

> .
> 

-- 
Regards,
  Zhen Lei

