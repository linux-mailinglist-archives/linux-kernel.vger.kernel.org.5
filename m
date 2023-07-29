Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4A7680E7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjG2SHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2SHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:07:07 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D310FF;
        Sat, 29 Jul 2023 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690654026; x=1722190026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tT3wP+FAPv+fZuu7vI6KFd2fqjjxbQbUxunSx/zWWXg=;
  b=B5QDUrB7/rpS0ExBgE42qNj6+M3ujLq5gdDJwK8dVpm6OSNldoxg6tBB
   hdi24DW9oCaWy3cP63LRHfMXWUOJOeuefO2oqalSpPTtpFz8gBpNQaN0i
   vu6K0Z4tzLd7z28YnjhjSj0QMX7WJtVS3PPUbsJLjW54KeAHBWbKA1swu
   B9bV6aL2TXENJzWLUg2OSLj/e+u2S4Y7xEc2aLzDUTpBK5eifa+CjbZk4
   R8U3usfdc/yjMtwaTqZqXjA/g3szX8O4cTMErKYbv+VY+CBURu2GOibnB
   BrTupbn1mr7bXPlcz7ybn3IYlaNVxUe68JylTRmoazhacCOaLG9eEW8N9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="353687289"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="353687289"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 11:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="727797369"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="727797369"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2023 11:07:01 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPoLE-0004EB-19;
        Sat, 29 Jul 2023 18:07:00 +0000
Date:   Sun, 30 Jul 2023 02:06:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: support per-flow
 accounting on MT7988
Message-ID: <202307300133.j8MIsDCa-lkp@intel.com>
References: <801c89963e95e5ce8f1ab7dbda894dd9da0125cc.1690638748.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801c89963e95e5ce8f1ab7dbda894dd9da0125cc.1690638748.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-ethernet-mtk_eth_soc-support-per-flow-accounting-on-MT7988/20230729-215634
base:   net-next/main
patch link:    https://lore.kernel.org/r/801c89963e95e5ce8f1ab7dbda894dd9da0125cc.1690638748.git.daniel%40makrotopia.org
patch subject: [PATCH net-next] net: ethernet: mtk_eth_soc: support per-flow accounting on MT7988
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230730/202307300133.j8MIsDCa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300133.j8MIsDCa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300133.j8MIsDCa-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_ppe.c: In function 'mtk_mib_entry_read':
>> drivers/net/ethernet/mediatek/mtk_ppe.c:112:17: error: 'bytes_cnt_low' undeclared (first use in this function); did you mean 'byte_cnt_low'?
     112 |                 bytes_cnt_low = cnt_r0;
         |                 ^~~~~~~~~~~~~
         |                 byte_cnt_low
   drivers/net/ethernet/mediatek/mtk_ppe.c:112:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/mediatek/mtk_ppe.c:113:17: error: 'bytes_cnt_high' undeclared (first use in this function); did you mean 'byte_cnt_high'?
     113 |                 bytes_cnt_high = cnt_r1;
         |                 ^~~~~~~~~~~~~~
         |                 byte_cnt_high


vim +112 drivers/net/ethernet/mediatek/mtk_ppe.c

    92	
    93	static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *bytes, u64 *packets)
    94	{
    95		u32 byte_cnt_low, byte_cnt_high, pkt_cnt_low, pkt_cnt_high;
    96		u32 val, cnt_r0, cnt_r1, cnt_r2;
    97		int ret;
    98	
    99		val = FIELD_PREP(MTK_PPE_MIB_SER_CR_ADDR, index) | MTK_PPE_MIB_SER_CR_ST;
   100		ppe_w32(ppe, MTK_PPE_MIB_SER_CR, val);
   101	
   102		ret = mtk_ppe_mib_wait_busy(ppe);
   103		if (ret)
   104			return ret;
   105	
   106		cnt_r0 = readl(ppe->base + MTK_PPE_MIB_SER_R0);
   107		cnt_r1 = readl(ppe->base + MTK_PPE_MIB_SER_R1);
   108		cnt_r2 = readl(ppe->base + MTK_PPE_MIB_SER_R2);
   109	
   110		if (mtk_is_netsys_v3_or_greater(ppe->eth)) {
   111			/* 64 bit for each counter */
 > 112			bytes_cnt_low = cnt_r0;
 > 113			bytes_cnt_high = cnt_r1;
   114			pkt_cnt_low = cnt_r2;
   115			pkt_cnt_high = readl(ppe->base + MTK_PPE_MIB_SER_R3);
   116		} else {
   117			/* 48 bit for each counter */
   118			byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
   119			byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
   120			pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
   121			pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
   122		}
   123	
   124		*bytes = ((u64)byte_cnt_high << 32) | byte_cnt_low;
   125		*packets = (pkt_cnt_high << 16) | pkt_cnt_low;
   126	
   127		return 0;
   128	}
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
