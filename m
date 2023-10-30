Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E47DB938
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJ3LsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:48:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C35C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698666495; x=1730202495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bpqJQ8YRbkdI5Q0YGPe2AevsEUiXsqLH1ApWuXERZok=;
  b=NOlvVcV6kYepiIXV/xgMMX4qlaCRfj9ln4GoNGiii0p3TIUO998B7X3L
   VrfFU/W+m1zQ+QSBv4HMfprQzG2dHWrLl2WdbFtEqP5GDu4ac48SrPiaT
   keO+BEmHk0AVIp7I869/rRvXyiv93ln9ElCNFGm2ijcMQEZHNXqOET3f3
   6X+HekkPsUTxO5g2JYEkntq8dhff9n9/oxEBOHPmQ0cbLp86TJ6Ipvuyd
   N0BeUBC1kjemv0b6meHXru4DxTDXRDRUmUSfWObcfAUbWnGiW7xznPtna
   CRsUjBo3vGaSK+YEZI4ezL7JdbNwCBlmaRIED9GLte+oU4/T09kjyDquF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="9588912"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="9588912"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 04:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="933752923"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="933752923"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2023 04:48:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxQkc-000DFD-1V;
        Mon, 30 Oct 2023 11:48:10 +0000
Date:   Mon, 30 Oct 2023 19:48:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning: writing
 8 bytes into a region of size 0
Message-ID: <202310301908.Wrj0diqe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
commit: 1fc4a874ff02ba8c07f8abf97c0bef686406f6df wifi: rtw89: coex: use new introduction BTC version format
date:   10 months ago
config: arm64-randconfig-r013-20221025 (https://download.01.org/0day-ci/archive/20231030/202310301908.Wrj0diqe-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301908.Wrj0diqe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301908.Wrj0diqe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw89/coex.c: In function '_append_tdma':
>> drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
    1448 |                 memcpy(v, &dm->tdma, sizeof(*v));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
                    from drivers/net/wireless/realtek/rtw89/coex.c:5:
   drivers/net/wireless/realtek/rtw89/core.h:2049:37: note: at offset [4782, 70317] into destination object 'ver' of size 8
    2049 |         const struct rtw89_btc_ver *ver;
         |                                     ^~~


vim +1448 drivers/net/wireless/realtek/rtw89/coex.c

e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1423  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1424  static void _append_tdma(struct rtw89_dev *rtwdev)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1425  {
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1426  	const struct rtw89_chip_info *chip = rtwdev->chip;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1427  	struct rtw89_btc *btc = &rtwdev->btc;
1fc4a874ff02ba Ping-Ke Shih 2022-12-17  1428  	const struct rtw89_btc_ver *ver = btc->ver;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1429  	struct rtw89_btc_dm *dm = &btc->dm;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1430  	struct rtw89_btc_btf_tlv *tlv;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1431  	struct rtw89_btc_fbtc_tdma *v;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1432  	struct rtw89_btc_fbtc_tdma_v1 *v1;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1433  	u16 len = btc->policy_len;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1434  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1435  	if (!btc->update_policy_force &&
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1436  	    !memcmp(&dm->tdma, &dm->tdma_now, sizeof(dm->tdma))) {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1437  		rtw89_debug(rtwdev,
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1438  			    RTW89_DBG_BTC, "[BTC], %s(): tdma no change!\n",
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1439  			    __func__);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1440  		return;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1441  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1442  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1443  	tlv = (struct rtw89_btc_btf_tlv *)&btc->policy[len];
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1444  	tlv->type = CXPOLICY_TDMA;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1445  	if (chip->chip_id == RTL8852A) {
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1446  		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1447  		tlv->len = sizeof(*v);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11 @1448  		memcpy(v, &dm->tdma, sizeof(*v));
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1449  		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v);
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1450  	} else {
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1451  		tlv->len = sizeof(*v1);
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1452  		v1 = (struct rtw89_btc_fbtc_tdma_v1 *)&tlv->val[0];
1fc4a874ff02ba Ping-Ke Shih 2022-12-17  1453  		v1->fver = ver->fcxtdma;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1454  		v1->tdma = dm->tdma;
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1455  		btc->policy_len += BTC_TLV_HDR_LEN  + sizeof(*v1);
ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1456  	}
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1457  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1458  	rtw89_debug(rtwdev, RTW89_DBG_BTC,
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1459  		    "[BTC], %s(): type:%d, rxflctrl=%d, txpause=%d, wtgle_n=%d, leak_n=%d, ext_ctrl=%d\n",
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1460  		    __func__, dm->tdma.type, dm->tdma.rxflctrl,
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1461  		    dm->tdma.txpause, dm->tdma.wtgle_n, dm->tdma.leak_n,
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1462  		    dm->tdma.ext_ctrl);
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1463  }
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1464  

:::::: The code at line 1448 was first introduced by commit
:::::: e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd rtw89: add Realtek 802.11ax driver

:::::: TO: Ping-Ke Shih <pkshih@realtek.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
