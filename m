Return-Path: <linux-kernel+bounces-13226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB1820165
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3245A1F22E53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004114291;
	Fri, 29 Dec 2023 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH/r6IL/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096714281;
	Fri, 29 Dec 2023 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703881421; x=1735417421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhcP1s+xHtIa280S64WwBQn6834wuT45tSu7NBxVVpI=;
  b=RH/r6IL/EWMZuo5mT/F7MaIIjabB82Wsha+6plMRPh+3ElF3Sf+khGce
   qb7dzOEVu42PZkQqnbR5egSVM54OH/t6Yvl6ST+lMBVrQWnCvI9XKphUR
   LKiq3lN9Z2TY3T65JAk0QkJUMxqKA1T6ddPLj1PniMzqYVpc9hLt1lQOq
   NK0RYdC87f6PgNbTQj0xfTfP3YosALGBOzG7ceoh0wDSeURjNj9JAEHjc
   BFL/snYr9X/ox3PGNP/hKpl2v842zVR7iTV61XyuGXsTyvGbgsvlZHLmj
   2k2/zQG0sTXHVVFWnbeDcrdoT/RoLpJJylcZPLWIBnhouGwhLxqsqb214
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="10057228"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="10057228"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 12:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="778876607"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="778876607"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2023 12:23:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJJOI-000HnN-28;
	Fri, 29 Dec 2023 20:23:34 +0000
Date: Sat, 30 Dec 2023 04:22:42 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 3/3] clk: sprd: add support for UMS9620
Message-ID: <202312300411.tYRuXlfZ-lkp@intel.com>
References: <20231229085156.1490233-4-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229085156.1490233-4-chunyan.zhang@unisoc.com>

