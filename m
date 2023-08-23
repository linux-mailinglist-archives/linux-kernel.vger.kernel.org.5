Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD24785E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHWRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjHWRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:22:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC82E67;
        Wed, 23 Aug 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692811337; x=1724347337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZbRmCx3FnjE1IPnG2qMSW8wsV/xlzM6uLH/OIlfDpQ=;
  b=SBu/MHuXMtj+sa1lEDlz7L9fGj4SQpU75JgR6Tcxn7WpzJZO6/GeBGrJ
   4bwrWhOUWEp9Ecp9oGPtSGBvm2oH3UDidcfLzB57d/+4JdmnScp4zqDUp
   AG93plVnK87keT8Vf1YlfaVxvtMLCajUYl5iBATaXKB4qVfBD8yC73czk
   B+b52Q77jKRU8i1pdqISRIzbchwwQmVTxLHvjnDTxlCggdrcQZLCTGf4V
   c+pcWLIx6euZXpPFOZWmzEpDP72sVstFqfTxoQZQpiCwhVBcDmEOsTfZ4
   FlGvz90L/zuHD+R3313+HMlN7Eq5isDwsL5joTVlLUzxLnYcrBF23WHbA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="377976901"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="377976901"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="730284644"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730284644"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2023 10:22:11 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYrYY-0001N1-2D;
        Wed, 23 Aug 2023 17:22:10 +0000
Date:   Thu, 24 Aug 2023 01:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ztarkhani@microsoft.com,
        alison.schofield@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] lsm: constify 'mnt_opts' parameter in
 security_free_mnt_opts()
