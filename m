Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B17B28A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjI1W6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1W6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:58:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299D194;
        Thu, 28 Sep 2023 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695941925; x=1727477925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UbGttFfuP6lw+hHb/xkwIGlEdNBxv5J2I9w5oq0PHfc=;
  b=nE1dpNhhi5mFncFgCz3i1AUcPk1BaFKvHTQQ1qAP8kj/pxQJDtvey5fv
   si4XbWjnQcHcrtKa1ACAzXLGxFkbIKwunbl0CznY3pFrsbBViBPzWY+vz
   M47ZKIls4l9K6D7n2vsw5ox1o31KcVt8tU4V99q9L8hkEi+popKtPAmwo
   vHvpd8Yp1QLYP+Xkzs/f9D0ocdBUpXzjemi3zzKjb7/o3QMnDp3lFiXUq
   YyRjqLPsb2+OJt+hYthZLcBb00EEtZWayJHKtx5s3SieVgM0wEw/p+81D
   5d030VTGMjboCEOjRoVRxYDKJNdH9ZkQVRGgesDPg5ieI9lFJgFqvA8Ze
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362443605"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="362443605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 15:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923423965"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="923423965"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2023 15:58:38 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlzxs-00026Y-0x;
        Thu, 28 Sep 2023 22:58:36 +0000
Date:   Fri, 29 Sep 2023 06:58:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, minyard@acm.org, joel@jms.id.au,
        andrew@aj.id.au, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, aladyshev22@gmail.com,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <202309290613.qxRTI9f7-lkp@intel.com>
References: <20230928123009.2913-4-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928123009.2913-4-aladyshev22@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cminyard-ipmi/for-next]
[also build test WARNING on linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Aladyshev/ipmi-Move-KCS-headers-to-common-include-folder/20230928-203248
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20230928123009.2913-4-aladyshev22%40gmail.com
patch subject: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290613.qxRTI9f7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290613.qxRTI9f7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290613.qxRTI9f7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_arp.h:22,
                    from drivers/net/mctp/mctp-kcs.c:16:
   drivers/net/mctp/mctp-kcs.c: In function 'mctp_kcs_validate_data':
>> drivers/net/mctp/mctp-kcs.c:121:25: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
     121 |                         "%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/mctp/mctp-kcs.c:120:17: note: in expansion of macro 'dev_err'
     120 |                 dev_err(mkcs->client.dev->dev,
         |                 ^~~~~~~
   drivers/net/mctp/mctp-kcs.c:121:89: note: format string is defined here
     121 |                         "%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
         |                                                                                      ~~~^
         |                                                                                         |
         |                                                                                         unsigned int
         |                                                                                      %02lx


vim +121 drivers/net/mctp/mctp-kcs.c

    95	
    96	static int mctp_kcs_validate_data(struct mctp_kcs *mkcs,
    97					  struct mctp_kcs_header *hdr, int len)
    98	{
    99		struct net_device *ndev = mkcs->netdev;
   100		struct mctp_kcs_trailer *tlr;
   101		u8 pec;
   102	
   103		if (hdr->netfn_lun != MCTP_KCS_NETFN_LUN) {
   104			dev_err(mkcs->client.dev->dev,
   105				"%s: KCS binding header error! netfn_lun = 0x%02x, but should be 0x%02x",
   106				__func__, hdr->netfn_lun, MCTP_KCS_NETFN_LUN);
   107			ndev->stats.rx_dropped++;
   108			return -EINVAL;
   109		}
   110		if (hdr->defining_body != DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP) {
   111			dev_err(mkcs->client.dev->dev,
   112				"%s: KCS binding header error! defining_body = 0x%02x, but should be 0x%02x",
   113				__func__, hdr->defining_body,
   114				DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP);
   115			ndev->stats.rx_dropped++;
   116			return -EINVAL;
   117		}
   118		if (hdr->len != (len - sizeof(struct mctp_kcs_header) -
   119				 sizeof(struct mctp_kcs_trailer))) {
   120			dev_err(mkcs->client.dev->dev,
 > 121				"%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
   122				__func__, hdr->len,
   123				(len - sizeof(struct mctp_kcs_header) -
   124				 sizeof(struct mctp_kcs_trailer)));
   125			ndev->stats.rx_length_errors++;
   126			return -EINVAL;
   127		}
   128	
   129		pec = generate_pec((u8 *)(hdr + 1), hdr->len);
   130		tlr = (struct mctp_kcs_trailer *)((u8 *)(hdr + 1) + hdr->len);
   131		if (pec != tlr->pec) {
   132			dev_err(mkcs->client.dev->dev,
   133				"%s: PEC error! Packet value=0x%02x, calculated value=0x%02x",
   134				__func__, tlr->pec, pec);
   135			ndev->stats.rx_crc_errors++;
   136			return -EINVAL;
   137		}
   138		return 0;
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
