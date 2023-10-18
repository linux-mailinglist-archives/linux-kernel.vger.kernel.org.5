Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE27CDD03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJRNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjJRNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:16:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E819F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697635013; x=1729171013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fm1VA7CJ7HFAsg0XviE9M0yMqnfrADsNC5tJ9obPJTU=;
  b=Ac1qLA1/q0tDHvNv09nYaL8njoo3aOAqYLPEvsN+D+kagbEKbEQD19Uc
   q4kkMCryF8AMbRMhdR/EA0nCyEHzV0G7pdEClW1lmqvTodvR+C9Q4uqIY
   kYX0QvXHcYB2n7PPhcqka9Ru7yj2syxjVWr5amZ1vP519OKdkJlWka09t
   JBuDUbSLns8N/S2duhVusC9X5PGwEvtimnzFezqLVa1y2dJvpBJbsHVD4
   3a5MKvDnsaa1MRUk/jrqj3Emga+QuPd5o1Vk0eyoScnfKE1yyqjY2RvuM
   miqJdqRFqCTOeJ2qpBfNAY7IkHpWaHZTDhlVfjpLNKoxV2Y2cM/2tp426
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371072707"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="371072707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="873022141"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="873022141"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2023 06:16:50 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt6Po-0000Oj-1s;
        Wed, 18 Oct 2023 13:16:48 +0000
Date:   Wed, 18 Oct 2023 21:16:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aya Levin <ayal@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:573:46:
 warning: '%s' directive output may be truncated writing up to 255 bytes into
 a region of size between 220 and 230
Message-ID: <202310182137.AlBjalaw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 521f31af004ade74963d551a719a36ca7df0ba70 net/mlx5e: Allow RQ outside of channel context
date:   2 years, 10 months ago
config: x86_64-randconfig-001-20230913 (https://download.01.org/0day-ci/archive/20231018/202310182137.AlBjalaw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182137.AlBjalaw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182137.AlBjalaw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c: In function 'mlx5e_reporter_rx_timeout':
>> drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:573:46: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 220 and 230 [-Wformat-truncation=]
     573 |                  "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
         |                                              ^~
     574 |                  rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
         |                          ~~~~~~~~~            
   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:572:9: note: 'snprintf' output between 43 and 322 bytes into a destination of size 256
     572 |         snprintf(err_str, sizeof(err_str),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     573 |                  "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     574 |                  rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +573 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c

   557	
   558	void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
   559	{
   560		char icosq_str[MLX5E_REPORTER_PER_Q_MAX_LEN] = {};
   561		char err_str[MLX5E_REPORTER_PER_Q_MAX_LEN];
   562		struct mlx5e_icosq *icosq = rq->icosq;
   563		struct mlx5e_priv *priv = rq->priv;
   564		struct mlx5e_err_ctx err_ctx = {};
   565	
   566		err_ctx.ctx = rq;
   567		err_ctx.recover = mlx5e_rx_reporter_timeout_recover;
   568		err_ctx.dump = mlx5e_rx_reporter_dump_rq;
   569	
   570		if (icosq)
   571			snprintf(icosq_str, sizeof(icosq_str), "ICOSQ: 0x%x, ", icosq->sqn);
   572		snprintf(err_str, sizeof(err_str),
 > 573			 "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
   574			 rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
   575	
   576		mlx5e_health_report(priv, priv->rx_reporter, err_str, &err_ctx);
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
