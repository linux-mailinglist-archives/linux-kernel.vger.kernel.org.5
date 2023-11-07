Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143997E4906
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjKGTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjKGTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:13:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3210A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384384; x=1730920384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0lLQFBIia7+TBK5Op3eAL1ddS0rV0CyVADAlwtTJleA=;
  b=C7QKqvpj0YYq0atIvUx1hKYB7zm34eHbJIGUHpme04Y+ie5A1bN8pR6c
   e134GbLcEl+suV7bQJNPn8lmdncBhCIb6tXk4351sZ5R8+G+XuvFXb6l/
   YMevZiR1DLQ31W1l06H3j3RDKY8ohzN541lC/aFLhrHJEaj2TlvrG0hUM
   dobfO+S/pJoeRwkhGXC+gadbnLn6iaRLkSQ3WdV7A7bp4giYl7/S/aBa+
   jhvv3ir7zQWYyLsmZ/xMiaNrfIHTWdij74rPv/wgfWxrndhHBFe3UNMh3
   2AlsrVAhKaInQK2LwuuIP1090rjWrMt7Ukp4/uPqxoGlHgFEQQpZBFmhE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374625651"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374625651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="936262428"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="936262428"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2023 11:13:02 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0RVT-0007Km-1s;
        Tue, 07 Nov 2023 19:12:59 +0000
Date:   Wed, 8 Nov 2023 03:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: include/linux/compiler_types.h:82:5: sparse: sparse: undefined
 preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
Message-ID: <202311080222.eHfQxcpS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   10 months ago
config: um-randconfig-r122-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080222.eHfQxcpS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080222.eHfQxcpS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080222.eHfQxcpS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/um/kernel/config.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/kernel/config.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/kernel/config.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/drivers/fd.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/drivers/fd.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/drivers/fd.c: note: in included file (through arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/drivers/chan_user.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/drivers/chan_user.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/drivers/chan_user.c: note: in included file (through arch/um/include/shared/init.h, arch/um/drivers/chan_user.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/main.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/main.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/main.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/main.c:187:6: sparse: sparse: symbol '__wrap_malloc' was not declared. Should it be static?
   arch/um/os-Linux/main.c:208:6: sparse: sparse: symbol '__wrap_calloc' was not declared. Should it be static?
   arch/um/os-Linux/main.c:222:6: sparse: sparse: symbol '__wrap_free' was not declared. Should it be static?
--
   arch/um/os-Linux/mem.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/mem.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/mem.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/process.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/process.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/process.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/sigio.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/sigio.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/sigio.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/start_up.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/start_up.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/start_up.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/umid.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/umid.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/umid.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/util.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/util.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/util.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/util.c:93:48: sparse: sparse: Using plain integer as NULL pointer
--
   arch/um/os-Linux/skas/mem.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/skas/mem.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/skas/mem.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
--
   arch/um/os-Linux/skas/process.c: note: in included file (through include/linux/compiler_types.h, arch/um/include/shared/init.h):
   include/linux/compiler_attributes.h:55:9: sparse: sparse: preprocessor token __always_inline redefined
   arch/um/os-Linux/skas/process.c: note: in included file (through /usr/include/features.h, /usr/include/sys/types.h, arch/um/include/shared/user.h, builtin):
   /usr/include/sys/cdefs.h:426:10: sparse: this was the original definition
   arch/um/os-Linux/skas/process.c: note: in included file (through arch/um/include/shared/init.h):
>> include/linux/compiler_types.h:82:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_FUNCTION_ALIGNMENT'
   arch/um/os-Linux/skas/process.c:300:5: sparse: sparse: symbol 'kill_userspace_mm' was not declared. Should it be static?

vim +/CONFIG_FUNCTION_ALIGNMENT +82 include/linux/compiler_types.h

    81	
  > 82	#if CONFIG_FUNCTION_ALIGNMENT > 0
    83	#define __function_aligned		__aligned(CONFIG_FUNCTION_ALIGNMENT)
    84	#else
    85	#define __function_aligned
    86	#endif
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
