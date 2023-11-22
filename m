Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6DE7F3AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjKVAzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVAzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:55:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE4112;
        Tue, 21 Nov 2023 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700614507; x=1732150507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5v2P07ds92gacwG7jBUufrR4IYudUYskFFuQRoGYaSA=;
  b=DJ7tz2OK7o+95BYnKLB8wEGlrZ9zo8I9c95GTh8iG6bjytjbX2Gn1llN
   e3cfTQmiauNEH0BXrkTbAIN1BDS7Rxuoihs87VFiJd0XfihLwNWjTMtQe
   tCY7IgsuIpUIh07mJlgOSJD0gsQ6tXZcApOiai0103PQ++UUPayPM4izI
   AO1f8YNu7qSCsVP8yswJPjnGQvrNo1FQZblyS1l5vI+iiC6ZxRQcDmAUi
   YyLU4CysNRlhlqihS7Wx6+VsOuwi3J91rbjYsvqgDRW6mPewTd34jH5hP
   tirCIp/nNibhoJUf3zUVkWAyqanSouuyZR2RHBWXyB1QVkBHGhVRpx3VI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5088477"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5088477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716674287"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="716674287"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 16:55:02 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5bW8-0008T4-0d;
        Wed, 22 Nov 2023 00:55:00 +0000
Date:   Wed, 22 Nov 2023 08:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
Message-ID: <202311220807.NUS4r7ML-lkp@intel.com>
References: <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus robh/for-next linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Sa-via-B4-Relay/driver-core-allow-modifying-device_links-flags/20231121-182010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231121-dev-iio-backend-v1-10-6a3d542eba35%40analog.com
patch subject: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
config: powerpc-randconfig-r071-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220807.NUS4r7ML-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220807.NUS4r7ML-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220807.NUS4r7ML-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad9467.c:276 ad9467_get_scale() warn: unsigned 'vref_val' is never less than zero.

vim +/vref_val +276 drivers/iio/adc/ad9467.c

ad67971202381c Michael Hennerich  2020-03-24  270  
a78b758afbce92 Nuno Sa            2023-11-21  271  static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
ad67971202381c Michael Hennerich  2020-03-24  272  {
337dbb6ec1acc2 Alexandru Ardelean 2020-09-24  273  	unsigned int i, vref_val;
ad67971202381c Michael Hennerich  2020-03-24  274  
ad67971202381c Michael Hennerich  2020-03-24  275  	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
d1e957a3e7676f Nuno Sa            2023-11-21 @276  	if (vref_val < 0)
d1e957a3e7676f Nuno Sa            2023-11-21  277  		return vref_val;
ad67971202381c Michael Hennerich  2020-03-24  278  
a78b758afbce92 Nuno Sa            2023-11-21  279  	vref_val &= st->info->vref_mask;
ad67971202381c Michael Hennerich  2020-03-24  280  
a78b758afbce92 Nuno Sa            2023-11-21  281  	for (i = 0; i < st->info->num_scales; i++) {
a78b758afbce92 Nuno Sa            2023-11-21  282  		if (vref_val == st->info->scale_table[i][1])
ad67971202381c Michael Hennerich  2020-03-24  283  			break;
ad67971202381c Michael Hennerich  2020-03-24  284  	}
ad67971202381c Michael Hennerich  2020-03-24  285  
a78b758afbce92 Nuno Sa            2023-11-21  286  	if (i == st->info->num_scales)
ad67971202381c Michael Hennerich  2020-03-24  287  		return -ERANGE;
ad67971202381c Michael Hennerich  2020-03-24  288  
a78b758afbce92 Nuno Sa            2023-11-21  289  	__ad9467_get_scale(st, i, val, val2);
ad67971202381c Michael Hennerich  2020-03-24  290  
ad67971202381c Michael Hennerich  2020-03-24  291  	return IIO_VAL_INT_PLUS_MICRO;
ad67971202381c Michael Hennerich  2020-03-24  292  }
ad67971202381c Michael Hennerich  2020-03-24  293  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
