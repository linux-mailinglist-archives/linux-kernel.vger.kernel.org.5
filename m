Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F5765592
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjG0OIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C38D1739;
        Thu, 27 Jul 2023 07:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA89061E95;
        Thu, 27 Jul 2023 14:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B664C433C7;
        Thu, 27 Jul 2023 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690466925;
        bh=oHozzgJjJODG6N4sBuk7wbfyPhiG/dxr5SHrjfhfLzU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NJmgzL0QLzVjmI1D5o4AaanyFKdkVeRKoDQCYFSyckpD9qQAX+xO5BLBqxPFjWkKk
         twgVBQq8CzqjyqXhJxD4MKnX5FVWDKypIoRV7+bXUFQgrjaGj52llbaYF6++UBdV1r
         nwKOVivnDVIk1/cArJx3kMsvYZdewI2sqRPLaA5bLjeEh1W5QrPeAkClV09hLcBomF
         4qebObbd093xD+m53EpsfbLntyd+UpARlPji5392UhTWu35MZr4Uz/R0H2wwrLjrra
         ZsG/ffyUCRxknV2NsgVWQDP2MTfKtyNVlJ+G19eWWcKaHWrMN7zpFuDMr2w7983soP
         Je75EtsfwOmOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5BA0CE0AD3; Thu, 27 Jul 2023 07:08:44 -0700 (PDT)
Date:   Thu, 27 Jul 2023 07:08:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <8d9b7237-e7cf-4f4e-8190-6adf3ce8910a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230727141930.0b5a3c40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727141930.0b5a3c40@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:19:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> In file included from arch/arm64/include/asm/alternative.h:9,
>                  from arch/arm64/include/asm/lse.h:14,
>                  from arch/arm64/include/asm/cmpxchg.h:14,
>                  from arch/arm64/include/asm/atomic.h:16,
>                  from include/linux/atomic.h:7,
>                  from include/asm-generic/bitops/atomic.h:5,
>                  from arch/arm64/include/asm/bitops.h:25,
>                  from include/linux/bitops.h:68,
>                  from arch/arm64/include/asm/cache.h:40,
>                  from include/linux/cache.h:6,
>                  from include/linux/slab.h:15,
>                  from include/linux/resource_ext.h:11,
>                  from include/linux/acpi.h:13,
>                  from include/acpi/apei.h:9,
>                  from include/acpi/ghes.h:5,
>                  from include/linux/arm_sdei.h:8,
>                  from arch/arm64/kernel/asm-offsets.c:10:
> include/linux/init.h:149:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
>   149 | extern char boot_command_line[] __ro_after_init;
>       |                                 ^~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   de2f542cfbec ("fs/proc: Add /proc/cmdline_load for boot loader arguments")
> 
> I have applied the following fix up (I have a faint memory that the
> section setting attributes are only needed on the definition, not the
> declaration):
> 
> From 9f56e539ed7d9c402caa85d4f5f3f8cec8373b2f Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 27 Jul 2023 13:26:08 +1000
> Subject: [PATCH] fix up for "fs/proc: Add /proc/cmdline_load for boot loader
>  arguments"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thank you, Stephen, I will adjust the commit as shown below.

							Thanx, Paul

> ---
>  include/linux/init.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index e3ce68988e1b..c075983c5015 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -113,8 +113,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/cache.h>
> -
>  /*
>   * Used for initialization calls..
>   */
> @@ -146,7 +144,7 @@ struct file_system_type;
>  
>  /* Defined in init/main.c */
>  extern int do_one_initcall(initcall_t fn);
> -extern char boot_command_line[] __ro_after_init;
> +extern char boot_command_line[];
>  extern char *saved_command_line;
>  extern unsigned int saved_command_line_len;
>  extern unsigned int reset_devices;
> -- 
> 2.40.1
> 
> -- 
> Cheers,
> Stephen Rothwell


