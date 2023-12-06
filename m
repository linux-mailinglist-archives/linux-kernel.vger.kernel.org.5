Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFE80724A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbjLFOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378905AbjLFOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:23:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6462AD4B;
        Wed,  6 Dec 2023 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701872622; x=1733408622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pp3OioeXpZho5+76nSTlDa8kUCjyMjUIKd1pp/K2V+4=;
  b=KuMuNc67gviEh+McSD+gFX+KTHjlwHyHVW6c/3Wh2Jj9izRFe6i8/14k
   ZT+P91+n8z8iRKVUampmC+q3AKOSE3e28/69mTroMPDtz+JDhiI4weAFs
   7h399aYLWcOTJG6rbvuQnJssge7IRi1k8lLuzAAEzg/CeUT6/vWYEtNci
   u3T1Blhl9zGtnyJ8+f0aiGlACgnliQStNkcqpOQXmUFG0rtAOPOx0LVT1
   zL8kCmtALj5kLgPX8j/5jFGxdC8H8duKDgd/7RdzzFY8qno/7KWd8G9Ia
   zQ37VZsPR4Qlp3ONDfjE0/nJJE7PAt5XGkTLZJ3ImHgJbixSoHeA8ks/W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="396856497"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="396856497"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 06:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="19337371"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Dec 2023 06:23:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAsoK-000Auk-0I;
        Wed, 06 Dec 2023 14:23:36 +0000
Date:   Wed, 6 Dec 2023 22:22:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, hvilleneuve@dimonoff.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, hugo@hugovil.com
Subject: Re: [PATCH 7/7] serial: max310x: use separate regmap name for each
 port
Message-ID: <202312062240.v39k99mQ-lkp@intel.com>
References: <20231130191050.3165862-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130191050.3165862-8-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d804987153e7bedf503f8e4ba649afe52cfd7f6d]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-fix-snprintf-format-specifier-in-sc16is7xx_regmap_name/20231201-031413
base:   d804987153e7bedf503f8e4ba649afe52cfd7f6d
patch link:    https://lore.kernel.org/r/20231130191050.3165862-8-hugo%40hugovil.com
patch subject: [PATCH 7/7] serial: max310x: use separate regmap name for each port
config: arm-randconfig-r081-20231201 (https://download.01.org/0day-ci/archive/20231206/202312062240.v39k99mQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312062240.v39k99mQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312062240.v39k99mQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'max310x_regmap_name',
       inlined from 'max310x_i2c_probe' at drivers/tty/serial/max310x.c:1641:21:
>> drivers/tty/serial/max310x.c:30:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
      30 | #define MAX310X_PORT_NAME_SUFFIX        "port"
         |                                         ^~~~~~
   drivers/tty/serial/max310x.c:1494:36: note: in expansion of macro 'MAX310X_PORT_NAME_SUFFIX'
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c: In function 'max310x_i2c_probe':
   drivers/tty/serial/max310x.c:1494:62: note: format string is defined here
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                                              ^~
   In function 'max310x_regmap_name',
       inlined from 'max310x_i2c_probe' at drivers/tty/serial/max310x.c:1641:21:
   drivers/tty/serial/max310x.c:30:41: note: directive argument in the range [1, 4294967294]
      30 | #define MAX310X_PORT_NAME_SUFFIX        "port"
         |                                         ^~~~~~
   drivers/tty/serial/max310x.c:1494:36: note: in expansion of macro 'MAX310X_PORT_NAME_SUFFIX'
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1494:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'max310x_regmap_name',
       inlined from 'max310x_spi_probe' at drivers/tty/serial/max310x.c:1535:17:
>> drivers/tty/serial/max310x.c:30:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
      30 | #define MAX310X_PORT_NAME_SUFFIX        "port"
         |                                         ^~~~~~
   drivers/tty/serial/max310x.c:1494:36: note: in expansion of macro 'MAX310X_PORT_NAME_SUFFIX'
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c: In function 'max310x_spi_probe':
   drivers/tty/serial/max310x.c:1494:62: note: format string is defined here
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                                              ^~
   In function 'max310x_regmap_name',
       inlined from 'max310x_spi_probe' at drivers/tty/serial/max310x.c:1535:17:
   drivers/tty/serial/max310x.c:30:41: note: directive argument in the range [0, 4294967294]
      30 | #define MAX310X_PORT_NAME_SUFFIX        "port"
         |                                         ^~~~~~
   drivers/tty/serial/max310x.c:1494:36: note: in expansion of macro 'MAX310X_PORT_NAME_SUFFIX'
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1494:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
    1494 |         snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +30 drivers/tty/serial/max310x.c

    28	
    29	#define MAX310X_NAME			"max310x"
  > 30	#define MAX310X_PORT_NAME_SUFFIX	"port"
    31	#define MAX310X_MAJOR			204
    32	#define MAX310X_MINOR			209
    33	#define MAX310X_UART_NRMAX		16
    34	#define MAX310X_MAX_PORTS		4 /* Maximum number of UART ports per IC. */
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
