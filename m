Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF877F150
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbjHQHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348527AbjHQHew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:34:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F482D69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692257678; x=1723793678;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=744qiTivAoAvtBvN7Yj4Ez7V6B10VGoNK+Nv7xkRTMU=;
  b=ScZcMB1N0pbdO8dAq9lThULjUYOF97cVRf2tWFKYnSPMtTmNW/tT4ALc
   qA1EflrMxpJzxuPULRQdp0y10BA0usd6KpqT4Jg7NmJ2mSXl5I7EkidAA
   mevNbq5t7KX7TsW4V4YxwACnptKxkD7zsNSPOgTfA4vvtNayHkb9viVw3
   GM6KM8KnCBft6VHVkT6UZhnelj7rYdWwS+E5Iz7oyPzMzWP0D7NTbl7nE
   FZACis7jN7eA3qxsfg/951HFSW7JSB7nEhy5UfrvHTD1HDxxiy3PRSxqB
   tpjxD2e7/KT5h+2anChlWdQZPTP/1CtYOzzz8AcQ7VjrqROhV0m6vVVmw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370206379"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="370206379"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065147790"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="1065147790"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 00:34:29 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWXWV-0000uX-0S;
        Thu, 17 Aug 2023 07:34:27 +0000
Date:   Thu, 17 Aug 2023 15:33:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Subject: fs/smb/server/vfs.c:1207: warning: Function parameter or member
 'parent_path' not described in 'ksmbd_vfs_kern_path_locked'
Message-ID: <202308171526.0mTJ7zrg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 2b57a4322b1b14348940744fdc02f9a86cbbdbeb ksmbd: check if a mount point is crossed during path lookup
date:   4 weeks ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308171526.0mTJ7zrg-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171526.0mTJ7zrg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171526.0mTJ7zrg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/smb/server/vfs.c:54: warning: Function parameter or member 'parent' not described in 'ksmbd_vfs_lock_parent'
   fs/smb/server/vfs.c:54: warning: Function parameter or member 'child' not described in 'ksmbd_vfs_lock_parent'
   fs/smb/server/vfs.c:375: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_read'
   fs/smb/server/vfs.c:375: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_read'
   fs/smb/server/vfs.c:492: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_write'
   fs/smb/server/vfs.c:492: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_write'
   fs/smb/server/vfs.c:555: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:555: warning: Function parameter or member 'stat' not described in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:555: warning: Excess function parameter 'work' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:555: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:555: warning: Excess function parameter 'attrs' description in 'ksmbd_vfs_getattr'
   fs/smb/server/vfs.c:572: warning: Function parameter or member 'p_id' not described in 'ksmbd_vfs_fsync'
   fs/smb/server/vfs.c:595: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:595: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:595: warning: Excess function parameter 'name' description in 'ksmbd_vfs_remove_file'
   fs/smb/server/vfs.c:638: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_link'
   fs/smb/server/vfs.c:815: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_truncate'
   fs/smb/server/vfs.c:815: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_truncate'
   fs/smb/server/vfs.c:856: warning: Excess function parameter 'size' description in 'ksmbd_vfs_listxattr'
   fs/smb/server/vfs.c:933: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_setxattr'
   fs/smb/server/vfs.c:933: warning: Excess function parameter 'dentry' description in 'ksmbd_vfs_setxattr'
   fs/smb/server/vfs.c:958: warning: Function parameter or member 'option' not described in 'ksmbd_vfs_set_fadvise'
   fs/smb/server/vfs.c:958: warning: Excess function parameter 'options' description in 'ksmbd_vfs_set_fadvise'
   fs/smb/server/vfs.c:1172: warning: Function parameter or member 'um' not described in 'ksmbd_vfs_lookup_in_dir'
   fs/smb/server/vfs.c:1207: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_kern_path_locked'
>> fs/smb/server/vfs.c:1207: warning: Function parameter or member 'parent_path' not described in 'ksmbd_vfs_kern_path_locked'


vim +1207 fs/smb/server/vfs.c

f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1194  
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1195  /**
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1196   * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1197   * @name:	file path that is relative to share
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1198   * @flags:	lookup flags
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1199   * @path:	if lookup succeed, return path info
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1200   * @caseless:	caseless filename lookup
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1201   *
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1202   * Return:	0 on success, otherwise error
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1203   */
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1204  int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1205  			       unsigned int flags, struct path *parent_path,
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1206  			       struct path *path, bool caseless)
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16 @1207  {
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1208  	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1209  	int err;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1210  
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1211  	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1212  					   path);
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1213  	if (!err)
cf5e7f734f4455 fs/smb/server/vfs.c Namjae Jeon   2023-05-30  1214  		return 0;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1215  
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1216  	if (caseless) {
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1217  		char *filepath;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1218  		size_t path_len, remain_len;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1219  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1220  		filepath = kstrdup(name, GFP_KERNEL);
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1221  		if (!filepath)
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1222  			return -ENOMEM;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1223  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1224  		path_len = strlen(filepath);
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1225  		remain_len = path_len;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1226  
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1227  		*parent_path = share_conf->vfs_path;
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1228  		path_get(parent_path);
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1229  
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1230  		while (d_can_lookup(parent_path->dentry)) {
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1231  			char *filename = filepath + path_len - remain_len;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1232  			char *next = strchrnul(filename, '/');
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1233  			size_t filename_len = next - filename;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1234  			bool is_last = !next[0];
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1235  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1236  			if (filename_len == 0)
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1237  				break;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1238  
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1239  			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
dbab80e2071ad8 fs/ksmbd/vfs.c      Atte Heikkilä 2022-09-28  1240  						      filename_len,
dbab80e2071ad8 fs/ksmbd/vfs.c      Atte Heikkilä 2022-09-28  1241  						      work->conn->um);
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1242  			if (err)
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1243  				goto out2;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1244  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1245  			next[0] = '\0';
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1246  
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1247  			err = vfs_path_lookup(share_conf->vfs_path.dentry,
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1248  					      share_conf->vfs_path.mnt,
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1249  					      filepath,
265fd1991c1db8 fs/ksmbd/vfs.c      Hyunchul Lee  2021-09-25  1250  					      flags,
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1251  					      path);
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1252  			if (err)
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1253  				goto out2;
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1254  			else if (is_last)
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1255  				goto out1;
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1256  			path_put(parent_path);
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1257  			*parent_path = *path;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1258  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1259  			next[0] = '/';
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1260  			remain_len -= filename_len + 1;
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1261  		}
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1262  
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1263  		err = -EINVAL;
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1264  out2:
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1265  		path_put(parent_path);
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1266  out1:
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1267  		kfree(filepath);
3c20378325c710 fs/cifsd/vfs.c      Hyunchul Lee  2021-04-13  1268  	}
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1269  
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1270  	if (!err) {
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1271  		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1272  		if (err) {
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1273  			path_put(path);
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1274  			path_put(parent_path);
2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon   2023-07-17  1275  		}
74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon   2023-04-21  1276  	}
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1277  	return err;
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1278  }
f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon   2021-03-16  1279  

:::::: The code at line 1207 was first introduced by commit
:::::: f44158485826c076335d6860d35872271a83791d cifsd: add file operations

:::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
:::::: CC: Steve French <stfrench@microsoft.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
