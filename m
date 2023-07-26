Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E60763451
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGZKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:54:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E829B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368845; x=1721904845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tV4kWXpWkDACr62OMZFOfCAZMY0F61TPzIcnQPWNHhM=;
  b=TpMqAWOATy8laiOYYhHEEh+6pybfv+ixBPdPqWQvpRG2eZY/vqh4yJGp
   ZQVgPh0HrtShAFL9BJB13CQ3O2wmiSfsq/N4yumH7fnTnKwKXD7muUEOJ
   fIwhkiEeFQ6cPatbWvo+prE4NPVVaWeNyVW15qPNzpbtlipP13eMLB4jC
   Vu+5BK8S8rboU82zH0waLnkcD9ElnPCinNTtCHaUOv+KE/8ojWoTlMgsP
   3Ip1ibM4+iffEk6f7cmmrVtkvhBapGkW3h7B4F93eDrjOtl2rUkma4Bgv
   Y6EuO8Emki+AvZM6kmdaGfr6L43n4gvPEC1otBytyFAjMzixtH5Sj9ilR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370657274"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370657274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726495829"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726495829"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 03:54:03 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOc96-0000ud-14;
        Wed, 26 Jul 2023 10:53:43 +0000
Date:   Wed, 26 Jul 2023 18:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202307261856.Pu27vw5Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: a376c10d45a8e6ee5ea55791193f90625b35e156 remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
date:   5 months ago
config: arm64-randconfig-r093-20230726 (https://download.01.org/0day-ci/archive/20230726/202307261856.Pu27vw5Y-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307261856.Pu27vw5Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307261856.Pu27vw5Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void * @@
   drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse:     expected void const volatile [noderef] __iomem *
   drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse:     got void *
   drivers/remoteproc/qcom_q6v5_pas.c:108:6: sparse: sparse: symbol 'adsp_segment_dump' was not declared. Should it be static?
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse:     expected void *mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dtb_mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse:     expected void *dtb_mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse:     got void [noderef] __iomem *

vim +123 drivers/remoteproc/qcom_q6v5_pas.c

   107	
   108	void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
   109			       void *dest, size_t offset, size_t size)
   110	{
   111		struct qcom_adsp *adsp = rproc->priv;
   112		int total_offset;
   113	
   114		total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
   115		if (total_offset < 0 || total_offset + size > adsp->mem_size) {
   116			dev_err(adsp->dev,
   117				"invalid copy request for segment %pad with offset %zu and size %zu)\n",
   118				&segment->da, offset, size);
   119			memset(dest, 0xff, size);
   120			return;
   121		}
   122	
 > 123		memcpy_fromio(dest, adsp->mem_region + total_offset, size);
   124	}
   125	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
