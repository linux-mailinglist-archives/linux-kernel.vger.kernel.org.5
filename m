Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED737A681D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjISPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjISPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:30:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7391
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695137429; x=1726673429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MsE14CnEQ9aXQLzzlGN0I8iIzWpQf9wpHth+Ryz1iTw=;
  b=RD1X1ylHy5sZSW8BG2YvHCw1I3e8vAh6JbaGBU+Vjakz7/UZ0GlRbAMe
   n8OFY6YH43wvh7SvpKcermtbXch60TWLJUj4RFmgR9k1xtkvLlz2RGuYE
   01SWKiRPRpisFMsNSXL1GA8Dpv5d9/ezI7PmB3JtQl+nUX4B3GAn7u930
   5YLwydET0RreN2fvyS+UZ2WSueMN1SwCHOeW7onAuwRauBBsLe9x9tkdw
   2EjrX+skN8yjwsZvuVMH+7mFwUTtbkxKcMIbMGfc0X4hRktxDTFYQZqBv
   +sziMY6t3uLbYX0KMlpjkWYlhadZlzODsWB9zR1CK/o4X2Oqu6S+6iFmb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377287146"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="377287146"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 08:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077020769"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="1077020769"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2023 08:30:23 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qicg9-0007YE-0g;
        Tue, 19 Sep 2023 15:30:21 +0000
Date:   Tue, 19 Sep 2023 23:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/asm-generic/unaligned.h:14:15: warning: array subscript -1
 is outside array bounds of 'char[]'
Message-ID: <202309192322.kHMCRGo5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
date:   12 months ago
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230919/202309192322.kHMCRGo5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192322.kHMCRGo5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309192322.kHMCRGo5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/zboot.c:163:1: warning: no previous prototype for 'efi_zboot_entry' [-Wmissing-prototypes]
     163 | efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/loongarch/include/uapi/asm/byteorder.h:11,
                    from include/asm-generic/qrwlock_types.h:6,
                    from ./arch/loongarch/include/generated/asm/qrwlock_types.h:1,
                    from include/asm-generic/spinlock_types.h:13,
                    from ./arch/loongarch/include/generated/asm/spinlock_types.h:1,
                    from include/linux/spinlock_types_raw.h:7,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:21,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/proc_fs.h:10,
                    from include/linux/efi.h:19,
                    from drivers/firmware/efi/libstub/zboot.c:3:
   In function 'get_unaligned_le32',
       inlined from 'load_file' at drivers/firmware/efi/libstub/zboot.c:92:22:
>> include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds=]
      14 |         __pptr->x;                                                              \
         |         ~~~~~~^~~
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   include/asm-generic/unaligned.h:32:28: note: in expansion of macro '__get_unaligned_t'
      32 |         return le32_to_cpu(__get_unaligned_t(__le32, p));
         |                            ^~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/zboot.c: In function 'load_file':
   drivers/firmware/efi/libstub/zboot.c:33:30: note: at offset -4 into object '_gzdata_end' of size [0, 9223372036854775807]
      33 | extern char _gzdata_start[], _gzdata_end[];
         |                              ^~~~~~~~~~~


vim +14 include/asm-generic/unaligned.h

aafe4dbed0bf6c Arnd Bergmann 2009-05-13  11  
803f4e1eab7a89 Arnd Bergmann 2021-05-08  12  #define __get_unaligned_t(type, ptr) ({						\
803f4e1eab7a89 Arnd Bergmann 2021-05-08  13  	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @14  	__pptr->x;								\
803f4e1eab7a89 Arnd Bergmann 2021-05-08  15  })
803f4e1eab7a89 Arnd Bergmann 2021-05-08  16  

:::::: The code at line 14 was first introduced by commit
:::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
