Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8447977F313
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbjHQJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349534AbjHQJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3052D64;
        Thu, 17 Aug 2023 02:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBCA65138;
        Thu, 17 Aug 2023 09:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCB1C433C7;
        Thu, 17 Aug 2023 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692263796;
        bh=E1xYM3eicIY2J4yt1dfa9Zc0USpwfRjN/j9GTHStkK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4LpdgarkYOJtZ15VDnKThnh9eMePVRKBPf1FdgsJzZ/bItnsb+40z+OWdFqfr82o
         F15NkfthCAQ95a55659cBYBloXtT3atkdPxAT8N1bxSZxi1qWmFnkphBTRgI5WIZE2
         CwuJYMev/D9t8y4oAXAL8COZCes/9K61dmRKvmKuAHmDT1r4Plo0uiKet2mV3jVggI
         fBJ4XGFGksBTQ7NZGXM+lhFzg7ayfYdKLNllHVg3A9JHe3DYWlwIBSRIAfmzw0eHeS
         KTdHwgQx1b39K4pZvVqmDDZn/W7EEGCMgeGgjX5KGxVthtBV0rCajaAFSBUukxmgCV
         IQKqSCxnRa/yA==
Date:   Thu, 17 Aug 2023 10:16:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, Pavel Machek <pavel@ucw.cz>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Purdie <rpurdie@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] led: trig: timer: stop offloading on deactivation
Message-ID: <20230817091631.GH648357@google.com>
References: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
 <202307290641.SUCRTRMI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202307290641.SUCRTRMI-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023, kernel test robot wrote:

> Hi Daniel,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lee-leds/for-leds-next]
> [also build test WARNING on wireless-next/main wireless/main linus/master pavel-leds/for-next v6.5-rc3 next-20230728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/led-trig-timer-stop-offloading-on-deactivation/20230728-203243
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
> patch link:    https://lore.kernel.org/r/728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel%40makrotopia.org
> patch subject: [PATCH] led: trig: timer: stop offloading on deactivation
> config: mips-randconfig-r093-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290641.SUCRTRMI-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290641.SUCRTRMI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307290641.SUCRTRMI-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/leds/trigger/ledtrig-timer.c:129:47: sparse: sparse: Using plain integer as NULL pointer
>    drivers/leds/trigger/ledtrig-timer.c:129:50: sparse: sparse: Using plain integer as NULL pointer

Are you planning on fixing this?

> vim +129 drivers/leds/trigger/ledtrig-timer.c
> 
>    123	
>    124	static void timer_trig_deactivate(struct led_classdev *led_cdev)
>    125	{
>    126		/* Stop blinking */
>    127		led_set_brightness(led_cdev, LED_OFF);
>    128		if (led_cdev->blink_set)
>  > 129			led_cdev->blink_set(led_cdev, 0, 0);
>    130	}
>    131	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Lee Jones [李琼斯]
