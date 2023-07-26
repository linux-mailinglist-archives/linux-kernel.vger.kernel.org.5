Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99961764232
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGZWhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGZWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFC213E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BF461CA5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79064C433C8;
        Wed, 26 Jul 2023 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690411037;
        bh=WQQupSmjofBDGu3HAWnE4eKHbclJmF4hABAfTGQqCqk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lOVa5zywy7T5xc8E9ZvlmdYomFEBWUGuFmz4QDkJh8cczy9Y282mkUXsTyBssNggF
         XjodvpY51KjHX7YQinTCALQSbuhRxmKIdEaOr672xE5afUNc7qGEXX/dEWorMUN60F
         9lyaSw+lcbunsmQLGRT4E5J2VEyGoTGN52bN1YbqBlAHHHVrLCvn5fiW9cJFS+EyEq
         jXMCov2Ls1ITV8VPngukd5zTmNlu1asyBEAL3ULA3yQLns6CK+RSatgdxMXt9a+0hn
         Ir6ZDytzkyyMq/8rHuu+RWB1+a/N2K92qYYbHIDh5BwAaRw1XvRRbXJtMWAvhpl6k/
         oFPZ+G52t0zpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16FDACE0A1C; Wed, 26 Jul 2023 15:37:17 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:37:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [paulmck-rcu:dev.2023.07.24a 26/26] include/linux/init.h:149:33:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 '__ro_after_init'
Message-ID: <085969b7-4668-4839-9352-9e7e5a37e58f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202307270622.15fzt0V1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307270622.15fzt0V1-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:11:50AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.24a
> head:   aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f
> commit: aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f [26/26] squash! fs/proc: Add /proc/cmdline_load for boot loader arguments
> config: parisc-randconfig-r006-20230726 (https://download.01.org/0day-ci/archive/20230727/202307270622.15fzt0V1-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270622.15fzt0V1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307270622.15fzt0V1-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/parisc/include/asm/alternative.h:18,
>                     from arch/parisc/include/asm/cache.h:9,
>                     from include/linux/cache.h:6,
>                     from include/linux/slab.h:15,
>                     from drivers/w1/w1_netlink.c:6:
> >> include/linux/init.h:149:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'
>      149 | extern char boot_command_line[] __ro_after_init;
>          |                                 ^~~~~~~~~~~~~~~

This is since fixed courtesy of fixes from Stephen Rothwell and Arnd
Bergmann, which I folded into the original:

de2f542cfbec ("fs/proc: Add /proc/cmdline_load for boot loader arguments")

							Thanx, Paul

> --
>    In file included from include/linux/init.h:116,
>                     from arch/parisc/include/asm/alternative.h:18,
>                     from arch/parisc/include/asm/cache.h:9,
>                     from arch/parisc/include/asm/page.h:23,
>                     from arch/parisc/include/asm/pgtable.h:5,
>                     from include/linux/pgtable.h:6,
>                     from arch/parisc/include/asm/io.h:6,
>                     from drivers/w1/w1_io.c:6:
> >> include/linux/cache.h:72:31: error: 'L1_CACHE_SHIFT' undeclared here (not in a function); did you mean 'L1_CACHE_ALIGN'?
>       72 | #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
>          |                               ^~~~~~~~~~~~~~
>    include/linux/cache.h:78:42: note: in expansion of macro 'INTERNODE_CACHE_SHIFT'
>       78 |         __attribute__((__aligned__(1 << (INTERNODE_CACHE_SHIFT))))
>          |                                          ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/cache.h:95:3: note: in expansion of macro '____cacheline_internodealigned_in_smp'
>       95 | } ____cacheline_internodealigned_in_smp;
>          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/parisc/include/asm/cache.h:23: warning: "ARCH_DMA_MINALIGN" redefined
>       23 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
>          | 
>    include/linux/cache.h:104: note: this is the location of the previous definition
>      104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
>          | 
> >> arch/parisc/include/asm/cache.h:25: warning: "__read_mostly" redefined
>       25 | #define __read_mostly __section(".data..read_mostly")
>          | 
>    include/linux/cache.h:28: note: this is the location of the previous definition
>       28 | #define __read_mostly
>          | 
> 
> 
> vim +149 include/linux/init.h
> 
>    146	
>    147	/* Defined in init/main.c */
>    148	extern int do_one_initcall(initcall_t fn);
>  > 149	extern char boot_command_line[] __ro_after_init;
>    150	extern char *saved_command_line;
>    151	extern unsigned int saved_command_line_len;
>    152	extern unsigned int reset_devices;
>    153	extern char saved_bootconfig_string[];
>    154	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
