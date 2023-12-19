Return-Path: <linux-kernel+bounces-6102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F68194A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D26287B81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E893FB11;
	Tue, 19 Dec 2023 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdjsK/cd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9643D0DB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028872; x=1734564872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vay69SJz8InIcyxn2hfrYQWzSpPUCJpIkGtVyC/KTk8=;
  b=kdjsK/cdDHPM6YHX5doyXtlEodk7kbP1bi1VwH32+TdTzIH0sKJq5ODt
   QYW9UV+HyEyPy+focFxJHM9Z0Um/Ei0nD/2aVeOrVRKbcu8oMRpQS1WUM
   AmEGd1y2wYDva4PeEaifeDLnF1i30s462q8hUkYHYXJPoX6m112aCgLcC
   HsgiJcPPmm1QTWxF09TX0VSPBVVBF7SwGihbKq6CAbBixorhHvgVn+0nC
   EnhNTmn/wTTWT0CyPJBycPLoHzZ49GYe1cMHBLFgbkxHxirxRtvoBLjzs
   FMcKKKMn30cFOWuBjj9dxSiddh8zNz3xyfFHGasouE2uUErQzzMQKDHrX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2585982"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2585982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866795397"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="866795397"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2023 15:34:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFjbX-00065H-1s;
	Tue, 19 Dec 2023 23:34:27 +0000
