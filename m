Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7B7BB3D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJFJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjJFJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:07:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65193
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696583229; x=1728119229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=prZqFFmVUVj+/pUPQIpwn+PhH/vTZVYxBW8hET2SOXQ=;
  b=mbDky0JPUbT8GXPSWNbpCNaqLdGdYMk9UW31IFBcP6LeFjdhXvN9iiT4
   lgZtuA5ks6zSQgm/9BsMi7o3UBaQT/E+NlWTAMDaobL0H1IBIrH5VohZ7
   XGeOn+PMiEwt7WH/GvcDdiqaupTwVJMJRWmfBpUlCADh7Kdwl9/vqya+L
   Npi0znJWbZOybBu0eI9GYL4E8N5mG9NwpekIZkMIslr2NMuuv/K49gQx5
   orbd5vK29DPiR85Cuq5pd65mYCRNZPMmVoT77QWphz18SlrCkRJUuTgW8
   mjdmaomHghPe9FCLJ3sV75+vAfR3C2qg2uSXt6NUutnkRWmZAGEH/kgJC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2313573"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2313573"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="787325919"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="787325919"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2023 02:07:07 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qognX-000MRM-39;
        Fri, 06 Oct 2023 09:07:03 +0000
Date:   Fri, 6 Oct 2023 17:06:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: drivers/tee/optee/smc_abi.c:764: warning: Function parameter or
 member 'rpc_arg' not described in 'optee_handle_rpc'
Message-ID: <202310061720.uZWZqosO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: ed8faf6c8f8c1f7e9ee88342a915ce5f09ca9736 optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG
date:   1 year, 6 months ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231006/202310061720.uZWZqosO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061720.uZWZqosO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061720.uZWZqosO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tee/optee/smc_abi.c:764: warning: Function parameter or member 'rpc_arg' not described in 'optee_handle_rpc'


vim +764 drivers/tee/optee/smc_abi.c

