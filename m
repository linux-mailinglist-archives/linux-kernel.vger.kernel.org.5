Return-Path: <linux-kernel+bounces-11993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE881EE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162631C21746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09774446BD;
	Wed, 27 Dec 2023 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cbza8hMy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917C1E534;
	Wed, 27 Dec 2023 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703677301; x=1735213301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3r/1e3HL0Ph6NuiSGOA5oAHEsDBmqySS8+0n+CnOMJQ=;
  b=Cbza8hMyso+PebbSYaEg8ExGbhY2C6L04iwrwKlzSeuBygPOkRvX/RDy
   Rk7QEfFdLOTdSpWAUsEF4RPVD3GWPCI6AzAR5wpjdLO6GF8F+E+eT48zW
   +kNbuNnOiXiYEaT4BwXf5lJisnZAvZVt2EBK3SJ/09mZxzk+lH8B44bte
   2iYRhwCnIAMkwoYmt7Bhx4JoN7cKm4MAclnTG4dtQRsYWzDumL8iXywV2
   e1br3734etAyVbQ/m1XR+l1DNXevAuoBJhJ2HWlk2oHyX64FxPnDTOX3u
   anhB9ce760AwAeaFQfOiqJTzHp64zxIlpXsEq+VsxvImpf5XoMDeOwqR5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3242949"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3242949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 03:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="19939496"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Dec 2023 03:41:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rISI2-000FL7-2L;
	Wed, 27 Dec 2023 11:41:34 +0000
Date: Wed, 27 Dec 2023 19:41:20 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, sherry.sun@nxp.com,
	rohit.fule@nxp.com
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Resolve TX timeout error in
 power save stress test
Message-ID: <202312271920.D4X4fO6I-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231227/202312271920.D4X4fO6I-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271920.D4X4fO6I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271920.D4X4fO6I-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btnxpuart.c: In function 'ps_control':
>> drivers/bluetooth/btnxpuart.c:356:25: error: implicit declaration of function 'usleep'; did you mean 'fsleep'? [-Werror=implicit-function-declaration]
     356 |                         usleep(2000); /* Allow chip to detect UART-break and enter sleep */
         |                         ^~~~~~
         |                         fsleep
   cc1: some warnings being treated as errors


vim +356 drivers/bluetooth/btnxpuart.c

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

