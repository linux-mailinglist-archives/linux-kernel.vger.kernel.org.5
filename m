Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D97E8F2C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 09:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKLI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjKLI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 03:27:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0A2D73;
        Sun, 12 Nov 2023 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699777667; x=1731313667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SRwwL6be49QrhtrbCrgRdGumKxy/22938qANWee9Ndg=;
  b=ASZqd+foYj5+2PCd+urCSg1zKkIHSEkCIQKG/3T2p2AxcZKAB7fcredx
   IM/vgkaULDYOhI6uXsNdnRF2gJCva24rhZnPM4cAeF37y0vpRwCRKIvDz
   8yhFs6fgY0W63FGDC3AO40kmo+keRhOvEUT4fXZUwcbc5tpRiACVmzpu0
   AFjVbUQv5CiI5R2zyBsG92PGonEpn9+VkBPLWqKwXlGr9JFbK2Nsu0s8n
   Qelbb96binB35BGq8V9twvyuFRiNgViU0+3jJiTBjeN8FaJN9jdU1gteh
   ro0Oi8RHF6Fs+8odkRVpgsnl5diAjvRpyOPJ/ZuzcdhxnjCELfSq+QgPd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="393186310"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="393186310"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 00:27:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713964310"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="713964310"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Nov 2023 00:27:45 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r25ok-000B22-2O;
        Sun, 12 Nov 2023 08:27:42 +0000
Date:   Sun, 12 Nov 2023 16:26:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, linux-doc@vger.kernel.org
Subject: fs/overlayfs/util.c:352: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202311121628.byHp8tkv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b907d0507354b74a4f2c286380cd6059af79248
commit: ad0af7104dadccd55cd2b390271677fac142650f vfs: introduce inode 'inuse' lock
date:   6 years ago
config: x86_64-randconfig-a001-20230604 (https://download.01.org/0day-ci/archive/20231112/202311121628.byHp8tkv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121628.byHp8tkv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311121628.byHp8tkv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/overlayfs/util.c:352: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Caller must hold a reference to inode to prevent it from being freed while


vim +352 fs/overlayfs/util.c

   350	
   351	/**
 > 352	 * Caller must hold a reference to inode to prevent it from being freed while
   353	 * it is marked inuse.
   354	 */
   355	bool ovl_inuse_trylock(struct dentry *dentry)
   356	{
   357		struct inode *inode = d_inode(dentry);
   358		bool locked = false;
   359	
   360		spin_lock(&inode->i_lock);
   361		if (!(inode->i_state & I_OVL_INUSE)) {
   362			inode->i_state |= I_OVL_INUSE;
   363			locked = true;
   364		}
   365		spin_unlock(&inode->i_lock);
   366	
   367		return locked;
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
