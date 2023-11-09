Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F97E6429
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjKIHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:07:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9D272C;
        Wed,  8 Nov 2023 23:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699513622; x=1731049622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DeI+cOT9CYgPMo2FIwpsfa32fIwnYT4C1szKk53nofc=;
  b=dEBrRCbI4poX2jIZpMbcEhf9oNz88nKC0xbsqtmNghj9MctvfFKc+Gxk
   kCeembllXhoBch6GFmUGuBHgvog+sY3H+GD5GGp74sAJV6+1VThFFwNSF
   5n+CUuxp5E3U2AVFAVSWyiS1oEF9d+9S/z1WWyGJxAUA2U52KMOLf6Qf3
   wCxKdHaMXuw1RkBoUIN7lT5NZbzujIEH1uVtbvwUy/FEXzDMK41LdgKky
   gfN34LxrRa9YGz/Qv7XXKDC0V4oZiz3/diXIBDXwOL5amGGe3qQCvGvNk
   v4AyfzbeEAsI6AmosX7SLzQ7GaJy5KBt9x4j+QGI8ggLIiFPpN4xsXiJO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8579454"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="8579454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="833740023"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="833740023"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2023 23:06:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0z7t-0008Xw-38;
        Thu, 09 Nov 2023 07:06:53 +0000
Date:   Thu, 9 Nov 2023 15:06:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: Re: [PATCH v8 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <202311091458.0Mnol4EW-lkp@intel.com>
References: <93354996c95926970684498f08061b60a52bb84c.1699449537.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93354996c95926970684498f08061b60a52bb84c.1699449537.git.mehdi.djait@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linuxtv-media-stage/master linus/master v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/dt-bindings-vendor-prefixes-Add-techwell-vendor-prefix/20231109-042139
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/93354996c95926970684498f08061b60a52bb84c.1699449537.git.mehdi.djait%40bootlin.com
patch subject: [PATCH v8 3/3] media: i2c: Introduce a driver for the Techwell TW9900 decoder
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20231109/202311091458.0Mnol4EW-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091458.0Mnol4EW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091458.0Mnol4EW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/tw9900.c:359:12: warning: 'tw9900_runtime_suspend' defined but not used [-Wunused-function]
     359 | static int tw9900_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/tw9900.c:350:12: warning: 'tw9900_runtime_resume' defined but not used [-Wunused-function]
     350 | static int tw9900_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/tw9900_runtime_suspend +359 drivers/media/i2c/tw9900.c

   349	
 > 350	static int tw9900_runtime_resume(struct device *dev)
   351	{
   352		struct i2c_client *client = to_i2c_client(dev);
   353		struct v4l2_subdev *sd = i2c_get_clientdata(client);
   354		struct tw9900 *tw9900 = to_tw9900(sd);
   355	
   356		return tw9900_power_on(tw9900);
   357	}
   358	
 > 359	static int tw9900_runtime_suspend(struct device *dev)
   360	{
   361		struct i2c_client *client = to_i2c_client(dev);
   362		struct v4l2_subdev *sd = i2c_get_clientdata(client);
   363		struct tw9900 *tw9900 = to_tw9900(sd);
   364	
   365		tw9900_power_off(tw9900);
   366	
   367		return 0;
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
