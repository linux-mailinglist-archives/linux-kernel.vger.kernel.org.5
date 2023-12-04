Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBECF804118
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjLDVoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjLDVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:44:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE1101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701726278; x=1733262278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hb0FnfC2VZ5UsdsmGvmo5jMt8lUxoOZJ8ZvO3FiOiCk=;
  b=E9lkzF6kxhfb4As1ELdsmJAQsENgYoNgAy8aOrheUj56fKkzGDBqKiBC
   kQ0VwUk+bwj2a4LZ4g2RVclkXi5Kh3B6cMl6qd3jcck6IxPam6ax+iwwn
   Bb4NxgfkFNFYElYs0ORGJZLnr/uY4XcVMQ9yMqF5liREMb/m962Rf4LBn
   F9pUPi5AIIb4lecrGtmh1kAeHXEEXqoNGYZiM3LKoHbjJ/ZFEX1JRnUHl
   KONVwhTfpOdsVlk4UNAHlLhz9BbZ5gf6Dlci/csPv/yPuzHMGnUIq8x1M
   HwuViknCGcvRH/465YRl828SZJ8faatSqF0K1MKOtuth23QLp9jMFLZTn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460296263"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460296263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914575944"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="914575944"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2023 13:44:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAGjs-00086f-31;
        Mon, 04 Dec 2023 21:44:28 +0000
Date:   Tue, 5 Dec 2023 05:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202312050445.sUkSCUIl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: e362359ace6f87c201531872486ff295df306d13 posix-cpu-timers: Cleanup CPU timers before freeing them during exec
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312050445.sUkSCUIl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050445.sUkSCUIl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050445.sUkSCUIl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/exec.c:422:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:422:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:422:31: sparse:     got void *
   fs/exec.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1051:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1051:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1158:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1158:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1158:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1193:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1193:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1193:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>> fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1307:26: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1307:26: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1309:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1309:28: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1309:28: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1766:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1766:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1766:70: sparse:     got struct task_struct [noderef] __rcu *parent

