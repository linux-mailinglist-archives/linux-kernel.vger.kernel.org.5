Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9799778C72
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjHKKvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjHKKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:50:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19494695;
        Fri, 11 Aug 2023 03:49:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so28075491fa.2;
        Fri, 11 Aug 2023 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691750962; x=1692355762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIQw6WBNp7ciWP2PmoacsY4tzU8T3VqystkQlcSBU+g=;
        b=arf1KDjfEBJ8fVUdUEXOTsEQ/1wE0x5t8Ku6kBjfJ4YwMUnA2GD2rnCFqC1XdoXdoG
         zF+ZKhP4AtVKFCG7t5sMIjwzt68lBptOqcuvCcHf//gjrSrJB/2HbnBg/qVQRV3cjj4n
         3lYA2KEWyrJRv8WhAr69YKxFuqxRv7/X1VnCQh/prlgQpkAcItN8UuuQIJHksOH+QK1k
         jlPMqnp8QegBVeQxVxLeS/4bqo0iMyQ0XJDce4jt7jqCWBm6/F6oRlPFPS16VI/llGzB
         kVMun9yUIwVJ0bRmovrmugxeLF9ypZbLzxovZ/6z2Qa1Su0PfrjgqdmzfGxxkGHOAYyj
         dVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750962; x=1692355762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIQw6WBNp7ciWP2PmoacsY4tzU8T3VqystkQlcSBU+g=;
        b=BOcz2JxO+rdNesml9v/jzpWUnw5fDBNPabWyq+rnsPafrsEdaTMvBr0MfBaETa6HJ8
         WedmRBhPzZ00aGDE7ipkGIydTFpd15791eQiHp31wVWDY1Hr2YxjaUHO9sc2HwOJQ0Kf
         H6v3juE/jLHEVqR7OMt5OU3pLH7Tx4cDOrK0lCqrc3Am+GxxU4F76MaW3EfkhKziji6l
         VtLquKHGHZDbXp7aHw/6wB8rJfniac5BKcGc5aaKerkOaEUZWu43wZAzwXe1j2MBpQGp
         B5qNFlDTAloH8pTMOqwxXuVia3YXNKjkGFibjiy5WdV0AAOyCrvsJS7mF/wApooHnejV
         gowg==
X-Gm-Message-State: AOJu0Ywp61areH9eS/MMsSBtBYfG7SkakOYh9rm+jt7mBojbveOGQeM/
        b/35g8xSYIJffjQxmyNrS2g=
X-Google-Smtp-Source: AGHT+IHFnQM8AFGX5qZdEF9cilua1IvCfBq27QQjsjtHXnw5vmhTxQUscQJX0WOWTglSw7qQNO5eJg==
X-Received: by 2002:a2e:b714:0:b0:2b9:d71c:b491 with SMTP id j20-20020a2eb714000000b002b9d71cb491mr1309584ljo.16.1691750961397;
        Fri, 11 Aug 2023 03:49:21 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id j21-20020a2e6e15000000b002b97fe43238sm822046ljc.19.2023.08.11.03.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 03:49:21 -0700 (PDT)
Message-ID: <9f7e9465-897a-445b-acd6-a968a683d14b@gmail.com>
Date:   Fri, 11 Aug 2023 12:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
 <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
 <ee134dae-8353-5735-e02d-e2cb1088c428@broadcom.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <ee134dae-8353-5735-e02d-e2cb1088c428@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 20:34, Florian Fainelli wrote:
> On 8/7/23 04:10, Rafał Miłecki wrote:
>> On 4.08.2023 13:07, Rafał Miłecki wrote:
>>> I triple checked that. Dropping a single unused function breaks kernel /
>>> device stability on BCM53573!
>>>
>>> AFAIK the only thing below diff actually affects is location of symbols
>>> (I actually verified that by comparing System.map before and after -
>>> over 22'000 of relocated symbols).
>>>
>>> Can some unfortunate location of symbols cause those hangs/lockups?
>>
>> I performed another experiment. First I dropped mtd_check_of_node() to
>> bring kernel back to the stable state.
>>
>> Then I started adding useless code to the mtdchar_unlocked_ioctl(). I
>> ended up adding just enough to make sure all post-mtd symbols in
>> System.map got the same offset as in case of backporting
>> mtd_check_of_node().
>>
>> I started experiencing lockups/hangs again.
>>
>> I repeated the same test with adding dumb code to the brcm_nvram_probe()
>> and verifying symbols offsets following brcm_nvram_probe one.
>>
>> I believe this confirms that this problem is about offset or alignment
>> of some specific symbol(s). The remaining question is what symbols and
>> how to fix or workaround that.
> 
> In the config.gz file you attached in your first email, both CONFIG_MTD_* and CONFIG_NVMEM_* so it is not like we are reaching into module space for code and/or data and need veneers or anything, it is part of the kernel image so we can assert the maximum distance between instructions etc.
> 
> Now is it just that specific mutex that is an issue, or do other mutexes through the system do cause problems as well?

If you mean mtd mutex, I'm quite sure it's not the one to blame. It just
happened modified function was using a mutex. Could be any other.


> Do we suspect the toolchain to be possibly problematic?

Maybe, I really don't know much such low level stuff.


>>
>> Following dump change brings back lockups/hangs:
>>
>> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
>> index ee437af41..0a24dec55 100644
>> --- a/drivers/mtd/mtdchar.c
>> +++ b/drivers/mtd/mtdchar.c
>> @@ -1028,6 +1028,22 @@ static long mtdchar_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
>>   {
>>       int ret;
>>
>> +    if (!file)
>> +        pr_info("Missing\n");
>> +    WARN_ON(!file);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +    WARN_ON(cmd == 1234);
>> +    WARN_ON(cmd == 5678);
>> +
>>       mutex_lock(&mtd_mutex);
>>       ret = mtdchar_ioctl(file, cmd, arg);
>>       mutex_unlock(&mtd_mutex);
>>
> 