Date: Wed, 20 Dec 2023 07:33:40 +0800
From: kernel test robot <lkp@intel.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:1398:16: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202312200723.AMwbM6Xg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: e5a26a4048eeb9558e5c84f340a989c78db4adf4 tracing/user_events: Split header into uapi and kernel
date:   9 months ago
config: i386-randconfig-061-20231101 (https://download.01.org/0day-ci/archive/20231220/202312200723.AMwbM6Xg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200723.AMwbM6Xg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200723.AMwbM6Xg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_events_user.c:1398:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/trace/trace_events_user.c:1398:16: sparse:    struct user_event_refs [noderef] __rcu *
>> kernel/trace/trace_events_user.c:1398:16: sparse:    struct user_event_refs *
   kernel/trace/trace_events_user.c:1506:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1506:16: sparse:    struct user_event_refs [noderef] __rcu *
   kernel/trace/trace_events_user.c:1506:16: sparse:    struct user_event_refs *
   kernel/trace/trace_events_user.c:1533:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1533:9: sparse:    struct user_event_refs [noderef] __rcu *
   kernel/trace/trace_events_user.c:1533:9: sparse:    struct user_event_refs *

vim +1398 kernel/trace/trace_events_user.c

7f5a08c79df35e Beau Belgrave 2022-01-18  1380  
7f5a08c79df35e Beau Belgrave 2022-01-18  1381  /*
7f5a08c79df35e Beau Belgrave 2022-01-18  1382   * Validates the user payload and writes via iterator.
7f5a08c79df35e Beau Belgrave 2022-01-18  1383   */
7f5a08c79df35e Beau Belgrave 2022-01-18  1384  static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
7f5a08c79df35e Beau Belgrave 2022-01-18  1385  {
e5d271812e7a4d Beau Belgrave 2022-09-30  1386  	struct user_event_file_info *info = file->private_data;
7f5a08c79df35e Beau Belgrave 2022-01-18  1387  	struct user_event_refs *refs;
7f5a08c79df35e Beau Belgrave 2022-01-18  1388  	struct user_event *user = NULL;
7f5a08c79df35e Beau Belgrave 2022-01-18  1389  	struct tracepoint *tp;
7f5a08c79df35e Beau Belgrave 2022-01-18  1390  	ssize_t ret = i->count;
7f5a08c79df35e Beau Belgrave 2022-01-18  1391  	int idx;
7f5a08c79df35e Beau Belgrave 2022-01-18  1392  
7f5a08c79df35e Beau Belgrave 2022-01-18  1393  	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
7f5a08c79df35e Beau Belgrave 2022-01-18  1394  		return -EFAULT;
7f5a08c79df35e Beau Belgrave 2022-01-18  1395  
7f5a08c79df35e Beau Belgrave 2022-01-18  1396  	rcu_read_lock_sched();
7f5a08c79df35e Beau Belgrave 2022-01-18  1397  
e5d271812e7a4d Beau Belgrave 2022-09-30 @1398  	refs = rcu_dereference_sched(info->refs);
7f5a08c79df35e Beau Belgrave 2022-01-18  1399  
7f5a08c79df35e Beau Belgrave 2022-01-18  1400  	/*
7f5a08c79df35e Beau Belgrave 2022-01-18  1401  	 * The refs->events array is protected by RCU, and new items may be
7f5a08c79df35e Beau Belgrave 2022-01-18  1402  	 * added. But the user retrieved from indexing into the events array
7f5a08c79df35e Beau Belgrave 2022-01-18  1403  	 * shall be immutable while the file is opened.
7f5a08c79df35e Beau Belgrave 2022-01-18  1404  	 */
7f5a08c79df35e Beau Belgrave 2022-01-18  1405  	if (likely(refs && idx < refs->count))
7f5a08c79df35e Beau Belgrave 2022-01-18  1406  		user = refs->events[idx];
7f5a08c79df35e Beau Belgrave 2022-01-18  1407  
7f5a08c79df35e Beau Belgrave 2022-01-18  1408  	rcu_read_unlock_sched();
7f5a08c79df35e Beau Belgrave 2022-01-18  1409  
7f5a08c79df35e Beau Belgrave 2022-01-18  1410  	if (unlikely(user == NULL))
7f5a08c79df35e Beau Belgrave 2022-01-18  1411  		return -ENOENT;
7f5a08c79df35e Beau Belgrave 2022-01-18  1412  
2467cda1b5c97a Beau Belgrave 2022-01-18  1413  	if (unlikely(i->count < user->min_size))
2467cda1b5c97a Beau Belgrave 2022-01-18  1414  		return -EINVAL;
2467cda1b5c97a Beau Belgrave 2022-01-18  1415  
7f5a08c79df35e Beau Belgrave 2022-01-18  1416  	tp = &user->tracepoint;
7f5a08c79df35e Beau Belgrave 2022-01-18  1417  
7f5a08c79df35e Beau Belgrave 2022-01-18  1418  	/*
7f5a08c79df35e Beau Belgrave 2022-01-18  1419  	 * It's possible key.enabled disables after this check, however
7f5a08c79df35e Beau Belgrave 2022-01-18  1420  	 * we don't mind if a few events are included in this condition.
7f5a08c79df35e Beau Belgrave 2022-01-18  1421  	 */
7f5a08c79df35e Beau Belgrave 2022-01-18  1422  	if (likely(atomic_read(&tp->key.enabled) > 0)) {
7f5a08c79df35e Beau Belgrave 2022-01-18  1423  		struct tracepoint_func *probe_func_ptr;
7f5a08c79df35e Beau Belgrave 2022-01-18  1424  		user_event_func_t probe_func;
0279400ad38d85 Beau Belgrave 2022-01-18  1425  		struct iov_iter copy;
7f5a08c79df35e Beau Belgrave 2022-01-18  1426  		void *tpdata;
2467cda1b5c97a Beau Belgrave 2022-01-18  1427  		bool faulted;
7f5a08c79df35e Beau Belgrave 2022-01-18  1428  
0279400ad38d85 Beau Belgrave 2022-01-18  1429  		if (unlikely(fault_in_iov_iter_readable(i, i->count)))
0279400ad38d85 Beau Belgrave 2022-01-18  1430  			return -EFAULT;
7f5a08c79df35e Beau Belgrave 2022-01-18  1431  
2467cda1b5c97a Beau Belgrave 2022-01-18  1432  		faulted = false;
2467cda1b5c97a Beau Belgrave 2022-01-18  1433  
7f5a08c79df35e Beau Belgrave 2022-01-18  1434  		rcu_read_lock_sched();
7f5a08c79df35e Beau Belgrave 2022-01-18  1435  
7f5a08c79df35e Beau Belgrave 2022-01-18  1436  		probe_func_ptr = rcu_dereference_sched(tp->funcs);
7f5a08c79df35e Beau Belgrave 2022-01-18  1437  
7f5a08c79df35e Beau Belgrave 2022-01-18  1438  		if (probe_func_ptr) {
7f5a08c79df35e Beau Belgrave 2022-01-18  1439  			do {
0279400ad38d85 Beau Belgrave 2022-01-18  1440  				copy = *i;
7f5a08c79df35e Beau Belgrave 2022-01-18  1441  				probe_func = probe_func_ptr->func;
7f5a08c79df35e Beau Belgrave 2022-01-18  1442  				tpdata = probe_func_ptr->data;
2467cda1b5c97a Beau Belgrave 2022-01-18  1443  				probe_func(user, &copy, tpdata, &faulted);
7f5a08c79df35e Beau Belgrave 2022-01-18  1444  			} while ((++probe_func_ptr)->func);
7f5a08c79df35e Beau Belgrave 2022-01-18  1445  		}
7f5a08c79df35e Beau Belgrave 2022-01-18  1446  
7f5a08c79df35e Beau Belgrave 2022-01-18  1447  		rcu_read_unlock_sched();
2467cda1b5c97a Beau Belgrave 2022-01-18  1448  
2467cda1b5c97a Beau Belgrave 2022-01-18  1449  		if (unlikely(faulted))
2467cda1b5c97a Beau Belgrave 2022-01-18  1450  			return -EFAULT;
7f5a08c79df35e Beau Belgrave 2022-01-18  1451  	}
7f5a08c79df35e Beau Belgrave 2022-01-18  1452  
7f5a08c79df35e Beau Belgrave 2022-01-18  1453  	return ret;
7f5a08c79df35e Beau Belgrave 2022-01-18  1454  }
7f5a08c79df35e Beau Belgrave 2022-01-18  1455  

:::::: The code at line 1398 was first introduced by commit
:::::: e5d271812e7a4d527e65b0228b4a16795c0e0c6c tracing/user_events: Move pages/locks into groups to prepare for namespaces

:::::: TO: Beau Belgrave <beaub@linux.microsoft.com>
:::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

