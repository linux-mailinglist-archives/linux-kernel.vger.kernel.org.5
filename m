Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FF75A9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGTI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGTIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:51:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494B2115
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:51:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso452051f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689843059; x=1690447859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UizpDIv2Ad6vV1LDImXPzSMVhFxXuzlESiAXg8RpGPU=;
        b=tt8hfNw3DwcF2qkP5+djGhf0o4tLGQLcsL/3QiWNXfsIGD5fRwnZ2biEpDnasi8VOl
         0rddel4nn4rxAaTomBi3QDoQ1H462KXhK8peAEbIEaNXx5vHEtvqfYk0+ad20SwQNq/t
         GljC8jkKgh6lgvcxDwtnhgGXW1Hz/EgncRZlsTNg+iZZ92fylUzsHiZ2B081U3LQncFT
         zPvyef1dgljpJGfVxZdEYpLicLuAvKmXkqtC4onRDoPtogodEPI2Mqgg2ozTW2cxV4h0
         tv5+TrJx/rdZk0gsYcHF7Ux010J9u5xsOFc4pei6uCsoqFwtt34Fi0y6bvUYMk4zYMx1
         pLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843059; x=1690447859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UizpDIv2Ad6vV1LDImXPzSMVhFxXuzlESiAXg8RpGPU=;
        b=YAIH3HS0U9DmLLGF+nAyphBTi/ap8b85a9WA/KDyMrax81i2RVdJk5T+25TJWh78Rz
         i/mfcc5eiTry0nPP+Z8fwJip5prytUzAU4k+MhK5/wvcz0POXpTJ7255n8E/fpZFg1zo
         q85nUYzsdj0szxiL9T6AYl0wvsvYEWd7ieIPpReOxAVEFehhSCsqDtn5ikX3Ll6ggtdi
         Cl7k4wpx2CT6OXP8uS+pZqCQmWX4bYkVhhylZc92ihsjkkBoX5CJTO7LV5iwwk7xaPCp
         xnGG2p7w+XtpV59BucHk8LnwY3gwukEBrzj9oR0R1zVq21drnsCgrNeJgezBNkQ3Zl+f
         AwQg==
X-Gm-Message-State: ABy/qLa3xzWVUisz0Y5le4Mcm51V4JHyaPZjsOqO9rIBgqFWoO+AXQ/q
        ob2Kub7Co2aOhTPnNUW8mp+SHA==
X-Google-Smtp-Source: APBJJlFewOfr5CnzAYZ2UmhVGuzVYT0qTY+YCbpa5jazfZaQn5800OoSOmYTiwSuTjR9htRiel9sYg==
X-Received: by 2002:a5d:4b81:0:b0:314:33a2:78fe with SMTP id b1-20020a5d4b81000000b0031433a278femr1588239wrt.29.1689843059177;
        Thu, 20 Jul 2023 01:50:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b00316eb7770b8sm672995wrx.5.2023.07.20.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:50:55 -0700 (PDT)
Date:   Thu, 20 Jul 2023 11:50:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:37:54PM -0700, Guenter Roeck wrote:
> Hi,
> 
> when booting images with both CONFIG_REGMAP_KUNIT and
> CONFIG_DEBUG_ATOMIC_SLEEP enabled, I get the following backtrace.
> 
> [    4.994957]     # Subtest: regmap
> [    4.995067]     1..14
> [    4.995190]         KTAP version 1
> [    4.995308]         # Subtest: basic_read_write
> [    4.999402]         ok 1 none
> [    5.003028]         ok 2 flat
> [    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
> [    5.006219] preempt_count: 1, expected: 0
> [    5.006414] 1 lock held by kunit_try_catch/117:
> [    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
> [    5.007493] irq event stamp: 162
> [    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
> [    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
> [    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
> [    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
> [    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
> [    5.009011] Hardware name: Generic DT based system
> [    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
> [    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
> [    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
> [    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
> [    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
> [    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
> [    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
> [    5.010634]  _regmap_write from regmap_write+0x44/0x68
> [    5.010803]  regmap_write from basic_read_write+0x8c/0x270
> [    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0
> [    5.011170]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x28
> [    5.011396]  kunit_generic_run_threadfn_adapter from kthread+0xf8/0x120
> [    5.011603]  kthread from ret_from_fork+0x14/0x3c
> [    5.011801] Exception stack(0x881a5fb0 to 0x881a5ff8)
> [    5.012024] 5fa0:                                     00000000 00000000 00000000 00000000
> [    5.012269] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    5.012502] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    5.014546]         ok 3 rbtree
> [    5.018988]         ok 4 maple
> 
> This isn't surprising given that the regmap code allocates rbcache nodes
> with GFP_KERNEL and the regmap configuration results in using spinlock
> to lock regmap accesses.
> 
> I'll be happy to submit a patch to fix the problem, but I would need
> some advice. I could
> 
> - Update the unit test regmap configuration to avoid using
>   spinlock as locking mechanism for rbtree tests.
>   That would work, but fail to catch situations where this happens
>   in the real world.
> - Use a different method to allocate memory in regcache_rbtree_node_alloc().
>   - Replace GFP_KERNEL with GFP_NOWAIT or GFP_KERNEL | __GFP_NOWARN (?)
>     or something else, possibly only if gfpflags_allow_blocking() is false

__GFP_NOWARN is only about allocation failure, not sleeping.  I would
have thought it should be.

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index fabf87058d80..d94e25120f2f 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -187,7 +187,7 @@ static int regcache_rbtree_init(struct regmap *map)
 	int i;
 	int ret;
 
-	map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
+	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);
 	if (!map->cache)
 		return -ENOMEM;
 
@@ -277,7 +277,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 
 	blk = krealloc(rbnode->block,
 		       blklen * map->cache_word_size,
-		       GFP_KERNEL);
+		       map->alloc_flags);
 	if (!blk)
 		return -ENOMEM;
 
@@ -286,7 +286,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
 		present = krealloc(rbnode->cache_present,
 				   BITS_TO_LONGS(blklen) * sizeof(*present),
-				   GFP_KERNEL);
+				   map->alloc_flags);
 		if (!present)
 			return -ENOMEM;
 
@@ -320,7 +320,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	const struct regmap_range *range;
 	int i;
 
-	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
+	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
 	if (!rbnode)
 		return NULL;
 
@@ -346,13 +346,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	}
 
 	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
-				      GFP_KERNEL);
+				      map->alloc_flags);
 	if (!rbnode->block)
 		goto err_free;
 
 	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
 					sizeof(*rbnode->cache_present),
-					GFP_KERNEL);
+					map->alloc_flags);
 	if (!rbnode->cache_present)
 		goto err_free_block;
 
