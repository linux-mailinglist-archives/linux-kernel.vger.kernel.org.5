Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DAD7BF6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjJJJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:11:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E509E;
        Tue, 10 Oct 2023 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696929088; x=1728465088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KboUvh1F7MxQgYzc8J1O7LouQyFbLpf8jGfEUnsK3H8=;
  b=ZwB8OT0w9SeFkwf069/j3wQIFixCbA1RfRtIWH9aGRm7La8O+OpucKHI
   Hsqn4yM+VMSltEu4Cfj4eTMDGBEbeIyMFKCQPbQbmX3v8x8N70HkaGMTF
   ZmzjLEPxcoSCoGm6v5vi0mmo3GbHvqWZQTJYf0lvA0se9MUEEuH+fxlOM
   WcLASCMNd1rw89jTG7A2LiXBj1QvVQ7RoU46N5/OeClTrdZpGeBLUMLyW
   9Enelm+8y4OZgk76XQDP1w7cOC3wY4bxs+rCIzeH8i4N7vfzEIxzVVLzL
   HxogZHfiO5E9JgzOodUp7zFNq/BFENA8DIkh7LFmf/othdz57TdS3KF9v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363695404"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="363695404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="819164498"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="819164498"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Oct 2023 02:11:24 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq8ln-0000E0-0m;
        Tue, 10 Oct 2023 09:11:15 +0000
Date:   Tue, 10 Oct 2023 17:11:06 +0800
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
Subject: Re: [PATCH v3 05/15] firmware: qcom: scm: enable the TZ mem allocator
Message-ID: <202310101720.hVVWyJf3-lkp@intel.com>
References: <20231009153427.20951-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231009]
[cannot apply to arm64/for-next/core krzk-dt/for-next linus/master v6.6-rc5 v6.6-rc4 v6.6-rc3 v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-move-Qualcomm-code-into-its-own-directory/20231009-233826
base:   next-20231009
patch link:    https://lore.kernel.org/r/20231009153427.20951-6-brgl%40bgdev.pl
patch subject: [PATCH v3 05/15] firmware: qcom: scm: enable the TZ mem allocator
config: arc-randconfig-001-20231010 (https://download.01.org/0day-ci/archive/20231010/202310101720.hVVWyJf3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101720.hVVWyJf3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101720.hVVWyJf3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/qcom/qcom_tzmem.c:72: warning: Function parameter or member 'size' not described in 'qcom_tzmem_pool_new'


vim +72 drivers/firmware/qcom/qcom_tzmem.c

2e798cd92c1686 Bartosz Golaszewski 2023-10-09   59  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   60  /**
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   61   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   62   * @size - Size of the new pool in bytes.
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   63   *
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   64   * Create a new pool of memory suitable for sharing with the TrustZone.
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   65   *
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   66   * Must not be used in atomic context.
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   67   *
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   68   * Returns:
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   69   * New memory pool address or ERR_PTR() on error.
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   70   */
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   71  struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  @72  {
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   73  	struct qcom_tzmem_pool *pool;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   74  	int ret = -ENOMEM;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   75  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   76  	if (!size)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   77  		return ERR_PTR(-EINVAL);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   78  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   79  	size = PAGE_ALIGN(size);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   80  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   81  	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   82  	if (!pool)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   83  		return ERR_PTR(-ENOMEM);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   84  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   85  	pool->size = size;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   86  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   87  	pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   88  					 GFP_KERNEL);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   89  	if (!pool->vbase)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   90  		goto err_kfree_pool;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   91  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   92  	pool->pool = gen_pool_create(PAGE_SHIFT, -1);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   93  	if (!pool)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   94  		goto err_dma_free;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   95  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   96  	gen_pool_set_algo(pool->pool, gen_pool_best_fit, NULL);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   97  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   98  	ret = gen_pool_add_virt(pool->pool, (unsigned long)pool->vbase,
2e798cd92c1686 Bartosz Golaszewski 2023-10-09   99  				pool->pbase, size, -1);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  100  	if (ret)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  101  		goto err_destroy_genpool;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  102  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  103  	ret = qcom_tzmem_init_pool(pool);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  104  	if (ret)
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  105  		goto err_destroy_genpool;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  106  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  107  	return pool;
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  108  
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  109  err_destroy_genpool:
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  110  	gen_pool_destroy(pool->pool);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  111  err_dma_free:
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  112  	dma_free_coherent(qcom_tzmem_dev, size, pool->vbase, pool->pbase);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  113  err_kfree_pool:
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  114  	kfree(pool);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  115  	return ERR_PTR(ret);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  116  }
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  117  EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
2e798cd92c1686 Bartosz Golaszewski 2023-10-09  118  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
