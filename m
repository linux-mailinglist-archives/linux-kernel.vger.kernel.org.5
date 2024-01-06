Return-Path: <linux-kernel+bounces-18737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C3E82624A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFEE1F21D96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D4101EF;
	Sat,  6 Jan 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtx/rERg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAF101C6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704582001; x=1736118001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fkAnOoCEuBDaTy6HUmcJlB4a4A5JVNK326EYrgY2KBM=;
  b=jtx/rERgo8IYaq/xGhsO0+ept61hAIE8cloKV0YZT6Ga1P0WzgmAroKx
   4aLv/gVjE0cr5p59gnC2ogHhPeffjU9zoTuuNewsPXCIntlKEPNwhy+/M
   ik7KlT++mzujoy91uxBoZc5tYqvf7H8tBojCZIYnifJG/t/qrEKr/wl6d
   hMnyyn8jgriM6A5hdtflpCJAoy51KmDjrqPaPaRZv3uDZnearyulXYjGH
   3QRouTBKkvRI0M+++TTcFMp2/KEzetsM9yXEXnsGh9M8ZEuODTiShzaj7
   trTlBl8cI6Njo/Q1lEaEZ6HF1CYCV/mDxbDVii5rPrvyeyrTeHouCfgPm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="394856850"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="394856850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 15:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="22808491"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jan 2024 14:59:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMFe0-00038C-11;
	Sat, 06 Jan 2024 22:59:56 +0000
Date: Sun, 7 Jan 2024 06:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: fs/btrfs/volumes.c:1004:34: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202401070634.inITDmDk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: bb21e30260a672172a26ee1626dc1463215cf18c btrfs: move device->name RCU allocation and assign to btrfs_alloc_device()
date:   1 year, 1 month ago
config: arm-randconfig-r122-20240105 (https://download.01.org/0day-ci/archive/20240107/202401070634.inITDmDk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240107/202401070634.inITDmDk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070634.inITDmDk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/btrfs/volumes.c:409:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:409:31: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:409:31: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:617:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:617:43: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:617:43: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:884:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:884:50: sparse:     expected char const *
   fs/btrfs/volumes.c:884:50: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:954:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:954:39: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:954:39: sparse:     got struct rcu_string [noderef] __rcu *name
>> fs/btrfs/volumes.c:1004:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const *dev_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:1004:34: sparse:     expected char const *dev_path
   fs/btrfs/volumes.c:1004:34: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2198:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2198:49: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2198:49: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2313:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2313:41: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2313:41: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:1446:29: sparse: sparse: self-comparison always evaluates to false

vim +1004 fs/btrfs/volumes.c

   980	
   981	static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
   982	{
   983		struct btrfs_fs_devices *fs_devices;
   984		struct btrfs_device *device;
   985		struct btrfs_device *orig_dev;
   986		int ret = 0;
   987	
   988		lockdep_assert_held(&uuid_mutex);
   989	
   990		fs_devices = alloc_fs_devices(orig->fsid, NULL);
   991		if (IS_ERR(fs_devices))
   992			return fs_devices;
   993	
   994		fs_devices->total_devices = orig->total_devices;
   995	
   996		list_for_each_entry(orig_dev, &orig->devices, dev_list) {
   997			const char *dev_path = NULL;
   998	
   999			/*
  1000			 * This is ok to do without RCU read locked because we hold the
  1001			 * uuid mutex so nothing we touch in here is going to disappear.
  1002			 */
  1003			if (orig_dev->name)
> 1004				dev_path = orig_dev->name->str;
  1005	
  1006			device = btrfs_alloc_device(NULL, &orig_dev->devid,
  1007						    orig_dev->uuid, dev_path);
  1008			if (IS_ERR(device)) {
  1009				ret = PTR_ERR(device);
  1010				goto error;
  1011			}
  1012	
  1013			if (orig_dev->zone_info) {
  1014				struct btrfs_zoned_device_info *zone_info;
  1015	
  1016				zone_info = btrfs_clone_dev_zone_info(orig_dev);
  1017				if (!zone_info) {
  1018					btrfs_free_device(device);
  1019					ret = -ENOMEM;
  1020					goto error;
  1021				}
  1022				device->zone_info = zone_info;
  1023			}
  1024	
  1025			list_add(&device->dev_list, &fs_devices->devices);
  1026			device->fs_devices = fs_devices;
  1027			fs_devices->num_devices++;
  1028		}
  1029		return fs_devices;
  1030	error:
  1031		free_fs_devices(fs_devices);
  1032		return ERR_PTR(ret);
  1033	}
  1034	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

