Return-Path: <linux-kernel+bounces-22418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F07829D65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D5B26807
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F54C3BA;
	Wed, 10 Jan 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="js00Zh+B"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380A4BAB0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900029; x=1736436029;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jgzQtNtP7d7ilSrAKXp1JWSP67QweptKQC9TivZz7f4=;
  b=js00Zh+BO6Nys9x1FuOI+euyjNRlCJ0tExWLJqNGYoxj3EbSWW1MX8VW
   MLZYpDtJXRtEvCb3BrEg4UIg61sHz9in2MpjZa8lZ24C//BE3foQUivV6
   9iZkULgxaIaaz4H6+vvxD+p47m77hrukaaq8Br0SwBuK0yzItIKhZ3D1T
   AD1Nkpe4l5uBw7fwRfxpl9Fpc1aXhWwQfmF69t6Lv5xFOBZEGeYVDSdur
   N02LEQd+HyLkKExlHJuaNAm1jUl98GHU0o/SN0O0ZFdT6Myi5ek3yG2fw
   xv0l8h3A/T3l9dMwd+vCPHbV621XfRq9Wal7twggu7YmIcP8RXlc3L9Cc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="388988356"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="388988356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="816384210"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816384210"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2024 07:20:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNaNA-0007Bj-0A;
	Wed, 10 Jan 2024 15:20:04 +0000
Date: Wed, 10 Jan 2024 23:19:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: block/blk-iocost.c:1183:6: warning: variable 'last_period' set but
 not used
Message-ID: <202401102335.GiWdeIo9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: ac33e91e2daca40fcad66c68712276da7b40f169 blk-iocost: implement vtime loss compensation
date:   3 years, 4 months ago
config: x86_64-buildonly-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20240110/202401102335.GiWdeIo9-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401102335.GiWdeIo9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401102335.GiWdeIo9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-iocost.c:1183:6: warning: variable 'last_period' set but not used [-Wunused-but-set-variable]
    1183 |         u64 last_period, cur_period;
         |             ^
   1 warning generated.


vim +/last_period +1183 block/blk-iocost.c

  1179	
  1180	static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
  1181	{
  1182		struct ioc *ioc = iocg->ioc;
> 1183		u64 last_period, cur_period;
  1184		u64 vtime, vtarget;
  1185		int i;
  1186	
  1187		/*
  1188		 * If seem to be already active, just update the stamp to tell the
  1189		 * timer that we're still active.  We don't mind occassional races.
  1190		 */
  1191		if (!list_empty(&iocg->active_list)) {
  1192			ioc_now(ioc, now);
  1193			cur_period = atomic64_read(&ioc->cur_period);
  1194			if (atomic64_read(&iocg->active_period) != cur_period)
  1195				atomic64_set(&iocg->active_period, cur_period);
  1196			return true;
  1197		}
  1198	
  1199		/* racy check on internal node IOs, treat as root level IOs */
  1200		if (iocg->child_active_sum)
  1201			return false;
  1202	
  1203		spin_lock_irq(&ioc->lock);
  1204	
  1205		ioc_now(ioc, now);
  1206	
  1207		/* update period */
  1208		cur_period = atomic64_read(&ioc->cur_period);
  1209		last_period = atomic64_read(&iocg->active_period);
  1210		atomic64_set(&iocg->active_period, cur_period);
  1211	
  1212		/* already activated or breaking leaf-only constraint? */
  1213		if (!list_empty(&iocg->active_list))
  1214			goto succeed_unlock;
  1215		for (i = iocg->level - 1; i > 0; i--)
  1216			if (!list_empty(&iocg->ancestors[i]->active_list))
  1217				goto fail_unlock;
  1218	
  1219		if (iocg->child_active_sum)
  1220			goto fail_unlock;
  1221	
  1222		/*
  1223		 * Always start with the target budget. On deactivation, we throw away
  1224		 * anything above it.
  1225		 */
  1226		vtarget = now->vnow - ioc->margins.target;
  1227		vtime = atomic64_read(&iocg->vtime);
  1228	
  1229		atomic64_add(vtarget - vtime, &iocg->vtime);
  1230		atomic64_add(vtarget - vtime, &iocg->done_vtime);
  1231		vtime = vtarget;
  1232	
  1233		/*
  1234		 * Activate, propagate weight and start period timer if not
  1235		 * running.  Reset hweight_gen to avoid accidental match from
  1236		 * wrapping.
  1237		 */
  1238		iocg->hweight_gen = atomic_read(&ioc->hweight_gen) - 1;
  1239		list_add(&iocg->active_list, &ioc->active_iocgs);
  1240	
  1241		propagate_weights(iocg, iocg->weight,
  1242				  iocg->last_inuse ?: iocg->weight, true, now);
  1243	
  1244		TRACE_IOCG_PATH(iocg_activate, iocg, now,
  1245				last_period, cur_period, vtime);
  1246	
  1247		iocg->activated_at = now->now;
  1248	
  1249		if (ioc->running == IOC_IDLE) {
  1250			ioc->running = IOC_RUNNING;
  1251			ioc->debt_busy_at = now->now;
  1252			ioc_start_period(ioc, now);
  1253		}
  1254	
  1255	succeed_unlock:
  1256		spin_unlock_irq(&ioc->lock);
  1257		return true;
  1258	
  1259	fail_unlock:
  1260		spin_unlock_irq(&ioc->lock);
  1261		return false;
  1262	}
  1263	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

