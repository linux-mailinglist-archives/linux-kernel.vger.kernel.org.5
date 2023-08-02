Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0876D5B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHBRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjHBRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833AC0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56FDC61A5C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50597C433C7;
        Wed,  2 Aug 2023 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690998132;
        bh=EY7xWTy+uC5nBlkjVqqP03MYWu0uTvv/MME+Ja83TR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBr245IHCceT9BV1+b8usevH8xJCSLnB3B6T6/2GgCWVuWoxgq5ew/QoizRkj9BgG
         lLKcQBJK1nxp8+9grnqnkT1Nx9Mcpd6cwcNQdKXvwYqMwJEWB9gxV+DaQM2cmYDqQa
         4e8ZrGMebQqhb5afoRVwhhPooIIegwlYtbUz49Gdfu8ezohV/VTEUg/bYa9OXPINg5
         jihL61eLUHeplRxLoN4DEcokP3jUzBmWfhYd9elOjDMGJUEEvO7Xc5fjHy6meS9jwG
         bLg/1GL7nQ/VKAeh95awNHMQVPVBKllnKKD+Rt8Z6DE5iCkckGqHpdQYJ7Qt1IQwai
         wqwSscvN2tL8g==
Date:   Wed, 2 Aug 2023 10:42:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linus:master] [x86]  3c516f89e1:
 WARNING:CPU:#PID:#at_call_timer_fn
Message-ID: <20230802174210.GA2202600@dev-arch.thelio-3990X>
References: <202308020936.58787e6c-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308020936.58787e6c-oliver.sang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:59:03AM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "WARNING:CPU:#PID:#at_call_timer_fn" on:
> 
> commit: 3c516f89e17e56b4738f05588e51267e295b5e63 ("x86: Add support for CONFIG_CFI_CLANG")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 12214540ad87ce824a8a791a3f063e6121ec5b66]
> [test failed on linux-next/master d7b3af5a77e8d8da28f435f313e069aea5bcf172]
> [test failed on fix commit 883bbbffa5a4ffd1915f8b42934dab81b7f87226]
> 
> in testcase: boot
> 
> compiler: clang-16
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> the config to build this commit has below difference with the one for parent:
> 
> --- /pkg/linux/x86_64-randconfig-r034-20230729/clang-16/a4b7a12c5594fe5e6ab2a5aa514a9ae3c0b85573/.config      2023-07-31 12:32:40.547938738 +0800
> +++ /pkg/linux/x86_64-randconfig-r034-20230729/clang-16/3c516f89e17e56b4738f05588e51267e295b5e63/.config      2023-07-31 12:33:11.354874788 +0800
> @@ -610,6 +610,10 @@ CONFIG_HAVE_STACKPROTECTOR=y
>  CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
>  CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
>  CONFIG_LTO_NONE=y
> +CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
> +CONFIG_ARCH_USES_CFI_TRAPS=y
> +CONFIG_CFI_CLANG=y
> +CONFIG_CFI_PERMISSIVE=y
>  CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>  CONFIG_HAVE_CONTEXT_TRACKING_USER=y
>  CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
> 
> we are not sure if that we can see below WARNINGs on this commit is just
> expected.
> 
> we also tested on linus/master linux-next/master when this bisection done,
> as well as one fix commit 883bbbffa5, we found the
> dmesg.WARNING:CPU:#PID:#at_call_timer_fn (below (1)) still exists on them,
> while others (below (2)(3)(4)) are gone. not sure if there are some further
> fixes.
> 
> a4b7a12c5594fe5e 3c516f89e17e56b4738f05588e5
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     dmesg.WARNING:CPU:#PID:#at_call_timer_fn    (1)
>            :6          100%           6:6     dmesg.WARNING:CPU:#PID:#at_do_basic_setup   (2)
>            :6          100%           6:6     dmesg.WARNING:CPU:#PID:#at_sha256_finup     (3)
>            :6          100%           6:6     dmesg.WARNING:CPU:#PID:#at_sha256_update    (4)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308020936.58787e6c-oliver.sang@intel.com
> 
> 
> 
> [   28.182726][    C1] CFI failure at call_timer_fn+0x161/0x390 (target: dsp_cmx_send+0x0/0x212f; expected type: 0x91b4a83a)

Thanks a lot for the report, this does seem expected. I have sent a
patch:

https://lore.kernel.org/20230802-fix-dsp_cmx_send-cfi-failure-v1-1-2f2e79b0178d@kernel.org/

Cheers,
Nathan
