Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57C7CEC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJSALo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:11:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCEFFA;
        Wed, 18 Oct 2023 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697674300; x=1729210300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lfHfhXx4PmjARlwECHoOSOd7MwM+0A7zoQb6TM0qST4=;
  b=P7cOSq46U9jQDcDzdAkjTM6PMs6iCttj9igkzFFwKEtvMNGj/LIyHRlr
   dCtEfjxoK/yV2N9ZEdVybZFbVt1Fjhr0cKHffQgSWDaR89ojhAchEnJ5B
   uV8KGoTgSlgYNPMqTL00HV41TZlE4GGi5yUWzr6sE9XblHiZtXepPOqNx
   1+BLaJMLr32Fmuu9qhphYMD2BaR3GjYWfverSRUylCu4AWX+iIcjnTPAm
   49IlBrIoBSd4BD1wHVWJfaU2QmADZ8z/4qzGaRKTXAbk2PNG5PCDlJxoK
   82FVx9vL9JQdnvko5hdxEwM1cRijzY4UoQ9Eo4vad2Jn+0+Wd1nRBBY1D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389002345"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="389002345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 17:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756799691"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756799691"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 17:11:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtGdR-0001JG-2c;
        Thu, 19 Oct 2023 00:11:33 +0000
Date:   Thu, 19 Oct 2023 08:10:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <202310190852.BCw4Ry7D-lkp@intel.com>
References: <20231017034356.1436677-2-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017034356.1436677-2-anshulusr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshul-Dalal/input-joystick-driver-for-Adafruit-Seesaw-Gamepad/20231017-160635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231017034356.1436677-2-anshulusr%40gmail.com
patch subject: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw Gamepad
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310190852.BCw4Ry7D-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190852.BCw4Ry7D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190852.BCw4Ry7D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:27,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from include/linux/delay.h:23,
                    from drivers/input/joystick/adafruit-seesaw.c:17:
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
>> include/linux/bitops.h:52:11: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
      52 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:61:41: note: in expansion of macro 'bitop'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                         ^~~~~
   drivers/input/joystick/adafruit-seesaw.c:89:27: note: in expansion of macro 'test_bit'
      89 |         data->button_a = !test_bit(BUTTON_A, (long *)&result);
         |                           ^~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In file included from include/linux/bitops.h:34:
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:89:20:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:90:20:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:91:20:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:92:20:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:93:24:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~
   In function 'generic_test_bit',
       inlined from 'seesaw_read_data' at drivers/input/joystick/adafruit-seesaw.c:94:25:
>> include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds=]
     128 |         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
         |                       ~~~~^~~~~~~~~~~~~~
   drivers/input/joystick/adafruit-seesaw.c: In function 'seesaw_read_data':
   drivers/input/joystick/adafruit-seesaw.c:87:13: note: object 'result' of size 4
      87 |         u32 result = get_unaligned_be32(&read_buf);
         |             ^~~~~~


vim +52 include/linux/bitops.h

0e862838f29014 Alexander Lobakin 2022-06-24  35  
b03fc1173c0c2b Alexander Lobakin 2022-06-24  36  /*
b03fc1173c0c2b Alexander Lobakin 2022-06-24  37   * Many architecture-specific non-atomic bitops contain inline asm code and due
b03fc1173c0c2b Alexander Lobakin 2022-06-24  38   * to that the compiler can't optimize them to compile-time expressions or
b03fc1173c0c2b Alexander Lobakin 2022-06-24  39   * constants. In contrary, generic_*() helpers are defined in pure C and
b03fc1173c0c2b Alexander Lobakin 2022-06-24  40   * compilers optimize them just well.
b03fc1173c0c2b Alexander Lobakin 2022-06-24  41   * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
b03fc1173c0c2b Alexander Lobakin 2022-06-24  42   * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
b03fc1173c0c2b Alexander Lobakin 2022-06-24  43   * the arguments can be resolved at compile time. That expression itself is a
b03fc1173c0c2b Alexander Lobakin 2022-06-24  44   * constant and doesn't bring any functional changes to the rest of cases.
b03fc1173c0c2b Alexander Lobakin 2022-06-24  45   * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
b03fc1173c0c2b Alexander Lobakin 2022-06-24  46   * passing a bitmap from .bss or .data (-> `!!addr` is always true).
b03fc1173c0c2b Alexander Lobakin 2022-06-24  47   */
e69eb9c460f128 Alexander Lobakin 2022-06-24  48  #define bitop(op, nr, addr)						\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  49  	((__builtin_constant_p(nr) &&					\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  50  	  __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) &&	\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  51  	  (uintptr_t)(addr) != (uintptr_t)NULL &&			\
b03fc1173c0c2b Alexander Lobakin 2022-06-24 @52  	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
b03fc1173c0c2b Alexander Lobakin 2022-06-24  53  	 const##op(nr, addr) : op(nr, addr))
e69eb9c460f128 Alexander Lobakin 2022-06-24  54  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
