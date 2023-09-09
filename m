Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CA7996D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbjIIIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbjIIIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:23:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A81BD3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:23:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c06f6f98c0so23200705ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694247833; x=1694852633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isXLur4flyniG6AGvwddmNgn1Xc65gLUnTbB88HTkaw=;
        b=Usmz/paboxp9TMKgvI7bYLAiNt2M9ITlxUbNpkedzqZU38At4H4xOW3bofVp6+md6R
         u7AzFWyBM79oHonQuNcrQKHGNHcsCpL8AoLMqfZVKgHZTSsn2BfqitZe0gjKz+yClHd2
         R5WvEinqdEqE2QS3vvHZNrN4GXf5tgi21qWz/PAlqA0fJZgLJs/Gup/QHM6/Cn7Raq/R
         bZeC8ILSmhqqIns+B8tN2yHGDm/ROF8JgOhbc3YDfnUOdww3nf4zCS81WMvcqXUhI+Dd
         xbF1JAtgQ7wNevgakwtknNT1z/8doLFCymrHgh1lOgUPxZmUSomGrwZYyQ+QLWXh9y7O
         FA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694247833; x=1694852633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isXLur4flyniG6AGvwddmNgn1Xc65gLUnTbB88HTkaw=;
        b=kLy/DVDcQQDFY9IkStoOP7f7QpVMQZzvnkrLUVjPWhZC/OGXGzMhHkgNd+ayyrQmiu
         5RBmcI5qCTp2P2JCSkjXwiV6dz9UtwD1CFFLjg4ORt9MqAUlG+5zxkK0iqVO7SY+4yWP
         QQ6UojCFFDqq4C+/ocD+uTqaZiD8MvJyvJ46wCVwY7jLwfnqjeauEBFRor3c3I1VTU2d
         16llr6mEAWfV6JnVflzUingBZHuDrQWJ720BFi81oXk9xgEgX4av1U9yjSvBt93HAyR7
         ZEzwCC/GTMrwDM4csZipA/ZK+8uNjADY7nfB45xhH3KyKFQb1e0wLoHT/I+Oy5g60GyK
         k4CA==
X-Gm-Message-State: AOJu0YwlfWdouYT8JDC0XNKHzjYkk2ImEp9ou8SHDll/fllP11GOr8kB
        wbat6XxA0E5qLNkSbXlQhDU=
X-Google-Smtp-Source: AGHT+IH+WadAFHeutXh9oUopOzDOg9fn0pYhJUNVObI7o8eq3aDha8h1ZAiU/A3VAkzTz1Pp7lXlvw==
X-Received: by 2002:a17:902:f7cf:b0:1c3:6705:bcee with SMTP id h15-20020a170902f7cf00b001c36705bceemr4612335plw.57.1694247832989;
        Sat, 09 Sep 2023 01:23:52 -0700 (PDT)
Received: from localhost ([104.193.10.236])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709028ec200b001b89a6164desm2740726plo.118.2023.09.09.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 01:23:52 -0700 (PDT)
From:   Zhi-zhou Zhang <zhizhou.zh@gmail.com>
X-Google-Original-From: Zhi-zhou Zhang <zhizhouzhang@asrmicro.com>
Date:   Sat, 9 Sep 2023 16:23:45 +0800
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Zhizhou Zhang <zhizhou.zh@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de,
        wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
Message-ID: <ZPwrkRldQU/5TOcz@local>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Zhizhou Zhang <zhizhou.zh@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de,
        wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230907143302.4940-1-zhizhou.zh@gmail.com>
 <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
 <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
 <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 11:00:31PM +0200, Linus Walleij wrote:
> On Fri, Sep 8, 2023 at 3:50 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > However, it makes a total nonsense of the comment, which explains
> > precisely why the flush_cache_all() is where it is. Moving it before
> > that comment means that the comment is now rediculous.
> 
> Zhizhou, can you look over the comment placement?

Linus, I found the bug on a cortex-a55 cpu with high address memory.
Since the lr is also corruptted, when flush_cache_all() is done, the
program continues at the next instruction after fixup_pv_table(). So
the disabling cache and flush_cache_all() is executed a secondary time.
Then this time lr is correct so the kernel may boot up as usual.

I read the comment carefully, I am not sure how "to ensure nothing is
prefetched into the caches" affects the system. My patch doesn't
prevent instrution prefetch though. But in my board everythings looks
good.

So I come up with a new fixup plan, that's keep the location of
flush_cache_all() with adding a flush stack cache before disabling
cache, the code is as follow, the fix is a bit ugly -- it makes
assumption stack grow towards low address and flush_cache_all() will
not occupy more than 32 bytes in the future. Comparing with move
flush_cache_all() before disabling cache, Which one do you prefer?
Thanks!

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 03fb0fe926f3..83a54c61a86b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1640,6 +1640,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
 	unsigned long pa_pgd;
 	unsigned int cr, ttbcr;
 	long long offset;
+	void *stack;
 
 	if (!mdesc->pv_fixup)
 		return;
@@ -1675,7 +1676,14 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
 	/* Run the patch stub to update the constants */
 	fixup_pv_table(&__pv_table_begin,
 		(&__pv_table_end - &__pv_table_begin) << 2);
-	flush_cache_all();
+
+	/*
+	 * clean stack in cacheline that undering memory will be changed in
+	 * the following flush_cache_all(). assuming 32 bytes is enough for
+	 * flush_cache_all().
+	 */
+	stack = (void *) (current_stack_pointer - 32);
+	__cpuc_flush_dcache_area(stack, 32);
 
 	/*
 	 * We changing not only the virtual to physical mapping, but also
@@ -1691,6 +1699,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
 	asm("mrc p15, 0, %0, c2, c0, 2" : "=r" (ttbcr));
 	asm volatile("mcr p15, 0, %0, c2, c0, 2"
 		: : "r" (ttbcr & ~(3 << 8 | 3 << 10)));
+	flush_cache_all();
 
 	/*
 	 * Fixup the page tables - this must be in the idmap region as

> 
> > So, please don't put it in the patch system.
> >
> > The patch certainly needs to be tested on TI Keystone which is the
> > primary user of this code.
> 
> Added Andrew Davis and Nishanth Menon to the thread:
> can you folks review and test this for Keystone?
> 
> Yours,
> Linus Walleij
