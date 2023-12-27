Return-Path: <linux-kernel+bounces-11776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16A81EB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176611F22A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138E23A6;
	Wed, 27 Dec 2023 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0chSsRq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C020EE;
	Wed, 27 Dec 2023 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703644571; x=1735180571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOJDRRxQCcECcUtLbWLmwY+VO9XB6AP8zj/voHh5AJw=;
  b=E0chSsRqssc4H3gbMZhYDLm9puBweowsqNyYMnvIjvXybr98/oCc6wB/
   zbmkF1dPEJ3CSAoKVBLJ3njlf3zG3Gv+THLV61nVOru62WF1p6Yu1MY9S
   CCZAOCx+VWkREcsA66fKtMGgj1LdcFPbMMJgcv929hOiyk/b2pFFAHPZt
   gjDTboBKhxkui+IYz8YwcXs/EP8BzKcKpcF+l/gN2LGsAezi7Y4oWZBlw
   J9mEvObILhPo8tosWDc6VqVYTUEE4GHwzuUtzMhvPyyLwq4gt+WvXmAg3
   VQeDzev8r2hs2z/Sv64uxbOh/jWIcBBgYNL8ssIUW5gNTDnpT3IwgDi81
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="393558222"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="393558222"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 18:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1109512652"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="1109512652"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Dec 2023 18:36:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIJm9-000EyZ-1z;
	Wed, 27 Dec 2023 02:36:05 +0000
Date: Wed, 27 Dec 2023 10:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com, rohit.fule@nxp.com
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Resolve TX timeout error in
 power save stress test
Message-ID: <202312271021.m0of6rmb-lkp@intel.com>
References: <20231226113110.3923962-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226113110.3923962-1-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Resolve-TX-timeout-error-in-power-save-stress-test/20231226-193718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20231226113110.3923962-1-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v2] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
config: arm-randconfig-003-20231227 (https://download.01.org/0day-ci/archive/20231227/202312271021.m0of6rmb-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d3ef86708241a3bee902615c190dead1638c4e09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271021.m0of6rmb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271021.m0of6rmb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:356:4: error: call to undeclared function 'usleep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     356 |                         usleep(2000); /* Allow chip to detect UART-break and enter sleep */
         |                         ^
   1 error generated.


vim +/usleep +356 drivers/bluetooth/btnxpuart.c

   333	
   334	static void ps_control(struct hci_dev *hdev, u8 ps_state)
   335	{
   336		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
   337		struct ps_data *psdata = &nxpdev->psdata;
   338		int status;
   339	
   340		if (psdata->ps_state == ps_state ||
   341		    !test_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state))
   342			return;
   343	
   344		mutex_lock(&psdata->ps_lock);
   345		switch (psdata->cur_h2c_wakeupmode) {
   346		case WAKEUP_METHOD_DTR:
   347			if (ps_state == PS_STATE_AWAKE)
   348				status = serdev_device_set_tiocm(nxpdev->serdev, TIOCM_DTR, 0);
   349			else
   350				status = serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_DTR);
   351			break;
   352		case WAKEUP_METHOD_BREAK:
   353		default:
   354			if (ps_state == PS_STATE_AWAKE) {
   355				status = serdev_device_break_ctl(nxpdev->serdev, 0);
 > 356				usleep(2000); /* Allow chip to detect UART-break and enter sleep */
   357			} else {
   358				status = serdev_device_break_ctl(nxpdev->serdev, -1);
   359			}
   360			bt_dev_dbg(hdev, "Set UART break: %s, status=%d",
   361				   str_on_off(ps_state == PS_STATE_SLEEP), status);
   362			break;
   363		}
   364		if (!status)
   365			psdata->ps_state = ps_state;
   366		mutex_unlock(&psdata->ps_lock);
   367	
   368		if (ps_state == PS_STATE_AWAKE)
   369			btnxpuart_tx_wakeup(nxpdev);
   370	}
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

