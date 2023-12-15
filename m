Return-Path: <linux-kernel+bounces-494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD168141F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBCFB222EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE3D28F;
	Fri, 15 Dec 2023 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnJu75iL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB8CA69;
	Fri, 15 Dec 2023 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702622989; x=1734158989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgBxIrEgIaVOjnCrN46tvM/6g0EOBBd04UFyN1Vvz6U=;
  b=LnJu75iLMl4aSDsha7qAbAbsHn/k06f5tof3NM9MH4/ddePuKWDOhFDq
   12KsA0Tg+8iRWq8actMKwvVQJKtrDU12qIroUzyDYlOsQqfCKe3lIkCVF
   jmrWfVH4BgCNCNrE9/Na4fY66Np3dlPD0t6LNBQBF2405XnMer8rAxFz4
   hZxAb3Jt8XUvYAM1TJSNqIgmkt/Gsao1OWHu4HoskNwM5HY/FWZicQK/n
   QVOdknBlgffoFZdMJTh8mN09uxQ091HZqCi4ezqtH+IH0m/JBm4/UVwyI
   oN+Ur6RDMhTU27xoFrx0rfzKiSLSXmc3RypJISvuLGYxFaH5a2++F2bRd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16789423"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="16789423"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 22:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865290401"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="865290401"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Dec 2023 22:49:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE20D-000NCk-2n;
	Fri, 15 Dec 2023 06:49:03 +0000
Date: Fri, 15 Dec 2023 14:48:36 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Message-ID: <202312151453.AaH01Gw5-lkp@intel.com>
References: <20231214070200.24405-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214070200.24405-1-rdunlap@infradead.org>

Hi Randy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/scripts-kernel-doc-restore-warning-for-Excess-struct-union/20231214-150722
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20231214070200.24405-1-rdunlap%40infradead.org
patch subject: [PATCH] scripts/kernel-doc: restore warning for Excess struct/union
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231215/202312151453.AaH01Gw5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312151453.AaH01Gw5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312151453.AaH01Gw5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/zynqmp-ipi-mailbox.c:92: warning: Excess struct member 'irq' description in 'zynqmp_ipi_mbox'
>> drivers/mailbox/zynqmp-ipi-mailbox.c:112: warning: Excess struct member 'ipi_mboxes' description in 'zynqmp_ipi_pdata'
--
>> drivers/pinctrl/pinctrl-zynqmp.c:60: warning: Excess struct member 'node' description in 'zynqmp_pmux_function'
--
>> drivers/pwm/pwm-mediatek.c:60: warning: Excess struct member 'clk_freq' description in 'pwm_mediatek_chip'
--
>> drivers/net/ipa/ipa_power.c:71: warning: Excess struct member 'interconnect' description in 'ipa_power'
--
>> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c:57: warning: Excess struct member 'wait_key_frame' description in 'vdec_vp8_slice_info'
--
>> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c:166: warning: Excess struct member 'mv_joint' description in 'vdec_vp9_slice_counts_map'


vim +92 drivers/mailbox/zynqmp-ipi-mailbox.c

4981b82ba2ff87d Wendy Liang 2019-02-21   74  
4981b82ba2ff87d Wendy Liang 2019-02-21   75  /**
4981b82ba2ff87d Wendy Liang 2019-02-21   76   * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
4981b82ba2ff87d Wendy Liang 2019-02-21   77   *                          platform data.
4981b82ba2ff87d Wendy Liang 2019-02-21   78   * @pdata:		  pointer to the IPI private data
4981b82ba2ff87d Wendy Liang 2019-02-21   79   * @dev:                  device pointer corresponding to the Xilinx ZynqMP
4981b82ba2ff87d Wendy Liang 2019-02-21   80   *                        IPI mailbox
4981b82ba2ff87d Wendy Liang 2019-02-21   81   * @remote_id:            remote IPI agent ID
4981b82ba2ff87d Wendy Liang 2019-02-21   82   * @mbox:                 mailbox Controller
4981b82ba2ff87d Wendy Liang 2019-02-21   83   * @mchans:               array for channels, tx channel and rx channel.
4981b82ba2ff87d Wendy Liang 2019-02-21   84   * @irq:                  IPI agent interrupt ID
4981b82ba2ff87d Wendy Liang 2019-02-21   85   */
4981b82ba2ff87d Wendy Liang 2019-02-21   86  struct zynqmp_ipi_mbox {
4981b82ba2ff87d Wendy Liang 2019-02-21   87  	struct zynqmp_ipi_pdata *pdata;
4981b82ba2ff87d Wendy Liang 2019-02-21   88  	struct device dev;
4981b82ba2ff87d Wendy Liang 2019-02-21   89  	u32 remote_id;
4981b82ba2ff87d Wendy Liang 2019-02-21   90  	struct mbox_controller mbox;
4981b82ba2ff87d Wendy Liang 2019-02-21   91  	struct zynqmp_ipi_mchan mchans[2];
4981b82ba2ff87d Wendy Liang 2019-02-21  @92  };
4981b82ba2ff87d Wendy Liang 2019-02-21   93  
4981b82ba2ff87d Wendy Liang 2019-02-21   94  /**
4981b82ba2ff87d Wendy Liang 2019-02-21   95   * struct zynqmp_ipi_pdata - Description of z ZynqMP IPI agent platform data.
4981b82ba2ff87d Wendy Liang 2019-02-21   96   *
4981b82ba2ff87d Wendy Liang 2019-02-21   97   * @dev:                  device pointer corresponding to the Xilinx ZynqMP
4981b82ba2ff87d Wendy Liang 2019-02-21   98   *                        IPI agent
4981b82ba2ff87d Wendy Liang 2019-02-21   99   * @irq:                  IPI agent interrupt ID
4981b82ba2ff87d Wendy Liang 2019-02-21  100   * @method:               IPI SMC or HVC is going to be used
4981b82ba2ff87d Wendy Liang 2019-02-21  101   * @local_id:             local IPI agent ID
4981b82ba2ff87d Wendy Liang 2019-02-21  102   * @num_mboxes:           number of mailboxes of this IPI agent
4981b82ba2ff87d Wendy Liang 2019-02-21  103   * @ipi_mboxes:           IPI mailboxes of this IPI agent
4981b82ba2ff87d Wendy Liang 2019-02-21  104   */
4981b82ba2ff87d Wendy Liang 2019-02-21  105  struct zynqmp_ipi_pdata {
4981b82ba2ff87d Wendy Liang 2019-02-21  106  	struct device *dev;
4981b82ba2ff87d Wendy Liang 2019-02-21  107  	int irq;
4981b82ba2ff87d Wendy Liang 2019-02-21  108  	unsigned int method;
4981b82ba2ff87d Wendy Liang 2019-02-21  109  	u32 local_id;
4981b82ba2ff87d Wendy Liang 2019-02-21  110  	int num_mboxes;
c5225cd073c65a6 Kees Cook   2023-09-22  111  	struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
4981b82ba2ff87d Wendy Liang 2019-02-21 @112  };
4981b82ba2ff87d Wendy Liang 2019-02-21  113  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

