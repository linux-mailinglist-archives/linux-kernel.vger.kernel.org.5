Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DD7B31C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjI2LyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2LyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:54:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EEA193;
        Fri, 29 Sep 2023 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988449; x=1727524449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISv2rSDawxjEuQmt6UgE2EEBy6745yQLVfXV6XeXgxA=;
  b=Ip9WwZFaxVNPbNU6nlorzh4oaJhNoLDvJxyAF9bzEZbZZQZRw93IVEVa
   6GZtMVGz9M/c3522VmX7ouwN2K7MSUM7baW+mGK1DgxsK0YlJuQgGbF2w
   sJ7SB55IjWigz9Ilae/Z3krqpf7P/pL78mv9QeLo/sYXW8t4lw58nBrAU
   7jyCmdvOyEjU5wGfFa1uXNFb7OnViswE9320OrERDVfEPS1Zu1u+KHdCl
   eeWO1Np+quRzAZOJ/BQN5pN1WJvM9cOCpiNj3bWKC2/bcZYXAkA4wfofn
   3qbOTQKDCqbFGk13TyAEsvA9m5h9ZfrWa0Arop3SM7nbT2+7T2xQ9nw/+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367338815"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="367338815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749936816"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="749936816"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Sep 2023 04:54:04 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmC4H-0002oj-2X;
        Fri, 29 Sep 2023 11:54:01 +0000
Date:   Fri, 29 Sep 2023 19:53:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sarthak Garg <quic_sartgarg@quicinc.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_narepall@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
Subject: Re: [PATCH V2 1/2] mmc: core: Add partial initialization support
Message-ID: <202309291907.0fApmbb7-lkp@intel.com>
References: <20230929102831.9702-2-quic_sartgarg@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102831.9702-2-quic_sartgarg@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarthak,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sarthak-Garg/mmc-core-Add-partial-initialization-support/20230929-183238
base:   linus/master
patch link:    https://lore.kernel.org/r/20230929102831.9702-2-quic_sartgarg%40quicinc.com
patch subject: [PATCH V2 1/2] mmc: core: Add partial initialization support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309291907.0fApmbb7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291907.0fApmbb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291907.0fApmbb7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/mmc.c:1975: warning: Function parameter or member 'host' not described in 'mmc_sleepawake'


vim +1975 drivers/mmc/core/mmc.c

