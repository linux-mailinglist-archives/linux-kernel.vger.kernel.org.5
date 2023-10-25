Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893D7D723B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJYRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:24:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53612F;
        Wed, 25 Oct 2023 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698254663; x=1729790663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIbb037174+bOdznRrZiyWuHxU4yCQHlYl1BOSUWzbw=;
  b=UIoYy9mP5W5U2XmpybyLG1NJGZfMhEf5Dh+34oWBzW4TjkG/2oI1rvOb
   SZlyEAZ6pQBkUw5DwRmmv/lkOY0dH+3L4Js9ilSf5UdkUAfALIjslVzhQ
   yjStByrreHcmgNbSnBDSTofw66ylLcw6C4AbAGpDwkXtkkm6zln0clyoY
   kVZqXStLtTJy+Kw+KS1PcYo94KKm66NfVzNU6/JAWHuU8s81agBZAMhqI
   g3PDmbSg2W2iGnPUNGMEFWjtT+JSYyr3H6vAdY391xS3TEO7hHkHRoU40
   tq8Pci8cWixycvpIgiJjmGRDE9gcXWOVigTjVem6HsPMpeCtFC3N1ADzE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="139638"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="139638"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 10:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="824715376"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="824715376"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2023 10:24:20 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvhcA-000945-1S;
        Wed, 25 Oct 2023 17:24:18 +0000
Date:   Thu, 26 Oct 2023 01:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marius.cristea@microchip.com
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
Message-ID: <202310260114.N4b9wmIC-lkp@intel.com>
References: <20231025134404.131485-3-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025134404.131485-3-marius.cristea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e99f692d4e32e3250ab18d511894ca797407aec]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-dt-bindings-for-PAC193X/20231025-214558
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20231025134404.131485-3-marius.cristea%40microchip.com
patch subject: [PATCH v2 2/2] iio: adc: adding support for pac193x
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310260114.N4b9wmIC-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260114.N4b9wmIC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260114.N4b9wmIC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/pac1934.c:1751:36: warning: 'pac1934_acpi_match' defined but not used [-Wunused-const-variable=]
    1751 | static const struct acpi_device_id pac1934_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +/pac1934_acpi_match +1751 drivers/iio/adc/pac1934.c

  1749	
  1750	/* using MCHP1930 to be compatible with WINDOWS ACPI */
> 1751	static const struct acpi_device_id pac1934_acpi_match[] = {
  1752		{"MCHP1930", 0},
  1753		{ }
  1754	};
  1755	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
