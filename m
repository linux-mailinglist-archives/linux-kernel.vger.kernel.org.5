Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA47604E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjGYBsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYBsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:48:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8771712
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690249693; x=1721785693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UrgQhGLBjZyDHdEPItxc4AXsxeh+8r5Lx2ogmZ8ZLuA=;
  b=ftLsTqjQJMPpy/fxQ93cgOvV2Wm0Au7pM7m6Ixw5LDO+Ld1pyIHMskE/
   Gpd6bbRUU/DYljhEf+1M5SvvDqiXguA1gxcv0litV4BkQqahMLnHnn/sx
   L7L4UBcB+Y+i3L4VYAVtT9Sciwm3JZAIYcs3Hft6JAofECgJo6g20TiXm
   sBorxgaYY01AzyK2BvjCthvie6ziJcwZCSQiRhPc0f1ZvPM41M6h2iEU2
   WPWLXhAagP3+oezM7teIsDk1zgGKXCuIORCSghixm/lDj1a/hQ34jGtWS
   OJFkE213McdSkZF7lTp/kkQSGH2q5xX6JC6Uf7nvNAgUoKh8uNAjPZ+6F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371200203"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="371200203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 18:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849818831"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="849818831"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2023 18:48:12 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO79n-000ACG-0P;
        Tue, 25 Jul 2023 01:48:11 +0000
Date:   Tue, 25 Jul 2023 09:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/ac97/bus.c:465:1: sparse: sparse: symbol 'dev_attr_vendor_id'
 was not declared. Should it be static?
Message-ID: <202307250936.Zx4eAszV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 5eab9265759e2fb042aa452931c3d06ab7ab8dae ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable
date:   6 months ago
config: nios2-randconfig-r072-20230723 (https://download.01.org/0day-ci/archive/20230725/202307250936.Zx4eAszV-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307250936.Zx4eAszV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307250936.Zx4eAszV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/ac97/bus.c:465:1: sparse: sparse: symbol 'dev_attr_vendor_id' was not declared. Should it be static?

vim +/dev_attr_vendor_id +465 sound/ac97/bus.c

74426fbff66eea Robert Jarzmik 2017-09-02  457  
74426fbff66eea Robert Jarzmik 2017-09-02  458  static ssize_t vendor_id_show(struct device *dev,
74426fbff66eea Robert Jarzmik 2017-09-02  459  			      struct device_attribute *attr, char *buf)
74426fbff66eea Robert Jarzmik 2017-09-02  460  {
74426fbff66eea Robert Jarzmik 2017-09-02  461  	struct ac97_codec_device *codec = to_ac97_device(dev);
74426fbff66eea Robert Jarzmik 2017-09-02  462  
7450320ec7ab11 Takashi Iwai   2022-08-01  463  	return sysfs_emit(buf, "%08x", codec->vendor_id);
74426fbff66eea Robert Jarzmik 2017-09-02  464  }
74426fbff66eea Robert Jarzmik 2017-09-02 @465  DEVICE_ATTR_RO(vendor_id);
74426fbff66eea Robert Jarzmik 2017-09-02  466  

:::::: The code at line 465 was first introduced by commit
:::::: 74426fbff66eea8e8d1f42c8238c268d1e63a832 ALSA: ac97: add an ac97 bus

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
