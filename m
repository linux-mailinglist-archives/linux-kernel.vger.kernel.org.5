Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069EA79C18E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjILBST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjILBSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:18:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292E770C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694472257; x=1726008257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+luhMqJzd5t2PX9yoJxMR2B4a8hOtjp3kpbTrBssBYE=;
  b=f2yi3KNbkpVMhrF0dI0E21V/P5UzvZCjUSd/tzjercJStREbAiQ+UbA+
   Nl/okcImiSr/Bofv/fI6davQzXz/Yj24tt+0cxQrSRRmiaEawlg6cp3g4
   dnn5PU1rRKpPZIiuqvkMj6LWjYpgZ9hxin879NXAc9so3OARjpXvVxSqQ
   ilFAJunPeStClWJHg7uULOq74tvlSgE6M9mpLsDvmH0MRhIVftkGuOF9n
   xIK8TJtjgdRsS1eEpRKNgNRuXzMpc83azXEMJg8FAsseeWcEjt2BZjzDr
   4ds4tgUCii1rLL9ZJkYpTMmCgmpcNphBwcoIFha2YHErUwExH29ybaCbf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377138488"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377138488"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833666958"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833666958"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2023 15:40:52 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfpaM-0006pY-0o;
        Mon, 11 Sep 2023 22:40:50 +0000
Date:   Tue, 12 Sep 2023 06:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-mtk-snfi.c:1168: warning: Function parameter or
 member 'op' not described in 'mtk_snand_is_page_ops'
Message-ID: <202309120607.CST7vQDG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 764f1b7481645b2b4488eda26c4da7f331697e6b spi: add driver for MTK SPI NAND Flash Interface
date:   1 year, 5 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230912/202309120607.CST7vQDG-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120607.CST7vQDG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120607.CST7vQDG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mtk-snfi.c:1168: warning: Function parameter or member 'op' not described in 'mtk_snand_is_page_ops'


vim +1168 drivers/spi/spi-mtk-snfi.c

  1154	
  1155	/**
  1156	 * mtk_snand_is_page_ops() - check if the op is a controller supported page op.
  1157	 * @op spi-mem op to check
  1158	 *
  1159	 * Check whether op can be executed with read_from_cache or program_load
  1160	 * mode in the controller.
  1161	 * This controller can execute typical Read From Cache and Program Load
  1162	 * instructions found on SPI-NAND with 2-byte address.
  1163	 * DTR and cmd buswidth & nbytes should be checked before calling this.
  1164	 *
  1165	 * Return: true if the op matches the instruction template
  1166	 */
  1167	static bool mtk_snand_is_page_ops(const struct spi_mem_op *op)
> 1168	{
  1169		if (op->addr.nbytes != 2)
  1170			return false;
  1171	
  1172		if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
  1173		    op->addr.buswidth != 4)
  1174			return false;
  1175	
  1176		// match read from page instructions
  1177		if (op->data.dir == SPI_MEM_DATA_IN) {
  1178			// check dummy cycle first
  1179			if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
  1180			    DATA_READ_MAX_DUMMY)
  1181				return false;
  1182			// quad io / quad out
  1183			if ((op->addr.buswidth == 4 || op->addr.buswidth == 1) &&
  1184			    op->data.buswidth == 4)
  1185				return true;
  1186	
  1187			// dual io / dual out
  1188			if ((op->addr.buswidth == 2 || op->addr.buswidth == 1) &&
  1189			    op->data.buswidth == 2)
  1190				return true;
  1191	
  1192			// standard spi
  1193			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
  1194				return true;
  1195		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
  1196			// check dummy cycle first
  1197			if (op->dummy.nbytes)
  1198				return false;
  1199			// program load quad out
  1200			if (op->addr.buswidth == 1 && op->data.buswidth == 4)
  1201				return true;
  1202			// standard spi
  1203			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
  1204				return true;
  1205		}
  1206		return false;
  1207	}
  1208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
