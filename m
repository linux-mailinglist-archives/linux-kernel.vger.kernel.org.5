Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADC75A20F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGSWiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGSWh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:37:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A84B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:37:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89bc52cd1so921795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689806276; x=1692398276;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bZf7cnG1mD4iNBWYyHZJzlzpjEPAuGHrppUTXxTlYTM=;
        b=eGdrrh3WAUmadPii6ZnFXG2nUXFUwDoPHKNbRu3C2hYyfM0XvdUWD0wUW+kiESjwjY
         GQWBxmN+39KTYQLNQzj6/AXOjMgfnQkEpqd9xh86tih3PQuY2a/lMAVGX3nnG5kChtw/
         +6/epQNYz3zL5fIC/8lRRdvKnTGXvJw/ZZlUSqdofS+dqe0hBqBM53dlbs2xcxJynJlb
         c2bsXO+b6lpPjNpAC7c17Y2NdunMgaQs5n6re4Hb1IgOU1gapLAushmABck0HJ+5Ao5I
         WVuLeE6pESGSUtFjXbm/Bhir8vyZemTWheQL850VYjE9JbCdRNwSauODmIYzXQHFRq3A
         s6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806276; x=1692398276;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZf7cnG1mD4iNBWYyHZJzlzpjEPAuGHrppUTXxTlYTM=;
        b=HexrfgoXVZQb8stJQGFMyK7i2EaIx1v2s+amtlRkVnlULp8W1Yg9AgpvCICWra/1W9
         nNBPVoy5mhaYG3XbFssa+OnN3JBYfY01VGAfz6OTNr6Q1RCF7oYtFGpYzH3J2SyNP9xU
         uNY2Xp26N44Ja7K5j4nFvn+SgmO5HrM5rRmUG0SgqYP7dex0wYbK6B5VyR+bkQlefclp
         P+30Ny92YEi4BJ8Ry8E6+LkKVTmv2Jdp4YjYS5NgJxYLyNtkxBHfjV/baPiR6JnC4ytM
         TShRX+8H0/2h+6M/tSJVN8PLRcoEx9Mz/XcaQdkeq87Aqc7+3lVL3Wfgxx5uVia5g2Nd
         maLQ==
X-Gm-Message-State: ABy/qLbqOx9Kd/tFJvECfYRSxhocvli8Ea3VyCukf2opXQwvB3K7Zaxa
        Ip9+Uo1r9KhxIrVPBH+yvIQ=
X-Google-Smtp-Source: APBJJlHEyPqkaFzvUWc4fAG2ZPm6YnLPatly2j+Jq8vTYAK280dlD9VPAHnPVbnaeQxsp5bw1mP8Zg==
X-Received: by 2002:a17:903:1c5:b0:1b9:d2fc:ba9f with SMTP id e5-20020a17090301c500b001b9d2fcba9fmr19958598plh.11.1689806276112;
        Wed, 19 Jul 2023 15:37:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902ba8500b001b8b2bf3313sm4495591pls.217.2023.07.19.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:37:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Jul 2023 15:37:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when booting images with both CONFIG_REGMAP_KUNIT and
CONFIG_DEBUG_ATOMIC_SLEEP enabled, I get the following backtrace.

[    4.994957]     # Subtest: regmap
[    4.995067]     1..14
[    4.995190]         KTAP version 1
[    4.995308]         # Subtest: basic_read_write
[    4.999402]         ok 1 none
[    5.003028]         ok 2 flat
[    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
[    5.006219] preempt_count: 1, expected: 0
[    5.006414] 1 lock held by kunit_try_catch/117:
[    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
[    5.007493] irq event stamp: 162
[    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
[    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
[    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
[    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
[    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
[    5.009011] Hardware name: Generic DT based system
[    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
[    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
[    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
[    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
[    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
[    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
[    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
[    5.010634]  _regmap_write from regmap_write+0x44/0x68
[    5.010803]  regmap_write from basic_read_write+0x8c/0x270
[    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0
[    5.011170]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x28
[    5.011396]  kunit_generic_run_threadfn_adapter from kthread+0xf8/0x120
[    5.011603]  kthread from ret_from_fork+0x14/0x3c
[    5.011801] Exception stack(0x881a5fb0 to 0x881a5ff8)
[    5.012024] 5fa0:                                     00000000 00000000 00000000 00000000
[    5.012269] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.012502] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.014546]         ok 3 rbtree
[    5.018988]         ok 4 maple

This isn't surprising given that the regmap code allocates rbcache nodes
with GFP_KERNEL and the regmap configuration results in using spinlock
to lock regmap accesses.

I'll be happy to submit a patch to fix the problem, but I would need
some advice. I could

- Update the unit test regmap configuration to avoid using
  spinlock as locking mechanism for rbtree tests.
  That would work, but fail to catch situations where this happens
  in the real world.
- Use a different method to allocate memory in regcache_rbtree_node_alloc().
  - Replace GFP_KERNEL with GFP_NOWAIT or GFP_KERNEL | __GFP_NOWARN (?)
    or something else, possibly only if gfpflags_allow_blocking() is false
  - Use some other allocation function if gfpflags_allow_blocking()
    is false (which one ?)

Any suggestions ?

Thanks,
Guenter
