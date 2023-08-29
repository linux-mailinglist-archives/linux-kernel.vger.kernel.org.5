Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A1C78D0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjH2XzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjH2Xyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:54:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602841B3;
        Tue, 29 Aug 2023 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693353289; x=1724889289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=poo2erOym6FYVcclncpP4gJ8Sb9wFCKFIGFC0CCir4M=;
  b=WBjeE5wBpEFEamaugUgxQ+R3JHegWHydFV4GKzyETMTsTTOjFxsxoCxa
   GGpbMHGddlB/EEucTgbyxrusPs/opyAagyMUtKKvYt5HvZOuXRvzNEmf7
   yxSsenA8BGw63QaPSoTbIEHAbDo8IMCXL5x8SFMp7g8VOWnPS3sSfJ4x7
   jISiYQ+jSh1Coypbmw9ATBB/+C4Exy/DO11O2K9B0XQerKnrVlSJQSDWC
   v57OJKtBRqot9pv+mZwrG/mdPs5LWmVEX16zKHfqbItJo7wGSSTCr4SlP
   3CDHbk6A3v5uHSSkgt0yvN7HH4h1u/YQql1bNiFqSE6QiT4IVDO0EXr5D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374413065"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="374413065"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732395012"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="732395012"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 16:54:32 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb8XX-0009DH-2O;
        Tue, 29 Aug 2023 23:54:31 +0000
Date:   Wed, 30 Aug 2023 07:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>, sudeep.holla@arm.com,
        catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Oza Pawandeep <quic_poza@quicinc.com>
Subject: Re: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <202308300720.JEfxnfQ5-lkp@intel.com>
References: <20230829201101.3330337-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829201101.3330337-1-quic_poza@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on v6.5]
[cannot apply to rafael-pm/linux-next arm64/for-next/core linus/master next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oza-Pawandeep/cpuidle-ACPI-Evaluate-LPI-arch_flags-for-broadcast-timer/20230830-041258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230829201101.3330337-1-quic_poza%40quicinc.com
patch subject: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230830/202308300720.JEfxnfQ5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300720.JEfxnfQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300720.JEfxnfQ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/processor_idle.c: In function 'acpi_processor_setup_lpi_states':
>> drivers/acpi/processor_idle.c:1220:61: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    1220 |                 arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
         |                                                             ^
>> drivers/acpi/processor_idle.c:1220:61: warning: statement with no effect [-Wunused-value]
    1220 |                 arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
         |                                             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~


vim +1220 drivers/acpi/processor_idle.c

  1201	
  1202	static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
  1203	{
  1204		int i;
  1205		struct acpi_lpi_state *lpi;
  1206		struct cpuidle_state *state;
  1207		struct cpuidle_driver *drv = &acpi_idle_driver;
  1208	
  1209		if (!pr->flags.has_lpi)
  1210			return -EOPNOTSUPP;
  1211	
  1212		for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
  1213			lpi = &pr->power.lpi_states[i];
  1214	
  1215			state = &drv->states[i];
  1216			snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
  1217			strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
  1218			state->exit_latency = lpi->wake_latency;
  1219			state->target_residency = lpi->min_residency;
> 1220			arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
  1221			if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
  1222				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
  1223			state->enter = acpi_idle_lpi_enter;
  1224			drv->safe_state_index = i;
  1225		}
  1226	
  1227		drv->state_count = i;
  1228	
  1229		return 0;
  1230	}
  1231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
