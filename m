Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B7D0372
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346553AbjJSUyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:54:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E5D7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697748873; x=1729284873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3NqRHsAR6XsnhK02RO1iSbeK91JgC8I9EUZ+LI6wcn8=;
  b=esKlLJ9en2tPsE2Rhcc157cIuHVUnpRbnh+ODflPj/AsV50AqNDhdepH
   lSROzCJXSiBeldChVPFIU6d/LtmPse7N8DRjvw5J6/VFp2yDDhEEdo2VQ
   fKXW7x/EB60+vY3h08Rlyxl9b57VirDWcPnJEBG6ZfQ5BrvxZY7FujtI2
   SJGrIJPp3m7DE531JURgqYPoEG15pq8rs6Puv6Hr/7Z8Okv2Ax7HeXKqd
   NlSLADzBB/jSTRuiYbpdWqAW7ywHGUeZztcAHfTCNPDVyDnD1DJd5b/ZZ
   j2fE5PM66O4NwPBdQWEp1FjW+4p5HKcdm5R/hddaD0DHMWyqIwa7fq7Ed
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="4974255"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4974255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="822978422"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="822978422"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Oct 2023 13:54:30 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qta2G-0002aY-0L;
        Thu, 19 Oct 2023 20:54:28 +0000
Date:   Fri, 20 Oct 2023 04:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: drivers/hwmon/coretemp.c:393:34: error: '%s' directive output may be
 truncated writing likely 5 or more bytes into a region of size between 3 and
 13
Message-ID: <202310200443.iD3tUbbK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce55c22ec8b223a90ff3e084d842f73cfba35588
commit: 7108b80a542b9d65e44b36d64a700a83658c0b73 hwmon/coretemp: Handle large core ID value
date:   1 year ago
config: x86_64-sof-customedconfig-memory-debug-defconfig (https://download.01.org/0day-ci/archive/20231020/202310200443.iD3tUbbK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200443.iD3tUbbK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200443.iD3tUbbK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/coretemp.c: In function 'create_core_data':
>> drivers/hwmon/coretemp.c:393:34: error: '%s' directive output may be truncated writing likely 5 or more bytes into a region of size between 3 and 13 [-Werror=format-truncation=]
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                                  ^~
   drivers/hwmon/coretemp.c:393:26: note: assuming directive output of 5 bytes
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                          ^~~~~~~~~~~
   drivers/hwmon/coretemp.c:392:17: note: 'snprintf' output 7 or more bytes (assuming 22) into a destination of size 19
     392 |                 snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +393 drivers/hwmon/coretemp.c

a321cedb129041 Carsten Emde       2010-05-24  378  
d23e2ae1aae52b Paul Gortmaker     2013-06-19  379  static int create_core_attrs(struct temp_data *tdata, struct device *dev,
d23e2ae1aae52b Paul Gortmaker     2013-06-19  380  			     int attr_no)
199e0de7f5df31 Durgadoss R        2011-05-20  381  {
1075305de47d8e Guenter Roeck      2014-02-16  382  	int i;
e3204ed3a4a78c Jan Beulich        2011-09-23  383  	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
199e0de7f5df31 Durgadoss R        2011-05-20  384  			struct device_attribute *devattr, char *buf) = {
c814a4c7c4aad7 Durgadoss R        2011-07-12  385  			show_label, show_crit_alarm, show_temp, show_tjmax,
f4af6fd6e21792 Guenter Roeck      2011-09-19  386  			show_ttarget };
1055b5f9042405 Rasmus Villemoes   2015-02-12  387  	static const char *const suffixes[TOTAL_ATTRS] = {
1055b5f9042405 Rasmus Villemoes   2015-02-12  388  		"label", "crit_alarm", "input", "crit", "max"
1055b5f9042405 Rasmus Villemoes   2015-02-12  389  	};
199e0de7f5df31 Durgadoss R        2011-05-20  390  
c814a4c7c4aad7 Durgadoss R        2011-07-12  391  	for (i = 0; i < tdata->attr_size; i++) {
1055b5f9042405 Rasmus Villemoes   2015-02-12  392  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
1055b5f9042405 Rasmus Villemoes   2015-02-12 @393  			 "temp%d_%s", attr_no, suffixes[i]);
4258781ac720ff Sergey Senozhatsky 2011-05-24  394  		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
199e0de7f5df31 Durgadoss R        2011-05-20  395  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
0cd709d0ddbfc2 Guenter Roeck      2018-12-10  396  		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
199e0de7f5df31 Durgadoss R        2011-05-20  397  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
199e0de7f5df31 Durgadoss R        2011-05-20  398  		tdata->sd_attrs[i].index = attr_no;
1075305de47d8e Guenter Roeck      2014-02-16  399  		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
bebe467823c0d8 Rudolf Marek       2007-05-08  400  	}
1075305de47d8e Guenter Roeck      2014-02-16  401  	tdata->attr_group.attrs = tdata->attrs;
1075305de47d8e Guenter Roeck      2014-02-16  402  	return sysfs_create_group(&dev->kobj, &tdata->attr_group);
199e0de7f5df31 Durgadoss R        2011-05-20  403  }
199e0de7f5df31 Durgadoss R        2011-05-20  404  

:::::: The code at line 393 was first introduced by commit
:::::: 1055b5f90424056432430fa06f94f1d12db07fba hwmon: (coretemp) Allow format checking

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