Message-ID: <202308240128.Gsn0b0Fv-lkp@intel.com>
References: <ZOXG/VVC1XRc7TtI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXG/VVC1XRc7TtI@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khadija,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on pcmoore-audit/next linus/master v6.5-rc7 next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/lsm-constify-mnt_opts-parameter-in-security_free_mnt_opts/20230823-170310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/ZOXG%2FVVC1XRc7TtI%40gmail.com
patch subject: [PATCH] lsm: constify 'mnt_opts' parameter in security_free_mnt_opts()
config: riscv-randconfig-001-20230823 (https://download.01.org/0day-ci/archive/20230824/202308240128.Gsn0b0Fv-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240128.Gsn0b0Fv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240128.Gsn0b0Fv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/super.c:1523:25: error: passing 'void **' to parameter of type 'const void **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           security_free_mnt_opts(&new_sec_opts);
                                  ^~~~~~~~~~~~~
   include/linux/security.h:301:42: note: passing argument to parameter 'mnt_opts' here
   void security_free_mnt_opts(const void **mnt_opts);
                                            ^
   fs/btrfs/super.c:1536:25: error: passing 'void **' to parameter of type 'const void **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           security_free_mnt_opts(&new_sec_opts);
                                  ^~~~~~~~~~~~~
   include/linux/security.h:301:42: note: passing argument to parameter 'mnt_opts' here
   void security_free_mnt_opts(const void **mnt_opts);
                                            ^
   fs/btrfs/super.c:1699:26: error: passing 'void **' to parameter of type 'const void **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   security_free_mnt_opts(&new_sec_opts);
                                          ^~~~~~~~~~~~~
   include/linux/security.h:301:42: note: passing argument to parameter 'mnt_opts' here
   void security_free_mnt_opts(const void **mnt_opts);
                                            ^
   3 errors generated.


vim +1523 fs/btrfs/super.c

450ba0ea06b6ed Josef Bacik       2010-11-19  1427  
312c89fbca0689 Misono, Tomohiro  2017-12-14  1428  /*
312c89fbca0689 Misono, Tomohiro  2017-12-14  1429   * Find a superblock for the given device / mount point.
312c89fbca0689 Misono, Tomohiro  2017-12-14  1430   *
312c89fbca0689 Misono, Tomohiro  2017-12-14  1431   * Note: This is based on mount_bdev from fs/super.c with a few additions
312c89fbca0689 Misono, Tomohiro  2017-12-14  1432   *       for multiple device setup.  Make sure to keep it in sync.
312c89fbca0689 Misono, Tomohiro  2017-12-14  1433   */
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1434  static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1435  		int flags, const char *device_name, void *data)
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1436  {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1437  	struct block_device *bdev = NULL;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1438  	struct super_block *s;
36350e95a2b1fe Gu Jinxiang       2018-07-12  1439  	struct btrfs_device *device = NULL;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1440  	struct btrfs_fs_devices *fs_devices = NULL;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1441  	struct btrfs_fs_info *fs_info = NULL;
204cc0ccf1d49c Al Viro           2018-12-13  1442  	void *new_sec_opts = NULL;
05bdb9965305bb Christoph Hellwig 2023-06-08  1443  	blk_mode_t mode = sb_open_mode(flags);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1444  	int error = 0;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1445  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1446  	if (data) {
a65001e8a4d465 Al Viro           2018-12-10  1447  		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1448  		if (error)
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1449  			return ERR_PTR(error);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1450  	}
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1451  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1452  	/*
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1453  	 * Setup a dummy root and fs_info for test/set super.  This is because
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1454  	 * we don't actually fill this stuff out until open_ctree, but we need
8260edba67a2e6 Josef Bacik       2020-01-24  1455  	 * then open_ctree will properly initialize the file system specific
8260edba67a2e6 Josef Bacik       2020-01-24  1456  	 * settings later.  btrfs_init_fs_info initializes the static elements
8260edba67a2e6 Josef Bacik       2020-01-24  1457  	 * of the fs_info (locks and such) to make cleanup easier if we find a
8260edba67a2e6 Josef Bacik       2020-01-24  1458  	 * superblock with our given fs_devices later on at sget() time.
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1459  	 */
a8fd1f71749387 Jeff Mahoney      2018-02-15  1460  	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1461  	if (!fs_info) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1462  		error = -ENOMEM;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1463  		goto error_sec_opts;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1464  	}
8260edba67a2e6 Josef Bacik       2020-01-24  1465  	btrfs_init_fs_info(fs_info);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1466  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1467  	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1468  	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1469  	if (!fs_info->super_copy || !fs_info->super_for_commit) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1470  		error = -ENOMEM;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1471  		goto error_fs_info;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1472  	}
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1473  
399f7f4c42e8a5 David Sterba      2018-06-19  1474  	mutex_lock(&uuid_mutex);
2ef789288afd36 Christoph Hellwig 2023-06-08  1475  	error = btrfs_parse_device_options(data, mode);
81ffd56b574535 David Sterba      2018-06-19  1476  	if (error) {
399f7f4c42e8a5 David Sterba      2018-06-19  1477  		mutex_unlock(&uuid_mutex);
399f7f4c42e8a5 David Sterba      2018-06-19  1478  		goto error_fs_info;
81ffd56b574535 David Sterba      2018-06-19  1479  	}
399f7f4c42e8a5 David Sterba      2018-06-19  1480  
2ef789288afd36 Christoph Hellwig 2023-06-08  1481  	device = btrfs_scan_one_device(device_name, mode);
36350e95a2b1fe Gu Jinxiang       2018-07-12  1482  	if (IS_ERR(device)) {
399f7f4c42e8a5 David Sterba      2018-06-19  1483  		mutex_unlock(&uuid_mutex);
36350e95a2b1fe Gu Jinxiang       2018-07-12  1484  		error = PTR_ERR(device);
399f7f4c42e8a5 David Sterba      2018-06-19  1485  		goto error_fs_info;
81ffd56b574535 David Sterba      2018-06-19  1486  	}
399f7f4c42e8a5 David Sterba      2018-06-19  1487  
36350e95a2b1fe Gu Jinxiang       2018-07-12  1488  	fs_devices = device->fs_devices;
399f7f4c42e8a5 David Sterba      2018-06-19  1489  	fs_info->fs_devices = fs_devices;
399f7f4c42e8a5 David Sterba      2018-06-19  1490  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1491  	error = btrfs_open_devices(fs_devices, mode, fs_type);
f5194e34cabadd David Sterba      2018-06-19  1492  	mutex_unlock(&uuid_mutex);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1493  	if (error)
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1494  		goto error_fs_info;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1495  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1496  	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1497  		error = -EACCES;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1498  		goto error_close_devices;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1499  	}
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1500  
d24fa5c1da0802 Anand Jain        2021-08-24  1501  	bdev = fs_devices->latest_dev->bdev;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1502  	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1503  		 fs_info);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1504  	if (IS_ERR(s)) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1505  		error = PTR_ERR(s);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1506  		goto error_close_devices;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1507  	}
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1508  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1509  	if (s->s_root) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1510  		btrfs_close_devices(fs_devices);
0d4b0463011de0 Josef Bacik       2020-01-24  1511  		btrfs_free_fs_info(fs_info);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1512  		if ((flags ^ s->s_flags) & SB_RDONLY)
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1513  			error = -EBUSY;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1514  	} else {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1515  		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
e33c267ab70de4 Roman Gushchin    2022-05-31  1516  		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
e33c267ab70de4 Roman Gushchin    2022-05-31  1517  					s->s_id);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1518  		btrfs_sb(s)->bdev_holder = fs_type;
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1519  		error = btrfs_fill_super(s, fs_devices, data);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1520  	}
a65001e8a4d465 Al Viro           2018-12-10  1521  	if (!error)
204cc0ccf1d49c Al Viro           2018-12-13  1522  		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
a65001e8a4d465 Al Viro           2018-12-10 @1523  	security_free_mnt_opts(&new_sec_opts);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1524  	if (error) {
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1525  		deactivate_locked_super(s);
a65001e8a4d465 Al Viro           2018-12-10  1526  		return ERR_PTR(error);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1527  	}
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1528  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1529  	return dget(s->s_root);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1530  
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1531  error_close_devices:
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1532  	btrfs_close_devices(fs_devices);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1533  error_fs_info:
0d4b0463011de0 Josef Bacik       2020-01-24  1534  	btrfs_free_fs_info(fs_info);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1535  error_sec_opts:
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1536  	security_free_mnt_opts(&new_sec_opts);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1537  	return ERR_PTR(error);
72fa39f5c7a1c9 Misono, Tomohiro  2017-12-14  1538  }
312c89fbca0689 Misono, Tomohiro  2017-12-14  1539  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
