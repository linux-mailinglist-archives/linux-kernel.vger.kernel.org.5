Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E5786477
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjHXBIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjHXBHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:07:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6B10DD;
        Wed, 23 Aug 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692839268; x=1724375268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lv3S5ouPY4y8kBlrKh8HvQ7grObroP43ydep697gLqI=;
  b=a5I0tUszl+mpvTLZPg1OibIlsCUR/iZ3eRRtCUDARq9Y+YfgwG9dqqwq
   GLkRm27YP5I2xDG32ixR997AACIFFe1k9yalLwmS3F3d/QDGGU3zlvxkN
   LLazE4WRGXYbRnUmyorWzW+2A6QaD2BDHm2t+L82CczzTr/GLKbJIGq1I
   EpM3l1AJZhxNnQpZWFEMRo5tjK7CBE9zar2vcKtXapf4UZZm55Q5ABQY2
   IVhoQNKBC15cp/S1CQJfoiU1+OT3DVrL+awu8rMz1oHrszzaCzHb+kYDO
   JBhUDVNOYf/cWCz2o/oirxqiDyfURcclWfta5EEInvK2ZTreQ+Xqv6UUe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438244454"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438244454"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 18:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826935169"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826935169"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 18:07:44 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYyp5-0001dw-2S;
        Thu, 24 Aug 2023 01:07:43 +0000
Date:   Thu, 24 Aug 2023 09:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: mwifiex: Sanity check tlv_len and
 tlv_bitmap_len
Message-ID: <202308240844.leyoOwdG-lkp@intel.com>
References: <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc7 next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-A-R-Silva/wifi-mwifiex-Fix-tlv_buf_left-calculation/20230824-063517
base:   linus/master
patch link:    https://lore.kernel.org/r/587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars%40kernel.org
patch subject: [PATCH 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230824/202308240844.leyoOwdG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240844.leyoOwdG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240844.leyoOwdG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:12:
   drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c: In function 'mwifiex_11n_rxba_sync_event':
>> drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:926:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     926 |                                     "TLV size (%ld) overflows event_buf (%d)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     927 |                                     size_add(sizeof(tlv_rxba->header), tlv_len),
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     |
         |                                     size_t {aka unsigned int}
   drivers/net/wireless/marvell/mwifiex/main.h:199:51: note: in definition of macro 'mwifiex_dbg'
     199 |         _mwifiex_dbg(adapter, MWIFIEX_DBG_##mask, fmt, ##__VA_ARGS__)
         |                                                   ^~~
   drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:926:50: note: format string is defined here
     926 |                                     "TLV size (%ld) overflows event_buf (%d)\n",
         |                                                ~~^
         |                                                  |
         |                                                  long int
         |                                                %d
   drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:942:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     942 |                                     "TLV size (%ld) overflows event_buf (%d)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     943 |                                     size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     |
         |                                     size_t {aka unsigned int}
   drivers/net/wireless/marvell/mwifiex/main.h:199:51: note: in definition of macro 'mwifiex_dbg'
     199 |         _mwifiex_dbg(adapter, MWIFIEX_DBG_##mask, fmt, ##__VA_ARGS__)
         |                                                   ^~~
   drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:942:50: note: format string is defined here
     942 |                                     "TLV size (%ld) overflows event_buf (%d)\n",
         |                                                ~~^
         |                                                  |
         |                                                  long int
         |                                                %d


vim +926 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c

   904	
   905	/* This function handles rxba_sync event
   906	 */
   907	void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
   908					 u8 *event_buf, u16 len)
   909	{
   910		struct mwifiex_ie_types_rxba_sync *tlv_rxba = (void *)event_buf;
   911		u16 tlv_type, tlv_len;
   912		struct mwifiex_rx_reorder_tbl *rx_reor_tbl_ptr;
   913		u8 i, j;
   914		u16 seq_num, tlv_seq_num, tlv_bitmap_len;
   915		int tlv_buf_left = len;
   916		int ret;
   917		u8 *tmp;
   918	
   919		mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
   920				 event_buf, len);
   921		while (tlv_buf_left > sizeof(*tlv_rxba)) {
   922			tlv_type = le16_to_cpu(tlv_rxba->header.type);
   923			tlv_len  = le16_to_cpu(tlv_rxba->header.len);
   924			if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
   925				mwifiex_dbg(priv->adapter, WARN,
 > 926					    "TLV size (%ld) overflows event_buf (%d)\n",

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
