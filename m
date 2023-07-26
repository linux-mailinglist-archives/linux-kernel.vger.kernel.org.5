Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C297642B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGZXru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGZXrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:47:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35BAA;
        Wed, 26 Jul 2023 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690415267; x=1721951267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9UOzZVHUyoZOolVH4sgzZgNDeRsx2SzYjy5By3+dfY=;
  b=dVub8iKZH5pox21J0MdsY+osfW02fF3Zhwe0d6vgm0/V4YoEjjWdy0EN
   +j9eHi3sp6XQ+R/mczohBx5b70YSCSYM3vSSnNzgDpxWvAnmt0bLPQ5ip
   3Jsravd1MKdnXxslw3dg/ErF9bmXFenuHPX42Fr+sNUaMGpLoCJTeMLQR
   fysS7QWx35XsiYyY20g6tixNuTyL2MZYPYMrXiCuOwEAjCXhNo2GfoezQ
   GpIrq0slUoDf7uQFmD540p4cb76AQxHcl03QfNsm4GgBNNHJfHkr1i4eN
   cgH8wIlQ25KXtQ9Xq4As4GD0laKrggxhyof7NecjGWwVuzl80OtK0dewx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="348439894"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="348439894"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792084731"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="792084731"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 16:47:39 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOoEF-0001S6-0N;
        Wed, 26 Jul 2023 23:47:39 +0000
Date:   Thu, 27 Jul 2023 07:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, vladimir.oltean@nxp.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, michael.chan@broadcom.com, rajur@chelsio.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, taras.chornyi@plvision.eu, saeedm@nvidia.com,
        leon@kernel.org, idosch@nvidia.com, petrm@nvidia.com,
        horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH net-next] dissector: Use 64bits for used_keys
Message-ID: <202307270742.fr5uXCME-lkp@intel.com>
References: <20230726131223.1230526-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726131223.1230526-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ratheesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/dissector-Use-64bits-for-used_keys/20230726-211458
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230726131223.1230526-1-rkannoth%40marvell.com
patch subject: [PATCH net-next] dissector: Use 64bits for used_keys
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230727/202307270742.fr5uXCME-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270742.fr5uXCME-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307270742.fr5uXCME-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:4:
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c: In function 'hclge_parse_cls_flower':
>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:7325:43: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    7325 |                 dev_err(&hdev->pdev->dev, "unsupported key set: %#lx\n",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:7325:17: note: in expansion of macro 'dev_err'
    7325 |                 dev_err(&hdev->pdev->dev, "unsupported key set: %#lx\n",
         |                 ^~~~~~~
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:7325:68: note: format string is defined here
    7325 |                 dev_err(&hdev->pdev->dev, "unsupported key set: %#lx\n",
         |                                                                 ~~~^
         |                                                                    |
         |                                                                    long unsigned int
         |                                                                 %#llx
--
   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/refcount.h:96,
                    from drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c:4:
   drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c: In function 'mlx5_ct_fs_smfs_ct_validate_flow_rule':
>> drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c:15:32: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long long unsigned int' [-Wformat=]
      15 |         netdev_dbg(fs->netdev, "ct_fs_smfs debug: " fmt "\n", ##args)
         |                                ^~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:275:9: note: in expansion of macro '_dynamic_func_call'
     275 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:9: note: in expansion of macro 'dynamic_netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c:15:9: note: in expansion of macro 'netdev_dbg'
      15 |         netdev_dbg(fs->netdev, "ct_fs_smfs debug: " fmt "\n", ##args)
         |         ^~~~~~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c:255:17: note: in expansion of macro 'ct_dbg'
     255 |                 ct_dbg("rule uses unexpected dissectors (0x%016x)",
         |                 ^~~~~~


vim +7325 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c

  7309	
  7310	static int hclge_parse_cls_flower(struct hclge_dev *hdev,
  7311					  struct flow_cls_offload *cls_flower,
  7312					  struct hclge_fd_rule *rule)
  7313	{
  7314		struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
  7315		struct flow_dissector *dissector = flow->match.dissector;
  7316	
  7317		if (dissector->used_keys &
  7318		    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
  7319		      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
  7320		      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
  7321		      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
  7322		      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
  7323		      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
  7324		      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
> 7325			dev_err(&hdev->pdev->dev, "unsupported key set: %#lx\n",
  7326				dissector->used_keys);
  7327			return -EOPNOTSUPP;
  7328		}
  7329	
  7330		hclge_get_cls_key_basic(flow, rule);
  7331		hclge_get_cls_key_mac(flow, rule);
  7332		hclge_get_cls_key_vlan(flow, rule);
  7333		hclge_get_cls_key_ip(flow, rule);
  7334		hclge_get_cls_key_port(flow, rule);
  7335	
  7336		return 0;
  7337	}
  7338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
