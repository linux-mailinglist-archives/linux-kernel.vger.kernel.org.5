Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8367EDA96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjKPEIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPEI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:08:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BB01A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700107703; x=1731643703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qL9piQHsJ20lz8yk9tR43XFPUfzc6L0zTkppwZBsX6o=;
  b=XA7n/4NmqUmHWic/ggddUt5ZhMRMPi927CjJUYVO4rTas91umMoHNdNC
   EioFPjLlmHGnd+I5SnCjqjYNQx+GWozM2O0qKZmFfiVJTBjsltz36jXIv
   hrE4gbjMMDc1awgEtjHB5tskuODPj1wdZ34ehXF9yqFs6KGZdb5ZXSBFO
   256LvMqarz8uOulD8PgKHWv1TyFyA1HdlDI0hpK6oMxMxzMvV4/rQknkc
   2nZClLNJq+Uiu0uqdBEpk6N7klku9ycZOzyZV7uFEcgups5BrPA0c95i6
   jA0JJ1aLnQDJg+arIyU2blo2RezlwcvCm5mpXqBwCHObVjfOiHZane4BR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455300412"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="455300412"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 20:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882615816"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="882615816"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2023 20:08:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Tfv-0001HH-0F;
        Thu, 16 Nov 2023 04:08:19 +0000
Date:   Thu, 16 Nov 2023 12:07:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michal Marek <mmarek@suse.com>
Subject: drivers/hid/hid-sensor-custom.c:598:64: warning: 'snprintf' output
 may be truncated before the last format character
