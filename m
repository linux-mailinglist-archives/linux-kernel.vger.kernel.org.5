Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F04805591
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbjLENMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjLENM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:12:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5F120;
        Tue,  5 Dec 2023 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701781954; x=1733317954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1YJkpglt0M+USmPuYOcmbpC1f8V0q1J5BWnl8qZNugo=;
  b=OAaPsOpAx43yCwCIv2tWbUcQzkoa09UYusHNapJOI9NxBAoac5yhawNa
   3WM0VB8qWQnvaSMX3MQGyKn7U00P9EWWYWBnczuY2WwvoYx3mNoxgvV77
   Naw/3XQKzuN3Ezhw/k4irK1EVcI9LQ1V2eZhqTzkctWPVwjiIFCIvmy3q
   2XCjzys7Zl/me4eJJ1RnG75jmXLzIp2UpkLrlqLl8Q5A9lIMZtYQ+YmTq
   pwzUSO67pUJEuE1lLiVo7RWHubiD2rwWrORQILHH5gzNhSQVOtUr7OzjY
   y6jVbF4Y3+fzJS6etvpaldGJIkTBcBdPstzQe/qox7AsR5QVGbRVPHLVK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7190135"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7190135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 05:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914798925"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="914798925"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2023 05:12:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAVDx-00090y-0k;
        Tue, 05 Dec 2023 13:12:29 +0000
