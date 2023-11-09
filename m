Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492FC7E71BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjKISuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:50:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBED3C10
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699555829; x=1731091829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Z4qGI1HHgsyoHU13b0J59WH/c4N5Ztnuu67puAJx0g=;
  b=Lsf9Wx04/CW4M80dTi1OI1kTppx/XS31VNocX0nmdKosYjeS3yykZ3AE
   z4w8icoNK7oOVAIMDkUeYX1K7MEuGvvTCQNnYPyIMGGUaKBPNkF3g8R/1
   5U8DsUMEi6NUdZKzXRjVnBN9dtzXtxD3QPL4VoL8CDT0AOlQtij/NKced
   2pdAEVxou56pfNx/ydjFtG4+sid+q2rdOLyxj2JgdWS7iyjjxrS63vpF2
   iTuKgjWOw8wEzrMh2SoCwgy8vjXcBCeYYAFyilP/MWXIZKk3dd2TSgMCd
   CnXFkKNqkZx8q7As0hZdXI+YyTc9so79XBGRZ3o2AVWFkibNxltPE7aYD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375094086"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375094086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 10:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792639156"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="792639156"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2023 10:50:27 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1A6j-000936-07;
        Thu, 09 Nov 2023 18:50:25 +0000
Date:   Fri, 10 Nov 2023 02:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Omkar Wagle <ov.wagle@gmail.com>, hughd@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omkar Wagle <ov.wagle@gmail.com>
Subject: Re: [PATCH] MM: shmem: Remove code sytle warnings
Message-ID: <202311100217.l1zmB8In-lkp@intel.com>
References: <20231109062228.10227-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109062228.10227-1-ov.wagle@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Omkar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20231109]
[cannot apply to v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Omkar-Wagle/MM-shmem-Remove-code-sytle-warnings/20231109-163742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231109062228.10227-1-ov.wagle%40gmail.com
patch subject: [PATCH] MM: shmem: Remove code sytle warnings
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231110/202311100217.l1zmB8In-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100217.l1zmB8In-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100217.l1zmB8In-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/shmem.c:29:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> mm/shmem.c:4310:19: error: too few arguments provided to function-like macro invocation
    4310 |                                 L1_CACHE_BYTES), GFP_KERNEL);
         |                                               ^
   include/linux/minmax.h:169:9: note: macro 'max_t' defined here
     169 | #define max_t(type, x, y)       __careful_cmp(max, (type)(x), (type)(y))
         |         ^
>> mm/shmem.c:4309:19: error: use of undeclared identifier 'max_t'
    4309 |         sbinfo = kzalloc(max_t((int)sizeof(struct shmem_sb_info),
         |                          ^
   12 warnings and 2 errors generated.


vim +4310 mm/shmem.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  4300  
f32356261d44d5 David Howells   2019-03-25  4301  static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
^1da177e4c3f41 Linus Torvalds  2005-04-16  4302  {
f32356261d44d5 David Howells   2019-03-25  4303  	struct shmem_options *ctx = fc->fs_private;
^1da177e4c3f41 Linus Torvalds  2005-04-16  4304  	struct inode *inode;
0edd73b33426df Hugh Dickins    2005-06-21  4305  	struct shmem_sb_info *sbinfo;
71480663b751de Carlos Maiolino 2023-07-25  4306  	int error = -ENOMEM;
680d794babebc7 Andrew Morton   2008-02-08  4307  
680d794babebc7 Andrew Morton   2008-02-08  4308  	/* Round up to L1_CACHE_BYTES to resist false sharing */
1c6e8dc111cb86 Omkar Wagle     2023-11-08 @4309  	sbinfo = kzalloc(max_t((int)sizeof(struct shmem_sb_info),
680d794babebc7 Andrew Morton   2008-02-08 @4310  				L1_CACHE_BYTES), GFP_KERNEL);
680d794babebc7 Andrew Morton   2008-02-08  4311  	if (!sbinfo)
71480663b751de Carlos Maiolino 2023-07-25  4312  		return error;
680d794babebc7 Andrew Morton   2008-02-08  4313  
680d794babebc7 Andrew Morton   2008-02-08  4314  	sb->s_fs_info = sbinfo;
^1da177e4c3f41 Linus Torvalds  2005-04-16  4315  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
