Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034117A7996
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjITKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjITKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:45:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77DF4;
        Wed, 20 Sep 2023 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695206730; x=1726742730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQ04r3rhhEvN+xUr1SkWuerOykbF40OxGzgam9T1NW4=;
  b=au9Ol2F26fxL8ZoFfi3/ihSrkQVAa3Vpo4Vhj+/+YEUf093EfX2Acs2w
   MzpljUc0yaaVH6fMai1ACPuV3SkPv8hDViX4PRlfREOxd3OH5nMlKCqUK
   ZDEVOBsVOQsY778oGUrFYxvAiI2QeB263Ogz/fCTAPgQ3FW/yJhOlSYXn
   IOIXyGYwmx7xDNKY+s8fF0fBIEmmC+6p9lzuRxy8+N7KTW/vlhDH/I2oT
   5h71NHabrV/2GfZZJNmbczI95//XHZK14JvZBuhmygm4yIHdbE1ZPWuKq
   z1bqGjcQUUM0JupVOALCYX2Al+aBWb/6yYMZl/3fU90/B4fH0K86cRLA+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360445466"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360445466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="723226594"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="723226594"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2023 03:45:27 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiuhx-0008ei-08;
        Wed, 20 Sep 2023 10:45:25 +0000
Date:   Wed, 20 Sep 2023 18:44:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
Message-ID: <202309201811.iKOZ5prG-lkp@intel.com>
References: <20230919090739.2448-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919090739.2448-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bragatheswaran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bragatheswaran-Manickavel/ASoC-dt-bindings-tfa9879-Convert-to-dtschema/20230919-170919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230919090739.2448-1-bragathemanick0908%40gmail.com
patch subject: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
reproduce: (https://download.01.org/0day-ci/archive/20230920/202309201811.iKOZ5prG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201811.iKOZ5prG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/tfa9879.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
