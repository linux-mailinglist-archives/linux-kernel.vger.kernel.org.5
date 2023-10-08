Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8F7BCDF2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjJHLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjJHLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:03:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20DDBA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:03:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2916654a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762985; x=1697367785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI2aGqX8IQw92CQpgLDjKYL8b/K1wVHaDqiaHa2ONas=;
        b=Doz6ffvu/ETlbrWtK0PvMo8fj9aTgCd8sytqdNjgmBQBEq42cPmx+qwlDrCpZfec26
         17IWtBGK3PMz9ryWeGXPcaV4NBEVObl5XzN8Pc8SxQOEOSmWUQt305BvLP0IKB76sbDO
         pRa5wI05sCYFPKUo0iWKR/oau3hLIT0NGwgmXoojtmwawMqV02iQvPOyeAZd8HKNjAyJ
         M85lmKLbjlwOOeaKD8hd9dBwqItz+941t78jt/uG18nXurnRn1a9Xu7IhH1z0hv6n7Y5
         ZEWCAPxVEOwGcNgq/v2rM+7SiUdKnenI/bYzE5ln/tQx1m/hk/sE3HLrdrqyfpxIehnw
         eV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762985; x=1697367785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MI2aGqX8IQw92CQpgLDjKYL8b/K1wVHaDqiaHa2ONas=;
        b=GppTqylsUyb1gkUFvaIPUAzvT7sq/tgslOSKok2M3QtnsIfNSd5qxgThWmX7r93elW
         MKaJ3sxi8BUPHW0ZZ2BOgRVZrbhAviJ0BxjibUa6h1dcmZc+MA+qrdRy4H6fNWBTA8hj
         qelZzfHZOEzTlQIH8zcMVp0V7jeibAH4j3YymFr0FLYI3soGLSbiguHtDRjcFJu8Acr6
         a4OrWqJL3TlAQynfiM07fkMg5NQ97XEHwLfrdVn8zbbbwVxOKatT3/BTlUUBeFlaQSxD
         Njz5sNi0nyWpQsuB56JuyJH1qT3gkp27/G3xc7/nbY4cn1tpeM1YXRTo8uRpmFuooegF
         zWjg==
X-Gm-Message-State: AOJu0YyWSwidvIlY756zWBxU4UrSZgS7cw/bJGwoi4yIeRFz0Agkvtk4
        Llc0Nw2QgUKr3Y2Vl7omxxAU17/+VGPp0gyhWQo=
X-Google-Smtp-Source: AGHT+IGMbVmDRDWN6R0443njiMorLkHAoOavCC66hn9SMnE+BnJ1HO2EFPfG5M++zVjO8PjtzevCjg==
X-Received: by 2002:a05:6a20:d41c:b0:138:2fb8:6a14 with SMTP id il28-20020a056a20d41c00b001382fb86a14mr11825377pzb.3.1696762985348;
        Sun, 08 Oct 2023 04:03:05 -0700 (PDT)
Received: from [10.53.28.113] ([143.92.127.238])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bdb0483e65sm7273757plg.265.2023.10.08.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 04:03:04 -0700 (PDT)
Message-ID: <2b2dbd18-b018-7212-8a3c-5d207697709d@gmail.com>
Date:   Sun, 8 Oct 2023 19:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] delayacct: introduce delayacct_enabled() to simplify
 implement
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <8e5d6ed7d70ff7187a33130231783ed2c1d70841.1696761522.git.chunguang.xu@shopee.com>
 <20231008105627.GB6320@noisy.programming.kicks-ass.net>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <20231008105627.GB6320@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/8 18:56, Peter Zijlstra 写道:
> On Sun, Oct 08, 2023 at 06:49:36PM +0800, brookxu.cn wrote:
>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>
>> Introduce delayacct_enabled() to simplify the code and make it
>> more concise.
>>
>> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
>> ---
>>   include/linux/delayacct.h | 74 +++++++++++----------------------------
>>   kernel/delayacct.c        |  2 +-
>>   2 files changed, 21 insertions(+), 55 deletions(-)
>>
>> diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
>> index 6639f48dac36..660e534ce7c4 100644
>> --- a/include/linux/delayacct.h
>> +++ b/include/linux/delayacct.h
>> @@ -94,137 +94,103 @@ static inline void delayacct_tsk_init(struct task_struct *tsk)
>>   		__delayacct_tsk_init(tsk);
>>   }
>>   
>> +static inline bool delayacct_enabled(void)
>> +{
>> +	return static_branch_unlikely(&delayacct_key);
>> +}
>> +
>>   /* Free tsk->delays. Called from bad fork and __put_task_struct
>>    * where there's no risk of tsk->delays being accessed elsewhere
>>    */
>>   static inline void delayacct_tsk_free(struct task_struct *tsk)
>>   {
>> -	if (tsk->delays)
>> +	if (delayacct_enabled())
> This isn't an equivalent change and your Changelog does not clarify.
Sorry, As Patch 2 will convert tsk->delays to object,  we donot need to 
check whether tsk->delays is null or not, so relative code can be simplify.
