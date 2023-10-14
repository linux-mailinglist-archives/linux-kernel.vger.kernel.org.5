Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D87C95DA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjJNSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjJNSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:11:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F6BB;
        Sat, 14 Oct 2023 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697307068; x=1728843068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eiDmfD8lwVIVrPcqy/x65+noFv8kPKYhkxxPejyvs4k=;
  b=NdDXoOA6p8UlKvJp2H/F583IP853etkFxXZyaVJrNYP790eGqvchvbXK
   5Br7oPTbRcJASY6cGIyIAn9jzCBm3DL+YSyDrXFsaNTNejJo+AHlcsakc
   qMaiFdVCdxbegRqNpjKCRPkSiRhdDGmgFlnd4BDs6dfHWJGYWby/8M+a1
   SGTDIYKzqC//ejY4AhpRcQiB6C5T+4gq+gVYTmGAm9BNXUpZvcO5Si8+Y
   fgCchV7DxJASUI/Al+IExJboSN920bquHS8uVeRE1L+0gS2JrD71rfysA
   SdjoN47aretMAZs1TOfnikjFmbc/2tiuWPDOyF9NOdLYVgm42zMPMb8h+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385180115"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="385180115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 11:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="898928706"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="898928706"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2023 11:09:10 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrj6L-0006U4-3D;
        Sat, 14 Oct 2023 18:11:02 +0000
Date:   Sun, 15 Oct 2023 02:11:01 +0800
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
Subject: Re: [PATCH v6 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <202310150123.XoLU3dcO-lkp@intel.com>
References: <857baa8073f0b8051720959ef8fb1d49a6161d36.1696608809.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857baa8073f0b8051720959ef8fb1d49a6161d36.1696608809.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on robh/for-next linus/master v6.6-rc5 next-20231013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/dt-bindings-vendor-prefixes-Add-techwell-vendor-prefix/20231007-002623
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/857baa8073f0b8051720959ef8fb1d49a6161d36.1696608809.git.mehdi.djait%40bootlin.com
patch subject: [PATCH v6 3/3] media: i2c: Introduce a driver for the Techwell TW9900 decoder
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231015/202310150123.XoLU3dcO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310150123.XoLU3dcO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310150123.XoLU3dcO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/i2c/tw9900.c: In function 'tw9900_get_stream_std':
>> drivers/media/i2c/tw9900.c:359:15: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     359 |         std = FIELD_GET(TW9900_STDNOW_MASK, ret);
         |               ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +359 drivers/media/i2c/tw9900.c

   347	
   348	static int tw9900_get_stream_std(struct tw9900 *tw9900,
   349					 v4l2_std_id *std_id)
   350	{
   351		int std, ret;
   352	
   353		ret = tw9900_read_reg(tw9900->client, TW9900_REG_STD_SEL);
   354		if (ret < 0) {
   355			*std_id = V4L2_STD_UNKNOWN;
   356			return ret;
   357		}
   358	
 > 359		std = FIELD_GET(TW9900_STDNOW_MASK, ret);
   360	
   361		switch (std) {
   362		case TW9900_STD_NTSC_M:
   363			*std_id = V4L2_STD_NTSC;
   364			break;
   365		case TW9900_STD_PAL_BDGHI:
   366			*std_id = V4L2_STD_PAL;
   367			break;
   368		case TW9900_STD_AUTO:
   369			*std_id = V4L2_STD_UNKNOWN;
   370			break;
   371		default:
   372			*std_id = V4L2_STD_UNKNOWN;
   373			break;
   374		}
   375	
   376		return 0;
   377	}
   378	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
