Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A917F29BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjKUKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjKUKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:04:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865110F;
        Tue, 21 Nov 2023 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700561078; x=1732097078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tM/dBdaQqRwyGzQe3I2S/GuZt02ZYBBRQTyGFOMoNS0=;
  b=DhTGRm9WC5wooj97TWH57KKWSHnRIhOEobfAEGVFloFi568v0tSFhl3p
   5iQmq5FW5ZCCnv99BWcHeGZ+3BZtJtGeGVHzA6hSaxLut2JOcu/RWNWzj
   20DynkDkZB2RtZa0D7kmZieKbrGoSL3AOaAEtCtVFA5ZJSMo8nl8bgnmR
   sw1Kxk8WqlId5o6MF064cPqsjlAw2+GbmpHNg066KZOci92flvhjMAL2Z
   ix5ab1TMojkzptfUg7KedOgROOvCk4XbcnEMLIY74WcbvpDOWweMNbB0H
   jAzBtPqe258U6YvsrRd1rdhBNEY4Zu2ym93NkBqDKSFRrmo0UBf8HKVvN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13349948"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13349948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884154460"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884154460"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2023 02:04:34 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5NcO-0007fo-0L;
        Tue, 21 Nov 2023 10:04:32 +0000
Date:   Tue, 21 Nov 2023 18:00:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v11 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202311211750.4FwMt8rx-lkp@intel.com>
References: <20231115133414.1221480-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115133414.1221480-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20231115-213811
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231115133414.1221480-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v11 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231121/202311211750.4FwMt8rx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211750.4FwMt8rx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211750.4FwMt8rx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1243:2: warning: variable 'csum_cmd' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
    1243 |         default:
         |         ^~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1255:2: note: uninitialized use occurs here
    1255 |         csum_cmd |= u32_encode_bits(skb_transport_offset(skb), TCPHO_MASK);
         |         ^~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1230:14: note: initialize the variable 'csum_cmd' to silence this warning
    1230 |         u32 csum_cmd;
         |                     ^
         |                      = 0
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1268:6: warning: variable 'pkt_len_cnt' set but not used [-Wunused-but-set-variable]
    1268 |         u64 pkt_len_cnt = 0;
         |             ^
   In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:47:
   In file included from include/linux/delay.h:23:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:26:
   In file included from include/linux/irqflags.h:17:
   In file included from arch/arm64/include/asm/irqflags.h:10:
   In file included from arch/arm64/include/asm/ptrace.h:11:
   In file included from arch/arm64/include/asm/cpufeature.h:26:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:12:
   In file included from include/linux/string.h:295:
   include/linux/fortify-string.h:588:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     588 |                         __read_overflow2_field(q_size_field, size);
         |                         ^
   3 warnings generated.


vim +/csum_cmd +1243 drivers/net/ethernet/realtek/rtase/rtase_main.c

