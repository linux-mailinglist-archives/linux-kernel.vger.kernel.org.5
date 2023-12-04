Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD30803A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjLDQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjLDQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:27:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98FDFD;
        Mon,  4 Dec 2023 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701707243; x=1733243243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYTA0/nyNB/hTWrk6pNHEYOU+FELVxtQJO0zY6r4OD0=;
  b=kpUbqTu/78WLPKDVOwgLc9wai53b/iFhHmYoGh6TVQiv3GgGjm+QYDHC
   i997MRaaezT9mibrv1WjcyqN4f0EodRmsokOwhIRowmLnehpb5vwFBKV6
   6yHblGvlYvMAIl6D5G3JOnXSZRkjcXUziipXIdCyhWpCnL2jEjGw/1dMF
   iXWoO9lsy/mPJ+cwfIk9oSkIORTZ1tI20hQyciDVZyi/wJc+1TsS4Bi/I
   H1sKyhrdghZZ6XmWTIIAjo+yvd/kIax0SKUiGIZ2O17N3meF7VTWdoKoa
   /F7ABclLCimD9n9fUyyvjbZ4a3o+vRwC7mq53vhQymJ83+nj4TBU8XExj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12473912"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="12473912"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836637120"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836637120"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2023 08:27:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rABmt-0007u3-34;
        Mon, 04 Dec 2023 16:27:15 +0000
Date:   Tue, 5 Dec 2023 00:26:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 5/8] net: qualcomm: ipqess: add bridge
 offloading features to the IPQESS driver
Message-ID: <202312042338.JK8rFU7w-lkp@intel.com>
References: <20231114105600.1012056-6-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-6-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/dt-bindings-net-Introduce-the-Qualcomm-IPQESS-Ethernet-switch/20231114-185953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231114105600.1012056-6-romain.gantois%40bootlin.com
patch subject: [PATCH net-next v3 5/8] net: qualcomm: ipqess: add bridge offloading features to the IPQESS driver
config: arc-randconfig-r112-20231116 (https://download.01.org/0day-ci/archive/20231204/202312042338.JK8rFU7w-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312042338.JK8rFU7w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312042338.JK8rFU7w-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/qca/qca8k-8xxx.c:1982:5: sparse: sparse: symbol 'qca8k_dsa_port_fdb_dump' was not declared. Should it be static?
>> drivers/net/dsa/qca/qca8k-8xxx.c:1988:6: sparse: sparse: symbol 'qca8k_dsa_port_stp_state_set' was not declared. Should it be static?
>> drivers/net/dsa/qca/qca8k-8xxx.c:1995:6: sparse: sparse: symbol 'qca8k_dsa_port_fast_age' was not declared. Should it be static?
>> drivers/net/dsa/qca/qca8k-8xxx.c:2000:5: sparse: sparse: symbol 'qca8k_dsa_set_ageing_time' was not declared. Should it be static?
>> drivers/net/dsa/qca/qca8k-8xxx.c:2005:5: sparse: sparse: symbol 'qca8k_dsa_port_vlan_filtering' was not declared. Should it be static?
>> drivers/net/dsa/qca/qca8k-8xxx.c:2012:5: sparse: sparse: symbol 'qca8k_dsa_vlan_add' was not declared. Should it be static?

vim +/qca8k_dsa_port_fdb_dump +1982 drivers/net/dsa/qca/qca8k-8xxx.c

  1981	
> 1982	int qca8k_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
  1983				    dsa_fdb_dump_cb_t *cb, void *data)
  1984	{
  1985		return qca8k_port_fdb_dump(ds->priv, port, cb, data);
  1986	}
  1987	
> 1988	void qca8k_dsa_port_stp_state_set(struct dsa_switch *ds, int port,
  1989					  u8 state)
  1990	{
  1991		qca8k_port_stp_state_set(ds->priv, port, state,
  1992					 dsa_to_port(ds, port)->learning, true);
  1993	}
  1994	
> 1995	void qca8k_dsa_port_fast_age(struct dsa_switch *ds, int port)
  1996	{
  1997		qca8k_port_fast_age(ds->priv, port);
  1998	}
  1999	
> 2000	int qca8k_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
  2001	{
  2002		return qca8k_set_ageing_time(ds->priv, msecs);
  2003	}
  2004	
> 2005	int qca8k_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
  2006					  bool vlan_filtering,
  2007					  struct netlink_ext_ack *extack)
  2008	{
  2009		return qca8k_port_vlan_filtering(ds->priv, port, vlan_filtering);
  2010	}
  2011	
> 2012	int qca8k_dsa_vlan_add(struct dsa_switch *ds, int port,
  2013			       const struct switchdev_obj_port_vlan *vlan,
  2014			       struct netlink_ext_ack *extack)
  2015	{
  2016		return qca8k_port_vlan_add(ds->priv, port, vlan, extack);
  2017	}
  2018	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
