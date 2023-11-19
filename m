Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3427F0929
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 22:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKSVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 16:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 16:34:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C89E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 13:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700429687; x=1731965687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qSjJGt3aBeEORUAlcuEjwSTLpZSdij4sXxvJAZeqHT8=;
  b=Tzc/MowdGIWFtQjA3vXEW89nXC0RhlCZxqU7moC0cmQ1uGCPowYy+vBf
   Pfu2zqFAM+O/b74PAUnkD7CTqzBLkyujJcQOvcHxdOL/J4S9ergnXtG7Z
   C3YGBQ5jm34aNuCQCfWX2Of/6MNTIMivLOyfP6kuy+p0x5qMTKWZy7fgQ
   dmXHleY9/0TosNMRBjT0X8FewHUfArCMsJYmF9UiurrKh6fyDV+0UBJWu
   k4wWj3lSS1nJ1meDpmupqYzX8+bbjJqKVNrqwjA+Wx+O7876DCETXPr+H
   AEVPSTRX+EGeHqyUIzSH+IbahwQLeatV6jN3TXr2kdWQJxYfGl/YKXRWw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="371702058"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="371702058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 13:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="909920497"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="909920497"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2023 13:34:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4pRD-0005Zf-26;
        Sun, 19 Nov 2023 21:34:43 +0000
Date:   Mon, 20 Nov 2023 05:34:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/hwtracing/intel_th/core.c:795: warning: Function parameter
 or member 'drvdata' not described in 'intel_th_alloc'
Message-ID: <202311200521.j8ybmtiW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: 3321371b5d648479058fa6f9441168abbc1467c9 intel_th: pci: Use drvdata for quirks
date:   6 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231120/202311200521.j8ybmtiW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200521.j8ybmtiW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200521.j8ybmtiW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/intel_th/core.c:795: warning: Function parameter or member 'drvdata' not described in 'intel_th_alloc'


vim +795 drivers/hwtracing/intel_th/core.c

39f4034693b7c7 Alexander Shishkin 2015-09-22  784  
39f4034693b7c7 Alexander Shishkin 2015-09-22  785  /**
39f4034693b7c7 Alexander Shishkin 2015-09-22  786   * intel_th_alloc() - allocate a new Intel TH device and its subdevices
39f4034693b7c7 Alexander Shishkin 2015-09-22  787   * @dev:	parent device
39f4034693b7c7 Alexander Shishkin 2015-09-22  788   * @devres:	parent's resources
39f4034693b7c7 Alexander Shishkin 2015-09-22  789   * @ndevres:	number of resources
39f4034693b7c7 Alexander Shishkin 2015-09-22  790   * @irq:	irq number
39f4034693b7c7 Alexander Shishkin 2015-09-22  791   */
39f4034693b7c7 Alexander Shishkin 2015-09-22  792  struct intel_th *
3321371b5d6484 Alexander Shishkin 2017-08-18  793  intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
3321371b5d6484 Alexander Shishkin 2017-08-18  794  	       struct resource *devres, unsigned int ndevres, int irq)
39f4034693b7c7 Alexander Shishkin 2015-09-22 @795  {
39f4034693b7c7 Alexander Shishkin 2015-09-22  796  	struct intel_th *th;
39f4034693b7c7 Alexander Shishkin 2015-09-22  797  	int err;
39f4034693b7c7 Alexander Shishkin 2015-09-22  798  
39f4034693b7c7 Alexander Shishkin 2015-09-22  799  	th = kzalloc(sizeof(*th), GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  800  	if (!th)
39f4034693b7c7 Alexander Shishkin 2015-09-22  801  		return ERR_PTR(-ENOMEM);
39f4034693b7c7 Alexander Shishkin 2015-09-22  802  
39f4034693b7c7 Alexander Shishkin 2015-09-22  803  	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
39f4034693b7c7 Alexander Shishkin 2015-09-22  804  	if (th->id < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  805  		err = th->id;
39f4034693b7c7 Alexander Shishkin 2015-09-22  806  		goto err_alloc;
39f4034693b7c7 Alexander Shishkin 2015-09-22  807  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  808  
39f4034693b7c7 Alexander Shishkin 2015-09-22  809  	th->major = __register_chrdev(0, 0, TH_POSSIBLE_OUTPUTS,
39f4034693b7c7 Alexander Shishkin 2015-09-22  810  				      "intel_th/output", &intel_th_output_fops);
39f4034693b7c7 Alexander Shishkin 2015-09-22  811  	if (th->major < 0) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  812  		err = th->major;
39f4034693b7c7 Alexander Shishkin 2015-09-22  813  		goto err_ida;
39f4034693b7c7 Alexander Shishkin 2015-09-22  814  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  815  	th->dev = dev;
3321371b5d6484 Alexander Shishkin 2017-08-18  816  	th->drvdata = drvdata;
39f4034693b7c7 Alexander Shishkin 2015-09-22  817  
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  818  	th->resource = devres;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  819  	th->num_resources = ndevres;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  820  	th->irq = irq;
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  821  
d7b1787161b78a Alexander Shishkin 2016-02-15  822  	dev_set_drvdata(dev, th);
d7b1787161b78a Alexander Shishkin 2016-02-15  823  
142dfeb2020960 Alexander Shishkin 2016-06-22  824  	pm_runtime_no_callbacks(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  825  	pm_runtime_put(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  826  	pm_runtime_allow(dev);
142dfeb2020960 Alexander Shishkin 2016-06-22  827  
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  828  	err = intel_th_populate(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  829  	if (err) {
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  830  		/* free the subdevices and undo everything */
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  831  		intel_th_free(th);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  832  		return ERR_PTR(err);
a753bfcfdb1f31 Alexander Shishkin 2017-08-10  833  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  834  
39f4034693b7c7 Alexander Shishkin 2015-09-22  835  	return th;
39f4034693b7c7 Alexander Shishkin 2015-09-22  836  
39f4034693b7c7 Alexander Shishkin 2015-09-22  837  err_ida:
39f4034693b7c7 Alexander Shishkin 2015-09-22  838  	ida_simple_remove(&intel_th_ida, th->id);
39f4034693b7c7 Alexander Shishkin 2015-09-22  839  
39f4034693b7c7 Alexander Shishkin 2015-09-22  840  err_alloc:
39f4034693b7c7 Alexander Shishkin 2015-09-22  841  	kfree(th);
39f4034693b7c7 Alexander Shishkin 2015-09-22  842  
39f4034693b7c7 Alexander Shishkin 2015-09-22  843  	return ERR_PTR(err);
39f4034693b7c7 Alexander Shishkin 2015-09-22  844  }
39f4034693b7c7 Alexander Shishkin 2015-09-22  845  EXPORT_SYMBOL_GPL(intel_th_alloc);
39f4034693b7c7 Alexander Shishkin 2015-09-22  846  

:::::: The code at line 795 was first introduced by commit
:::::: 39f4034693b7c7bd1fe4cb58c93259d600f55561 intel_th: Add driver infrastructure for Intel(R) Trace Hub devices

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
