Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479B7C7A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443101AbjJLXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:23:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99503A9;
        Thu, 12 Oct 2023 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697152986; x=1728688986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fYSG4sqWrIC/2C2Ao8u1hyYEpig6sxUSVbww+LIg5f0=;
  b=evWobl74g29pAC1VcQcaBBjvFpf7+owm8gXoDObp0VzQlLTtBoxb0rCR
   ynpx3t7DMwTXK9i7qkeN+P3mDsHbYj3y3hYMe4sTwPJ7303JbXB+wuq21
   AD2Y+oKF4y3b7YjGIjLmlLB9dvfUZp+qfxFy5PeDJG8OBv0KIG7Jf2AUP
   DEdNmLQBM7idPApnNr7Rp+J8VipBEj7u9Do4/2cJgbdfE/DfkxujURjlN
   iRfoVzG0CUvkOn7YhF8gyadf3vkcpr1nSJpI0kNGFI/mDik/KhPzySNoo
   /XVZjq+N0YgNFidC41XtWHphpQzdh+3ZVJ+aogE7V5L9NXNiC+oanRIvx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471299401"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="471299401"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928179846"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928179846"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2023 16:22:04 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr50D-00042J-0v;
        Thu, 12 Oct 2023 23:22:01 +0000
Date:   Fri, 13 Oct 2023 07:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the
 TZ allocator
Message-ID: <202310130731.YHBtmaQU-lkp@intel.com>
References: <20231009153427.20951-12-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-12-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231009]
[cannot apply to arm64/for-next/core krzk-dt/for-next linus/master v6.6-rc5 v6.6-rc4 v6.6-rc3 v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-move-Qualcomm-code-into-its-own-directory/20231009-233826
base:   next-20231009
patch link:    https://lore.kernel.org/r/20231009153427.20951-12-brgl%40bgdev.pl
patch subject: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the TZ allocator
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231013/202310130731.YHBtmaQU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130731.YHBtmaQU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130731.YHBtmaQU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/qcom/qcom_qseecom_uefisecapp.c: In function 'qcom_uefisecapp_probe':
>> drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:767:67: error: 'SZ_256K' undeclared (first use in this function)
     767 |         qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
         |                                                                   ^~~~~~~
   drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:767:67: note: each undeclared identifier is reported only once for each function it appears in


vim +/SZ_256K +767 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c

   745	
   746	static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
   747					 const struct auxiliary_device_id *aux_dev_id)
   748	{
   749		struct qcuefi_client *qcuefi;
   750		int status;
   751	
   752		qcuefi = devm_kzalloc(&aux_dev->dev, sizeof(*qcuefi), GFP_KERNEL);
   753		if (!qcuefi)
   754			return -ENOMEM;
   755	
   756		qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
   757	
   758		auxiliary_set_drvdata(aux_dev, qcuefi);
   759		status = qcuefi_set_reference(qcuefi);
   760		if (status)
   761			return status;
   762	
   763		status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
   764		if (status)
   765			qcuefi_set_reference(NULL);
   766	
 > 767		qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
   768		if (IS_ERR(qcuefi->mempool))
   769			return PTR_ERR(qcuefi->mempool);
   770	
   771		return status;
   772	}
   773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
