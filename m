Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD678CB91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjH2Ruy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbjH2Ruu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:50:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC6DE9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693331447; x=1724867447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4QxiCQjQW/UnKH6n0uDRKOzqFIqrY2QFeJcA2859rhM=;
  b=f35Ns6Onscf5x0hKaucIi9OElG8Hw7VInPvG6CkvTAvGsF9yUgP4NNW6
   F6H2Sp3MEmBHo9ISpLmw1FcIMbfzEz1LXJbDTkVShXGpCVAeT3ZJJCIAL
   +sNHEG3hou/7Bs+LTZuVex0JO4ZtY4AMKb1H1kGsowxsFruS08RiLbyCz
   W5O2ZZPiOvcNQjPkizma0DvcF+6bxtmcJNbsLjuv6xrz4neS4v04oMXod
   K6esvEiKhCTJ7loA8cgPBLL4e8cf+odAEiNUZgD6hBhCZE4YJGN5/O7Zw
   8AQBfZ7Y2Lv7ZKeSabJ3IgDgyv4u5R2rj8d39C9OBzChInmdKXFPcU2ev
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439392188"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439392188"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 10:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808786659"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="808786659"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 10:50:43 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb2rT-0008yZ-0a;
        Tue, 29 Aug 2023 17:50:43 +0000
Date:   Wed, 30 Aug 2023 01:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ALSA: control: Use list_for_each_entry_safe()
Message-ID: <202308300128.l96uIvcS-lkp@intel.com>
References: <20230829142307.3916823-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829142307.3916823-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.5 next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ALSA-control-Use-list_for_each_entry_safe/20230829-222521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230829142307.3916823-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/1] ALSA: control: Use list_for_each_entry_safe()
config: i386-buildonly-randconfig-001-20230829 (https://download.01.org/0day-ci/archive/20230830/202308300128.l96uIvcS-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300128.l96uIvcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300128.l96uIvcS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/core/control_led.c:304:3: error: assigning to 'struct snd_ctl_led_ctl' from incompatible type 'typeof (*(lctl)) *' (aka 'struct snd_ctl_led_ctl *'); dereference with *
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:777:5: note: expanded from macro 'list_for_each_entry_safe'
                   n = list_next_entry(pos, member);                       \
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/core/control_led.c:304:3: error: assigning to 'struct snd_ctl_led_ctl *' from incompatible type 'struct snd_ctl_led_ctl'; take the address with &
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^                              ~~~~~
                                                  &
   include/linux/list.h:779:11: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                    ^ ~
>> sound/core/control_led.c:304:3: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
>> sound/core/control_led.c:304:3: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
>> sound/core/control_led.c:304:3: error: indirection requires pointer operand ('struct snd_ctl_led_ctl' invalid)
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:40: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   include/linux/list.h:520:20: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
>> sound/core/control_led.c:304:3: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
>> sound/core/control_led.c:304:3: error: indirection requires pointer operand ('struct snd_ctl_led_ctl' invalid)
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:40: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   include/linux/list.h:520:20: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/container_of.h:23:4: note: expanded from macro 'container_of'
           ((type *)(__mptr - offsetof(type, member))); })
             ^~~~
>> sound/core/control_led.c:304:3: error: indirection requires pointer operand ('struct snd_ctl_led_ctl' invalid)
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:40: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   include/linux/list.h:520:20: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/container_of.h:23:30: note: expanded from macro 'container_of'
           ((type *)(__mptr - offsetof(type, member))); })
                              ~~~~~~~~~^~~~~~~~~~~~~
   include/linux/stddef.h:16:51: note: expanded from macro 'offsetof'
   #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
                                                      ^~~~
>> sound/core/control_led.c:304:3: error: assigning to 'struct snd_ctl_led_ctl' from incompatible type 'void'
                   list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:18: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/control_led.c:329:2: error: assigning to 'struct snd_ctl_led_ctl' from incompatible type 'typeof (*(lctl)) *' (aka 'struct snd_ctl_led_ctl *'); dereference with *
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:777:5: note: expanded from macro 'list_for_each_entry_safe'
                   n = list_next_entry(pos, member);                       \
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/core/control_led.c:329:2: error: assigning to 'struct snd_ctl_led_ctl *' from incompatible type 'struct snd_ctl_led_ctl'; take the address with &
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^                              ~~~~~
                                          &
   include/linux/list.h:779:11: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                    ^ ~
   sound/core/control_led.c:329:2: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
           void *__mptr = (void *)(ptr);                                   \
                                   ^~~
   sound/core/control_led.c:329:2: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   sound/core/control_led.c:329:2: error: indirection requires pointer operand ('struct snd_ctl_led_ctl' invalid)
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:40: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   include/linux/list.h:520:20: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   sound/core/control_led.c:329:2: error: member reference type 'struct snd_ctl_led_ctl' is not a pointer; did you mean to use '.'?
           list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:779:20: note: expanded from macro 'list_for_each_entry_safe'
                pos = n, n = list_next_entry(n, member))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:564:18: note: expanded from macro 'list_next_entry'
           list_entry((pos)->member.next, typeof(*(pos)), member)
           ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:520:15: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:338:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   sound/core/control_led.c:329:2: error: indirection requires pointer operand ('struct snd_ctl_led_ctl' invalid)


vim +304 sound/core/control_led.c

   295	
   296	static void snd_ctl_led_clean(struct snd_card *card)
   297	{
   298		unsigned int group;
   299		struct snd_ctl_led *led;
   300		struct snd_ctl_led_ctl *lctl, _lctl;
   301	
   302		for (group = 0; group < MAX_LED; group++) {
   303			led = &snd_ctl_leds[group];
 > 304			list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
   305				if (!card || lctl->card == card)
   306					snd_ctl_led_ctl_destroy(lctl);
   307		}
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
