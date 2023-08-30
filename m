Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80A78DBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjH3Shl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbjH3K3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:29:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB487C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693391356; x=1724927356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hlCHDwzO9I7pdjBo3fG2owpnDQOc0e1ih0Ar6il9ukk=;
  b=J2P8hXaASNt/c2pMs/Z7t9fhu6AiHnGUyuo6ggSeobF9J1Ty1QYJK6Ou
   ngECrETByX/JZhDQObR6D36AxmUNT9/Dc3hdmlai6ZXv4PmK2mxj7dtsw
   lCys+QghjDtLNzWKCrlT2rQ0cTcWGgEwZv65JlV/hBOKSvOwVN5X4BLHH
   4jV1wgxjUFXJR76h8iLU6GjIpkdoQ2VQ7iJLioYXg35QKAy3nJptPyII6
   3+FMnLUkiwCnKWD4xzF/tG6O5o6s3uBfo0j6EV63w50niLTGotGuKw6CK
   kuwLuJazUMuMClCURBcAulQwRJAzfAU14uMi7U1Up6LTzWt9sGEISNMYt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355113897"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="355113897"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 03:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768366973"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="768366973"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 03:29:04 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbIRa-0009iO-2Q;
        Wed, 30 Aug 2023 10:29:03 +0000
Date:   Wed, 30 Aug 2023 18:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: kernel/fork.c:1962: warning: bad line:
Message-ID: <202308301820.d4bxzPI0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c1b980a7e79e55e951b4b2c47eefebc75071209
commit: 6ae930d9dbf2d093157be33428538c91966d8a9f pid: add pidfd_prepare()
date:   5 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230830/202308301820.d4bxzPI0-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308301820.d4bxzPI0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308301820.d4bxzPI0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/fork.c:1261: warning: Function parameter or member 'mm' not described in 'set_mm_exe_file'
   kernel/fork.c:1261: warning: Function parameter or member 'new_exe_file' not described in 'set_mm_exe_file'
   kernel/fork.c:1298: warning: Function parameter or member 'mm' not described in 'replace_mm_exe_file'
   kernel/fork.c:1298: warning: Function parameter or member 'new_exe_file' not described in 'replace_mm_exe_file'
   kernel/fork.c:1350: warning: Function parameter or member 'mm' not described in 'get_mm_exe_file'
   kernel/fork.c:1369: warning: Function parameter or member 'task' not described in 'get_task_exe_file'
   kernel/fork.c:1393: warning: Function parameter or member 'task' not described in 'get_task_mm'
>> kernel/fork.c:1962: warning: bad line: 
>> kernel/fork.c:1983: warning: Function parameter or member 'ret' not described in '__pidfd_prepare'
>> kernel/fork.c:1983: warning: Excess function parameter 'pidfd' description in '__pidfd_prepare'
>> kernel/fork.c:2032: warning: Function parameter or member 'ret' not described in 'pidfd_prepare'
>> kernel/fork.c:2032: warning: Excess function parameter 'pidfd' description in 'pidfd_prepare'
   kernel/fork.c:3048: warning: expecting prototype for clone3(). Prototype was for sys_clone3() instead


vim +1962 kernel/fork.c

  1953	
  1954	/**
  1955	 * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  1956	 * @pid:   the struct pid for which to create a pidfd
  1957	 * @flags: flags of the new @pidfd
  1958	 * @pidfd: the pidfd to return
  1959	 *
  1960	 * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  1961	 * caller's file descriptor table. The pidfd is reserved but not installed yet.
> 1962	
  1963	 * The helper doesn't perform checks on @pid which makes it useful for pidfds
  1964	 * created via CLONE_PIDFD where @pid has no task attached when the pidfd and
  1965	 * pidfd file are prepared.
  1966	 *
  1967	 * If this function returns successfully the caller is responsible to either
  1968	 * call fd_install() passing the returned pidfd and pidfd file as arguments in
  1969	 * order to install the pidfd into its file descriptor table or they must use
  1970	 * put_unused_fd() and fput() on the returned pidfd and pidfd file
  1971	 * respectively.
  1972	 *
  1973	 * This function is useful when a pidfd must already be reserved but there
  1974	 * might still be points of failure afterwards and the caller wants to ensure
  1975	 * that no pidfd is leaked into its file descriptor table.
  1976	 *
  1977	 * Return: On success, a reserved pidfd is returned from the function and a new
  1978	 *         pidfd file is returned in the last argument to the function. On
  1979	 *         error, a negative error code is returned from the function and the
  1980	 *         last argument remains unchanged.
  1981	 */
  1982	static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> 1983	{
  1984		int pidfd;
  1985		struct file *pidfd_file;
  1986	
  1987		if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
  1988			return -EINVAL;
  1989	
  1990		pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
  1991		if (pidfd < 0)
  1992			return pidfd;
  1993	
  1994		pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
  1995						flags | O_RDWR | O_CLOEXEC);
  1996		if (IS_ERR(pidfd_file)) {
  1997			put_unused_fd(pidfd);
  1998			return PTR_ERR(pidfd_file);
  1999		}
  2000		get_pid(pid); /* held by pidfd_file now */
  2001		*ret = pidfd_file;
  2002		return pidfd;
  2003	}
  2004	
  2005	/**
  2006	 * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
  2007	 * @pid:   the struct pid for which to create a pidfd
  2008	 * @flags: flags of the new @pidfd
  2009	 * @pidfd: the pidfd to return
  2010	 *
  2011	 * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  2012	 * caller's file descriptor table. The pidfd is reserved but not installed yet.
  2013	 *
  2014	 * The helper verifies that @pid is used as a thread group leader.
  2015	 *
  2016	 * If this function returns successfully the caller is responsible to either
  2017	 * call fd_install() passing the returned pidfd and pidfd file as arguments in
  2018	 * order to install the pidfd into its file descriptor table or they must use
  2019	 * put_unused_fd() and fput() on the returned pidfd and pidfd file
  2020	 * respectively.
  2021	 *
  2022	 * This function is useful when a pidfd must already be reserved but there
  2023	 * might still be points of failure afterwards and the caller wants to ensure
  2024	 * that no pidfd is leaked into its file descriptor table.
  2025	 *
  2026	 * Return: On success, a reserved pidfd is returned from the function and a new
  2027	 *         pidfd file is returned in the last argument to the function. On
  2028	 *         error, a negative error code is returned from the function and the
  2029	 *         last argument remains unchanged.
  2030	 */
  2031	int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> 2032	{
  2033		if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
  2034			return -EINVAL;
  2035	
  2036		return __pidfd_prepare(pid, flags, ret);
  2037	}
  2038	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
