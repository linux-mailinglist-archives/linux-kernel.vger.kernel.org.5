Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F4812909
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443282AbjLNHX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjLNHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:23:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC8F5;
        Wed, 13 Dec 2023 23:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702538641; x=1734074641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+EMCP39Ou08Hk0CdxIr+mRISfIYGOru/KXGx9QU3hU=;
  b=k27cEFNL41fOJiJlSrN5O3bmGDvVVoBqFhWU54CXrwNOh2rJGZcz/CDM
   q2wtjKTu5291cxNCjTBDGQjQ1GITbb82zRyhKyqQD0htV5ItveF710zlm
   nkXduxyhV8TUsKY0u0Lc5IefNrrEpq26KyaWTNNX5GGKCsaeHnw2WyLbp
   UyvdwqFTd4AcVr3WBqpQKsOsRV5PJ+N5a+0wN9eM9q+skA9ZEhVRsZ1O/
   /n7xpJFLf4+rr3+CNHTFgtu9vyYY/a2iZsu0DTfnaqP5iiR6RnvHY4gQQ
   0Ifur9u9bGlDYI/tDUwYvUnRIJT22u+6ElMbeMOll16vkrPHCVwqs9Etc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393951934"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="393951934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723969124"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723969124"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 23:23:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDg4a-000LjJ-0i;
        Thu, 14 Dec 2023 07:23:56 +0000
Date:   Thu, 14 Dec 2023 15:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, caleb.connolly@linaro.org,
        lina.iyer@linaro.org, lukasz.luba@arm.com, quic_manafm@quicinc.com,
        quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Message-ID: <202312141515.SbtqsA27-lkp@intel.com>
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
config: x86_64-randconfig-012-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141515.SbtqsA27-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141515.SbtqsA27-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141515.SbtqsA27-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: sound/core/oss/pcm_plugin.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/io.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/copy.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/linear.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/mulaw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/route.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/core/oss/rate.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/core/oss/pcm_oss.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/virtio/virtio_chmap.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/virtio/virtio_ctl_msg.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/virtio/virtio_jack.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/virtio/virtio_pcm.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/virtio/virtio_pcm_msg.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/virtio/virtio_pcm_ops.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/virtio/virtio_card.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/soc-dapm.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-jack.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-utils.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-dai.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-component.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-pcm.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-devres.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-ops.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-link.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-card.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-generic-dmaengine-pcm.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-ac97.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/soc/soc-compress.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/soc-core.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/cs35l45-tables.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/cs35l45.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/rt715-sdw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/rt715.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/rt712-sdca-sdw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/rt712-sdca.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/rt711-sdw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/rt711.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/rt700-sdw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/rt700.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/codecs/rt722-sdca-sdw.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/codecs/rt722-sdca.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/soc/fsl/fsl_asrc_dma.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/soc/fsl/fsl_asrc.o:include/linux/pm_qos.h:300: first defined here
--
   ld: sound/pci/ac97/ac97_pcm.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/pci/ac97/ac97_codec.o:include/linux/pm_qos.h:300: first defined here
   ld: sound/pci/ac97/ac97_proc.o: in function `dev_pm_qos_hide_perf_limit':
>> include/linux/pm_qos.h:300: multiple definition of `dev_pm_qos_hide_perf_limit'; sound/pci/ac97/ac97_codec.o:include/linux/pm_qos.h:300: first defined here
..


vim +300 include/linux/pm_qos.h

   297	
   298	static inline int dev_pm_qos_expose_perf_limit(struct device *dev)
   299				{ return 0; }
 > 300	void dev_pm_qos_hide_perf_limit(struct device *dev) {}
   301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