Hi Chunyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/dt-bindings-clk-sprd-Add-UMS9620-support/20231229-165718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20231229085156.1490233-4-chunyan.zhang%40unisoc.com
patch subject: [PATCH 3/3] clk: sprd: add support for UMS9620
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231230/202312300411.tYRuXlfZ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300411.tYRuXlfZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300411.tYRuXlfZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sprd/ums9620-clk.c:1671:37: warning: unused variable 'pmu_26m_parents' [-Wunused-const-variable]
    1671 | static const struct clk_parent_data pmu_26m_parents[] = {
         |                                     ^~~~~~~~~~~~~~~
>> drivers/clk/sprd/ums9620-clk.c:2642:37: warning: unused variable 'depth_parents' [-Wunused-const-variable]
    2642 | static const struct clk_parent_data depth_parents[] = {
         |                                     ^~~~~~~~~~~~~
   2 warnings generated.


vim +/pmu_26m_parents +1671 drivers/clk/sprd/ums9620-clk.c

  1451	
  1452	/* aon apb clks */
  1453	static const struct clk_parent_data aon_apb_parents[] = {
  1454		{ .hw = &rco_100m_4m.hw },
  1455		{ .hw = &clk_4m3.hw },
  1456		{ .hw = &clk_13m.hw },
  1457		{ .hw = &rco_100m_25m.hw },
  1458		{ .fw_name = "ext-26m" },
  1459		{ .fw_name = "rco-100m" },
  1460		{ .hw = &tgpll_128m.hw },
  1461		{ .hw = &tgpll_153m6.hw },
  1462	};
  1463	static SPRD_COMP_CLK_DATA_OFFSET(aon_apb, "aon-apb", aon_apb_parents, 0x28,
  1464				    0, 3, -4, 0, 2, 0);
  1465	
  1466	static const struct clk_parent_data adi_parents[] = {
  1467		{ .hw = &rco_100m_4m.hw },
  1468		{ .fw_name = "ext-26m" },
  1469		{ .hw = &rco_100m_25m.hw },
  1470		{ .hw = &tgpll_38m4.hw },
  1471		{ .hw = &tgpll_51m2.hw },
  1472	};
  1473	static SPRD_MUX_CLK_DATA(adi, "adi", adi_parents, 0x34,
  1474			    0, 3, UMS9620_MUX_FLAG);
  1475	
  1476	static const struct clk_parent_data pwm_parents[] = {
  1477		{ .fw_name = "ext-32k" },
  1478		{ .fw_name = "ext-26m" },
  1479		{ .hw = &rco_100m_4m.hw },
  1480		{ .hw = &rco_100m_25m.hw },
  1481		{ .hw = &tgpll_48m.hw },
  1482	};
  1483	static SPRD_MUX_CLK_DATA(pwm0, "pwm0", pwm_parents, 0x40,
  1484			    0, 3, UMS9620_MUX_FLAG);
  1485	static SPRD_MUX_CLK_DATA(pwm1, "pwm1", pwm_parents, 0x4c,
  1486			    0, 3, UMS9620_MUX_FLAG);
  1487	static SPRD_MUX_CLK_DATA(pwm2, "pwm2", pwm_parents, 0x58,
  1488			    0, 3, UMS9620_MUX_FLAG);
  1489	static SPRD_MUX_CLK_DATA(pwm3, "pwm3", pwm_parents, 0x64,
  1490			    0, 3, UMS9620_MUX_FLAG);
  1491	
  1492	static const struct clk_parent_data efuse_parents[] = {
  1493		{ .hw = &rco_100m_25m.hw },
  1494		{ .fw_name = "ext-26m" },
  1495	};
  1496	static SPRD_MUX_CLK_DATA(efuse, "efuse", efuse_parents, 0x70,
  1497			    0, 1, UMS9620_MUX_FLAG);
  1498	
  1499	static const struct clk_parent_data uart_parents[] = {
  1500		{ .hw = &rco_100m_4m.hw },
  1501		{ .fw_name = "ext-26m" },
  1502		{ .hw = &tgpll_48m.hw },
  1503		{ .hw = &tgpll_51m2.hw },
  1504		{ .hw = &tgpll_96m.hw },
  1505		{ .fw_name = "rco-100m" },
  1506		{ .hw = &tgpll_128m.hw },
  1507	};
  1508	static SPRD_MUX_CLK_DATA(uart0, "uart0", uart_parents, 0x7c,
  1509			    0, 3, UMS9620_MUX_FLAG);
  1510	static SPRD_MUX_CLK_DATA(uart1, "uart1", uart_parents, 0x88,
  1511			    0, 3, UMS9620_MUX_FLAG);
  1512	static SPRD_MUX_CLK_DATA(uart2, "uart2", uart_parents, 0x94,
  1513			    0, 3, UMS9620_MUX_FLAG);
  1514	
  1515	static const struct clk_parent_data thm_parents[] = {
  1516		{ .fw_name = "ext-32k" },
  1517		{ .hw = &clk_250k.hw },
  1518	};
  1519	static SPRD_MUX_CLK_DATA(thm0, "thm0", thm_parents, 0xc4,
  1520			    0, 1, UMS9620_MUX_FLAG);
  1521	static SPRD_MUX_CLK_DATA(thm1, "thm1", thm_parents, 0xd0,
  1522			    0, 1, UMS9620_MUX_FLAG);
  1523	static SPRD_MUX_CLK_DATA(thm2, "thm2", thm_parents, 0xdc,
  1524			    0, 1, UMS9620_MUX_FLAG);
  1525	static SPRD_MUX_CLK_DATA(thm3, "thm3", thm_parents, 0xe8,
  1526			    0, 1, UMS9620_MUX_FLAG);
  1527	
  1528	static const struct clk_parent_data aon_iis_parents[] = {
  1529		{ .fw_name = "ext-26m" },
  1530		{ .hw = &tgpll_128m.hw },
  1531		{ .hw = &tgpll_153m6.hw },
  1532	};
  1533	static SPRD_MUX_CLK_DATA(aon_iis, "aon-iis", aon_iis_parents, 0x118,
  1534			    0, 2, UMS9620_MUX_FLAG);
  1535	
  1536	static const struct clk_parent_data scc_parents[] = {
  1537		{ .fw_name = "ext-26m" },
  1538		{ .hw = &tgpll_48m.hw },
  1539		{ .hw = &tgpll_51m2.hw },
  1540		{ .hw = &tgpll_96m.hw },
  1541	};
  1542	static SPRD_MUX_CLK_DATA(scc, "scc", scc_parents, 0x124,
  1543			    0, 2, UMS9620_MUX_FLAG);
  1544	
  1545	static const struct clk_parent_data apcpu_dap_parents[] = {
  1546		{ .fw_name = "ext-26m" },
  1547		{ .hw = &rco_100m_4m.hw },
  1548		{ .hw = &tgpll_76m8.hw },
  1549		{ .fw_name = "rco-100m" },
  1550		{ .hw = &tgpll_128m.hw },
  1551		{ .hw = &tgpll_153m6.hw },
  1552	};
  1553	static SPRD_MUX_CLK_DATA(apcpu_dap, "apcpu-dap", apcpu_dap_parents, 0x130,
  1554			    0, 3, UMS9620_MUX_FLAG);
  1555	
  1556	static const struct clk_parent_data apcpu_ts_parents[] = {
  1557		{ .fw_name = "ext-32k" },
  1558		{ .fw_name = "ext-26m" },
  1559		{ .hw = &tgpll_128m.hw },
  1560		{ .hw = &tgpll_153m6.hw },
  1561	};
  1562	static SPRD_MUX_CLK_DATA(apcpu_ts, "apcpu-ts", apcpu_ts_parents, 0x13c,
  1563			    0, 2, UMS9620_MUX_FLAG);
  1564	
  1565	static const struct clk_parent_data debug_ts_parents[] = {
  1566		{ .fw_name = "ext-26m" },
  1567		{ .hw = &tgpll_76m8.hw },
  1568		{ .hw = &tgpll_128m.hw },
  1569		{ .hw = &tgpll_192m.hw },
  1570	};
  1571	static SPRD_MUX_CLK_DATA(debug_ts, "debug-ts", debug_ts_parents, 0x148,
  1572			    0, 2, UMS9620_MUX_FLAG);
  1573	
  1574	static const struct clk_parent_data pri_sbi_parents[] = {
  1575		{ .fw_name = "ext-26m" },
  1576		{ .fw_name = "ext-52m" },
  1577		{ .hw = &tgpll_96m.hw },
  1578	};
  1579	static SPRD_MUX_CLK_DATA(pri_sbi, "pri-sbi", pri_sbi_parents, 0x154,
  1580			    0, 2, UMS9620_MUX_FLAG);
  1581	
  1582	static const struct clk_parent_data xo_sel_parents[] = {
  1583		{ .fw_name = "ext-26m" },
  1584		{ .fw_name = "ext-52m" },
  1585	};
  1586	static SPRD_MUX_CLK_DATA(xo_sel, "xo-sel", xo_sel_parents, 0x160,
  1587			    0, 1, UMS9620_MUX_FLAG);
  1588	
  1589	static const struct clk_parent_data rfti_lth_parents[] = {
  1590		{ .fw_name = "ext-26m" },
  1591		{ .fw_name = "ext-52m" },
  1592	};
  1593	static SPRD_MUX_CLK_DATA(rfti_lth, "rfti-lth", rfti_lth_parents, 0x16c,
  1594			    0, 1, UMS9620_MUX_FLAG);
  1595	
  1596	static const struct clk_parent_data afc_lth_parents[] = {
  1597		{ .fw_name = "ext-26m" },
  1598		{ .fw_name = "ext-52m" },
  1599	};
  1600	static SPRD_MUX_CLK_DATA(afc_lth, "afc-lth", afc_lth_parents, 0x178,
  1601			    0, 1, UMS9620_MUX_FLAG);
  1602	
  1603	static SPRD_DIV_CLK_FW_NAME(rco100m_fdk, "rco100m-fdk", "rco-100m", 0x18c,
  1604			    0, 6, 0);
  1605	
  1606	static SPRD_DIV_CLK_FW_NAME(rco60m_fdk, "rco60m-fdk", "rco-60m", 0x1a4,
  1607			    0, 5, 0);
  1608	static const struct clk_parent_data rco6m_ref_parents[] = {
  1609		{ .hw = &clk_16k.hw },
  1610		{ .hw = &clk_2m.hw },
  1611	};
  1612	static SPRD_COMP_CLK_DATA_OFFSET(rco6m_ref, "rco6m-ref", rco6m_ref_parents, 0x1b4,
  1613				    0, 1, -4, 0, 5, 0);
  1614	static SPRD_DIV_CLK_FW_NAME(rco6m_fdk, "rco6m-fdk", "rco-6m", 0x1bc,
  1615			    0, 9, 0);
  1616	
  1617	static const struct clk_parent_data djtag_tck_parents[] = {
  1618		{ .hw = &rco_100m_4m.hw },
  1619		{ .fw_name = "ext-26m" },
  1620	};
  1621	static SPRD_MUX_CLK_DATA(djtag_tck, "djtag-tck", djtag_tck_parents, 0x1cc,
  1622			    0, 1, UMS9620_MUX_FLAG);
  1623	
  1624	static const struct clk_parent_data aon_tmr_parents[] = {
  1625		{ .hw = &rco_100m_4m.hw },
  1626		{ .hw = &rco_100m_25m.hw },
  1627		{ .fw_name = "ext-26m" },
  1628	};
  1629	static SPRD_MUX_CLK_DATA(aon_tmr, "aon-tmr", aon_tmr_parents, 0x1f0,
  1630			    0, 2, UMS9620_MUX_FLAG);
  1631	
  1632	static const struct clk_parent_data aon_pmu_parents[] = {
  1633		{ .fw_name = "ext-32k" },
  1634		{ .hw = &rco_100m_4m.hw },
  1635		{ .hw = &clk_4m3.hw },
  1636		{ .hw = &rco_60m_4m.hw },
  1637	};
  1638	static SPRD_MUX_CLK_DATA(aon_pmu, "aon-pmu", aon_pmu_parents, 0x208,
  1639			    0, 2, UMS9620_MUX_FLAG);
  1640	
  1641	static const struct clk_parent_data debounce_parents[] = {
  1642		{ .fw_name = "ext-32k" },
  1643		{ .hw = &rco_100m_4m.hw },
  1644		{ .hw = &rco_100m_25m.hw },
  1645		{ .fw_name = "ext-26m" },
  1646		{ .hw = &rco_60m_4m.hw },
  1647		{ .hw = &rco_60m_20m.hw },
  1648	};
  1649	static SPRD_MUX_CLK_DATA(debounce, "debounce", debounce_parents, 0x214,
  1650			    0, 3, UMS9620_MUX_FLAG);
  1651	
  1652	static const struct clk_parent_data apcpu_pmu_parents[] = {
  1653		{ .fw_name = "ext-26m" },
  1654		{ .hw = &tgpll_76m8.hw },
  1655		{ .fw_name = "rco-60m" },
  1656		{ .fw_name = "rco-100m" },
  1657		{ .hw = &tgpll_128m.hw },
  1658	};
  1659	static SPRD_MUX_CLK_DATA(apcpu_pmu, "apcpu-pmu", apcpu_pmu_parents, 0x220,
  1660			    0, 3, UMS9620_MUX_FLAG);
  1661	
  1662	static const struct clk_parent_data top_dvfs_parents[] = {
  1663		{ .fw_name = "ext-26m" },
  1664		{ .hw = &tgpll_96m.hw },
  1665		{ .fw_name = "rco-100m" },
  1666		{ .hw = &tgpll_128m.hw },
  1667	};
  1668	static SPRD_MUX_CLK_DATA(top_dvfs, "top-dvfs", top_dvfs_parents, 0x22c,
  1669			    0, 2, UMS9620_MUX_FLAG);
  1670	
> 1671	static const struct clk_parent_data pmu_26m_parents[] = {
  1672		{ .hw = &rco_100m_20m.hw },
  1673		{ .fw_name = "ext-26m" },
  1674		{ .hw = &rco_60m_20m.hw },
  1675	};
  1676	static SPRD_MUX_CLK_DATA(pmu_26m, "pmu-26m", aon_pmu_parents, 0x238,
  1677			    0, 2, UMS9620_MUX_FLAG);
  1678	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

