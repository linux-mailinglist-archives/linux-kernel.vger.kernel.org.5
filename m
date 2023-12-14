Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC1812978
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjLNHgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjLNHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:36:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF1A3;
        Wed, 13 Dec 2023 23:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539379; x=1734075379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O793Cg30kUeFVU+/2kA6cXSlaIN7rlSxi04rzgR+wKg=;
  b=FKocxqI7yTcQmKchIAe8USM+teo3wMI1aLgchVoxvxdk4JydAsrY4PiU
   wgTWztj56/pqP51bUiXPBTqPlGmohAxIP6FZvoFC4okP/YY2k/rFOApwx
   MrfFusvffsuyhJdn4UXqMCkCCdclEEYQed+zZrF96wmkLM4C2leDmvQQV
   rtFYy791TlvG+inN9yNovAANWte4hmNeKXnWOQ07hItsr9Wn0Ke+jSWZs
   L7mT/iLNFXj/xHA7PGUZQ869LOp/Hgn3dcV/VOAx7o00CzVycJoJmoqCA
   pVb999N60yYAjhtwOJ8FUOJgqKzU2fXNtWyOefhXBtPdHWDIAswcTbq61
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394827969"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="394827969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917968557"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="917968557"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 23:36:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDgGR-000Ljx-1Y;
        Thu, 14 Dec 2023 07:36:12 +0000
Date:   Thu, 14 Dec 2023 15:35:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, caleb.connolly@linaro.org,
        lina.iyer@linaro.org, lukasz.luba@arm.com, quic_manafm@quicinc.com,
        quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Message-ID: <202312141523.Mm96MDNX-lkp@intel.com>
References: <20231213175818.2826876-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213175818.2826876-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/acpi-bus rafael-pm/thermal linus/master rafael-pm/devprop v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/PM-QoS-Add-a-performance-QoS/20231214-020026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231213175818.2826876-2-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 2/2] PM: QoS: Add a performance QoS
config: i386-buildonly-randconfig-002-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141523.Mm96MDNX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141523.Mm96MDNX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141523.Mm96MDNX-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: sound/soc/intel/catpt/pcm.o: in function `dev_pm_qos_hide_perf_limit':
>> pcm.c:(.text+0xb94): multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/intel/catpt/device.o:device.c:(.text+0x624): first defined here
--
   ld: sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.o: in function `dev_pm_qos_hide_perf_limit':
>> acp3x-es83xx.c:(.text+0x368): multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/amd/acp/acp-legacy-mach.o:acp-legacy-mach.c:(.text+0x174): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
