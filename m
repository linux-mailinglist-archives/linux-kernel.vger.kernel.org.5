Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D17CF611
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjJSLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbjJSLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:04:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0D119;
        Thu, 19 Oct 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697713460; x=1729249460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zD1Nbo0e2j9JFXzrsBuYue3Ao3OZSe9Wd/XfAWure3M=;
  b=dty7tVuWl1I/Wmy7bYTbIkqUCrxcq3ids4M/HdvS4IUlYIkvlmNeLr7X
   ea9vKqtPT8Oz8EevCxXd7JRUMcbSuIJ0PV282VFg2LWWdxJopO7hkBghB
   JRyTY2vFeyl/Cgqw2CjoNcU0DvN9gydVDnBYtrfWll9/sjESy0VjribK6
   2+GNRpv/cwEcx+1pnOBfd/RgBNHqKqwRXNwkCf0+2dj1bD6ATDhG3abDY
   AvmdJa/B08w+H1AWvQQs1jtMHEcDbU5e0/wOvjpHMUJP0XRAa70QDre0a
   2rntuDnazqzyekE93ck0t8dBVIpbV7/SUobz7dAJeEXwahcnR46BpAkGn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450443926"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="450443926"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 04:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="4922323"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2023 04:04:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtQov-00022e-1g;
        Thu, 19 Oct 2023 11:04:05 +0000
