Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034C7BA2EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjJEPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjJEPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDD2D0E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696516083; x=1728052083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i4Xa4F7uUkCS1mkKe4lLewio/lYLvcRYrhAlHsNksI8=;
  b=NfDvADeo8xVCK4C9FOEJ68MBwh6VKpC0V22h5jKgCIOdvcqz/d0NXMP3
   hAjXVAgZYGvWnQcmso0qsEiMRDRYiuvyOdVkEisr/5aVsJ3a/7fWpjoMQ
   0gfGPF1BGDVyQ3rDRxEV1K/0QdOrsdfRQzK+1O3ZxxaTLOFCLeioChNsx
   HxwXuHDRCtozqFXBwN33nT2ZDBo41Uoww9SD1CdwOqd7KdvCubc5siR9C
   2HZIRBlIcBvCCB/4ugN6P5xMC0N8Qv5oi13IPBF5pJFetirKsBq2j4XbG
   tMoC+lXKAQUT8CB7ne6NagnyWAmwj6OSINmXEeYz5g39AWV0PFnLaaoO8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2092168"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2092168"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842372662"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842372662"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2023 06:11:53 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoO8t-000LPy-1O;
        Thu, 05 Oct 2023 13:11:51 +0000
Date:   Thu, 5 Oct 2023 21:11:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202310052127.fOKunDCP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3006adf3be79cde4d14b1800b963b82b6e5572e0
commit: c5b331d4f550fb78bf1a553b2517616a5ea913d6 wifi: wilc1000: add WPA3 SAE support
date:   1 year, 4 months ago
config: i386-randconfig-063-20231005 (https://download.01.org/0day-ci/archive/20231005/202310052127.fOKunDCP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310052127.fOKunDCP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310052127.fOKunDCP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
   drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     expected unsigned int key_mgmt_suite
   drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     got restricted __be32 [usertype]

vim +361 drivers/net/wireless/microchip/wilc1000/cfg80211.c

   300	
   301	static int connect(struct wiphy *wiphy, struct net_device *dev,
   302			   struct cfg80211_connect_params *sme)
   303	{
   304		struct wilc_vif *vif = netdev_priv(dev);
   305		struct wilc_priv *priv = &vif->priv;
   306		struct host_if_drv *wfi_drv = priv->hif_drv;
   307		int ret;
   308		u32 i;
   309		u8 security = WILC_FW_SEC_NO;
   310		enum authtype auth_type = WILC_FW_AUTH_ANY;
   311		u32 cipher_group;
   312		struct cfg80211_bss *bss;
   313		void *join_params;
   314		u8 ch;
   315	
   316		vif->connecting = true;
   317	
   318		cipher_group = sme->crypto.cipher_group;
   319		if (cipher_group != 0) {
   320			if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
   321				if (cipher_group == WLAN_CIPHER_SUITE_TKIP)
   322					security = WILC_FW_SEC_WPA2_TKIP;
   323				else
   324					security = WILC_FW_SEC_WPA2_AES;
   325			} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) {
   326				if (cipher_group == WLAN_CIPHER_SUITE_TKIP)
   327					security = WILC_FW_SEC_WPA_TKIP;
   328				else
   329					security = WILC_FW_SEC_WPA_AES;
   330			} else {
   331				ret = -ENOTSUPP;
   332				netdev_err(dev, "%s: Unsupported cipher\n",
   333					   __func__);
   334				goto out_error;
   335			}
   336		}
   337	
   338		if ((sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) ||
   339		    (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2)) {
   340			for (i = 0; i < sme->crypto.n_ciphers_pairwise; i++) {
   341				u32 ciphers_pairwise = sme->crypto.ciphers_pairwise[i];
   342	
   343				if (ciphers_pairwise == WLAN_CIPHER_SUITE_TKIP)
   344					security |= WILC_FW_TKIP;
   345				else
   346					security |= WILC_FW_AES;
   347			}
   348		}
   349	
   350		switch (sme->auth_type) {
   351		case NL80211_AUTHTYPE_OPEN_SYSTEM:
   352			auth_type = WILC_FW_AUTH_OPEN_SYSTEM;
   353			break;
   354	
   355		case NL80211_AUTHTYPE_SAE:
   356			auth_type = WILC_FW_AUTH_SAE;
   357			if (sme->ssid_len) {
   358				memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
   359				vif->auth.ssid.ssid_len = sme->ssid_len;
   360			}
 > 361			vif->auth.key_mgmt_suite = cpu_to_be32(sme->crypto.akm_suites[0]);
   362			ether_addr_copy(vif->auth.bssid, sme->bssid);
   363			break;
   364	
   365		default:
   366			break;
   367		}
   368	
   369		if (sme->crypto.n_akm_suites) {
   370			if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X)
   371				auth_type = WILC_FW_AUTH_IEEE8021;
   372			else if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_PSK_SHA256)
   373				auth_type = WILC_FW_AUTH_OPEN_SYSTEM_SHA256;
   374			else if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X_SHA256)
   375				auth_type = WILC_FW_AUTH_IEE8021X_SHA256;
   376		}
   377	
   378		if (wfi_drv->usr_scan_req.scan_result) {
   379			netdev_err(vif->ndev, "%s: Scan in progress\n", __func__);
   380			ret = -EBUSY;
   381			goto out_error;
   382		}
   383	
   384		bss = cfg80211_get_bss(wiphy, sme->channel, sme->bssid, sme->ssid,
   385				       sme->ssid_len, IEEE80211_BSS_TYPE_ANY,
   386				       IEEE80211_PRIVACY(sme->privacy));
   387		if (!bss) {
   388			ret = -EINVAL;
   389			goto out_error;
   390		}
   391	
   392		if (ether_addr_equal_unaligned(vif->bssid, bss->bssid)) {
   393			ret = -EALREADY;
   394			goto out_put_bss;
   395		}
   396	
   397		join_params = wilc_parse_join_bss_param(bss, &sme->crypto);
   398		if (!join_params) {
   399			netdev_err(dev, "%s: failed to construct join param\n",
   400				   __func__);
   401			ret = -EINVAL;
   402			goto out_put_bss;
   403		}
   404	
   405		ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
   406		vif->wilc->op_ch = ch;
   407		if (vif->iftype != WILC_CLIENT_MODE)
   408			vif->wilc->sta_ch = ch;
   409	
   410		wilc_wlan_set_bssid(dev, bss->bssid, WILC_STATION_MODE);
   411	
   412		wfi_drv->conn_info.security = security;
   413		wfi_drv->conn_info.auth_type = auth_type;
   414		wfi_drv->conn_info.ch = ch;
   415		wfi_drv->conn_info.conn_result = cfg_connect_result;
   416		wfi_drv->conn_info.arg = priv;
   417		wfi_drv->conn_info.param = join_params;
   418	
   419		ret = wilc_set_join_req(vif, bss->bssid, sme->ie, sme->ie_len);
   420		if (ret) {
   421			netdev_err(dev, "wilc_set_join_req(): Error\n");
   422			ret = -ENOENT;
   423			if (vif->iftype != WILC_CLIENT_MODE)
   424				vif->wilc->sta_ch = WILC_INVALID_CHANNEL;
   425			wilc_wlan_set_bssid(dev, NULL, WILC_STATION_MODE);
   426			wfi_drv->conn_info.conn_result = NULL;
   427			kfree(join_params);
   428			goto out_put_bss;
   429		}
   430		kfree(join_params);
   431		vif->bss = bss;
   432		cfg80211_put_bss(wiphy, bss);
   433		return 0;
   434	
   435	out_put_bss:
   436		cfg80211_put_bss(wiphy, bss);
   437	
   438	out_error:
   439		vif->connecting = false;
   440		return ret;
   441	}
   442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