8786b9922e6b87 Sarthak Garg    2023-09-29  1962  
8786b9922e6b87 Sarthak Garg    2023-09-29  1963  /**
8786b9922e6b87 Sarthak Garg    2023-09-29  1964   * mmc_sleepawake - function to sleep or awake the device
8786b9922e6b87 Sarthak Garg    2023-09-29  1965   * @sleep: if true then sleep command is sent else awake
8786b9922e6b87 Sarthak Garg    2023-09-29  1966   *
8786b9922e6b87 Sarthak Garg    2023-09-29  1967   * This function first deselects the card and then sends the sleep command
8786b9922e6b87 Sarthak Garg    2023-09-29  1968   * in case of sleep whereas in case of awake first awake command is send
8786b9922e6b87 Sarthak Garg    2023-09-29  1969   * and then the card is selected.
8786b9922e6b87 Sarthak Garg    2023-09-29  1970   *
8786b9922e6b87 Sarthak Garg    2023-09-29  1971   * Returns 0 on success, non-zero value on failure
8786b9922e6b87 Sarthak Garg    2023-09-29  1972   */
8786b9922e6b87 Sarthak Garg    2023-09-29  1973  
8786b9922e6b87 Sarthak Garg    2023-09-29  1974  static int mmc_sleepawake(struct mmc_host *host, bool sleep)
07a682160866e3 Ulf Hansson     2013-04-19 @1975  {
c7836d1593b87c Masahiro Yamada 2016-12-19  1976  	struct mmc_command cmd = {};
07a682160866e3 Ulf Hansson     2013-04-19  1977  	struct mmc_card *card = host->card;
cb962e04b04fb6 Ulf Hansson     2014-01-14  1978  	unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
e62f1e0b2384e2 Ulf Hansson     2021-05-04  1979  	bool use_r1b_resp;
07a682160866e3 Ulf Hansson     2013-04-19  1980  	int err;
07a682160866e3 Ulf Hansson     2013-04-19  1981  
436f8daa6f5a29 Adrian Hunter   2015-05-07  1982  	/* Re-tuning can't be done once the card is deselected */
436f8daa6f5a29 Adrian Hunter   2015-05-07  1983  	mmc_retune_hold(host);
436f8daa6f5a29 Adrian Hunter   2015-05-07  1984  
8786b9922e6b87 Sarthak Garg    2023-09-29  1985  	if (sleep) {
07a682160866e3 Ulf Hansson     2013-04-19  1986  		err = mmc_deselect_cards(host);
07a682160866e3 Ulf Hansson     2013-04-19  1987  		if (err)
436f8daa6f5a29 Adrian Hunter   2015-05-07  1988  			goto out_release;
8786b9922e6b87 Sarthak Garg    2023-09-29  1989  	}
07a682160866e3 Ulf Hansson     2013-04-19  1990  
07a682160866e3 Ulf Hansson     2013-04-19  1991  	cmd.opcode = MMC_SLEEP_AWAKE;
07a682160866e3 Ulf Hansson     2013-04-19  1992  	cmd.arg = card->rca << 16;
e62f1e0b2384e2 Ulf Hansson     2021-05-04  1993  	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
8786b9922e6b87 Sarthak Garg    2023-09-29  1994  	if (sleep)
8786b9922e6b87 Sarthak Garg    2023-09-29  1995  		cmd.arg |= BIT(15);
cb962e04b04fb6 Ulf Hansson     2014-01-14  1996  
07a682160866e3 Ulf Hansson     2013-04-19  1997  	err = mmc_wait_for_cmd(host, &cmd, 0);
07a682160866e3 Ulf Hansson     2013-04-19  1998  	if (err)
436f8daa6f5a29 Adrian Hunter   2015-05-07  1999  		goto out_release;
07a682160866e3 Ulf Hansson     2013-04-19  2000  
07a682160866e3 Ulf Hansson     2013-04-19  2001  	/*
6fa79651cc808f Ulf Hansson     2021-05-04  2002  	 * If the host does not wait while the card signals busy, then we can
6fa79651cc808f Ulf Hansson     2021-05-04  2003  	 * try to poll, but only if the host supports HW polling, as the
6fa79651cc808f Ulf Hansson     2021-05-04  2004  	 * SEND_STATUS cmd is not allowed. If we can't poll, then we simply need
6fa79651cc808f Ulf Hansson     2021-05-04  2005  	 * to wait the sleep/awake timeout.
07a682160866e3 Ulf Hansson     2013-04-19  2006  	 */
6fa79651cc808f Ulf Hansson     2021-05-04  2007  	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY && use_r1b_resp)
6fa79651cc808f Ulf Hansson     2021-05-04  2008  		goto out_release;
6fa79651cc808f Ulf Hansson     2021-05-04  2009  
6fa79651cc808f Ulf Hansson     2021-05-04  2010  	if (!host->ops->card_busy) {
cb962e04b04fb6 Ulf Hansson     2014-01-14  2011  		mmc_delay(timeout_ms);
6fa79651cc808f Ulf Hansson     2021-05-04  2012  		goto out_release;
6fa79651cc808f Ulf Hansson     2021-05-04  2013  	}
6fa79651cc808f Ulf Hansson     2021-05-04  2014  
1760fdb6fe9f79 Ulf Hansson     2022-03-04  2015  	err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
07a682160866e3 Ulf Hansson     2013-04-19  2016  
436f8daa6f5a29 Adrian Hunter   2015-05-07  2017  out_release:
8786b9922e6b87 Sarthak Garg    2023-09-29  2018  	if (!sleep)
8786b9922e6b87 Sarthak Garg    2023-09-29  2019  		err = mmc_select_card(card);
8786b9922e6b87 Sarthak Garg    2023-09-29  2020  
436f8daa6f5a29 Adrian Hunter   2015-05-07  2021  	mmc_retune_release(host);
07a682160866e3 Ulf Hansson     2013-04-19  2022  	return err;
07a682160866e3 Ulf Hansson     2013-04-19  2023  }
07a682160866e3 Ulf Hansson     2013-04-19  2024  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
