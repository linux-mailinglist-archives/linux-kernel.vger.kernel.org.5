Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E0761054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGYKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:12:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E206E10C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690279963; x=1721815963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ac2oTc77a/6ATzI5ndGgl+nQJWoBoiKoSIVhzNQso5w=;
  b=YkOL+fbqHFu2aV6P7/bg4Ve37rggzvoINuJNhECbJqXqUu0d07oRuCx6
   a6NoMQR3A6cvm4F94LQjgayiJWghsK6hFEG2GDbgFaEPobJ2FgTtg3p+b
   h9ODzqktXCY5JXvOTLsBIHV+gw2nIP25ERh/Iyms9ZGfdBDXlng7+XuYn
   5PtA9jI1y7yg7HN/+yu0x+pRg1GYEiA1JrBxBGPfBaQA58A74PUcljtLl
   9bdakg+pj3zEjCckLHBHMPvCRJM9o2Vh8Q5KFpaP66BoT+AUTb8m3XsQ9
   IHdUiYvbs5a0dsiHzOVFsyTv+CXm/+AtA09vSLVoXysXTcMTB2dxm5PW6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366561462"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366561462"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972611804"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972611804"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2023 03:12:30 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOF1p-000AWy-2j;
        Tue, 25 Jul 2023 10:12:29 +0000
Date:   Tue, 25 Jul 2023 18:11:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/spi/spi-mpc52xx-psc.c:195:5: sparse: sparse: symbol
 'mpc52xx_psc_spi_transfer_one_message' was not declared. Should it be
 static?
Message-ID: <202307251816.gcbUAjbM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b spi: mpc52xx-psc: Switch to using core message queue
date:   1 year, 1 month ago
config: powerpc-randconfig-r081-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251816.gcbUAjbM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251816.gcbUAjbM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251816.gcbUAjbM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-mpc52xx-psc.c:195:5: sparse: sparse: symbol 'mpc52xx_psc_spi_transfer_one_message' was not declared. Should it be static?
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int const [usertype] *regaddr_p @@     got restricted __be32 const [usertype] * @@
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse:     expected unsigned int const [usertype] *regaddr_p
   drivers/spi/spi-mpc52xx-psc.c:398:19: sparse:     got restricted __be32 const [usertype] *
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *addr @@     got unsigned int const [usertype] *regaddr_p @@
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse:     expected restricted __be32 const [usertype] *addr
   drivers/spi/spi-mpc52xx-psc.c:403:59: sparse:     got unsigned int const [usertype] *regaddr_p

vim +/mpc52xx_psc_spi_transfer_one_message +195 drivers/spi/spi-mpc52xx-psc.c

   177	
   178	int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   179						 struct spi_message *m)
   180	{
   181		struct spi_device *spi;
   182		struct spi_transfer *t = NULL;
   183		unsigned cs_change;
   184		int status;
   185	
   186		spi = m->spi;
   187		cs_change = 1;
   188		status = 0;
   189		list_for_each_entry (t, &m->transfers, transfer_list) {
   190			if (t->bits_per_word || t->speed_hz) {
   191				status = mpc52xx_psc_spi_transfer_setup(spi, t);
   192				if (status < 0)
   193					break;
   194			}
 > 195	
   196			if (cs_change)
   197				mpc52xx_psc_spi_activate_cs(spi);
   198			cs_change = t->cs_change;
   199	
   200			status = mpc52xx_psc_spi_transfer_rxtx(spi, t);
   201			if (status)
   202				break;
   203			m->actual_length += t->len;
   204	
   205			spi_transfer_delay_exec(t);
   206		}
   207	
   208		m->status = status;
   209	
   210		mpc52xx_psc_spi_transfer_setup(spi, NULL);
   211	
   212		spi_finalize_current_message(ctlr);
   213	
   214		return 0;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
