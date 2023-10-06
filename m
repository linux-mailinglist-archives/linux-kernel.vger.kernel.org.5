Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1967BC093
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjJFUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJFUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:42:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CDC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624955; x=1728160955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jiITkl0m/f62n06eNDckFeQStKeEIqe8acfOfHMmOjA=;
  b=E/gZ/9j9oey7wW5SentGuqvFYwnzycSPsSlF4u3gVLcWovXnUZVSOUtT
   0+qOk1n5DP7oYu6JuBVmcU32LZ8vqZC4QT7AVtYxeSiaOZnRh2+kiJzVv
   4MSwP1DTlxge9F0xMfWkCP84+VhLmjleVg2p9QTuH371b2mcTxpJSNaq5
   4Jwfd+MdD81CQUXGLVUIchvesZSBukqBIV2Kc/jM+d6V0A7wmc0CkiitQ
   d/TQELDyPJxsv4cfi2ch/wEoRzL7esKuE6EI8h5kDbFTup3oOKWSl70RL
   PH4ohkVBqtD6nl7C2xdGL5M6PHspd7QJAZMroHSPAVnA8vANEAcZezgH0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5387518"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5387518"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752300234"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752300234"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2023 13:42:32 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoreX-0003d9-34;
        Fri, 06 Oct 2023 20:42:29 +0000
Date:   Sat, 7 Oct 2023 04:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Subject: fs/smb/server/vfs.c:929: warning: Function parameter or member
 'path' not described in 'ksmbd_vfs_setxattr'
Message-ID: <202310070441.73IUVG65-lkp@intel.com>
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

Hi Namjae,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 40b268d384a22276dca1450549f53eed60e21deb ksmbd: add mnt_want_write to ksmbd vfs functions
date:   4 months ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310070441.73IUVG65-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070441.73IUVG65-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070441.73IUVG65-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/smb/server/vfs.c:54: warning: Function parameter or member 'parent' not described in 'ksmbd_vfs_lock_parent'
   fs/smb/server/vfs.c:54: warning: Function parameter or member 'child' not described in 'ksmbd_vfs_lock_parent'
   fs/smb/server/vfs.c:372: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_read'
   fs/smb/server/vfs.c:372: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_read'
   fs/smb/server/vfs.c:488: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_write'
   fs/smb/server/vfs.c:488: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_write'
   fs/smb/server/vfs.c:551: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:551: warning: Function parameter or member 'stat' not described in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:551: warning: Excess function parameter 'work' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:551: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:551: warning: Excess function parameter 'attrs' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:568: warning: Function parameter or member 'p_id' not described in 'ksmbd_vfs_fsync'
   fs/smb/server/vfs.c:591: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:591: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:591: warning: Excess function parameter 'name' description in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:634: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_link'
   fs/smb/server/vfs.c:811: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_truncate'
   fs/smb/server/vfs.c:811: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_truncate'
   fs/smb/server/vfs.c:852: warning: Excess function parameter 'size' description in 'ksmbd_vfs_listxattr'
>> fs/smb/server/vfs.c:929: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_setxattr'
>> fs/smb/server/vfs.c:929: warning: Excess function parameter 'dentry' description in 'ksmbd_vfs_setxattr'
   fs/smb/server/vfs.c:954: warning: Function parameter or member 'option' not described in 'ksmbd_vfs_set_fadvise'
   fs/smb/server/vfs.c:954: warning: Excess function parameter 'options' description in 'ksmbd_vfs_set_fadvise'
   fs/smb/server/vfs.c:1168: warning: Function parameter or member 'um' not described in 'ksmbd_vfs_lookup_in_dir'
   fs/smb/server/vfs.c:1203: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_kern_path_locked'


vim +929 fs/smb/server/vfs.c

f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  914  
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  915  /**
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  916   * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  917   * @idmap:	idmap of the relevant mount
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  918   * @dentry:	dentry to set XATTR at
63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  919   * @attr_name:	xattr name for setxattr
63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  920   * @attr_value:	xattr value to set
63f09a9986eb58 fs/ksmbd/vfs.c      Jiapeng Chong     2023-02-08  921   * @attr_size:	size of xattr value
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  922   * @flags:	destination buffer length
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  923   *
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  924   * Return:	0 on success, otherwise error
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  925   */
4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  926  int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  927  		       const struct path *path, const char *attr_name,
0c5fd887d2bb47 fs/ksmbd/vfs.c      Christian Brauner 2022-07-06  928  		       void *attr_value, size_t attr_size, int flags)
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16 @929  {
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  930  	int err;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  931  
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  932  	err = mnt_want_write(path->mnt);
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  933  	if (err)
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  934  		return err;
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  935  
4609e1f18e19c3 fs/ksmbd/vfs.c      Christian Brauner 2023-01-13  936  	err = vfs_setxattr(idmap,
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  937  			   path->dentry,
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  938  			   attr_name,
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  939  			   attr_value,
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  940  			   attr_size,
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  941  			   flags);
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  942  	if (err)
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  943  		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
40b268d384a222 fs/smb/server/vfs.c Namjae Jeon       2023-06-15  944  	mnt_drop_write(path->mnt);
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  945  	return err;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  946  }
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon       2021-03-16  947  

:::::: The code at line 929 was first introduced by commit
:::::: f44158485826c076335d6860d35872271a83791d cifsd: add file operations

:::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
:::::: CC: Steve French <stfrench@microsoft.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
