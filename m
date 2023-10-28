Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A47DA701
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjJ1Mhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Mhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D98B4;
        Sat, 28 Oct 2023 05:37:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97831C433C8;
        Sat, 28 Oct 2023 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698496663;
        bh=TVoco+AzDRBF0NOEmoQSKHl1rwpR7Tej2rKXmSgrB/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpxQ9Pxx92B9yi2W2q0u+w+t1U4x0W6ly/t+hRtFyZxbjW/IRo8JHv8fP8yD0F/xY
         EQnE/gVYqz0fcJdUcfLme6Ks55xIyy8Zje7S6v6QbcwWb/JeWWq9JnEzgTSUXW4/kg
         6ZPmRxLX5FhIxh5nbge+sCUpLG4lY1hPytosQVNbKNa7JBxg2aVOsPqCfuGudb+c0g
         ncBx03pML4dk+ufsQp6P3qnfbywSfYVtkMsMw5p0CXj7E5vRicyJONhAPG2OlzxM6L
         crgOfh1ViarxBTNWQAoqApdNfj1gTrlq1HQ+HsAPKihcuZ8jcnaAAsA7L53nofDClO
         vHxogP2/XVWOA==
Date:   Sat, 28 Oct 2023 21:37:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        oe-kbuild-all@lists.linux.dev, suleiman@google.com,
        briannorris@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231028213738.476725c68a1473e1418231b0@kernel.org>
In-Reply-To: <202310281942.ZwkSMsVB-lkp@intel.com>
References: <169845668624.1319505.1097714089024984847.stgit@mhiramat.roam.corp.google.com>
        <202310281942.ZwkSMsVB-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 19:26:10 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.6-rc7 next-20231027]
> [cannot apply to pavel-leds/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/PM-sleep-Expose-last-succeeded-resumed-timestamp-in-sysfs/20231028-093251
> base:   linus/master
> patch link:    https://lore.kernel.org/r/169845668624.1319505.1097714089024984847.stgit%40mhiramat.roam.corp.google.com
> patch subject: [PATCH v2] PM: sleep: Expose last succeeded resumed timestamp in sysfs
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231028/202310281942.ZwkSMsVB-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281942.ZwkSMsVB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310281942.ZwkSMsVB-lkp@intel.com/

Oops, I missed casting. Let me fix it.

Thanks,

> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/power/main.c: In function 'last_success_resume_time_show':
> >> kernel/power/main.c:427:38: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Wformat=]
>      427 |         return sprintf(buf, "%llu.%llu\n",
>          |                                   ~~~^
>          |                                      |
>          |                                      long long unsigned int
>          |                                   %lu
>      428 |                        suspend_stats.last_success_resume_time.tv_sec,
>      429 |                        suspend_stats.last_success_resume_time.tv_nsec);
>          |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                              |
>          |                                                              long int
>    kernel/power/main.c: In function 'suspend_stats_show':
>    kernel/power/main.c:528:62: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Wformat=]
>      528 |         seq_printf(s,   "last_success_resume_time:\t%-llu.%llu\n",
>          |                                                           ~~~^
>          |                                                              |
>          |                                                              long long unsigned int
>          |                                                           %lu
>      529 |                    suspend_stats.last_success_resume_time.tv_sec,
>      530 |                    suspend_stats.last_success_resume_time.tv_nsec);
>          |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                          |
>          |                                                          long int
> 
> 
> vim +427 kernel/power/main.c
> 
>    423	
>    424	static ssize_t last_success_resume_time_show(struct kobject *kobj,
>    425			struct kobj_attribute *attr, char *buf)
>    426	{
>  > 427		return sprintf(buf, "%llu.%llu\n",
>    428			       suspend_stats.last_success_resume_time.tv_sec,
>    429			       suspend_stats.last_success_resume_time.tv_nsec);
>    430	}
>    431	static struct kobj_attribute last_success_resume_time =
>    432				__ATTR_RO(last_success_resume_time);
>    433	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
