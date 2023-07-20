Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249B75B132
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjGTO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGTO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:26:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C13E4C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:26:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so1399384b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689863216; x=1690468016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp5sJi1VNBF59ULgvnJ54gBzbh9E9Vb82vPBW44lFSA=;
        b=CnlucDUL495m/RDN6WTT07Ye9Vc2H8qKdI8wLj2zPThm3sWw3lx1E711cOmaOKnsJq
         f92fdv+yXLjSHQ1jwszKQVHxNCZVXYi8V8g0uRuKR8iS2Y7Io1XlDd5LIZHBLQXzZ6c+
         vSRt/AtL9bO0Ljrn3rO2osv96UopjvKE44jN1e6CXJhlzCuXhVx6SKmITTAcHfBV2MX9
         t47dKutrr7MlyhwgOUWV2QHyhLchd2/coxnU0sBy6bjlgP5IXPIP34SgmtMKUViJdsM3
         5K/WMPxRXekLEm31cAk702MGF/wD8Y+EQ/6h/oE8DRvTTUFHz2t+JcLUzQW6JpjDxAQJ
         l/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863216; x=1690468016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vp5sJi1VNBF59ULgvnJ54gBzbh9E9Vb82vPBW44lFSA=;
        b=cE9pUTiYl+9BJxjBMzWzTrlrwM6BBtWLOiwY5wsyteiJXrNpzVhwNp5510bZrU5NuY
         a62JszjXKngf6T2ZrWrRL/+QWtW7haCC2ATuMUbmHkoCaFfGrhpJJP9cY1qYsoWD+ZVE
         7aEC+DQO777+3obTZjN3dnhY5SI2hf1ZuDn1ADv1fpDimIKnbXBXANj21MFP1DGx83Y6
         uM33tgldoIso/ffAfGIGtQm7yAaaGSGR9fKyu/HtbTgcz4Svi/mLY/4TrDi1Q0ZTftvO
         t1kdIqbZekzLUq4mKw98gtyt5cpxAxpgnulXdUqOsLCi4t8tr7MGKCmtoQ3fPXt9uttA
         YVQg==
X-Gm-Message-State: ABy/qLZgtyRgq0SQ6kY6rVm/PtCdCOrbeTiPx48xALTqodaoNq7iKFKz
        q5OtVZ2nvsiiak320masjjY=
X-Google-Smtp-Source: APBJJlECpNHAOqz0R+xJ/EsDHCe2f1vLhprTzr6HtijnHTNrPIdwilRI6aTQtp+cjjVlU8giCr5/7w==
X-Received: by 2002:a05:6a20:7486:b0:132:f926:5891 with SMTP id p6-20020a056a20748600b00132f9265891mr6902577pzd.4.1689863216196;
        Thu, 20 Jul 2023 07:26:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t22-20020a62ea16000000b0066684d8115bsm1247151pfh.178.2023.07.20.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:26:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
Date:   Thu, 20 Jul 2023 07:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
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

On 7/20/23 01:50, Dan Carpenter wrote:
> On Wed, Jul 19, 2023 at 03:37:54PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> when booting images with both CONFIG_REGMAP_KUNIT and
>> CONFIG_DEBUG_ATOMIC_SLEEP enabled, I get the following backtrace.
>>
>> [    4.994957]     # Subtest: regmap
>> [    4.995067]     1..14
>> [    4.995190]         KTAP version 1
>> [    4.995308]         # Subtest: basic_read_write
>> [    4.999402]         ok 1 none
>> [    5.003028]         ok 2 flat
>> [    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
>> [    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
>> [    5.006219] preempt_count: 1, expected: 0
>> [    5.006414] 1 lock held by kunit_try_catch/117:
>> [    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
>> [    5.007493] irq event stamp: 162
>> [    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
>> [    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
>> [    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
>> [    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
>> [    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
>> [    5.009011] Hardware name: Generic DT based system
>> [    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
>> [    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
>> [    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
>> [    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
>> [    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
>> [    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
>> [    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
>> [    5.010634]  _regmap_write from regmap_write+0x44/0x68
>> [    5.010803]  regmap_write from basic_read_write+0x8c/0x270
>> [    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0
>> [    5.011170]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x28
>> [    5.011396]  kunit_generic_run_threadfn_adapter from kthread+0xf8/0x120
>> [    5.011603]  kthread from ret_from_fork+0x14/0x3c
>> [    5.011801] Exception stack(0x881a5fb0 to 0x881a5ff8)
>> [    5.012024] 5fa0:                                     00000000 00000000 00000000 00000000
>> [    5.012269] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    5.012502] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    5.014546]         ok 3 rbtree
>> [    5.018988]         ok 4 maple
>>
>> This isn't surprising given that the regmap code allocates rbcache nodes
>> with GFP_KERNEL and the regmap configuration results in using spinlock
>> to lock regmap accesses.
>>
>> I'll be happy to submit a patch to fix the problem, but I would need
>> some advice. I could
>>
>> - Update the unit test regmap configuration to avoid using
>>    spinlock as locking mechanism for rbtree tests.
>>    That would work, but fail to catch situations where this happens
>>    in the real world.
>> - Use a different method to allocate memory in regcache_rbtree_node_alloc().
>>    - Replace GFP_KERNEL with GFP_NOWAIT or GFP_KERNEL | __GFP_NOWARN (?)
>>      or something else, possibly only if gfpflags_allow_blocking() is false
> 
> __GFP_NOWARN is only about allocation failure, not sleeping.  I would
> have thought it should be.
> 
> diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
> index fabf87058d80..d94e25120f2f 100644
> --- a/drivers/base/regmap/regcache-rbtree.c
> +++ b/drivers/base/regmap/regcache-rbtree.c
> @@ -187,7 +187,7 @@ static int regcache_rbtree_init(struct regmap *map)
>   	int i;
>   	int ret;
>   
> -	map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
> +	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);

Yes, that might work as well (and after looking more deeply into the code
I wondered why it wasn't used in the first place).

Based on Mark's feedback I submitted
https://lore.kernel.org/lkml/20230720032848.1306349-1-linux@roeck-us.net/
Sorry, I forgot to copy you on that one.

Mark, please let me know what you prefer.

Thanks,
Guenter

>   	if (!map->cache)
>   		return -ENOMEM;
>   
> @@ -277,7 +277,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
>   
>   	blk = krealloc(rbnode->block,
>   		       blklen * map->cache_word_size,
> -		       GFP_KERNEL);
> +		       map->alloc_flags);
>   	if (!blk)
>   		return -ENOMEM;
>   
> @@ -286,7 +286,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
>   	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
>   		present = krealloc(rbnode->cache_present,
>   				   BITS_TO_LONGS(blklen) * sizeof(*present),
> -				   GFP_KERNEL);
> +				   map->alloc_flags);
>   		if (!present)
>   			return -ENOMEM;
>   
> @@ -320,7 +320,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
>   	const struct regmap_range *range;
>   	int i;
>   
> -	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
> +	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
>   	if (!rbnode)
>   		return NULL;
>   
> @@ -346,13 +346,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
>   	}
>   
>   	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
> -				      GFP_KERNEL);
> +				      map->alloc_flags);
>   	if (!rbnode->block)
>   		goto err_free;
>   
>   	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
>   					sizeof(*rbnode->cache_present),
> -					GFP_KERNEL);
> +					map->alloc_flags);
>   	if (!rbnode->cache_present)
>   		goto err_free_block;
>   