Message-ID: <202311161224.pnGqzMx0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 8ae94224c9d72fc4d9aaac93b2d7833cf46d7141 kbuild: add -fno-PIE
date:   7 years ago
config: x86_64-randconfig-m001-20230717 (https://download.01.org/0day-ci/archive/20231116/202311161224.pnGqzMx0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161224.pnGqzMx0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161224.pnGqzMx0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hid/hid-sensor-custom.c: In function 'store_value':
   drivers/hid/hid-sensor-custom.c:409:21: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     409 |                 int ret;
         |                     ^~~
   drivers/hid/hid-sensor-custom.c: In function 'hid_sensor_custom_add_attributes':
>> drivers/hid/hid-sensor-custom.c:598:64: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     598 |                                  HID_CUSTOM_NAME_LENGTH, "%s-%s",
         |                                                                ^
   drivers/hid/hid-sensor-custom.c:597:25: note: 'snprintf' output 2 or more bytes (assuming 65) into a destination of size 64
     597 |                         snprintf((char *)&sensor_inst->fields[i].attr_name[j],
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     598 |                                  HID_CUSTOM_NAME_LENGTH, "%s-%s",
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     599 |                                  sensor_inst->fields[i].group_name,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     600 |                                  hid_custom_attrs[j].name);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
--
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/acl.c:7:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/dcache.c:11:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/dcache.c: In function 'orangefs_revalidate_lookup':
   fs/orangefs/dcache.c:33:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
      33 |         strncpy(new_op->upcall.req.lookup.d_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      34 |                 dentry->d_name.name,
         |                 ~~~~~~~~~~~~~~~~~~~~
      35 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
--
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/inode.c:11:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:96: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:139: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
--
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/super.c:7:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/super.c: In function 'orangefs_mount':
   fs/orangefs/super.c:451:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     451 |         strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     452 |                 devname,
         |                 ~~~~~~~~
     453 |                 ORANGEFS_MAX_SERVER_ADDR_LEN);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/super.c:491:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     491 |         strncpy(ORANGEFS_SB(sb)->devname,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     492 |                 devname,
         |                 ~~~~~~~~
     493 |                 ORANGEFS_MAX_SERVER_ADDR_LEN);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/namei.c:11:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c: In function 'orangefs_rename':
   fs/orangefs/namei.c:434:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     434 |         strncpy(new_op->upcall.req.rename.d_old_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     435 |                 old_dentry->d_name.name,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
     436 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c:437:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     437 |         strncpy(new_op->upcall.req.rename.d_new_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     438 |                 new_dentry->d_name.name,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
     439 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c: In function 'orangefs_unlink':
   fs/orangefs/namei.c:240:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     240 |         strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     241 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c: In function 'orangefs_lookup':
   fs/orangefs/namei.c:137:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     137 |         strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     138 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c:137:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
   fs/orangefs/namei.c: In function 'orangefs_mkdir':
   fs/orangefs/namei.c:358:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     358 |         strncpy(new_op->upcall.req.mkdir.d_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     359 |                 dentry->d_name.name, ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c: In function 'orangefs_create':
   fs/orangefs/namei.c:40:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
      40 |         strncpy(new_op->upcall.req.create.d_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      41 |                 dentry->d_name.name, ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c: In function 'orangefs_symlink':
   fs/orangefs/namei.c:291:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     291 |         strncpy(new_op->upcall.req.sym.entry_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     292 |                 dentry->d_name.name,
         |                 ~~~~~~~~~~~~~~~~~~~~
     293 |                 ORANGEFS_NAME_MAX);
         |                 ~~~~~~~~~~~~~~~~~~
   fs/orangefs/namei.c:294:9: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
     294 |         strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   fs/orangefs/orangefs-bufmap.c:225:5: warning: no previous prototype for 'orangefs_get_bufmap_init' [-Wmissing-prototypes]
     225 | int orangefs_get_bufmap_init(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/orangefs/protocol.h:336,
                    from fs/orangefs/orangefs-bufmap.c:6:
>> fs/orangefs/orangefs-debug.h:89:18: warning: 'num_kmod_keyword_mask_map' defined but not used [-Wunused-const-variable=]
      89 | static const int num_kmod_keyword_mask_map = (int)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +598 drivers/hid/hid-sensor-custom.c

4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  568  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  569  static int hid_sensor_custom_add_attributes(struct hid_sensor_custom
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  570  								*sensor_inst)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  571  {
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  572  	struct hid_sensor_hub_device *hsdev = sensor_inst->hsdev;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  573  	struct hid_device *hdev = hsdev->hdev;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  574  	int ret = -1;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  575  	int i, j;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  576  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  577  	for (j = 0; j < HID_REPORT_TYPES; ++j) {
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  578  		if (j == HID_OUTPUT_REPORT)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  579  			continue;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  580  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  581  		ret = hid_sensor_custom_add_fields(sensor_inst,
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  582  						   &hdev->report_enum[j], j);
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  583  		if (ret)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  584  			return ret;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  585  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  586  	}
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  587  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  588  	/* Create sysfs attributes */
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  589  	for (i = 0; i < sensor_inst->sensor_field_count; ++i) {
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  590  		j = 0;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  591  		while (j < HID_CUSTOM_TOTAL_ATTRS &&
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  592  		       hid_custom_attrs[j].name) {
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  593  			struct device_attribute *device_attr;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  594  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  595  			device_attr = &sensor_inst->fields[i].sd_attrs[j];
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  596  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  597  			snprintf((char *)&sensor_inst->fields[i].attr_name[j],
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10 @598  				 HID_CUSTOM_NAME_LENGTH, "%s-%s",
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  599  				 sensor_inst->fields[i].group_name,
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  600  				 hid_custom_attrs[j].name);
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  601  			sysfs_attr_init(&device_attr->attr);
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  602  			device_attr->attr.name =
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  603  				(char *)&sensor_inst->fields[i].attr_name[j];
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  604  			device_attr->attr.mode = hid_custom_attrs[j].mode;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  605  			device_attr->show = show_value;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  606  			if (hid_custom_attrs[j].mode & S_IWUSR)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  607  				device_attr->store = store_value;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  608  			sensor_inst->fields[i].attrs[j] = &device_attr->attr;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  609  			++j;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  610  		}
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  611  		sensor_inst->fields[i].attrs[j] = NULL;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  612  		sensor_inst->fields[i].hid_custom_attribute_group.attrs =
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  613  						sensor_inst->fields[i].attrs;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  614  		sensor_inst->fields[i].hid_custom_attribute_group.name =
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  615  					sensor_inst->fields[i].group_name;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  616  		ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  617  					 &sensor_inst->fields[i].
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  618  					 hid_custom_attribute_group);
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  619  		if (ret)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  620  			break;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  621  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  622  		/* For power or report field store indexes */
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  623  		if (sensor_inst->fields[i].attribute.attrib_id ==
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  624  					HID_USAGE_SENSOR_PROY_POWER_STATE)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  625  			sensor_inst->power_state = &sensor_inst->fields[i];
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  626  		else if (sensor_inst->fields[i].attribute.attrib_id ==
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  627  					HID_USAGE_SENSOR_PROP_REPORT_STATE)
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  628  			sensor_inst->report_state = &sensor_inst->fields[i];
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  629  	}
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  630  
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  631  	return ret;
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  632  }
4a7de0519df5e8 Srinivas Pandruvada 2015-04-10  633  

:::::: The code at line 598 was first introduced by commit
:::::: 4a7de0519df5e8fb89cef6ee062330ffe4b50a4d HID: sensor: Custom and Generic sensor support

:::::: TO: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
