Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4637F467E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjKVMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjKVMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:42:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65CD40;
        Wed, 22 Nov 2023 04:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700656975; x=1732192975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J5yFHdyGT9gyyy/JUixtO2LCLxe6dAnNkPnM4kLJdXs=;
  b=lYSOnKj2d246AzVvWHvNeFhuqC4bpytR/MBqdH/fzQxRcIpmAwhdlHzP
   qkJ77uS2AEIE2culWDNyZ3/V0Vg+QP7cnlnCpnQ+H4v2qXN/I58GkHFJ2
   ZW0j5B81TSA7e2EveMm6sk4NoY9UsV1z6HNbgYEpyMSVI1YHFqU2SOj7R
   Mikqh71pjv/gI/g36S3ZXXbrmAeNDTSmodaQ8wT1fUDuYh09eQOoOinht
   +CUpHG5zvOXIqJ1GAAB0JicG4OCsaJZ6eMoPsfHFXKmrvtRihgGe/dNtn
   lQhOBbXtb3/qQaIRd5yxkq3H2WmfHVChaC2UFkFsvzeYLBW7KuyI0dd8a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391815143"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="391815143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910779584"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910779584"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 04:42:53 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5mZ9-0000TE-0X;
        Wed, 22 Nov 2023 12:42:51 +0000
Date:   Wed, 22 Nov 2023 20:40:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "marcelo.schmitt@analog.com" <marcelo.schmitt@analog.com>,
        beniamin.bia@analog.com, paul.cercueil@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        marcelo.schmitt1@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: ad7091r: Move defines to header file
Message-ID: <202311221730.lHHfx8Ft-lkp@intel.com>
References: <8aa859817e86408733a81cf31b932f0efa273c71.1700595310.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa859817e86408733a81cf31b932f0efa273c71.1700595310.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marcelo-schmitt-analog-com/MAINTAINERS-Add-MAINTAINERS-entry-for-AD7091R/20231122-093706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/8aa859817e86408733a81cf31b932f0efa273c71.1700595310.git.marcelo.schmitt1%40gmail.com
patch subject: [PATCH 3/7] iio: adc: ad7091r: Move defines to header file
config: powerpc-randconfig-r071-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221730.lHHfx8Ft-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311221730.lHHfx8Ft-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221730.lHHfx8Ft-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad7091r-base.c:16:
>> drivers/iio/adc/ad7091r-base.h:41:36: warning: 'ad7091r_events' defined but not used [-Wunused-const-variable=]
      41 | static const struct iio_event_spec ad7091r_events[] = {
         |                                    ^~~~~~~~~~~~~~


vim +/ad7091r_events +41 drivers/iio/adc/ad7091r-base.h

    40	
  > 41	static const struct iio_event_spec ad7091r_events[] = {
    42		{
    43			.type = IIO_EV_TYPE_THRESH,
    44			.dir = IIO_EV_DIR_RISING,
    45			.mask_separate = BIT(IIO_EV_INFO_VALUE) |
    46					 BIT(IIO_EV_INFO_ENABLE),
    47		},
    48		{
    49			.type = IIO_EV_TYPE_THRESH,
    50			.dir = IIO_EV_DIR_FALLING,
    51			.mask_separate = BIT(IIO_EV_INFO_VALUE) |
    52					 BIT(IIO_EV_INFO_ENABLE),
    53		},
    54		{
    55			.type = IIO_EV_TYPE_THRESH,
    56			.dir = IIO_EV_DIR_EITHER,
    57			.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
    58		},
    59	};
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
