Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31C79C1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjILB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjILB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:29:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850D16479E;
        Mon, 11 Sep 2023 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481192; x=1726017192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1EJVBAr5si3B8nlNmvY+MmhcTC0HYp8CfIRkvp3yw4=;
  b=LGtV9ftMf5MUgCtAGLT/Un2AIkm9nUYLxTV6psjV1Wp42cLwiU51Y7/5
   vWTPZv7KpgNon6AGpB2zPFMQ7ALM0ypwkJCtE6CeUBoz435ifsFaxsoIn
   1JvQlLVP3uSd31ykUuwD6d2Q0Yo0YrbKLWgASn7+pQ/1SB5p41y890kvP
   JQdMfxEu9bTpx6TIOHbOH6PIA7qzt/5/XhkY1QEtIbTPImSdVhWMlCpYz
   SBQWmKGgcbiECo+M9FVK/pjlYgmLkoyKW+uRv/SMNFfpao/+UqHzy2tnn
   KHwrdfmcvhin2QrO8hMhph3aFfYOnD3my+F9coXKD+IVQPJkm2+8UxyH+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444673301"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444673301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886733766"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886733766"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2023 16:53:32 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfqj5-0006uM-1y;
        Mon, 11 Sep 2023 23:53:55 +0000
Date:   Tue, 12 Sep 2023 07:53:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH RFT 11/20] media: venus: core: Drop cache properties in
 resource struct
Message-ID: <202309120738.fip6vVJN-lkp@intel.com>
References: <20230911-topic-mars-v1-11-a7d38bf87bdb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-topic-mars-v1-11-a7d38bf87bdb@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7bc675554773f09d88101bf1ccfc8537dc7c0be9]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/media-venus-pm_helpers-Only-set-rate-of-the-core-clock-in-core_clks_enable/20230912-051942
base:   7bc675554773f09d88101bf1ccfc8537dc7c0be9
patch link:    https://lore.kernel.org/r/20230911-topic-mars-v1-11-a7d38bf87bdb%40linaro.org
patch subject: [PATCH RFT 11/20] media: venus: core: Drop cache properties in resource struct
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230912/202309120738.fip6vVJN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120738.fip6vVJN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120738.fip6vVJN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/qcom/venus/hfi_venus.c: In function 'venus_isr_thread':
>> drivers/media/platform/qcom/venus/hfi_venus.c:1060:39: warning: variable 'res' set but not used [-Wunused-but-set-variable]
    1060 |         const struct venus_resources *res;
         |                                       ^~~


vim +/res +1060 drivers/media/platform/qcom/venus/hfi_venus.c

d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1056  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1057  static irqreturn_t venus_isr_thread(struct venus_core *core)
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1058  {
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1059  	struct venus_hfi_device *hdev = to_hfi_priv(core);
4cb3548a87c4a3 Stanimir Varbanov 2017-06-15 @1060  	const struct venus_resources *res;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1061  	void *pkt;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1062  	u32 msg_ret;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1063  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1064  	if (!hdev)
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1065  		return IRQ_NONE;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1066  
4cb3548a87c4a3 Stanimir Varbanov 2017-06-15  1067  	res = hdev->core->res;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1068  	pkt = hdev->pkt_buf;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1069  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1070  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1071  	while (!venus_iface_msgq_read(hdev, pkt)) {
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1072  		msg_ret = hfi_process_msg_packet(core, pkt);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1073  		switch (msg_ret) {
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1074  		case HFI_MSG_EVENT_NOTIFY:
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1075  			venus_process_msg_sys_error(hdev, pkt);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1076  			break;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1077  		case HFI_MSG_SYS_INIT:
8b05e503e6c2dd Konrad Dybcio     2023-09-11  1078  			/* Disable OCMEM/VMEM unconditionally until support is added */
8b05e503e6c2dd Konrad Dybcio     2023-09-11  1079  			venus_hfi_core_set_resource(core, VIDC_RESOURCE_NONE,
8b05e503e6c2dd Konrad Dybcio     2023-09-11  1080  						    0,
8b05e503e6c2dd Konrad Dybcio     2023-09-11  1081  						    0,
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1082  						    hdev);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1083  			break;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1084  		case HFI_MSG_SYS_RELEASE_RESOURCE:
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1085  			complete(&hdev->release_resource);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1086  			break;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1087  		case HFI_MSG_SYS_PC_PREP:
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1088  			complete(&hdev->pwr_collapse_prep);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1089  			break;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1090  		default:
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1091  			break;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1092  		}
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1093  	}
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1094  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1095  	venus_flush_debug_queue(hdev);
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1096  
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1097  	return IRQ_HANDLED;
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1098  }
d96d3f30c0f2f5 Stanimir Varbanov 2017-06-15  1099  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
