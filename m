Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5D78BD71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjH2EJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjH2EJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:09:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B38102
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693282139; x=1724818139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JelNIEqHQVyEPPElaNX+PFjZlpmd2RjQ2b1G8zTUt6A=;
  b=hDl83JlCoF0GVSX9HCbTVR0OMa4Tkebh3TgsXuhBcycY9Ap+sXVGtYzu
   fcyXRtJilusgrka/EDV4B6oH2Xt3KHzX0JwK6RbvleRTiPN0Jcj09tCzB
   hU+SCDtHOjcR8mtML7WUbzHLFTMhvCZYFg1W7G4jofKT91t8HaBubcaqE
   WGJ/n/AuxZo/Da885d0BG0jvL1yDvn5pXnHFt+KJWmUt/LSoshcaqBK6Y
   /UiIixWNdyq7Fo6DofzEY7LdGTZj7Dx+xTfBuC9/u4JJzS6Qar6uvxb3y
   eF6WdBwacVfL3ASDk2GwJn4xL0tKu+AFQ5xVF13RkO6iFR+jD8T4uymI7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="379046310"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="379046310"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 21:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="808524340"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="808524340"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2023 21:08:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaq2C-0008N5-0n;
        Tue, 29 Aug 2023 04:08:56 +0000
Date:   Tue, 29 Aug 2023 12:07:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/cpu/amd.c:1289:6: warning: no previous prototype for
 function 'amd_check_microcode'
Message-ID: <202308291220.DOn00Y1A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c59d383390f970b891b503b7f79b63a02db2ec5
commit: 522b1d69219d8f083173819fde04f994aa051a98 x86/cpu/amd: Add a Zenbleed fix
date:   6 weeks ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230829/202308291220.DOn00Y1A-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308291220.DOn00Y1A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308291220.DOn00Y1A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/open.c:1167: warning: Function parameter or member 'real_path' not described in 'backing_file_open'
   fs/open.c:1561: warning: expecting prototype for close_range(). Prototype was for sys_close_range() instead
--
>> fs/namespace.c:3046: warning: Function parameter or member 'mp' not described in 'can_move_mount_beneath'
--
>> arch/x86/kernel/cpu/amd.c:1289:6: warning: no previous prototype for function 'amd_check_microcode' [-Wmissing-prototypes]
   void amd_check_microcode(void)
        ^
   arch/x86/kernel/cpu/amd.c:1289:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void amd_check_microcode(void)
   ^
   static 
   1 warning generated.
--
>> arch/x86/kernel/cpu/mtrr/generic.c:434: warning: Function parameter or member 'var' not described in 'mtrr_overwrite_state'
>> arch/x86/kernel/cpu/mtrr/generic.c:434: warning: Function parameter or member 'num_var' not described in 'mtrr_overwrite_state'
>> arch/x86/kernel/cpu/mtrr/generic.c:434: warning: Function parameter or member 'def_type' not described in 'mtrr_overwrite_state'
   arch/x86/kernel/cpu/mtrr/generic.c:504: warning: Function parameter or member 'start' not described in 'mtrr_type_lookup'
   arch/x86/kernel/cpu/mtrr/generic.c:504: warning: Function parameter or member 'end' not described in 'mtrr_type_lookup'
   arch/x86/kernel/cpu/mtrr/generic.c:504: warning: Function parameter or member 'uniform' not described in 'mtrr_type_lookup'
--
>> fs/exportfs/expfs.c:395: warning: Function parameter or member 'parent' not described in 'exportfs_encode_inode_fh'


vim +/amd_check_microcode +1289 arch/x86/kernel/cpu/amd.c

  1288	
> 1289	void amd_check_microcode(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
