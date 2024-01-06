Return-Path: <linux-kernel+bounces-18708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E3826171
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0E1C21042
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78170FBF4;
	Sat,  6 Jan 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuSnb9Hb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68087F51E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704572377; x=1736108377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Oaxnl+WDuKCrzJhLjIRx+yriqNXpMAN+vqLtYP3D1Hc=;
  b=AuSnb9HbA1+bom+SpEIeaardajq+voDNnXLOgGtFxCvLu+x+avRi2Jyo
   TbonKc3pAzklTo7vE4Bmlyl3fcVsRFEH10w+SDDJ2iDz+TqJxYUW3LrxA
   ebscBl675HgtGIiWCCnyMcBGotcScLG00NrPOa+GwVDeb+dhuNir9eQga
   JdvIilNaX9ts2xT3GwPcPuPm1HP2xKWCnCJvB1SugQCO+w77+i2aXkhEi
   GJ0SfSV7/GPIh/wayPF0V3GVP0kMV58TELFRfXuQFHaiWinvFMZQrKzGD
   +auTlD70PlCcorUQChIHfX8aZ5MSbjtKLd1nef6FANClebGWh3Eym92b6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="19185503"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="19185503"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 12:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="781047314"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="781047314"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2024 12:19:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMD8a-0002xo-2U;
	Sat, 06 Jan 2024 20:19:20 +0000
Date: Sun, 7 Jan 2024 04:19:13 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/eventpoll.c:526:9: sparse: sparse: restricted __poll_t degrades
 to integer
Message-ID: <202401070458.AoQY32kd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: caf1aeaffc3b09649a56769e559333ae2c4f1802 eventpoll: add EPOLL_URING_WAKE poll wakeup flag
date:   1 year, 2 months ago
config: i386-randconfig-063-20240105 (https://download.01.org/0day-ci/archive/20240107/202401070458.AoQY32kd-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070458.AoQY32kd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070458.AoQY32kd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/eventpoll.c:526:9: sparse: sparse: restricted __poll_t degrades to integer
>> fs/eventpoll.c:526:9: sparse: sparse: cast to restricted __poll_t
>> fs/eventpoll.c:1213:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int pollflags @@     got restricted __poll_t @@
   fs/eventpoll.c:1213:53: sparse:     expected unsigned int pollflags
   fs/eventpoll.c:1213:53: sparse:     got restricted __poll_t

vim +526 fs/eventpoll.c

   493	
   494	static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
   495				     unsigned pollflags)
   496	{
   497		struct eventpoll *ep_src;
   498		unsigned long flags;
   499		u8 nests = 0;
   500	
   501		/*
   502		 * To set the subclass or nesting level for spin_lock_irqsave_nested()
   503		 * it might be natural to create a per-cpu nest count. However, since
   504		 * we can recurse on ep->poll_wait.lock, and a non-raw spinlock can
   505		 * schedule() in the -rt kernel, the per-cpu variable are no longer
   506		 * protected. Thus, we are introducing a per eventpoll nest field.
   507		 * If we are not being call from ep_poll_callback(), epi is NULL and
   508		 * we are at the first level of nesting, 0. Otherwise, we are being
   509		 * called from ep_poll_callback() and if a previous wakeup source is
   510		 * not an epoll file itself, we are at depth 1 since the wakeup source
   511		 * is depth 0. If the wakeup source is a previous epoll file in the
   512		 * wakeup chain then we use its nests value and record ours as
   513		 * nests + 1. The previous epoll file nests value is stable since its
   514		 * already holding its own poll_wait.lock.
   515		 */
   516		if (epi) {
   517			if ((is_file_epoll(epi->ffd.file))) {
   518				ep_src = epi->ffd.file->private_data;
   519				nests = ep_src->nests;
   520			} else {
   521				nests = 1;
   522			}
   523		}
   524		spin_lock_irqsave_nested(&ep->poll_wait.lock, flags, nests);
   525		ep->nests = nests + 1;
 > 526		wake_up_locked_poll(&ep->poll_wait, EPOLLIN | pollflags);
   527		ep->nests = 0;
   528		spin_unlock_irqrestore(&ep->poll_wait.lock, flags);
   529	}
   530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