Date:   Tue, 5 Dec 2023 21:11:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     YangXin <yx.0xffff@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
Message-ID: <202312052031.mECkx7WX-lkp@intel.com>
References: <20231204185943.68-1-yx.0xffff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204185943.68-1-yx.0xffff@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YangXin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.7-rc4 next-20231205]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/YangXin/net-___neigh_lookup_noref-remove-redundant-parameters/20231205-030205
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231204185943.68-1-yx.0xffff%40gmail.com
patch subject: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
config: i386-randconfig-015-20231205 (https://download.01.org/0day-ci/archive/20231205/202312052031.mECkx7WX-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052031.mECkx7WX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052031.mECkx7WX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/sfc/ef100_rx.c:11:
   In file included from drivers/net/ethernet/sfc/net_driver.h:28:
   In file included from include/net/busy_poll.h:18:
   In file included from include/net/ip.h:30:
   In file included from include/net/route.h:28:
   include/net/arp.h:27:63: error: too many arguments to function call, expected 3, have 4
           return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, &key, dev);
                  ~~~~~~~~~~~~~~~~~~~~~                                 ^~~
   include/net/neighbour.h:293:33: note: '___neigh_lookup_noref' declared here
   static inline struct neighbour *___neigh_lookup_noref(
                                   ^
   In file included from drivers/net/ethernet/sfc/ef100_rx.c:11:
   In file included from drivers/net/ethernet/sfc/net_driver.h:28:
   In file included from include/net/busy_poll.h:18:
   In file included from include/net/ip.h:30:
   In file included from include/net/route.h:29:
   include/net/ndisc.h:383:63: error: too many arguments to function call, expected 3, have 4
           return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, pkey, dev);
                  ~~~~~~~~~~~~~~~~~~~~~                                 ^~~
   include/net/neighbour.h:293:33: note: '___neigh_lookup_noref' declared here
   static inline struct neighbour *___neigh_lookup_noref(
                                   ^
   In file included from drivers/net/ethernet/sfc/ef100_rx.c:11:
   In file included from drivers/net/ethernet/sfc/net_driver.h:28:
   In file included from include/net/busy_poll.h:18:
   In file included from include/net/ip.h:30:
   In file included from include/net/route.h:29:
   include/net/ndisc.h:390:73: error: too many arguments to function call, expected 3, have 4
           return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128, pkey, dev);
                  ~~~~~~~~~~~~~~~~~~~~~                                           ^~~
   include/net/neighbour.h:293:33: note: '___neigh_lookup_noref' declared here
   static inline struct neighbour *___neigh_lookup_noref(
                                   ^
   drivers/net/ethernet/sfc/ef100_rx.c:175:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_QWORD_FIELD(*p_event, ESF_GZ_EV_RXPKTS_NUM_PKT);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:231:26: note: expanded from macro 'EFX_QWORD_FIELD'
   #define EFX_QWORD_FIELD         EFX_QWORD_FIELD32
                                   ^
   drivers/net/ethernet/sfc/bitfield.h:183:2: note: expanded from macro 'EFX_QWORD_FIELD32'
           EFX_EXTRACT_QWORD32(qword, EFX_LOW_BIT(field),          \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:163:4: note: expanded from macro 'EFX_EXTRACT_QWORD32'
             EFX_EXTRACT32((qword).u32[1], 32, 63, low, high)) &           \
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:143:2: note: expanded from macro 'EFX_EXTRACT32'
           EFX_EXTRACT_NATIVE(le32_to_cpu(element), min, max, low, high)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:128:20: note: expanded from macro 'EFX_EXTRACT_NATIVE'
            (native_element) >> ((low) - (min)) :                          \
                             ^  ~~~~~~~~~~~~~~~
>> drivers/net/ethernet/sfc/ef100_rx.c:175:3: warning: shift count >= width of type [-Wshift-count-overflow]
                   EFX_QWORD_FIELD(*p_event, ESF_GZ_EV_RXPKTS_NUM_PKT);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:231:26: note: expanded from macro 'EFX_QWORD_FIELD'
   #define EFX_QWORD_FIELD         EFX_QWORD_FIELD32
                                   ^
   drivers/net/ethernet/sfc/bitfield.h:183:2: note: expanded from macro 'EFX_QWORD_FIELD32'
           EFX_EXTRACT_QWORD32(qword, EFX_LOW_BIT(field),          \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:163:4: note: expanded from macro 'EFX_EXTRACT_QWORD32'
             EFX_EXTRACT32((qword).u32[1], 32, 63, low, high)) &           \
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:143:2: note: expanded from macro 'EFX_EXTRACT32'
           EFX_EXTRACT_NATIVE(le32_to_cpu(element), min, max, low, high)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:129:20: note: expanded from macro 'EFX_EXTRACT_NATIVE'
            (native_element) << ((min) - (low)))
                             ^  ~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/ef100_rx.c:204:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_1(*rxd, ESF_GZ_RX_BUF_ADDR, rx_buf->dma_addr);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:440:2: note: expanded from macro 'EFX_POPULATE_QWORD_1'
           EFX_POPULATE_QWORD_2(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:438:2: note: expanded from macro 'EFX_POPULATE_QWORD_2'
           EFX_POPULATE_QWORD_3(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:436:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 21 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:258:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:247:21: note: expanded from macro 'EFX_INSERT_NATIVE64'
             (((u64) (value)) << (low - min)) :            \
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/ef100_rx.c:204:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_1(*rxd, ESF_GZ_RX_BUF_ADDR, rx_buf->dma_addr);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:440:2: note: expanded from macro 'EFX_POPULATE_QWORD_1'
           EFX_POPULATE_QWORD_2(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:438:2: note: expanded from macro 'EFX_POPULATE_QWORD_2'
           EFX_POPULATE_QWORD_3(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:436:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 21 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:259:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:253:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) << (low - min)) :            \
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/ef100_rx.c:204:3: warning: shift count >= width of type [-Wshift-count-overflow]
                   EFX_POPULATE_QWORD_1(*rxd, ESF_GZ_RX_BUF_ADDR, rx_buf->dma_addr);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:440:2: note: expanded from macro 'EFX_POPULATE_QWORD_1'
           EFX_POPULATE_QWORD_2(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:438:2: note: expanded from macro 'EFX_POPULATE_QWORD_2'
           EFX_POPULATE_QWORD_3(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:436:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 21 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:259:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE32(min, max, low, high, value))
            ^
   drivers/net/ethernet/sfc/bitfield.h:254:21: note: expanded from macro 'EFX_INSERT_NATIVE32'
             (((u32) (value)) >> (min - low))))
                              ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   drivers/net/ethernet/sfc/ef100_rx.c:204:3: warning: shift count is negative [-Wshift-count-negative]
                   EFX_POPULATE_QWORD_1(*rxd, ESF_GZ_RX_BUF_ADDR, rx_buf->dma_addr);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:440:2: note: expanded from macro 'EFX_POPULATE_QWORD_1'
           EFX_POPULATE_QWORD_2(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:438:2: note: expanded from macro 'EFX_POPULATE_QWORD_2'
           EFX_POPULATE_QWORD_3(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/bitfield.h:436:2: note: expanded from macro 'EFX_POPULATE_QWORD_3'
           EFX_POPULATE_QWORD_4(qword, EFX_DUMMY_FIELD, 0, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 21 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/net/ethernet/sfc/bitfield.h:258:3: note: expanded from macro 'EFX_INSERT_NATIVE'
            EFX_INSERT_NATIVE64(min, max, low, high, value) :      \
            ^
   drivers/net/ethernet/sfc/bitfield.h:247:21: note: expanded from macro 'EFX_INSERT_NATIVE64'


vim +175 drivers/net/ethernet/sfc/ef100_rx.c

8e57daf70671e4 Edward Cree 2020-08-03  170  
8e57daf70671e4 Edward Cree 2020-08-03  171  void efx_ef100_ev_rx(struct efx_channel *channel, const efx_qword_t *p_event)
8e57daf70671e4 Edward Cree 2020-08-03  172  {
8e57daf70671e4 Edward Cree 2020-08-03  173  	struct efx_rx_queue *rx_queue = efx_channel_get_rx_queue(channel);
8e57daf70671e4 Edward Cree 2020-08-03  174  	unsigned int n_packets =
8e57daf70671e4 Edward Cree 2020-08-03 @175  		EFX_QWORD_FIELD(*p_event, ESF_GZ_EV_RXPKTS_NUM_PKT);
8e57daf70671e4 Edward Cree 2020-08-03  176  	int i;
8e57daf70671e4 Edward Cree 2020-08-03  177  
8e57daf70671e4 Edward Cree 2020-08-03  178  	WARN_ON_ONCE(!n_packets);
8e57daf70671e4 Edward Cree 2020-08-03  179  	if (n_packets > 1)
8e57daf70671e4 Edward Cree 2020-08-03  180  		++channel->n_rx_merge_events;
8e57daf70671e4 Edward Cree 2020-08-03  181  
8e57daf70671e4 Edward Cree 2020-08-03  182  	channel->irq_mod_score += 2 * n_packets;
8e57daf70671e4 Edward Cree 2020-08-03  183  
8e57daf70671e4 Edward Cree 2020-08-03  184  	for (i = 0; i < n_packets; ++i) {
8e57daf70671e4 Edward Cree 2020-08-03  185  		ef100_rx_packet(rx_queue,
8e57daf70671e4 Edward Cree 2020-08-03  186  				rx_queue->removed_count & rx_queue->ptr_mask);
8e57daf70671e4 Edward Cree 2020-08-03  187  		++rx_queue->removed_count;
8e57daf70671e4 Edward Cree 2020-08-03  188  	}
8e57daf70671e4 Edward Cree 2020-08-03  189  }
8e57daf70671e4 Edward Cree 2020-08-03  190  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
