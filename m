Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0D7BCF7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbjJHSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJHSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:04:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF7AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696788252; x=1728324252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxmOCSaovhTpr23m24r/ivhTBR7t+IQqd8EbUZuhaoE=;
  b=L+3e/DQop5FMfOP66ef6TNmIzbZ5XQktX36n/C5eiaJr6BKToUgjcTZv
   OmHwgrSTx53G479oaOR1OI9x0vSnOseFy+xf2o0Y0ljmOA1a4RZuCgcfI
   BuvscibaC/m28/WJ26MEW5Vq6Zk5QhBPhZPYAyjLqumZ89ei04yyZkyzV
   71Dskz2HNXoQBVIUmmcGylu2eS3TAeiD7xxv/on1E6hVyUBQNaMqSylYF
   +i4d2hVdZCMVSdejpD4HXwSJ8xKITTnsoKICkgCmvrahiXpalOKLEL4rf
   Y4W9aDgNz0A9iItfdcfwaxx4vr4IC0ZTpK3+FxssYepNOLV+gIXGbIxET
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382903114"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="382903114"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 11:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="729426782"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="729426782"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2023 11:04:09 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpY8M-0005dp-2s;
        Sun, 08 Oct 2023 18:04:06 +0000
Date:   Mon, 9 Oct 2023 02:03:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Message-ID: <202310090122.Yp9JndiQ-lkp@intel.com>
References: <20231008135601.542356-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008135601.542356-1-jmkrzyszt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Janusz-Krzysztofik/ASoC-ti-ams-delta-Allow-it-to-be-test-compiled/20231008-215910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231008135601.542356-1-jmkrzyszt%40gmail.com
patch subject: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231009/202310090122.Yp9JndiQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090122.Yp9JndiQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310090122.Yp9JndiQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/ti/ams-delta.c:401:24: error: initialization of 'void (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const unsigned char *, unsigned int)'} from incompatible pointer type 'void (*)(struct tty_struct *, const u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const char *, int)'} [-Werror=incompatible-pointer-types]
     401 |         .receive_buf = cx81801_receive,
         |                        ^~~~~~~~~~~~~~~
   sound/soc/ti/ams-delta.c:401:24: note: (near initialization for 'cx81801_ops.receive_buf')
   cc1: some warnings being treated as errors


vim +401 sound/soc/ti/ams-delta.c

6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  393  
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  394  static struct tty_ldisc_ops cx81801_ops = {
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  395  	.name = "cx81801",
fbadf70a8053b3 sound/soc/ti/ams-delta.c   Jiri Slaby         2021-05-05  396  	.num = N_V253,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  397  	.owner = THIS_MODULE,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  398  	.open = cx81801_open,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  399  	.close = cx81801_close,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  400  	.hangup = cx81801_hangup,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29 @401  	.receive_buf = cx81801_receive,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  402  	.write_wakeup = cx81801_wakeup,
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  403  };
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  404  
6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  405  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
