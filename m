Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCD7E1235
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKEDtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKEDtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:49:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F5D6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699156139; x=1730692139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tbWPIv9LKZDFPModWFk9rgmA/NehZrAhXyugcHnZFPQ=;
  b=UemDAxXpIz5Jz2YFpQRdp8+OnfgLizU5MG0pzWSPD8TjIDUU47iNEbTU
   5dRMwZH2M7D7uYfzTdRjCR6yJQtHgGaH+6lJCT7FyGXZL/qblfr8rktDw
   pxIyhz49bkB0TceOH3MTqJVjIja1Own6Mm1lax1ZW+hoySyb6l19RwdmM
   WE62az8gbhfSY/5V1SACVf7VsLuHx2nVKIt6jZntnJMpK2iOX4a177R1e
   +pASbSHNuN5gkW79GfzJCt/Eh7g5DJ93EbVG+Pz6uUTGD6p1DqbAi5VyR
   IGV8gw137yF5Tm9bEyET5wnCAPVMtVLH1H933vvPF+wwJbcREbG3gEXJZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="475358748"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="475358748"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 20:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="3294375"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Nov 2023 20:48:57 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzU87-0004zQ-1U;
        Sun, 05 Nov 2023 03:48:55 +0000
Date:   Sun, 5 Nov 2023 11:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: fs/vboxsf/vboxsf_wrappers.c:132: warning: Function parameter or
 member 'create_parms' not described in 'vboxsf_create'
Message-ID: <202311051104.VxtpAuZ7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 0fd169576648452725fa2949bf391d10883d3991 fs: Add VirtualBox guest shared folder (vboxsf) support
date:   3 years, 9 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231105/202311051104.VxtpAuZ7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051104.VxtpAuZ7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051104.VxtpAuZ7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/vboxsf/vboxsf_wrappers.c:132: warning: Function parameter or member 'create_parms' not described in 'vboxsf_create'
>> fs/vboxsf/vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'


vim +132 fs/vboxsf/vboxsf_wrappers.c

   112	
   113	/**
   114	 * vboxsf_create - Create a new file or folder
   115	 * @root:         Root of the shared folder in which to create the file
   116	 * @parsed_path:  The path of the file or folder relative to the shared folder
   117	 * @param:        create_parms Parameters for file/folder creation.
   118	 *
   119	 * Create a new file or folder or open an existing one in a shared folder.
   120	 * Note this function always returns 0 / success unless an exceptional condition
   121	 * occurs - out of memory, invalid arguments, etc. If the file or folder could
   122	 * not be opened or created, create_parms->handle will be set to
   123	 * SHFL_HANDLE_NIL on return.  In this case the value in create_parms->result
   124	 * provides information as to why (e.g. SHFL_FILE_EXISTS), create_parms->result
   125	 * is also set on success as additional information.
   126	 *
   127	 * Returns:
   128	 * 0 or negative errno value.
   129	 */
   130	int vboxsf_create(u32 root, struct shfl_string *parsed_path,
   131			  struct shfl_createparms *create_parms)
 > 132	{
   133		struct shfl_create parms;
   134	
   135		parms.root.type = VMMDEV_HGCM_PARM_TYPE_32BIT;
   136		parms.root.u.value32 = root;
   137	
   138		parms.path.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
   139		parms.path.u.pointer.size = shfl_string_buf_size(parsed_path);
   140		parms.path.u.pointer.u.linear_addr = (uintptr_t)parsed_path;
   141	
   142		parms.parms.type = VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL;
   143		parms.parms.u.pointer.size = sizeof(struct shfl_createparms);
   144		parms.parms.u.pointer.u.linear_addr = (uintptr_t)create_parms;
   145	
   146		return vboxsf_call(SHFL_FN_CREATE, &parms, SHFL_CPARMS_CREATE, NULL);
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
