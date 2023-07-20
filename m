Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673A75B1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGTPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjGTPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:03:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F007BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:03:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66c729f5618so778748b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865397; x=1690470197;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnxkxQ0PxkB3p5PqVcQ0DO2VgVD/sjfzmwcVTmlPiY8=;
        b=M4J6bZ8ONXHBSU6thvDpIQmjNg8G4ztS1mfot8KtlnCyN44Ct2PTyAnku1hUIucr0Q
         /ZppzYhm85PYp5W6lmXGhBB920k0uOstdxOpDt+F0hLuBMsK39d5TNC2VfNFp2vnztLc
         L345C11D73guky6QcVA9UFHeHUWOt3U/bwI0eIdOuaJfEXJieVH2m2hGkeqfeJReQxnG
         PBPejokm21juaN3pNtbsu+E+4B5AHJXrLatu2GCb2F2sDwXyXzGMPdVp3oNiNAhZoi4o
         W+h+4JMBCFGfGr7C4UEmFm1NUR5ApiPpPnC5ZjQOwOyYWMS4XVkUxvKPzwQi2Cgo2eFo
         viOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865397; x=1690470197;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnxkxQ0PxkB3p5PqVcQ0DO2VgVD/sjfzmwcVTmlPiY8=;
        b=buNSlKzx7jZZqcx89tsCStxmK7QLzc5NfmjaUk9n1whxeQ8vutWxxbh24d+GVCYmA7
         RzDXEUxMV2fuuzJeXqviTqjsElZ8rAmdMUPt5ZTPyUgeeBKPUgBvqqGNoLXsEdgHNCqq
         Ixwz/yVDRfP2yhZVbHNBaRkD2u2IYjMvVmqd+OoawOQQG6YvhtSQXuedpS6Uv4qNiIqO
         2emtWqj/gQn5RMTGkZRp1sNz9Eg6n+JAeeqWOexPRIr3vHv3ElaYecYkuQAjZ7/2NqcO
         J2AnqgmGbwNZ9Opba0dS5f0uNjE9qthYl72B36UHG99R1te5g3sSOsVu5fIm33aZkFWW
         QNVg==
X-Gm-Message-State: ABy/qLayMwHlDSZtwBFcec5dDG5i3ajmHJlKsM8VZStKrJbmZEJcOlCP
        Cx6bxuRlELU9entG9uZ+F88=
X-Google-Smtp-Source: APBJJlFTnXIfwkObV5tkC7sG/dKujh/U0MICNOCQUwbHnRTM+AZNBdvfG6UeN1RMTA+c0Rk0X+hySg==
X-Received: by 2002:a05:6a00:803:b0:668:82fe:16f1 with SMTP id m3-20020a056a00080300b0066882fe16f1mr7857465pfk.1.1689865395099;
        Thu, 20 Jul 2023 08:03:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b006862af32fbesm1358280pfm.14.2023.07.20.08.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:03:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
Date:   Thu, 20 Jul 2023 08:03:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
In-Reply-To: <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 07:31, Mark Brown wrote:
> On Thu, Jul 20, 2023 at 07:26:54AM -0700, Guenter Roeck wrote:
>> On 7/20/23 01:50, Dan Carpenter wrote:
> 
>>> +++ b/drivers/base/regmap/regcache-rbtree.c
>>> @@ -187,7 +187,7 @@ static int regcache_rbtree_init(struct regmap *map)
>>>    	int i;
>>>    	int ret;
>>> -	map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
>>> +	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);
> 
>> Yes, that might work as well (and after looking more deeply into the code
>> I wondered why it wasn't used in the first place).
> 
>> Based on Mark's feedback I submitted
>> https://lore.kernel.org/lkml/20230720032848.1306349-1-linux@roeck-us.net/
>> Sorry, I forgot to copy you on that one.
> 
>> Mark, please let me know what you prefer.
> 
> They're both independently fine, but I wouldn't expect anything that's
> running in atomic context to be actually using dynamic allocations.

Which one do you prefer ? As I mentioned in my second patch, there are
two drivers which use fast_io together with REGCACHE_RBTREE and thus
are likely affected by this problem. Dan's solution would cover that,
while my current RFC patch would likely cause those drivers to fail.
Plus, of course, they could get stuck if they actually end up trying to
sleep while allocating memory.

Thanks,
Guenter

