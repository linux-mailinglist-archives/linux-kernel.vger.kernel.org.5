Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD57CD59E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjJRHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJRHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:46:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D9B6;
        Wed, 18 Oct 2023 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615165; x=1729151165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q758F4Gi/UU/qeaxET/FotQtuXbxWVHRjy+3ChV2Clk=;
  b=Jx5x7TDPzkUcsQrayarnawgzI7gMMEMJ3So9BGiO3gGrWVeGPFJLR48a
   llw21OXujRte1FiBDMKnfJFnKZjDkmjDgDSk4qDOHk6btt9eFG4usxk3X
   VmW/Ifp+z7bXegtqTLtHnAIyLqbFq2/ErwaHBlHdI9iGMPpR9dicYgFd3
   IsPHk7zkBgrHP//prLBF0AeEdx6gMejStxWeKuWEYMeKqRk8wxC+Fq7uz
   M2C6q1qgu1ASkRgvxmm0GNmlULcwxLQlY6iBdle/3J24loU19S+ViRR9Y
   3rHZE4MPtMRUdkN2nWJVLZcoCCOVxumLeGZjfcz7SjjfTtEfhFkitGqDs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388823706"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388823706"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785794057"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="785794057"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2023 00:45:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt1F2-00004q-1t;
        Wed, 18 Oct 2023 07:45:20 +0000
Date:   Wed, 18 Oct 2023 15:45:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     liuchang_125125@163.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, mark.tao@bayhubtech.com,
        shaper.liu@bayhubtech.com, thomas.hu@bayhubtech.com,
        chevron.li@bayhubtech.com, charl.liu@bayhubtech.com,
        Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH 7/9] scsi: bht: main: Add the source files related to
 driver setting management
