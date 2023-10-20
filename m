Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA377D12CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377754AbjJTPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377782AbjJTPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87110C7;
        Fri, 20 Oct 2023 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697815890; x=1729351890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8WfxPaOzLW8AWmNf+EMLv4pLoLyObaSU2ANMkPjryc=;
  b=QeFS+w9GFm2fP845g8ugdDxm1yVn3R83EuVoCz2DmpU99GFTFN95ljAp
   7fpYcPCN3bgCqSeTf85ffQ6mUTtkbWkZgzvM/KDG0xZSA1yqJKiKMV+Jm
   +cU4mFfAp2n9KnZcbm+MuMnb6odMym9M7oWXzhjNdNKnug24YfKjSH79s
   baWQccS8hVUmTgg5mDl00f4iUTKL/Yw5bf4/7m1mbuFbzSuH4LLlTf3Fq
   DQyslOebcc8d7G3gwl/br0/gLQJZNotef0RJN7FkbnnOMO02d6w5AUarp
   geUJ6YPRPHBYcjs5MfcsYZ+7cQ3ODzcnmm0jtXaHSfVhBFeAw32De5h2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385401514"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385401514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761084863"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761084863"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Oct 2023 08:31:15 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtrSz-0003fh-0M;
        Fri, 20 Oct 2023 15:31:13 +0000
Date:   Fri, 20 Oct 2023 23:30:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Ogletree <james.ogletree@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <202310202344.LreohGFP-lkp@intel.com>
References: <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus lee-mfd/for-mfd-next robh/for-next linus/master lee-mfd/for-mfd-fixes v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Ogletree/dt-bindings-input-cirrus-cs40l50-Add-initial-DT-binding/20231019-015950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231018175726.3879955-5-james.ogletree%40opensource.cirrus.com
patch subject: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50 haptic driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310202344.LreohGFP-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310202344.LreohGFP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310202344.LreohGFP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/misc/cs40l50-vibra.c: In function 'cs40l50_vibra_remove':
>> drivers/input/misc/cs40l50-vibra.c:329:13: warning: the comparison will always evaluate as 'true' for the address of 'dsp' will never be NULL [-Waddress]
     329 |         if (&cs40l50->dsp)
         |             ^
   In file included from drivers/input/misc/cs40l50-vibra.c:11:
   include/linux/mfd/cs40l50.h:180:23: note: 'dsp' declared here
     180 |         struct cs_dsp dsp;
         |                       ^~~


vim +329 drivers/input/misc/cs40l50-vibra.c

   319	
   320	static int cs40l50_vibra_remove(struct platform_device *pdev)
   321	{
   322		struct cs40l50_private *cs40l50 = dev_get_drvdata(pdev->dev.parent);
   323	
   324		input_unregister_device(cs40l50->input);
   325		cs_hap_remove(&cs40l50->haptics);
   326	
   327		if (cs40l50->dsp.booted)
   328			cs_dsp_power_down(&cs40l50->dsp);
 > 329		if (&cs40l50->dsp)
   330			cs_dsp_remove(&cs40l50->dsp);
   331	
   332		return 0;
   333	}
   334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
