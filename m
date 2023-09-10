Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887A5799C88
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 06:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjIJEKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 00:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbjIJEK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:10:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74765CCA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694319023; x=1725855023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YpJYNMao6po1S/fn5VJKCaALxDQaB5WiuOhwF2x/dmc=;
  b=L0xQ2bwCTVLSgXll4+zdNPqKC5f6lragp1V7HYjN8fqQuZZ4gY1UA1fU
   ojR3vm4XrTScDk7IKMVCJM10Sd5pvqOjwhVW5DpsQDElzsJS1CBbbu7Dx
   INFIGTghsio4h0jIsrdt8nBKCAwkJODBnAASOrCmwae3gfFYAd8JWkH7b
   6B73jdzYlftUv3TYndln568Lxo2tCCvLvUJQ4Qt9EwicosHayVfleu1mV
   WP6V3MoNcf/nMcy2vtTrXWefloVjdWhqIuo/ZmunN9akSKI4iQf6Fk3Wm
   NtK9wmTkEbXAorg7SJyS8KkxYU+G4t0mqFA1wS52xUmSmHLZh3r6jxd6g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="381684806"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="381684806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 21:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="772179409"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="772179409"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2023 21:10:21 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfBm6-0004MQ-2k;
        Sun, 10 Sep 2023 04:10:18 +0000
Date:   Sun, 10 Sep 2023 12:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/powercap/dtpm.c:602: warning: Function parameter or member
 'dtpm_match_table' not described in 'dtpm_create_hierarchy'
Message-ID: <202309101242.EjuX7vK3-lkp@intel.com>
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
head:   a3c57ab79a06e333a869ae340420cb3c6f5921d3
commit: 3759ec678e8944dc2ea70cab77a300408f78ae27 powercap/drivers/dtpm: Add hierarchy creation
date:   1 year, 7 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230910/202309101242.EjuX7vK3-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309101242.EjuX7vK3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309101242.EjuX7vK3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/powercap/dtpm.c:602: warning: Function parameter or member 'dtpm_match_table' not described in 'dtpm_create_hierarchy'
>> drivers/powercap/dtpm.c:602: warning: Excess function parameter 'hierarchy' description in 'dtpm_create_hierarchy'


vim +602 drivers/powercap/dtpm.c

   574	
   575	/**
   576	 * dtpm_create_hierarchy - Create the dtpm hierarchy
   577	 * @hierarchy: An array of struct dtpm_node describing the hierarchy
   578	 *
   579	 * The function is called by the platform specific code with the
   580	 * description of the different node in the hierarchy. It creates the
   581	 * tree in the sysfs filesystem under the powercap dtpm entry.
   582	 *
   583	 * The expected tree has the format:
   584	 *
   585	 * struct dtpm_node hierarchy[] = {
   586	 *	[0] { .name = "topmost", type =  DTPM_NODE_VIRTUAL },
   587	 *	[1] { .name = "package", .type = DTPM_NODE_VIRTUAL, .parent = &hierarchy[0] },
   588	 *	[2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   589	 *	[3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   590	 *	[4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   591	 *	[5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   592	 *	[6] { }
   593	 * };
   594	 *
   595	 * The last element is always an empty one and marks the end of the
   596	 * array.
   597	 *
   598	 * Return: zero on success, a negative value in case of error. Errors
   599	 * are reported back from the underlying functions.
   600	 */
   601	int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 > 602	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
