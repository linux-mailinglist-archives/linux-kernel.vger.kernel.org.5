Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45E8122AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjLMXOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:14:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882CFE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702509255; x=1734045255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2HhgxzypDa5gBJlL3fVXaMJ/guTw/6vPdE6mdWuZ2Og=;
  b=P8ETsBFpqSONdbiOjsQ9QKDtDrsmOhTOAkCbi81svJeBr4EVnHGZTWYN
   kLiNmQltrIWDNtCITW+GUgvzZUUEfJSEnaApf5JSIfe/+ze7xCBrA54eX
   StHPbbXaz03GE10XGX2vl7Bxb6byMw4jvdzf5JGLjnL6c4dLiBxe2eKPb
   9Fu2tQ4KFUqKz7/pQotzP/Sdb0bfcWsuRM35gZzjPb7CJgcOdOaKj67iP
   pGMo9oL3MmmU14JzGI4kwpFBLp2DOOUcjfklvhCArZBW6tH3B9qeW/Fqt
   dKmkd9hxhT1B7Mb/AoxcFoPqut9ukZkgdyYJp6NB4CxT0IJSFwmtu4sxV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1861556"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1861556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844496106"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="844496106"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 15:14:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDYQe-000LGx-0I;
        Wed, 13 Dec 2023 23:14:12 +0000
Date:   Thu, 14 Dec 2023 07:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/rpmsg/qcom_glink_smem.c:93:17: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202312140746.AMlosG0F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 928002a5e9dab2ddc1a0fe3e00739e89be30dc6b rpmsg: glink: smem: Support rx peak for size less than 4 bytes
date:   5 years ago
config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231214/202312140746.AMlosG0F-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140746.AMlosG0F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140746.AMlosG0F-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/rpmsg/qcom_glink_smem.c:93:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void * @@
   drivers/rpmsg/qcom_glink_smem.c:93:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/rpmsg/qcom_glink_smem.c:93:17: sparse:     got void *
>> drivers/rpmsg/qcom_glink_smem.c:96:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *fifo @@
   drivers/rpmsg/qcom_glink_smem.c:96:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/rpmsg/qcom_glink_smem.c:96:17: sparse:     got void *fifo

vim +93 drivers/rpmsg/qcom_glink_smem.c

    78	
    79	static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
    80				       void *data, unsigned int offset, size_t count)
    81	{
    82		struct glink_smem_pipe *pipe = to_smem_pipe(np);
    83		size_t len;
    84		u32 tail;
    85	
    86		tail = le32_to_cpu(*pipe->tail);
    87		tail += offset;
    88		if (tail >= pipe->native.length)
    89			tail -= pipe->native.length;
    90	
    91		len = min_t(size_t, count, pipe->native.length - tail);
    92		if (len)
  > 93			memcpy_fromio(data, pipe->fifo + tail, len);
    94	
    95		if (len != count)
  > 96			memcpy_fromio(data + len, pipe->fifo, (count - len));
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