Message-ID: <202310181522.ndHXtUlU-lkp@intel.com>
References: <20231013083429.10347-1-liuchang_125125@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013083429.10347-1-liuchang_125125@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 401644852d0b2a278811de38081be23f74b5bb04]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/scsi-Update-Kconfig-and-Makefile-for-supporting-Bayhub-s-SD-MMC-Card-interface-driver/20231017-123349
base:   401644852d0b2a278811de38081be23f74b5bb04
patch link:    https://lore.kernel.org/r/20231013083429.10347-1-liuchang_125125%40163.com
patch subject: [PATCH 7/9] scsi: bht: main: Add the source files related to driver setting management
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181522.ndHXtUlU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181522.ndHXtUlU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181522.ndHXtUlU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/main/autotimerfunc.c:57:6: warning: no previous prototype for 'func_timer_callback' [-Wmissing-prototypes]
      57 | void func_timer_callback(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/main/autotimerfunc.c:158:6: warning: no previous prototype for 'func_autotimer_init' [-Wmissing-prototypes]
     158 | void func_autotimer_init(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/main/autotimerfunc.c:209:6: warning: no previous prototype for 'func_timer_thread' [-Wmissing-prototypes]
     209 | void func_timer_thread(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/main/autotimerfunc.c:303:6: warning: no previous prototype for 'func_autotimer_stop' [-Wmissing-prototypes]
     303 | void func_autotimer_stop(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/main/autotimerfunc.c:315:6: warning: no previous prototype for 'func_autotimer_start' [-Wmissing-prototypes]
     315 | void func_autotimer_start(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bht/main/autotimerfunc.c:326:6: warning: no previous prototype for 'func_autotimer_cancel' [-Wmissing-prototypes]
     326 | void func_autotimer_cancel(bht_dev_ext_t *pdx)
         |      ^~~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: /drivers/scsi: No such file or directory [-Wmissing-include-dirs]
>> drivers/scsi/bht/main/pmfunc.c:29:6: warning: no previous prototype for 'pm_init' [-Wmissing-prototypes]
      29 | void pm_init(bht_dev_ext_t *pdx)
         |      ^~~~~~~


vim +/func_timer_callback +57 drivers/scsi/bht/main/autotimerfunc.c

    43	
    44	/*
    45	 * Function Name: func_timer_callback
    46	 * Abstract: This Function is used to calculate timer tick
    47	 *
    48	 * Input:
    49	 *	bht_dev_ext_t *pdx
    50	 *
    51	 *
    52	 * Notes:
    53	 *
    54	 *        so giving the routine another name requires you to modify the build tools.
    55	 */
    56	
  > 57	void func_timer_callback(bht_dev_ext_t *pdx)
    58	{
    59		u32 cur_time, interval;
    60		bool event = FALSE;
    61	
    62		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Enter %s\n",
    63			__func__);
    64		if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel)
    65			goto exit;
    66	
    67		if (pdx->auto_timer.stop) {
    68			autotimer_clear(pdx);
    69			goto exit;
    70		}
    71	
    72		/* If card not workable don't use timer */
    73		if (pdx->card.card_present == FALSE)
    74			goto exit;
    75		if (pdx->card.card_type == CARD_NONE
    76		    || pdx->card.card_type == CARD_ERROR)
    77			goto exit;
    78		if (pdx->card.state == CARD_STATE_POWEROFF)
    79			goto exit;
    80		/* If rtd3 entered not do below steps */
    81		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0,
    82			"auto timer really work\n");
    83	
    84		/* calculate the real interval */
    85		cur_time = os_get_cur_tick();
    86		if (pdx->auto_timer.last_tick == 0) {
    87			pdx->auto_timer.last_tick = cur_time;
    88			interval = AUTO_TIMER_TICK;
    89		} else {
    90			interval = cur_time - pdx->auto_timer.last_tick;
    91			pdx->auto_timer.last_tick = cur_time;
    92		}
    93	
    94		/* update and check timeout for each tick */
    95		if (pdx->auto_timer.auto_cmd12_enable && pdx->card.has_built_inf) {
    96			pdx->auto_timer.auto_cmd12_tick += interval;
    97			if (pdx->auto_timer.auto_cmd12_tick >=
    98			    pdx->auto_timer.auto_cmd12_time)
    99				event = TRUE;
   100		}
   101	
   102		if (pdx->auto_timer.auto_dmt_enable && pdx->card.card_type == CARD_UHS2
   103		    && pdx->card.state == CARD_STATE_WORKING) {
   104			pdx->auto_timer.auto_dmt_tick += interval;
   105			if (pdx->auto_timer.auto_dmt_tick >=
   106			    pdx->auto_timer.auto_dmt_time)
   107				event = TRUE;
   108		}
   109	
   110		if (pdx->auto_timer.auto_led_off_enable && (pdx->host.led_on)) {
   111			pdx->auto_timer.auto_led_off_tick += interval;
   112			if (pdx->auto_timer.auto_led_off_tick >=
   113			    pdx->auto_timer.auto_led_off_time)
   114				event = TRUE;
   115		}
   116	
   117		if (pdx->auto_timer.auto_poweroff_enable) {
   118			pdx->auto_timer.auto_poweroff_tick += interval;
   119			if (pdx->auto_timer.auto_poweroff_tick >=
   120			    pdx->auto_timer.auto_poweroff_time)
   121				event = TRUE;
   122		}
   123	
   124		if (pdx->auto_timer.cancel || pdx->auto_timer.stop)
   125			goto exit;
   126	
   127		if (event) {
   128			DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0,
   129				"auto timer set event\n");
   130	
   131	#if CFG_OS_LINUX
   132			os_set_event(&pdx->os, EVENT_AUTO_TIMER);
   133	#else
   134			os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR, EVENT_AUTO_TIMER);
   135	#endif
   136	
   137		}
   138		os_start_timer(pdx, &pdx->os, TIMER_AUTO, AUTO_TIMER_TICK);
   139	
   140	exit:
   141		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Exit %s\n",
   142			__func__);
   143	}
   144	
   145	/*
   146	 * Function Name: func_autotimer_init
   147	 * Abstract: This Function is used to init timer function variables
   148	 *
   149	 * Input:
   150	 *	bht_dev_ext_t *pdx
   151	 *
   152	 *
   153	 * Notes:
   154	 *
   155	 *        so giving the routine another name requires you to modify the build tools.
   156	 */
   157	
 > 158	void func_autotimer_init(bht_dev_ext_t *pdx)
   159	{
   160		cfg_item_t *cfg = pdx->cfg;
   161	
   162		os_memset(&pdx->auto_timer, 0, sizeof(pdx->auto_timer));
   163	
   164		pdx->auto_timer.auto_dmt_time =
   165		    cfg->timer_item.auto_dormant_timer.time_ms;
   166		pdx->auto_timer.auto_dmt_enable =
   167		    (bool)cfg->timer_item.auto_dormant_timer.enable_dmt_func;
   168		pdx->auto_timer.enable_hibernate =
   169		    (bool)cfg->timer_item.auto_dormant_timer.enable_hbr;
   170	
   171		pdx->auto_timer.auto_poweroff_enable = FALSE;
   172		pdx->auto_timer.auto_poweroff_time = 10 * 1000;
   173	
   174		pdx->auto_timer.auto_led_off_enable = pdx->host.feature.hw_led_fix;
   175		/* led off set to 1s */
   176		pdx->auto_timer.auto_led_off_time = 1000;
   177	
   178		pdx->auto_timer.enable = pdx->auto_timer.auto_cmd12_enable |
   179		    pdx->auto_timer.auto_poweroff_enable |
   180		    pdx->auto_timer.auto_dmt_enable |
   181		    pdx->auto_timer.auto_led_off_enable;
   182	
   183		DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
   184			"Autopower off enable=%d time=%dms\n",
   185			pdx->auto_timer.auto_poweroff_enable,
   186			pdx->auto_timer.auto_poweroff_time);
   187		DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
   188			"Autodmt=%d time=%dms bhrb=%d\n",
   189			pdx->auto_timer.auto_dmt_enable, pdx->auto_timer.auto_dmt_time,
   190			pdx->auto_timer.enable_hibernate);
   191		DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
   192			"AutoStopInf enable=%d time=%dms\n",
   193			pdx->auto_timer.auto_cmd12_enable,
   194			pdx->auto_timer.auto_cmd12_time);
   195	}
   196	
   197	/*
   198	 * Function Name: func_timer_thread
   199	 * Abstract: This Function is used to calculate timer tick
   200	 *
   201	 * Input:
   202	 *	bht_dev_ext_t *pdx
   203	 *
   204	 *
   205	 * Notes:
   206	 *
   207	 *        This function is called by thread to do real job
   208	 */
 > 209	void func_timer_thread(bht_dev_ext_t *pdx)
   210	{
   211		int busy = 0;
   212	
   213		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Enter %s\n",
   214			__func__);
   215	
   216		if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel
   217		    || pdx->auto_timer.stop)
   218			goto clear;
   219	
   220		/* If card not workable don't use timer */
   221		if (pdx->card.card_present == FALSE)
   222			goto clear;
   223		if (pdx->card.card_type == CARD_NONE
   224		    || pdx->card.card_type == CARD_ERROR)
   225			goto clear;
   226		if (pdx->card.state == CARD_STATE_POWEROFF)
   227			goto clear;
   228	
   229		/* If rtd3 entered not call below function */
   230	
   231		if (pdx->auto_timer.auto_poweroff_enable) {
   232			if (pdx->auto_timer.auto_poweroff_tick >=
   233			    pdx->auto_timer.auto_poweroff_time) {
   234				DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
   235					"auto poweroff\n");
   236				if (busy == 0) {
   237					os_set_dev_busy(pdx);
   238					busy = 1;
   239				}
   240				card_power_off(&pdx->card, FALSE);
   241				autotimer_clear(pdx);
   242				goto next;
   243			}
   244		}
   245	
   246		if (pdx->auto_timer.auto_cmd12_enable && pdx->card.has_built_inf) {
   247			if (pdx->auto_timer.auto_cmd12_tick >=
   248			    pdx->auto_timer.auto_cmd12_time) {
   249				if (busy == 0) {
   250					os_set_dev_busy(pdx);
   251					busy = 1;
   252				}
   253				pdx->auto_timer.auto_cmd12_tick = 0;
   254				DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
   255					"auto stop infinite\n");
   256				card_stop_infinite(&pdx->card, TRUE, NULL);
   257			}
   258		}
   259	
   260		if (pdx->auto_timer.auto_dmt_enable && pdx->card.card_type == CARD_UHS2
   261		    && pdx->card.state == CARD_STATE_WORKING) {
   262			if (pdx->auto_timer.auto_dmt_tick >=
   263			    pdx->auto_timer.auto_dmt_time) {
   264				if (busy == 0) {
   265					os_set_dev_busy(pdx);
   266					busy = 1;
   267				}
   268				pdx->auto_timer.auto_dmt_tick = 0;
   269				DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
   270					"auto enter sleep\n");
   271				card_enter_sleep(&pdx->card, TRUE,
   272						 pdx->auto_timer.enable_hibernate);
   273			}
   274		}
   275	
   276		if (pdx->auto_timer.auto_led_off_enable && (pdx->host.led_on)) {
   277			if (pdx->auto_timer.auto_led_off_tick >=
   278			    pdx->auto_timer.auto_led_off_time) {
   279				if (busy == 0) {
   280					os_set_dev_busy(pdx);
   281					busy = 1;
   282				}
   283				DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
   284					"auto led off\n");
   285				pdx->auto_timer.auto_led_off_tick = 0;
   286				host_led_ctl(&pdx->host, FALSE);
   287			}
   288		}
   289	
   290	next:
   291		if (busy)
   292			os_set_dev_idle(pdx);
   293		goto exit;
   294	
   295	clear:
   296		autotimer_clear(pdx);
   297	
   298	exit:
   299		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Exit %s\n",
   300			__func__);
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
