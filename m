Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214667D8C05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjJZXC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjJZXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:02:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92D1AB;
        Thu, 26 Oct 2023 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698361372; x=1729897372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dp8Mxkor4+0vFNhT/6lhmMk+dPa03eQZ6dKy3m3Bw6A=;
  b=Bhkc4iIRKIpf2l3Yqq4XWTmrurUYZ4w5SPLn8aB0L5g38jL0h6vngLrC
   G1ogsgpp3XjKgtQJGX29NrfgIeJ0tIEOc4gMSE59934nyxvgRsv0sGtF7
   hhvMT6C2ezPnXu+vAbnrIELpatOLNMa0w/tC2ONUjKLCY77NOuKmfgE5F
   xBdIGGLv32hXzNLcA56NUW4sUUu2LDJGq67vJE+0/Gy7Cs7l37/BNe/HO
   7Nz2ekMdsNXjV/J4G6zL3VajZEDgtXTz8sJhRxdo4B8shAPpMgpCmUAEK
   xWr+az4q6NOYkXje/ddX7xxHDiWBGFnveFrTWa/R0Zqox6IliIiUO4JlP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378035414"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="378035414"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="1090731883"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="1090731883"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2023 16:02:48 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw9NG-000AD2-1b;
        Thu, 26 Oct 2023 23:02:46 +0000
Date:   Fri, 27 Oct 2023 07:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <202310270618.i3W3qKiJ-lkp@intel.com>
References: <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094327.565297-6-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Pirea-NXP-OSS/net-macsec-move-sci_to_cpu-to-macsec-header/20231023-174539
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231023094327.565297-6-radu-nicolae.pirea%40oss.nxp.com
patch subject: [PATCH net-next v8 5/7] net: phy: nxp-c45-tja11xx: add MACsec support
config: x86_64-randconfig-103-20231026 (https://download.01.org/0day-ci/archive/20231027/202310270618.i3W3qKiJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270618.i3W3qKiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270618.i3W3qKiJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/phy/nxp-c45-tja11xx-macsec.o: in function `nxp_c45_handle_macsec_interrupt':
>> drivers/net/phy/nxp-c45-tja11xx-macsec.c:1330: undefined reference to `macsec_pn_wrapped'


vim +1330 drivers/net/phy/nxp-c45-tja11xx-macsec.c

  1299	
  1300	void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
  1301					     irqreturn_t *ret)
  1302	{
  1303		struct nxp_c45_phy *priv = phydev->priv;
  1304		struct nxp_c45_secy *pos, *tmp;
  1305		struct nxp_c45_sa *sa;
  1306		u8 encoding_sa;
  1307		int secy_id;
  1308		u32 reg = 0;
  1309	
  1310		if (!priv->macsec)
  1311			return;
  1312	
  1313		do {
  1314			nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
  1315			if (!reg)
  1316				return;
  1317	
  1318			secy_id = MACSEC_REG_SIZE - ffs(reg);
  1319			list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list,
  1320						 list)
  1321				if (pos->secy_id == secy_id)
  1322					break;
  1323	
  1324			encoding_sa = pos->secy->tx_sc.encoding_sa;
  1325			phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
  1326				   pos->secy_id, encoding_sa);
  1327	
  1328			sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
  1329			if (!IS_ERR(sa))
> 1330				macsec_pn_wrapped(pos->secy, sa->sa);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
