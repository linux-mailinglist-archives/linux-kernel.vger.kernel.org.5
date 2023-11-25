Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DD7F88ED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjKYHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjKYHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:43:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2B1990;
        Fri, 24 Nov 2023 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700898224; x=1732434224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NPrp5k8M2Z/T9LhMIJDXeX8+nnPUWI8hRvX1g/UAks0=;
  b=UGePtL/P87MBcjYZf17l7Q0PQYcqWVRFGrx9XOY6GrX1Mt7fKJKKHv4n
   21inqnqr+A/nWRYAXtsr3TfcmLgvU9AllGg7IycmWOky7ZtMMssmQwNnd
   KxiHPrz0kEGeiNU0/9VN0ZqmCA63rmu0VnuaPN2zZFnzKawhjFyXJ8hi7
   XVt8mEq/4IdVqWq+XPPPW2u4Wpdlrswxx3hCsZiGPKxAOndsrivXsqj7b
   H2HlWdjyX6FPYE0RaWNAd5fHuWHthNosZDXcxI9W6+3Us+r9S7ONjnjHV
   6yEVW/wfZEJkieitrWmRcVRMP/XEyUrm9aG/6MhxTLDkQblG9XTSy3OLK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="392266120"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="392266120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 23:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="911623527"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="911623527"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2023 23:43:40 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6nKE-0003kN-2Z;
        Sat, 25 Nov 2023 07:43:38 +0000
Date:   Sat, 25 Nov 2023 15:42:43 +0800
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
Subject: Re: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
Message-ID: <202311251430.QfOfg5Ws-lkp@intel.com>
References: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
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
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus robh/for-next linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Sa-via-B4-Relay/driver-core-allow-modifying-device_links-flags/20231121-182010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231121-dev-iio-backend-v1-12-6a3d542eba35%40analog.com
patch subject: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
config: arm-randconfig-r081-20231123 (https://download.01.org/0day-ci/archive/20231125/202311251430.QfOfg5Ws-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231125/202311251430.QfOfg5Ws-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251430.QfOfg5Ws-lkp@intel.com/

smatch warnings:
drivers/iio/adc/adi-axi-adc.c:64 axi_adc_enable() warn: inconsistent indenting

vim +64 drivers/iio/adc/adi-axi-adc.c

    58	
    59	static int axi_adc_enable(struct iio_backend *back)
    60	{
    61		struct adi_axi_adc_state *st = iio_backend_get_priv(back);
    62		int ret;
    63	
  > 64		 ret = regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
    65				       ADI_AXI_REG_RSTN_MMCM_RSTN);
    66		if (ret)
    67			return ret;
    68	
    69		fsleep(10);
    70		return regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
    71				       ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
    72	}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
