Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAB7CF957
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJSMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbjJSMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:50:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2A9F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697719813; x=1729255813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wB86GoqdauFfotmqJEugQ98KtnM4Buboa+WlRVu+L4=;
  b=jl609dh4hLrgX58WXqccASOFuTR4XuR//Sl5QedvgXJv7iC0uClhECik
   y+w1DTQ0Oer4MkcR1lpTd7//fMx28qlUUcF/7xpfVW0bFXXKypXAmicqD
   90RQNJGyySyXRaDnD6wIErGhx53Fv2ARm9cwImQW9sVhZVL5BdakH8Pkx
   5tU67HAk6l2KYm+O/bwbPl/5YXY/3M5WMqsTJ/peYTecP+z/yAFPJqmdG
   osQ2KS9uZKCTb+fiF5p2rNSqUu46t+9gVLd9XE8JybPcbHL5KW483CUhm
   IkYffPNkGDEtbSTVZgvAew37ZaKJPPLzlwddFOFFIVlqLiUM2KmslVJQ+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452709301"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="452709301"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757010036"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="757010036"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2023 05:50:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtSTY-00027G-0t;
        Thu, 19 Oct 2023 12:50:08 +0000
Date:   Thu, 19 Oct 2023 20:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Etienne Carriere <etienne.carriere@foss.st.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v11 1/4] tee: optee: system call property
Message-ID: <202310192021.fvb6JDOY-lkp@intel.com>
References: <20231016090428.1369071-2-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016090428.1369071-2-etienne.carriere@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Etienne-Carriere/tee-optee-system-call-property/20231017-135906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231016090428.1369071-2-etienne.carriere%40foss.st.com
patch subject: [PATCH v11 1/4] tee: optee: system call property
config: arm64-randconfig-001-20231019 (https://download.01.org/0day-ci/archive/20231019/202310192021.fvb6JDOY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192021.fvb6JDOY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192021.fvb6JDOY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tee/optee/ffa_abi.c:618: warning: Function parameter or member 'system_thread' not described in 'optee_ffa_do_call_with_arg'
--
   drivers/tee/optee/smc_abi.c:818: warning: Function parameter or member 'rpc_arg' not described in 'optee_handle_rpc'
>> drivers/tee/optee/smc_abi.c:890: warning: Function parameter or member 'system_thread' not described in 'optee_smc_do_call_with_arg'


vim +618 drivers/tee/optee/ffa_abi.c

4615e5a34b95e0 Jens Wiklander   2021-07-21  602  
4615e5a34b95e0 Jens Wiklander   2021-07-21  603  /**
4615e5a34b95e0 Jens Wiklander   2021-07-21  604   * optee_ffa_do_call_with_arg() - Do a FF-A call to enter OP-TEE in secure world
4615e5a34b95e0 Jens Wiklander   2021-07-21  605   * @ctx:	calling context
4615e5a34b95e0 Jens Wiklander   2021-07-21  606   * @shm:	shared memory holding the message to pass to secure world
5b4018b959149e Jens Wiklander   2022-01-25  607   * @offs:	offset of the message in @shm
4615e5a34b95e0 Jens Wiklander   2021-07-21  608   *
4615e5a34b95e0 Jens Wiklander   2021-07-21  609   * Does a FF-A call to OP-TEE in secure world and handles eventual resulting
4615e5a34b95e0 Jens Wiklander   2021-07-21  610   * Remote Procedure Calls (RPC) from OP-TEE.
4615e5a34b95e0 Jens Wiklander   2021-07-21  611   *
4615e5a34b95e0 Jens Wiklander   2021-07-21  612   * Returns return code from FF-A, 0 is OK
4615e5a34b95e0 Jens Wiklander   2021-07-21  613   */
4615e5a34b95e0 Jens Wiklander   2021-07-21  614  
4615e5a34b95e0 Jens Wiklander   2021-07-21  615  static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
9f34a9d2a70d79 Etienne Carriere 2023-10-16  616  				      struct tee_shm *shm, u_int offs,
9f34a9d2a70d79 Etienne Carriere 2023-10-16  617  				      bool system_thread)
4615e5a34b95e0 Jens Wiklander   2021-07-21 @618  {
4615e5a34b95e0 Jens Wiklander   2021-07-21  619  	struct ffa_send_direct_data data = {
4615e5a34b95e0 Jens Wiklander   2021-07-21  620  		.data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
4615e5a34b95e0 Jens Wiklander   2021-07-21  621  		.data1 = (u32)shm->sec_world_id,
4615e5a34b95e0 Jens Wiklander   2021-07-21  622  		.data2 = (u32)(shm->sec_world_id >> 32),
5b4018b959149e Jens Wiklander   2022-01-25  623  		.data3 = offs,
4615e5a34b95e0 Jens Wiklander   2021-07-21  624  	};
4064c461148ab1 Jens Wiklander   2021-12-28  625  	struct optee_msg_arg *arg;
4064c461148ab1 Jens Wiklander   2021-12-28  626  	unsigned int rpc_arg_offs;
4064c461148ab1 Jens Wiklander   2021-12-28  627  	struct optee_msg_arg *rpc_arg;
4064c461148ab1 Jens Wiklander   2021-12-28  628  
a639b2b18a240d Jens Wiklander   2022-01-12  629  	/*
a639b2b18a240d Jens Wiklander   2022-01-12  630  	 * The shared memory object has to start on a page when passed as
a639b2b18a240d Jens Wiklander   2022-01-12  631  	 * an argument struct. This is also what the shm pool allocator
a639b2b18a240d Jens Wiklander   2022-01-12  632  	 * returns, but check this before calling secure world to catch
a639b2b18a240d Jens Wiklander   2022-01-12  633  	 * eventual errors early in case something changes.
a639b2b18a240d Jens Wiklander   2022-01-12  634  	 */
a639b2b18a240d Jens Wiklander   2022-01-12  635  	if (shm->offset)
a639b2b18a240d Jens Wiklander   2022-01-12  636  		return -EINVAL;
a639b2b18a240d Jens Wiklander   2022-01-12  637  
5b4018b959149e Jens Wiklander   2022-01-25  638  	arg = tee_shm_get_va(shm, offs);
4064c461148ab1 Jens Wiklander   2021-12-28  639  	if (IS_ERR(arg))
4064c461148ab1 Jens Wiklander   2021-12-28  640  		return PTR_ERR(arg);
4064c461148ab1 Jens Wiklander   2021-12-28  641  
4064c461148ab1 Jens Wiklander   2021-12-28  642  	rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
5b4018b959149e Jens Wiklander   2022-01-25  643  	rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
4064c461148ab1 Jens Wiklander   2021-12-28  644  	if (IS_ERR(rpc_arg))
4064c461148ab1 Jens Wiklander   2021-12-28  645  		return PTR_ERR(rpc_arg);
4615e5a34b95e0 Jens Wiklander   2021-07-21  646  
9f34a9d2a70d79 Etienne Carriere 2023-10-16  647  	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
4615e5a34b95e0 Jens Wiklander   2021-07-21  648  }
4615e5a34b95e0 Jens Wiklander   2021-07-21  649  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