vim +1307 fs/exec.c

  1243	
  1244	/*
  1245	 * Calling this is the point of no return. None of the failures will be
  1246	 * seen by userspace since either the process is already taking a fatal
  1247	 * signal (via de_thread() or coredump), or will have SEGV raised
  1248	 * (after exec_mmap()) by search_binary_handler (see below).
  1249	 */
  1250	int begin_new_exec(struct linux_binprm * bprm)
  1251	{
  1252		struct task_struct *me = current;
  1253		int retval;
  1254	
  1255		/* Once we are committed compute the creds */
  1256		retval = bprm_creds_from_file(bprm);
  1257		if (retval)
  1258			return retval;
  1259	
  1260		/*
  1261		 * Ensure all future errors are fatal.
  1262		 */
  1263		bprm->point_of_no_return = true;
  1264	
  1265		/*
  1266		 * Make this the only thread in the thread group.
  1267		 */
  1268		retval = de_thread(me);
  1269		if (retval)
  1270			goto out;
  1271	
  1272		/*
  1273		 * Cancel any io_uring activity across execve
  1274		 */
  1275		io_uring_task_cancel();
  1276	
  1277		/* Ensure the files table is not shared. */
  1278		retval = unshare_files();
  1279		if (retval)
  1280			goto out;
  1281	
  1282		/*
  1283		 * Must be called _before_ exec_mmap() as bprm->mm is
  1284		 * not visible until then. This also enables the update
  1285		 * to be lockless.
  1286		 */
  1287		retval = set_mm_exe_file(bprm->mm, bprm->file);
  1288		if (retval)
  1289			goto out;
  1290	
  1291		/* If the binary is not readable then enforce mm->dumpable=0 */
  1292		would_dump(bprm, bprm->file);
  1293		if (bprm->have_execfd)
  1294			would_dump(bprm, bprm->executable);
  1295	
  1296		/*
  1297		 * Release all of the old mmap stuff
  1298		 */
  1299		acct_arg_size(bprm, 0);
  1300		retval = exec_mmap(bprm->mm);
  1301		if (retval)
  1302			goto out;
  1303	
  1304		bprm->mm = NULL;
  1305	
  1306	#ifdef CONFIG_POSIX_TIMERS
> 1307		spin_lock_irq(&me->sighand->siglock);
  1308		posix_cpu_timers_exit(me);
  1309		spin_unlock_irq(&me->sighand->siglock);
  1310		exit_itimers(me);
  1311		flush_itimer_signals();
  1312	#endif
  1313	
  1314		/*
  1315		 * Make the signal table private.
  1316		 */
  1317		retval = unshare_sighand(me);
  1318		if (retval)
  1319			goto out_unlock;
  1320	
  1321		me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
  1322						PF_NOFREEZE | PF_NO_SETAFFINITY);
  1323		flush_thread();
  1324		me->personality &= ~bprm->per_clear;
  1325	
  1326		clear_syscall_work_syscall_user_dispatch(me);
  1327	
  1328		/*
  1329		 * We have to apply CLOEXEC before we change whether the process is
  1330		 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
  1331		 * trying to access the should-be-closed file descriptors of a process
  1332		 * undergoing exec(2).
  1333		 */
  1334		do_close_on_exec(me->files);
  1335	
  1336		if (bprm->secureexec) {
  1337			/* Make sure parent cannot signal privileged process. */
  1338			me->pdeath_signal = 0;
  1339	
  1340			/*
  1341			 * For secureexec, reset the stack limit to sane default to
  1342			 * avoid bad behavior from the prior rlimits. This has to
  1343			 * happen before arch_pick_mmap_layout(), which examines
  1344			 * RLIMIT_STACK, but after the point of no return to avoid
  1345			 * needing to clean up the change on failure.
  1346			 */
  1347			if (bprm->rlim_stack.rlim_cur > _STK_LIM)
  1348				bprm->rlim_stack.rlim_cur = _STK_LIM;
  1349		}
  1350	
  1351		me->sas_ss_sp = me->sas_ss_size = 0;
  1352	
  1353		/*
  1354		 * Figure out dumpability. Note that this checking only of current
  1355		 * is wrong, but userspace depends on it. This should be testing
  1356		 * bprm->secureexec instead.
  1357		 */
  1358		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
  1359		    !(uid_eq(current_euid(), current_uid()) &&
  1360		      gid_eq(current_egid(), current_gid())))
  1361			set_dumpable(current->mm, suid_dumpable);
  1362		else
  1363			set_dumpable(current->mm, SUID_DUMP_USER);
  1364	
  1365		perf_event_exec();
  1366		__set_task_comm(me, kbasename(bprm->filename), true);
  1367	
  1368		/* An exec changes our domain. We are no longer part of the thread
  1369		   group */
  1370		WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
  1371		flush_signal_handlers(me, 0);
  1372	
  1373		retval = set_cred_ucounts(bprm->cred);
  1374		if (retval < 0)
  1375			goto out_unlock;
  1376	
  1377		/*
  1378		 * install the new credentials for this executable
  1379		 */
  1380		security_bprm_committing_creds(bprm);
  1381	
  1382		commit_creds(bprm->cred);
  1383		bprm->cred = NULL;
  1384	
  1385		/*
  1386		 * Disable monitoring for regular users
  1387		 * when executing setuid binaries. Must
  1388		 * wait until new credentials are committed
  1389		 * by commit_creds() above
  1390		 */
  1391		if (get_dumpable(me->mm) != SUID_DUMP_USER)
  1392			perf_event_exit_task(me);
  1393		/*
  1394		 * cred_guard_mutex must be held at least to this point to prevent
  1395		 * ptrace_attach() from altering our determination of the task's
  1396		 * credentials; any time after this it may be unlocked.
  1397		 */
  1398		security_bprm_committed_creds(bprm);
  1399	
  1400		/* Pass the opened binary to the interpreter. */
  1401		if (bprm->have_execfd) {
  1402			retval = get_unused_fd_flags(0);
  1403			if (retval < 0)
  1404				goto out_unlock;
  1405			fd_install(retval, bprm->executable);
  1406			bprm->executable = NULL;
  1407			bprm->execfd = retval;
  1408		}
  1409		return 0;
  1410	
  1411	out_unlock:
  1412		up_write(&me->signal->exec_update_lock);
  1413	out:
  1414		return retval;
  1415	}
  1416	EXPORT_SYMBOL(begin_new_exec);
  1417	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