Date:   Thu, 19 Oct 2023 19:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <202310191806.NjLsejwM-lkp@intel.com>
References: <20231013042229.3954527-5-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013042229.3954527-5-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a7d272979d3a89b117ca2c547dc8a465c4f28635]

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Shah/dt-bindings-remoteproc-add-Tightly-Coupled-Memory-TCM-bindings/20231017-120805
base:   a7d272979d3a89b117ca2c547dc8a465c4f28635
patch link:    https://lore.kernel.org/r/20231013042229.3954527-5-tanmay.shah%40amd.com
patch subject: [PATCH v6 4/4] remoteproc: zynqmp: parse TCM from device tree
config: arm64-randconfig-002-20231019 (https://download.01.org/0day-ci/archive/20231019/202310191806.NjLsejwM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191806.NjLsejwM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191806.NjLsejwM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/remoteproc/xlnx_r5_remoteproc.c: In function 'zynqmp_r5_get_tcm_node_from_dt':
>> drivers/remoteproc/xlnx_r5_remoteproc.c:1162:28: warning: array subscript 'struct mem_bank_data[0]' is partly outside array bounds of 'unsigned char[8]' [-Warray-bounds=]
    1162 |                         tcm->da = (u32)abs_addr;
         |                            ^~
   In file included from include/linux/dma-mapping.h:8,
                    from drivers/remoteproc/xlnx_r5_remoteproc.c:8:
   In function 'devm_kzalloc',
       inlined from 'zynqmp_r5_get_tcm_node_from_dt' at drivers/remoteproc/xlnx_r5_remoteproc.c:1143:10:
   include/linux/device.h:314:16: note: object of size 8 allocated by 'devm_kmalloc'
     314 |         return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/xlnx_r5_remoteproc.c: In function 'zynqmp_r5_get_tcm_node_from_dt':
   drivers/remoteproc/xlnx_r5_remoteproc.c:1163:28: warning: array subscript 'struct mem_bank_data[0]' is partly outside array bounds of 'unsigned char[8]' [-Warray-bounds=]
    1163 |                         tcm->size = (u32)size;
         |                            ^~
   In function 'devm_kzalloc',
       inlined from 'zynqmp_r5_get_tcm_node_from_dt' at drivers/remoteproc/xlnx_r5_remoteproc.c:1143:10:
   include/linux/device.h:314:16: note: object of size 8 allocated by 'devm_kmalloc'
     314 |         return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/xlnx_r5_remoteproc.c: In function 'zynqmp_r5_get_tcm_node_from_dt':
   drivers/remoteproc/xlnx_r5_remoteproc.c:1172:28: warning: array subscript 'struct mem_bank_data[0]' is partly outside array bounds of 'unsigned char[8]' [-Warray-bounds=]
    1172 |                         tcm->addr = (u32)res->start;
         |                            ^~
   In function 'devm_kzalloc',
       inlined from 'zynqmp_r5_get_tcm_node_from_dt' at drivers/remoteproc/xlnx_r5_remoteproc.c:1143:10:
   include/linux/device.h:314:16: note: object of size 8 allocated by 'devm_kmalloc'
     314 |         return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/xlnx_r5_remoteproc.c: In function 'zynqmp_r5_get_tcm_node_from_dt':
   drivers/remoteproc/xlnx_r5_remoteproc.c:1173:28: warning: array subscript 'struct mem_bank_data[0]' is partly outside array bounds of 'unsigned char[8]' [-Warray-bounds=]
    1173 |                         tcm->bank_name = (char *)res->name;
         |                            ^~
   In function 'devm_kzalloc',
       inlined from 'zynqmp_r5_get_tcm_node_from_dt' at drivers/remoteproc/xlnx_r5_remoteproc.c:1143:10:
   include/linux/device.h:314:16: note: object of size 8 allocated by 'devm_kmalloc'
     314 |         return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:17:
   drivers/remoteproc/xlnx_r5_remoteproc.c: In function 'zynqmp_r5_get_tcm_node_from_dt':
   drivers/remoteproc/xlnx_r5_remoteproc.c:1174:74: warning: array subscript 'struct mem_bank_data[0]' is partly outside array bounds of 'unsigned char[8]' [-Warray-bounds=]
    1174 |                         res = devm_request_mem_region(dev, tcm->addr, tcm->size,
         |                                                                          ^~
   include/linux/ioport.h:306:63: note: in definition of macro 'devm_request_mem_region'
     306 |         __devm_request_region(dev, &iomem_resource, (start), (n), (name))
         |                                                               ^
   In function 'devm_kzalloc',
       inlined from 'zynqmp_r5_get_tcm_node_from_dt' at drivers/remoteproc/xlnx_r5_remoteproc.c:1143:10:
   include/linux/device.h:314:16: note: object of size 8 allocated by 'devm_kmalloc'
     314 |         return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1162 drivers/remoteproc/xlnx_r5_remoteproc.c

  1108	
  1109	static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
  1110	{
  1111		struct zynqmp_r5_core *r5_core;
  1112		int i, j, tcm_bank_count, ret;
  1113		struct platform_device *cpdev;
  1114		struct mem_bank_data *tcm;
  1115		struct device_node *np;
  1116		struct resource *res;
  1117		u64 abs_addr, size;
  1118		struct device *dev;
  1119	
  1120		for (i = 0; i < cluster->core_count; i++) {
  1121			r5_core = cluster->r5_cores[i];
  1122			dev = r5_core->dev;
  1123			np = dev_of_node(dev);
  1124	
  1125			/* we have address cell 2 and size cell as 2 */
  1126			ret = of_property_count_elems_of_size(np, "reg",
  1127							      4 * sizeof(u32));
  1128			if (ret <= 0) {
  1129				dev_err(dev, "can't get reg property err %d\n", ret);
  1130				return -EINVAL;
  1131			}
  1132	
  1133			tcm_bank_count = ret;
  1134	
  1135			r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
  1136							  sizeof(struct mem_bank_data *),
  1137							  GFP_KERNEL);
  1138			if (!r5_core->tcm_banks)
  1139				ret = -ENOMEM;
  1140	
  1141			r5_core->tcm_bank_count = tcm_bank_count;
  1142			for (j = 0; j < tcm_bank_count; j++) {
  1143				tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data *),
  1144						   GFP_KERNEL);
  1145				if (!tcm)
  1146					return -ENOMEM;
  1147	
  1148				r5_core->tcm_banks[j] = tcm;
  1149	
  1150				/* get tcm address without translation */
  1151				ret = of_property_read_reg(np, j, &abs_addr, &size);
  1152				if (ret) {
  1153					dev_err(dev, "failed to get reg property\n");
  1154					return ret;
  1155				}
  1156	
  1157				/*
  1158				 * remote processor can address only 32 bits
  1159				 * so convert 64-bits into 32-bits. This will discard
  1160				 * any unwanted upper 32-bits.
  1161				 */
> 1162				tcm->da = (u32)abs_addr;
  1163				tcm->size = (u32)size;
  1164	
  1165				cpdev = to_platform_device(dev);
  1166				res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
  1167				if (!res) {
  1168					dev_err(dev, "failed to get tcm resource\n");
  1169					return -EINVAL;
  1170				}
  1171	
  1172				tcm->addr = (u32)res->start;
  1173				tcm->bank_name = (char *)res->name;
  1174				res = devm_request_mem_region(dev, tcm->addr, tcm->size,
  1175							      tcm->bank_name);
  1176				if (!res) {
  1177					dev_err(dev, "failed to request tcm resource\n");
  1178					return -EINVAL;
  1179				}
  1180			}
  1181		}
  1182	
  1183		return 0;
  1184	}
  1185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
