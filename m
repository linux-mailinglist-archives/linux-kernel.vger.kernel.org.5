Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE67E1280
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjKEIBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:01:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96DAEE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699171262; x=1730707262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9uTbg31APiLQYULTXy9LkmsBSutHYWrABXH52vn/yo=;
  b=CMPWeF3jkGmdsqrZOcUpnrR5KjIdNGR0AkdP9vEbINAguJLcV5AfVT6Q
   puRzmXUIa7wAJksgIwg+/66IZMRpmxb96brOphGhwtayG637xvhX1mEaq
   hsrjTcDXCdLTejiORybc7iCSwnvcJPYJf3hVs07AHHJyNNh4F+isrSp+f
   Y14UXQwqtjlAK62OnCHeM0b0fsp2fCOhJoETYq70afZnSTTEOEAichVP+
   YUQptqhE2qUclW2nkJYSZithI12DX3Kt3ekGzyEaGncadgyyI+vTX7sCE
   QZRmAScb/t1S3gdsQ7ra9F9ZEDmAAUEOj8cAjZGmEE+X+gAAfJ1xv1suI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="388953181"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="388953181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 01:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009238058"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="1009238058"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2023 01:00:55 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzY3x-0005Am-1J;
        Sun, 05 Nov 2023 08:00:53 +0000
Date:   Sun, 5 Nov 2023 16:00:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202311051507.6ckT59OU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: c5b331d4f550fb78bf1a553b2517616a5ea913d6 wifi: wilc1000: add WPA3 SAE support
date:   1 year, 5 months ago
config: i386-randconfig-063-20231026 (https://download.01.org/0day-ci/archive/20231105/202311051507.6ckT59OU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051507.6ckT59OU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051507.6ckT59OU-lkp@intel.com/

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
