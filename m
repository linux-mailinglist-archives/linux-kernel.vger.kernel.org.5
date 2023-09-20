Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D917A7399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjITHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjITHDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:03:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E0792;
        Wed, 20 Sep 2023 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695193418; x=1726729418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EtTh13CKXNbPz2a7ayAQwbnTJR4U+Lo4uuuRZZuaJM=;
  b=EUb17RjvO6/66502O3oHssQNrCLHbDf6YCV1e5qkB+nDahVOyW/5+7Ew
   d2u1t0HZtb7ACNUFwYLTYuO/T8FTkJmfzRYWdB3Ieu5d+Ot4aOXEMlDuV
   ZBub74ew4saRRMvcs3y9S+4QpjStk8ULR4UjNmMEXtdtekd/PuH7LLdqM
   6GjfjmsBqJ7goyC89ruO3SIHGO2Yr0ihU2qshWbAjn/+T/wufGayARxpb
   TiiBbvL5b2m15RM9biTgyYr7934JM2i+wgxK3xsTTWAyStvCl9Qx4Z/0q
   5xwc+bWFMr7GeZsskj0Qr0rawainzgRNOC1/qO77pQBCYT87v0hwgctKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="380045018"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="380045018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920164837"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920164837"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2023 00:03:33 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qirFD-0008Qi-1g;
        Wed, 20 Sep 2023 07:03:31 +0000
Date:   Wed, 20 Sep 2023 15:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/18] net/smc: extend GID to 128bits for
 virtual ISM device
Message-ID: <202309201408.95QRxHEl-lkp@intel.com>
References: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230920-010019
base:   net-next/main
patch link:    https://lore.kernel.org/r/1695134522-126655-7-git-send-email-guwen%40linux.alibaba.com
patch subject: [PATCH net-next 06/18] net/smc: extend GID to 128bits for virtual ISM device
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201408.95QRxHEl-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/smc/smc_ism.c: In function 'smc_ism_signal_shutdown':
>> net/smc/smc_ism.c:539:57: error: incompatible type for argument 2 of 'lgr-><U72f8>.<U7260>.smcd->ops->signal_event'
     539 |         rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
         |                                                      ~~~^~~~~~~~~~
         |                                                         |
         |                                                         struct smcd_gid
   net/smc/smc_ism.c:539:57: note: expected 'u64' {aka 'long long unsigned int'} but argument is of type 'struct smcd_gid'


vim +539 net/smc/smc_ism.c

820f21009f1bc7a Stefan Raspl 2023-01-23  526  
820f21009f1bc7a Stefan Raspl 2023-01-23  527  int smc_ism_signal_shutdown(struct smc_link_group *lgr)
820f21009f1bc7a Stefan Raspl 2023-01-23  528  {
820f21009f1bc7a Stefan Raspl 2023-01-23  529  	int rc = 0;
820f21009f1bc7a Stefan Raspl 2023-01-23  530  #if IS_ENABLED(CONFIG_ISM)
820f21009f1bc7a Stefan Raspl 2023-01-23  531  	union smcd_sw_event_info ev_info;
820f21009f1bc7a Stefan Raspl 2023-01-23  532  
820f21009f1bc7a Stefan Raspl 2023-01-23  533  	if (lgr->peer_shutdown)
820f21009f1bc7a Stefan Raspl 2023-01-23  534  		return 0;
820f21009f1bc7a Stefan Raspl 2023-01-23  535  
820f21009f1bc7a Stefan Raspl 2023-01-23  536  	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
820f21009f1bc7a Stefan Raspl 2023-01-23  537  	ev_info.vlan_id = lgr->vlan_id;
820f21009f1bc7a Stefan Raspl 2023-01-23  538  	ev_info.code = ISM_EVENT_REQUEST;
820f21009f1bc7a Stefan Raspl 2023-01-23 @539  	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
820f21009f1bc7a Stefan Raspl 2023-01-23  540  					  ISM_EVENT_REQUEST_IR,
820f21009f1bc7a Stefan Raspl 2023-01-23  541  					  ISM_EVENT_CODE_SHUTDOWN,
820f21009f1bc7a Stefan Raspl 2023-01-23  542  					  ev_info.info);
820f21009f1bc7a Stefan Raspl 2023-01-23  543  #endif
820f21009f1bc7a Stefan Raspl 2023-01-23  544  	return rc;
820f21009f1bc7a Stefan Raspl 2023-01-23  545  }
201091ebb2a161a Ursula Braun 2020-09-26  546  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
