Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB707788EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjHKI2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHKI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:28:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6B2728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691742519; x=1723278519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QvrtACmX8/i9rfCNtFxrT7FpsWiOfExBm5Lwix+yG2g=;
  b=aVelmQu77CTQnC/xmejz0gJ7ccwfQpuD2cwllQPvlEmod4XbN1sJAiJ1
   gk0thH3xgJx4LQe9Kbby9u161f9L37qbctZ2sc4bRV6WeMrEadXPE6hPB
   aooPuVZgLnR4dNLznt2wtMS4+iTmllKxGD5kXPXIw7UQhcORx0zkoTkCX
   ttQOx58rgRWkKkNb+0ZbfLjIAECXFsUUlSDJCeV0tP0SOH+5DGyyMzux3
   h1V3BUNUSQjMcOCRekm1okzFR+xZnS/spPWFcObbWZl3ey2NklvjVhPlF
   DT2F3n9gE+g70Z+nyDdL1Kl6qG7w8EWwXa3d817bqExcL0O4IsvKG1nUN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351951433"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351951433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709460092"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="709460092"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2023 01:28:37 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUNVc-0007eK-2d;
        Fri, 11 Aug 2023 08:28:36 +0000
Date:   Fri, 11 Aug 2023 16:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202308111617.zQJeSOZG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   12 months ago
config: loongarch-randconfig-r091-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111617.zQJeSOZG-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111617.zQJeSOZG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308111617.zQJeSOZG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
--
   net/mptcp/options.c: note: in included file:
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
--
   net/mptcp/protocol.c: note: in included file:
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
   net/mptcp/protocol.c:3011:24: sparse: sparse: context imbalance in 'mptcp_sk_clone' - unexpected unlock
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *

vim +56 crypto/crypto_engine.c

735d37b5424b27 Baolin Wang    2016-01-26  18  
218d1cc1860c45 Corentin LABBE 2018-01-26  19  /**
218d1cc1860c45 Corentin LABBE 2018-01-26  20   * crypto_finalize_request - finalize one request if the request is done
218d1cc1860c45 Corentin LABBE 2018-01-26  21   * @engine: the hardware engine
218d1cc1860c45 Corentin LABBE 2018-01-26  22   * @req: the request need to be finalized
218d1cc1860c45 Corentin LABBE 2018-01-26  23   * @err: error number
218d1cc1860c45 Corentin LABBE 2018-01-26  24   */
218d1cc1860c45 Corentin LABBE 2018-01-26  25  static void crypto_finalize_request(struct crypto_engine *engine,
218d1cc1860c45 Corentin LABBE 2018-01-26  26  				    struct crypto_async_request *req, int err)
218d1cc1860c45 Corentin LABBE 2018-01-26  27  {
218d1cc1860c45 Corentin LABBE 2018-01-26  28  	unsigned long flags;
6a89f492f8e509 Iuliana Prodan 2020-04-28  29  	bool finalize_req = false;
218d1cc1860c45 Corentin LABBE 2018-01-26  30  	int ret;
218d1cc1860c45 Corentin LABBE 2018-01-26  31  	struct crypto_engine_ctx *enginectx;
218d1cc1860c45 Corentin LABBE 2018-01-26  32  
6a89f492f8e509 Iuliana Prodan 2020-04-28  33  	/*
6a89f492f8e509 Iuliana Prodan 2020-04-28  34  	 * If hardware cannot enqueue more requests
6a89f492f8e509 Iuliana Prodan 2020-04-28  35  	 * and retry mechanism is not supported
6a89f492f8e509 Iuliana Prodan 2020-04-28  36  	 * make sure we are completing the current request
6a89f492f8e509 Iuliana Prodan 2020-04-28  37  	 */
6a89f492f8e509 Iuliana Prodan 2020-04-28  38  	if (!engine->retry_support) {
218d1cc1860c45 Corentin LABBE 2018-01-26  39  		spin_lock_irqsave(&engine->queue_lock, flags);
6a89f492f8e509 Iuliana Prodan 2020-04-28  40  		if (engine->cur_req == req) {
6a89f492f8e509 Iuliana Prodan 2020-04-28  41  			finalize_req = true;
6a89f492f8e509 Iuliana Prodan 2020-04-28  42  			engine->cur_req = NULL;
6a89f492f8e509 Iuliana Prodan 2020-04-28  43  		}
218d1cc1860c45 Corentin LABBE 2018-01-26  44  		spin_unlock_irqrestore(&engine->queue_lock, flags);
6a89f492f8e509 Iuliana Prodan 2020-04-28  45  	}
218d1cc1860c45 Corentin LABBE 2018-01-26  46  
6a89f492f8e509 Iuliana Prodan 2020-04-28  47  	if (finalize_req || engine->retry_support) {
218d1cc1860c45 Corentin LABBE 2018-01-26  48  		enginectx = crypto_tfm_ctx(req->tfm);
6a89f492f8e509 Iuliana Prodan 2020-04-28  49  		if (enginectx->op.prepare_request &&
218d1cc1860c45 Corentin LABBE 2018-01-26  50  		    enginectx->op.unprepare_request) {
218d1cc1860c45 Corentin LABBE 2018-01-26  51  			ret = enginectx->op.unprepare_request(engine, req);
218d1cc1860c45 Corentin LABBE 2018-01-26  52  			if (ret)
218d1cc1860c45 Corentin LABBE 2018-01-26  53  				dev_err(engine->dev, "failed to unprepare request\n");
218d1cc1860c45 Corentin LABBE 2018-01-26  54  		}
218d1cc1860c45 Corentin LABBE 2018-01-26  55  	}
4058cf08945c18 Corentin Labbe 2022-02-21 @56  	lockdep_assert_in_softirq();
218d1cc1860c45 Corentin LABBE 2018-01-26  57  	req->complete(req, err);
218d1cc1860c45 Corentin LABBE 2018-01-26  58  
218d1cc1860c45 Corentin LABBE 2018-01-26  59  	kthread_queue_work(engine->kworker, &engine->pump_requests);
218d1cc1860c45 Corentin LABBE 2018-01-26  60  }
218d1cc1860c45 Corentin LABBE 2018-01-26  61  

:::::: The code at line 56 was first introduced by commit
:::::: 4058cf08945c18a6de193f4118fd05d83d3d4285 crypto: engine - check if BH is disabled during completion

:::::: TO: Corentin Labbe <clabbe@baylibre.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
