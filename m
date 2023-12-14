Return-Path: <linux-kernel+bounces-248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC74813E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC86283681
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDE2DB62;
	Thu, 14 Dec 2023 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd/VSgkQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D86C6DC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702596393; x=1734132393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RtL+WCMeA+S+UlFakKQs3VQHa0ZWdhAT2s4Vj2pdFOY=;
  b=Cd/VSgkQVaGfiPX3LhEdRUd5/htiDyR0PaSk2m0GJQQl/7T0qjePB5Jg
   VAkvsnpaMgmT1sELM6MayhByZFJECIRlnptL5b6ulDUrmlsWONLMpF9j4
   bYfA4r9W97zn3sBsS6n2SrAwZMcirJdOOs9u9oyAPfI8nEENb00PXv2Ci
   gj/p6M/5KFO2RhVMt6kTl3RJ9p4WPg+6p8ZNTnqRgQGny42KrSZxuFNH8
   0qFCTBa2HyLNmKYDaleXe+obtStOde7/thi4obNuc/9KL9nPcY+XchJLn
   l4yWJgO7CmvTB/rR50Sl+aQkSf3NfwoD/3gmXVR61nB+izWW1QT7Dst4k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461665345"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="461665345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105909711"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1105909711"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2023 15:26:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDv64-000Mjt-05;
	Thu, 14 Dec 2023 23:26:28 +0000
Date: Fri, 15 Dec 2023 07:25:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/mailbox/zynqmp-ipi-mailbox.c:112: warning: Excess struct
 member 'ipi_mboxes' description in 'zynqmp_ipi_pdata'
Message-ID: <202312150705.glrQ4ypv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: c5225cd073c65a6d7e8e311ec0114792a671982a mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
date:   10 weeks ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231215/202312150705.glrQ4ypv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150705.glrQ4ypv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150705.glrQ4ypv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mailbox/zynqmp-ipi-mailbox.c:92: warning: Excess struct member 'irq' description in 'zynqmp_ipi_mbox'
>> drivers/mailbox/zynqmp-ipi-mailbox.c:112: warning: Excess struct member 'ipi_mboxes' description in 'zynqmp_ipi_pdata'


vim +112 drivers/mailbox/zynqmp-ipi-mailbox.c

4981b82ba2ff87 Wendy Liang 2019-02-21   93  
4981b82ba2ff87 Wendy Liang 2019-02-21   94  /**
4981b82ba2ff87 Wendy Liang 2019-02-21   95   * struct zynqmp_ipi_pdata - Description of z ZynqMP IPI agent platform data.
4981b82ba2ff87 Wendy Liang 2019-02-21   96   *
4981b82ba2ff87 Wendy Liang 2019-02-21   97   * @dev:                  device pointer corresponding to the Xilinx ZynqMP
4981b82ba2ff87 Wendy Liang 2019-02-21   98   *                        IPI agent
4981b82ba2ff87 Wendy Liang 2019-02-21   99   * @irq:                  IPI agent interrupt ID
4981b82ba2ff87 Wendy Liang 2019-02-21  100   * @method:               IPI SMC or HVC is going to be used
4981b82ba2ff87 Wendy Liang 2019-02-21  101   * @local_id:             local IPI agent ID
4981b82ba2ff87 Wendy Liang 2019-02-21  102   * @num_mboxes:           number of mailboxes of this IPI agent
4981b82ba2ff87 Wendy Liang 2019-02-21  103   * @ipi_mboxes:           IPI mailboxes of this IPI agent
4981b82ba2ff87 Wendy Liang 2019-02-21  104   */
4981b82ba2ff87 Wendy Liang 2019-02-21  105  struct zynqmp_ipi_pdata {
4981b82ba2ff87 Wendy Liang 2019-02-21  106  	struct device *dev;
4981b82ba2ff87 Wendy Liang 2019-02-21  107  	int irq;
4981b82ba2ff87 Wendy Liang 2019-02-21  108  	unsigned int method;
4981b82ba2ff87 Wendy Liang 2019-02-21  109  	u32 local_id;
4981b82ba2ff87 Wendy Liang 2019-02-21  110  	int num_mboxes;
c5225cd073c65a Kees Cook   2023-09-22  111  	struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
4981b82ba2ff87 Wendy Liang 2019-02-21 @112  };
4981b82ba2ff87 Wendy Liang 2019-02-21  113  

:::::: The code at line 112 was first introduced by commit
:::::: 4981b82ba2ff87df6a711fcd7a233c615df5fc79 mailbox: ZynqMP IPI mailbox controller

:::::: TO: Wendy Liang <wendy.liang@xilinx.com>
:::::: CC: Jassi Brar <jaswinder.singh@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