7f5e83b995e2f8 Justin Lai 2023-11-15  1226  
7f5e83b995e2f8 Justin Lai 2023-11-15  1227  static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
7f5e83b995e2f8 Justin Lai 2023-11-15  1228  {
7f5e83b995e2f8 Justin Lai 2023-11-15  1229  	u8 ip_protocol;
7f5e83b995e2f8 Justin Lai 2023-11-15  1230  	u32 csum_cmd;
7f5e83b995e2f8 Justin Lai 2023-11-15  1231  
7f5e83b995e2f8 Justin Lai 2023-11-15  1232  	switch (vlan_get_protocol(skb)) {
7f5e83b995e2f8 Justin Lai 2023-11-15  1233  	case htons(ETH_P_IP):
7f5e83b995e2f8 Justin Lai 2023-11-15  1234  		csum_cmd = TX_IPCS_C;
7f5e83b995e2f8 Justin Lai 2023-11-15  1235  		ip_protocol = ip_hdr(skb)->protocol;
7f5e83b995e2f8 Justin Lai 2023-11-15  1236  		break;
7f5e83b995e2f8 Justin Lai 2023-11-15  1237  
7f5e83b995e2f8 Justin Lai 2023-11-15  1238  	case htons(ETH_P_IPV6):
7f5e83b995e2f8 Justin Lai 2023-11-15  1239  		csum_cmd = TX_IPV6F_C;
7f5e83b995e2f8 Justin Lai 2023-11-15  1240  		ip_protocol = ipv6_hdr(skb)->nexthdr;
7f5e83b995e2f8 Justin Lai 2023-11-15  1241  		break;
7f5e83b995e2f8 Justin Lai 2023-11-15  1242  
7f5e83b995e2f8 Justin Lai 2023-11-15 @1243  	default:
7f5e83b995e2f8 Justin Lai 2023-11-15  1244  		ip_protocol = IPPROTO_RAW;
7f5e83b995e2f8 Justin Lai 2023-11-15  1245  		break;
7f5e83b995e2f8 Justin Lai 2023-11-15  1246  	}
7f5e83b995e2f8 Justin Lai 2023-11-15  1247  
7f5e83b995e2f8 Justin Lai 2023-11-15  1248  	if (ip_protocol == IPPROTO_TCP)
7f5e83b995e2f8 Justin Lai 2023-11-15  1249  		csum_cmd |= TX_TCPCS_C;
7f5e83b995e2f8 Justin Lai 2023-11-15  1250  	else if (ip_protocol == IPPROTO_UDP)
7f5e83b995e2f8 Justin Lai 2023-11-15  1251  		csum_cmd |= TX_UDPCS_C;
7f5e83b995e2f8 Justin Lai 2023-11-15  1252  	else
7f5e83b995e2f8 Justin Lai 2023-11-15  1253  		WARN_ON_ONCE(1);
7f5e83b995e2f8 Justin Lai 2023-11-15  1254  
7f5e83b995e2f8 Justin Lai 2023-11-15  1255  	csum_cmd |= u32_encode_bits(skb_transport_offset(skb), TCPHO_MASK);
7f5e83b995e2f8 Justin Lai 2023-11-15  1256  
7f5e83b995e2f8 Justin Lai 2023-11-15  1257  	return csum_cmd;
7f5e83b995e2f8 Justin Lai 2023-11-15  1258  }
7f5e83b995e2f8 Justin Lai 2023-11-15  1259  
7f5e83b995e2f8 Justin Lai 2023-11-15  1260  static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
7f5e83b995e2f8 Justin Lai 2023-11-15  1261  			    u32 opts1, u32 opts2)
7f5e83b995e2f8 Justin Lai 2023-11-15  1262  {
7f5e83b995e2f8 Justin Lai 2023-11-15  1263  	const struct skb_shared_info *info = skb_shinfo(skb);
7f5e83b995e2f8 Justin Lai 2023-11-15  1264  	const struct rtase_private *tp = ring->ivec->tp;
7f5e83b995e2f8 Justin Lai 2023-11-15  1265  	const u8 nr_frags = info->nr_frags;
7f5e83b995e2f8 Justin Lai 2023-11-15  1266  	struct tx_desc *txd = NULL;
7f5e83b995e2f8 Justin Lai 2023-11-15  1267  	u32 cur_frag, entry;
7f5e83b995e2f8 Justin Lai 2023-11-15 @1268  	u64 pkt_len_cnt = 0;
7f5e83b995e2f8 Justin Lai 2023-11-15  1269  
7f5e83b995e2f8 Justin Lai 2023-11-15  1270  	entry = ring->cur_idx;
7f5e83b995e2f8 Justin Lai 2023-11-15  1271  	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
7f5e83b995e2f8 Justin Lai 2023-11-15  1272  		const skb_frag_t *frag = &info->frags[cur_frag];
7f5e83b995e2f8 Justin Lai 2023-11-15  1273  		dma_addr_t mapping;
7f5e83b995e2f8 Justin Lai 2023-11-15  1274  		u32 status, len;
7f5e83b995e2f8 Justin Lai 2023-11-15  1275  		void *addr;
7f5e83b995e2f8 Justin Lai 2023-11-15  1276  
7f5e83b995e2f8 Justin Lai 2023-11-15  1277  		entry = (entry + 1) % NUM_DESC;
7f5e83b995e2f8 Justin Lai 2023-11-15  1278  
7f5e83b995e2f8 Justin Lai 2023-11-15  1279  		txd = ring->desc + sizeof(struct tx_desc) * entry;
7f5e83b995e2f8 Justin Lai 2023-11-15  1280  		len = skb_frag_size(frag);
7f5e83b995e2f8 Justin Lai 2023-11-15  1281  		addr = skb_frag_address(frag);
7f5e83b995e2f8 Justin Lai 2023-11-15  1282  		mapping = dma_map_single(&tp->pdev->dev, addr, len,
7f5e83b995e2f8 Justin Lai 2023-11-15  1283  					 DMA_TO_DEVICE);
7f5e83b995e2f8 Justin Lai 2023-11-15  1284  
7f5e83b995e2f8 Justin Lai 2023-11-15  1285  		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
7f5e83b995e2f8 Justin Lai 2023-11-15  1286  			if (unlikely(net_ratelimit()))
7f5e83b995e2f8 Justin Lai 2023-11-15  1287  				netdev_err(tp->dev,
7f5e83b995e2f8 Justin Lai 2023-11-15  1288  					   "Failed to map TX fragments DMA!\n");
7f5e83b995e2f8 Justin Lai 2023-11-15  1289  
7f5e83b995e2f8 Justin Lai 2023-11-15  1290  			goto err_out;
7f5e83b995e2f8 Justin Lai 2023-11-15  1291  		}
7f5e83b995e2f8 Justin Lai 2023-11-15  1292  
7f5e83b995e2f8 Justin Lai 2023-11-15  1293  		if (((entry + 1) % NUM_DESC) == 0)
7f5e83b995e2f8 Justin Lai 2023-11-15  1294  			status = (opts1 | len | RING_END);
7f5e83b995e2f8 Justin Lai 2023-11-15  1295  		else
7f5e83b995e2f8 Justin Lai 2023-11-15  1296  			status = opts1 | len;
7f5e83b995e2f8 Justin Lai 2023-11-15  1297  
7f5e83b995e2f8 Justin Lai 2023-11-15  1298  		if (cur_frag == (nr_frags - 1)) {
7f5e83b995e2f8 Justin Lai 2023-11-15  1299  			ring->skbuff[entry] = skb;
7f5e83b995e2f8 Justin Lai 2023-11-15  1300  			status |= TX_LAST_FRAG;
7f5e83b995e2f8 Justin Lai 2023-11-15  1301  		}
7f5e83b995e2f8 Justin Lai 2023-11-15  1302  
7f5e83b995e2f8 Justin Lai 2023-11-15  1303  		ring->mis.len[entry] = len;
7f5e83b995e2f8 Justin Lai 2023-11-15  1304  		txd->addr = cpu_to_le64(mapping);
7f5e83b995e2f8 Justin Lai 2023-11-15  1305  		txd->opts2 = cpu_to_le32(opts2);
7f5e83b995e2f8 Justin Lai 2023-11-15  1306  
7f5e83b995e2f8 Justin Lai 2023-11-15  1307  		/* make sure the operating fields have been updated */
7f5e83b995e2f8 Justin Lai 2023-11-15  1308  		wmb();
7f5e83b995e2f8 Justin Lai 2023-11-15  1309  		txd->opts1 = cpu_to_le32(status);
7f5e83b995e2f8 Justin Lai 2023-11-15  1310  		pkt_len_cnt += len;
7f5e83b995e2f8 Justin Lai 2023-11-15  1311  	}
7f5e83b995e2f8 Justin Lai 2023-11-15  1312  
7f5e83b995e2f8 Justin Lai 2023-11-15  1313  	return cur_frag;
7f5e83b995e2f8 Justin Lai 2023-11-15  1314  
7f5e83b995e2f8 Justin Lai 2023-11-15  1315  err_out:
7f5e83b995e2f8 Justin Lai 2023-11-15  1316  	rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
7f5e83b995e2f8 Justin Lai 2023-11-15  1317  	return -EIO;
7f5e83b995e2f8 Justin Lai 2023-11-15  1318  }
7f5e83b995e2f8 Justin Lai 2023-11-15  1319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
