Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB77D20A2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 03:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJVB0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 21:26:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05FE4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697937998; x=1729473998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LBX6ZtGVn8F0eER1BTMElbYs8butshP26d1YMoFYSh8=;
  b=RkBITnhuEnGg4iTSPetrgSuwgNsAH95AMVjdV7kUbyTMAMCtUJozymAz
   8VdNAp/eROH9KqFrSdtMXsBMSMHlZJ+eRVtrH7GHQSzyGXGzMqbCrNDv8
   ZfJ/m17sdbmyzd+r9b1IzsvRvLBhX9Sc9c1IxV6dXOxOVCXZONDHZxc8j
   AaEPam83D4azFBtZCqRzW94dkevsmlFCItlsP1OD00GONwzFLil6barQk
   R9CUcXvgr3V8Pts6bBWSXbqIpKburbGnY40xkla4x5zP05EaMxZgX67bE
   DVkd8NxBpWaC54X+EDaOychXAtgeu8mycV99VEl6fMqsXeEvQltoHiQ4R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="386491837"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="386491837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 18:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="787139778"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="787139778"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2023 18:26:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quNEf-0005SR-0U;
        Sun, 22 Oct 2023 01:26:33 +0000
Date:   Sun, 22 Oct 2023 09:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: Re: [PATCH] staging: rtl8192e: renamed variable
 HTIOTActIsDisableMCSTwoSpatialStream
Message-ID: <202310220944.r88EaZm2-lkp@intel.com>
References: <20231022002646.11861-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022002646.11861-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Gary-Rookard/staging-rtl8192e-renamed-variable-HTIOTActIsDisableMCSTwoSpatialStream/20231022-082912
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20231022002646.11861-1-garyrookard%40fastmail.org
patch subject: [PATCH] staging: rtl8192e: renamed variable HTIOTActIsDisableMCSTwoSpatialStream
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231022/202310220944.r88EaZm2-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220944.r88EaZm2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220944.r88EaZm2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/rtl8192e/rtl819x_HTProc.c: In function 'HTResetSelfAndSavePeerSetting':
>> drivers/staging/rtl8192e/rtl819x_HTProc.c:707:30: error: implicit declaration of function 'ht_iot_act_is_diable_mcs_two_spatial_stream'; did you mean 'ht_iot_act_is_disable_mcs_two_spatial_stream'? [-Werror=implicit-function-declaration]
     707 |                 bIOTAction = ht_iot_act_is_diable_mcs_two_spatial_stream(ieee);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                              ht_iot_act_is_disable_mcs_two_spatial_stream
   drivers/staging/rtl8192e/rtl819x_HTProc.c: At top level:
>> drivers/staging/rtl8192e/rtl819x_HTProc.c:220:13: warning: 'ht_iot_act_is_disable_mcs_two_spatial_stream' defined but not used [-Wunused-function]
     220 | static bool ht_iot_act_is_disable_mcs_two_spatial_stream(struct rtllib_device *ieee)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +707 drivers/staging/rtl8192e/rtl819x_HTProc.c

   657	
   658	void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
   659					   struct rtllib_network *pNetwork)
   660	{
   661		struct rt_hi_throughput *ht_info = ieee->ht_info;
   662		u8	bIOTAction = 0;
   663	
   664		/* unmark enable_ht flag here is the same reason why unmarked in
   665		 * function rtllib_softmac_new_net. WB 2008.09.10
   666		 */
   667		if (pNetwork->bssht.bd_support_ht) {
   668			ht_info->current_ht_support = true;
   669			ht_info->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
   670	
   671			if (pNetwork->bssht.bd_ht_cap_len > 0 &&
   672			    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->PeerHTCapBuf))
   673				memcpy(ht_info->PeerHTCapBuf,
   674				       pNetwork->bssht.bd_ht_cap_buf,
   675				       pNetwork->bssht.bd_ht_cap_len);
   676	
   677			if (pNetwork->bssht.bd_ht_info_len > 0 &&
   678			    pNetwork->bssht.bd_ht_info_len <=
   679			    sizeof(ht_info->PeerHTInfoBuf))
   680				memcpy(ht_info->PeerHTInfoBuf,
   681				       pNetwork->bssht.bd_ht_info_buf,
   682				       pNetwork->bssht.bd_ht_info_len);
   683	
   684			if (ht_info->reg_rt2rt_aggregation) {
   685				ht_info->current_rt2rt_aggregation =
   686					 pNetwork->bssht.bd_rt2rt_aggregation;
   687				ht_info->current_rt2rt_long_slot_time =
   688					 pNetwork->bssht.bd_rt2rt_long_slot_time;
   689				ht_info->RT2RT_HT_Mode = pNetwork->bssht.rt2rt_ht_mode;
   690			} else {
   691				ht_info->current_rt2rt_aggregation = false;
   692				ht_info->current_rt2rt_long_slot_time = false;
   693				ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
   694			}
   695	
   696			HTIOTPeerDetermine(ieee);
   697	
   698			ht_info->iot_action = 0;
   699			bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
   700			if (bIOTAction)
   701				ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
   702	
   703			bIOTAction = HTIOTActIsDisableMCS15(ieee);
   704			if (bIOTAction)
   705				ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
   706	
 > 707			bIOTAction = ht_iot_act_is_diable_mcs_two_spatial_stream(ieee);
   708			if (bIOTAction)
   709				ht_info->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
   710	
   711			bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
   712			if (bIOTAction)
   713				ht_info->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
   714	
   715			bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
   716			if (bIOTAction)
   717				ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
   718			bIOTAction = HTIOTActIsCCDFsync(ieee);
   719			if (bIOTAction)
   720				ht_info->iot_action |= HT_IOT_ACT_CDD_FSYNC;
   721		} else {
   722			ht_info->current_ht_support = false;
   723			ht_info->current_rt2rt_aggregation = false;
   724			ht_info->current_rt2rt_long_slot_time = false;
   725			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
   726	
   727			ht_info->iot_action = 0;
   728			ht_info->iot_ra_func = 0;
   729		}
   730	}
   731	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
