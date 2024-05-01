Return-Path: <linux-kernel+bounces-165086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E88B8792
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7E1F22B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C551009;
	Wed,  1 May 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IddQyAdR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93B502B1;
	Wed,  1 May 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555353; cv=none; b=RIOLgLtjoSyENDQAVqCSn6EO8Z+c5XPMR6xPoWrYo85Mll9bQ7YbzFytH/KB06wKqLlLk9JxFr9QR512ZL+m4Rfi648mBEYvde168NhzRggiF8aVpdmXKXZ9K3UWrtOc6W+hDAMipc2ldJO8MI+wzFPVlkCb1U16wJQHrQOMALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555353; c=relaxed/simple;
	bh=xPIXDVY5gVPMDe5fMgyJ098UWrM9E71BMIAPj1D00UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJo6ag3H4KzsuRN3kP2HEhmb9X5AtcgBfE6bvbjjwQ4HOhgmixi8PeM7I8IyZIfSs0GsUAZCXwqWBoroMOglsFRShJTmOhBJ4Buux7QRU8uwGl5vzlO51aajQXrM+46fNgSrkmwzopMpbvAXmPvcnaETpOcNAjsIXMRZiXIfQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IddQyAdR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714555350; x=1746091350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xPIXDVY5gVPMDe5fMgyJ098UWrM9E71BMIAPj1D00UE=;
  b=IddQyAdRCr35BLErVXB49gdExU8eFlLsBAhpSLGASzdEdZB1VIa+iose
   qcYv/Pygq2nE7RbCZqoFSOJFM5+AMT2GWP/PL/4pgbFtPaySNO+G0qh+c
   kkB+3tnbrSylsq/qO/gqw948uK3nIipBGNoUBkxaP/UCo2tSnoyvwbSzz
   rE9CFU/tWCsazsK5grIBeRdkXjQfpt2TKc8UXdooVT3AuMHZnGKAuCvvM
   4LgovAg3vz3bM/hMwDNKXGYrhg+eI0lNOFuqFFkDE9eDp5ek7j6vAJVye
   4yJUIAnbxauFBtOE6njDq5voMr3EmgKB/xkTNuzRx3DIZvM3QoJSaRatI
   g==;
X-CSE-ConnectionGUID: LuFTWI3uRcKD+1/HvWGDFw==
X-CSE-MsgGUID: KPBORj1wSsyXXKyazibM0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10129448"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="10129448"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 02:22:29 -0700
X-CSE-ConnectionGUID: cyPWk+HwSSSI5x1uyYTQVQ==
X-CSE-MsgGUID: payiuTkjS7uRMOU5KcG7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="26816520"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 May 2024 02:22:28 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s26AU-0009Jo-0b;
	Wed, 01 May 2024 09:22:26 +0000
Date: Wed, 1 May 2024 17:22:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Urban <surban@surban.net>
Cc: oe-kbuild-all@lists.linux.dev, Sebastian Urban <surban@surban.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Bluetooth: compute LE flow credits based on recvbuf
 space
Message-ID: <202405011748.NWhismdZ-lkp@intel.com>
References: <20240430235122.37716-1-surban@surban.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430235122.37716-1-surban@surban.net>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on linus/master v6.9-rc6 next-20240430]
[cannot apply to bluetooth/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Urban/Bluetooth-compute-LE-flow-credits-based-on-recvbuf-space/20240501-075548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240430235122.37716-1-surban%40surban.net
patch subject: [PATCH v6] Bluetooth: compute LE flow credits based on recvbuf space
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20240501/202405011748.NWhismdZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011748.NWhismdZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011748.NWhismdZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/openrisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from net/bluetooth/l2cap_core.c:31:
   net/bluetooth/l2cap_core.c: In function 'l2cap_chan_rx_avail':
>> net/bluetooth/l2cap_core.c:6570:16: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'ssize_t' {aka 'int'} [-Wformat=]
    6570 |         BT_DBG("chan %p has %ld bytes avail for rx", chan, rx_avail);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:347:21: note: in definition of macro 'pr_fmt'
     347 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
     581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:271:33: note: in expansion of macro 'pr_debug'
     271 | #define BT_DBG(fmt, ...)        pr_debug(fmt "\n", ##__VA_ARGS__)
         |                                 ^~~~~~~~
   net/bluetooth/l2cap_core.c:6570:9: note: in expansion of macro 'BT_DBG'
    6570 |         BT_DBG("chan %p has %ld bytes avail for rx", chan, rx_avail);
         |         ^~~~~~
   net/bluetooth/l2cap_core.c:6570:31: note: format string is defined here
    6570 |         BT_DBG("chan %p has %ld bytes avail for rx", chan, rx_avail);
         |                             ~~^
         |                               |
         |                               long int
         |                             %d


vim +6570 net/bluetooth/l2cap_core.c

  6564	
  6565	void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
  6566	{
  6567		if (chan->rx_avail == rx_avail)
  6568			return;
  6569	
> 6570		BT_DBG("chan %p has %ld bytes avail for rx", chan, rx_avail);
  6571	
  6572		chan->rx_avail = rx_avail;
  6573	
  6574		if (chan->state == BT_CONNECTED)
  6575			l2cap_chan_le_send_credits(chan);
  6576	}
  6577	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

