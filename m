Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B447F77A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbjKXPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbjKXPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:23:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D975172A;
        Fri, 24 Nov 2023 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700839439; x=1732375439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rxL2jk4MgQcXj8eN+mwhkKKDZzLlAvvuyE/DYYerPSo=;
  b=Tv58esZanAkrUjApfYMuR4//jJB40lcHJAaB1BxYwycGxFyk0nSU15Gl
   SUz96eJC9TL4ofdyawzRTT0p58Jyk6vVciQ2Z2f05l1RWFXFTk17W/bod
   9qriShqAWI08MVcJ2/O6COivje+GFxRnYB0RAud52hP9cF4Qcrjr6K4Z6
   X+OnVQJr40fJL2hilKX5dU+QDpf460pb77AqfNKeztTJ+wOS5VfwuMOOW
   8CZB8MTTTVV7d3E2kbV6TjRo2c28uQoHkG4Upb2URG3xsfT9Mlb4sHbey
   UjqpYS0pfd9i1FMAyxBl7unzyZuyoJbhQesCS9ctbHWvYflgcCGtu6qqq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5660695"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="5660695"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="16002353"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Nov 2023 07:23:55 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6Y25-0002wq-09;
        Fri, 24 Nov 2023 15:23:53 +0000
Date:   Fri, 24 Nov 2023 23:23:31 +0800
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
Subject: Re: [RESEND PATCH v5 02/12] firmware: qcom: scm: enable the TZ mem
 allocator
Message-ID: <202311241607.v3tvaLvH-lkp@intel.com>
References: <20231120132118.30473-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120132118.30473-3-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-add-a-dedicated-TrustZone-buffer-allocator/20231120-213154
base:   linus/master
patch link:    https://lore.kernel.org/r/20231120132118.30473-3-brgl%40bgdev.pl
patch subject: [RESEND PATCH v5 02/12] firmware: qcom: scm: enable the TZ mem allocator
config: arm-randconfig-r071-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241607.v3tvaLvH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241607.v3tvaLvH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241607.v3tvaLvH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/qcom/qcom_tzmem.c: In function 'qcom_tzmem_pool_new':
>> drivers/firmware/qcom/qcom_tzmem.c:87:64: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
      87 |         pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
         |                                                                ^~~~~~~~~~~~
         |                                                                |
         |                                                                phys_addr_t * {aka unsigned int *}
   In file included from drivers/firmware/qcom/qcom_tzmem.c:10:
   include/linux/dma-mapping.h:429:29: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}
     429 |                 dma_addr_t *dma_handle, gfp_t gfp)
         |                 ~~~~~~~~~~~~^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dma_alloc_coherent +87 drivers/firmware/qcom/qcom_tzmem.c

757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   59  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   60  /**
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   61   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   62   * @size: Size of the new pool in bytes.
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   63   *
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   64   * Create a new pool of memory suitable for sharing with the TrustZone.
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   65   *
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   66   * Must not be used in atomic context.
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   67   *
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   68   * Returns:
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   69   * New memory pool address or ERR_PTR() on error.
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   70   */
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   71  struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   72  {
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   73  	struct qcom_tzmem_pool *pool;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   74  	int ret = -ENOMEM;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   75  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   76  	if (!size)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   77  		return ERR_PTR(-EINVAL);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   78  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   79  	size = PAGE_ALIGN(size);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   80  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   81  	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   82  	if (!pool)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   83  		return ERR_PTR(-ENOMEM);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   84  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   85  	pool->size = size;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   86  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  @87  	pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   88  					 GFP_KERNEL);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   89  	if (!pool->vbase)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   90  		goto err_kfree_pool;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   91  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   92  	pool->pool = gen_pool_create(PAGE_SHIFT, -1);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   93  	if (!pool)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   94  		goto err_dma_free;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   95  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   96  	gen_pool_set_algo(pool->pool, gen_pool_best_fit, NULL);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   97  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   98  	ret = gen_pool_add_virt(pool->pool, (unsigned long)pool->vbase,
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20   99  				pool->pbase, size, -1);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  100  	if (ret)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  101  		goto err_destroy_genpool;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  102  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  103  	ret = qcom_tzmem_init_pool(pool);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  104  	if (ret)
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  105  		goto err_destroy_genpool;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  106  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  107  	return pool;
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  108  
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  109  err_destroy_genpool:
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  110  	gen_pool_destroy(pool->pool);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  111  err_dma_free:
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  112  	dma_free_coherent(qcom_tzmem_dev, size, pool->vbase, pool->pbase);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  113  err_kfree_pool:
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  114  	kfree(pool);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  115  	return ERR_PTR(ret);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  116  }
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  117  EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
757fc9ecf8f244 Bartosz Golaszewski 2023-11-20  118  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