c51a564a5b4835 Jens Wiklander 2021-07-21  751  
c51a564a5b4835 Jens Wiklander 2021-07-21  752  /**
c51a564a5b4835 Jens Wiklander 2021-07-21  753   * optee_handle_rpc() - handle RPC from secure world
c51a564a5b4835 Jens Wiklander 2021-07-21  754   * @ctx:	context doing the RPC
c51a564a5b4835 Jens Wiklander 2021-07-21  755   * @param:	value of registers for the RPC
c51a564a5b4835 Jens Wiklander 2021-07-21  756   * @call_ctx:	call context. Preserved during one OP-TEE invocation
c51a564a5b4835 Jens Wiklander 2021-07-21  757   *
c51a564a5b4835 Jens Wiklander 2021-07-21  758   * Result of RPC is written back into @param.
c51a564a5b4835 Jens Wiklander 2021-07-21  759   */
c51a564a5b4835 Jens Wiklander 2021-07-21  760  static void optee_handle_rpc(struct tee_context *ctx,
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  761  			     struct optee_msg_arg *rpc_arg,
c51a564a5b4835 Jens Wiklander 2021-07-21  762  			     struct optee_rpc_param *param,
c51a564a5b4835 Jens Wiklander 2021-07-21  763  			     struct optee_call_ctx *call_ctx)
c51a564a5b4835 Jens Wiklander 2021-07-21 @764  {
c51a564a5b4835 Jens Wiklander 2021-07-21  765  	struct tee_device *teedev = ctx->teedev;
c51a564a5b4835 Jens Wiklander 2021-07-21  766  	struct optee *optee = tee_get_drvdata(teedev);
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  767  	struct optee_msg_arg *arg;
c51a564a5b4835 Jens Wiklander 2021-07-21  768  	struct tee_shm *shm;
c51a564a5b4835 Jens Wiklander 2021-07-21  769  	phys_addr_t pa;
c51a564a5b4835 Jens Wiklander 2021-07-21  770  
c51a564a5b4835 Jens Wiklander 2021-07-21  771  	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
c51a564a5b4835 Jens Wiklander 2021-07-21  772  	case OPTEE_SMC_RPC_FUNC_ALLOC:
5d41f1b3e32829 Jens Wiklander 2022-02-04  773  		shm = tee_shm_alloc_priv_buf(optee->ctx, param->a1);
c51a564a5b4835 Jens Wiklander 2021-07-21  774  		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
c51a564a5b4835 Jens Wiklander 2021-07-21  775  			reg_pair_from_64(&param->a1, &param->a2, pa);
c51a564a5b4835 Jens Wiklander 2021-07-21  776  			reg_pair_from_64(&param->a4, &param->a5,
c51a564a5b4835 Jens Wiklander 2021-07-21  777  					 (unsigned long)shm);
c51a564a5b4835 Jens Wiklander 2021-07-21  778  		} else {
c51a564a5b4835 Jens Wiklander 2021-07-21  779  			param->a1 = 0;
c51a564a5b4835 Jens Wiklander 2021-07-21  780  			param->a2 = 0;
c51a564a5b4835 Jens Wiklander 2021-07-21  781  			param->a4 = 0;
c51a564a5b4835 Jens Wiklander 2021-07-21  782  			param->a5 = 0;
c51a564a5b4835 Jens Wiklander 2021-07-21  783  		}
6add87fdae9bcb Xiaolei Wang   2021-12-06  784  		kmemleak_not_leak(shm);
c51a564a5b4835 Jens Wiklander 2021-07-21  785  		break;
c51a564a5b4835 Jens Wiklander 2021-07-21  786  	case OPTEE_SMC_RPC_FUNC_FREE:
c51a564a5b4835 Jens Wiklander 2021-07-21  787  		shm = reg_pair_to_ptr(param->a1, param->a2);
c51a564a5b4835 Jens Wiklander 2021-07-21  788  		tee_shm_free(shm);
c51a564a5b4835 Jens Wiklander 2021-07-21  789  		break;
c51a564a5b4835 Jens Wiklander 2021-07-21  790  	case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
c51a564a5b4835 Jens Wiklander 2021-07-21  791  		/*
c51a564a5b4835 Jens Wiklander 2021-07-21  792  		 * A foreign interrupt was raised while secure world was
c51a564a5b4835 Jens Wiklander 2021-07-21  793  		 * executing, since they are handled in Linux a dummy RPC is
c51a564a5b4835 Jens Wiklander 2021-07-21  794  		 * performed to let Linux take the interrupt through the normal
c51a564a5b4835 Jens Wiklander 2021-07-21  795  		 * vector.
c51a564a5b4835 Jens Wiklander 2021-07-21  796  		 */
c51a564a5b4835 Jens Wiklander 2021-07-21  797  		break;
c51a564a5b4835 Jens Wiklander 2021-07-21  798  	case OPTEE_SMC_RPC_FUNC_CMD:
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  799  		if (rpc_arg) {
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  800  			arg = rpc_arg;
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  801  		} else {
c51a564a5b4835 Jens Wiklander 2021-07-21  802  			shm = reg_pair_to_ptr(param->a1, param->a2);
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  803  			arg = tee_shm_get_va(shm, 0);
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  804  			if (IS_ERR(arg)) {
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  805  				pr_err("%s: tee_shm_get_va %p failed\n",
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  806  				       __func__, shm);
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  807  				break;
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  808  			}
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  809  		}
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  810  
ed8faf6c8f8c1f Jens Wiklander 2021-11-03  811  		handle_rpc_func_cmd(ctx, optee, arg, call_ctx);
c51a564a5b4835 Jens Wiklander 2021-07-21  812  		break;
c51a564a5b4835 Jens Wiklander 2021-07-21  813  	default:
c51a564a5b4835 Jens Wiklander 2021-07-21  814  		pr_warn("Unknown RPC func 0x%x\n",
c51a564a5b4835 Jens Wiklander 2021-07-21  815  			(u32)OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0));
c51a564a5b4835 Jens Wiklander 2021-07-21  816  		break;
c51a564a5b4835 Jens Wiklander 2021-07-21  817  	}
c51a564a5b4835 Jens Wiklander 2021-07-21  818  
c51a564a5b4835 Jens Wiklander 2021-07-21  819  	param->a0 = OPTEE_SMC_CALL_RETURN_FROM_RPC;
c51a564a5b4835 Jens Wiklander 2021-07-21  820  }
c51a564a5b4835 Jens Wiklander 2021-07-21  821  

:::::: The code at line 764 was first introduced by commit
:::::: c51a564a5b48355f30309b84cdffe3f96d1ae0d3 optee: isolate smc abi

:::::: TO: Jens Wiklander <jens.wiklander@linaro.org>
:::::: CC: Jens Wiklander <jens.wiklander@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
