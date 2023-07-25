Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A259476255A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjGYWCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGYWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DE2D43;
        Tue, 25 Jul 2023 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690322494; x=1721858494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7dcdBb1/l78pg8+v1QmtAHi7qI73pAZdEwi0vo4frl0=;
  b=i5udl0hLr6hEp0Gg0jZvTNHklyRZegRyZePCIQZlQzXSMsr1IsCx2qNd
   AJ7S0ZSvsGy7Ugfg0X1rIyTgweBGPzgmgNrba1YJkRvX29R3gbsLA7KaO
   S9EFsTRdOap93aX4Rb/aTtijzCAxmc80Vlv3/Hq9Hs0yaVl7tQIgewz4Q
   6aR2xorKpEFx5ghtnVtpRdW+wIDqU9ggdBxxm4EQ+uufRRW4xAo9FTq8r
   etokJtuKoBMiWva9n0B82H3rfAcKsHY+L1ZNqz+OkY9lJyG+Gb4/Wb4pm
   tkYgKdIGkj4dof2zdZjoPUKO9f3BV5sJoMQwXdXTV4oE3WwkP5LqsSyw3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366734265"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="366734265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 15:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761370839"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="761370839"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 15:01:28 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOQ5v-0000Nf-0M;
        Tue, 25 Jul 2023 22:01:27 +0000
Date:   Wed, 26 Jul 2023 06:00:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
Message-ID: <202307260533.MTqa5ObG-lkp@intel.com>
References: <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zhang/coresight-tpdm-Remove-the-unnecessary-lock/20230725-152235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1690269353-10829-10-git-send-email-quic_taozha%40quicinc.com
patch subject: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
config: arm-randconfig-r013-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260533.MTqa5ObG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260533.MTqa5ObG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260533.MTqa5ObG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-tpdm.c:383:21: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     383 |         unsigned long val, mask, edge_ctrl;
         |                            ^
>> drivers/hwtracing/coresight/coresight-tpdm.c:451:3: warning: misleading indentation; statement is not part of the previous 'else' [-Wmisleading-indentation]
     451 |                 drvdata->dsb->edge_ctrl_mask[reg] = set;
         |                 ^
   drivers/hwtracing/coresight/coresight-tpdm.c:449:2: note: previous statement is here
     449 |         else
         |         ^
   2 warnings generated.


vim +/else +451 drivers/hwtracing/coresight/coresight-tpdm.c

   426	
   427	static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
   428						     struct device_attribute *attr,
   429						     const char *buf,
   430						     size_t size)
   431	{
   432		struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
   433		unsigned long val;
   434		u32 set;
   435		int reg;
   436	
   437		if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
   438			return -EINVAL;
   439	
   440		spin_lock(&drvdata->spinlock);
   441		/*
   442		 * There is 1 bit per DSB Edge Control Mark line.
   443		 * Thus we have 32 lines in a 32bit word.
   444		 */
   445		reg = EDCMR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
   446		set = drvdata->dsb->edge_ctrl_mask[reg];
   447		if (val)
   448			set |= BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
   449		else
   450			set &= ~BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
 > 451			drvdata->dsb->edge_ctrl_mask[reg] = set;
   452		spin_unlock(&drvdata->spinlock);
   453	
   454		return size;
   455	}
   456	static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
   457	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
