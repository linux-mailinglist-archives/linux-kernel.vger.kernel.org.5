Return-Path: <linux-kernel+bounces-136055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2C89CF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545261F233F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB64A04;
	Tue,  9 Apr 2024 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OER1NZdi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750096FD5;
	Tue,  9 Apr 2024 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623575; cv=none; b=HpfNRSIXQRpnoIV+zTh0YMA4lqgb+H0+cc8Ek2NHZWNXnjOc4nFxszpKdgxPQTjZ0Lu29vGdq1r6zRYxn7yeXsIb7tDYDcBXlMb5Q41kotvfT3S/NZIwvnbU8k/57Xe8D5s0QHYbT66XjnrHuBVa9qgBRjIC/Kz0H++pN86+YFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623575; c=relaxed/simple;
	bh=ef+GHsE25y8FCBN2LthYrBmec0jk/70hqRxVZ7B2Uek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr83Zt7on40C37yH6vMuweKQRE0LYdgqt3JfjpuxH+Lu87FwRhzoK7oGhhfL49O0wwdKvXu4QL+BOJaqYvQn8o3HZUBsb6HY+kkmpSla3b+eXQ3KVxU3oC1izYwW/pBzE0td+tGEER+ixHIMMw4om5QdGspfwqd2LIfCNfu/cCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OER1NZdi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712623574; x=1744159574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ef+GHsE25y8FCBN2LthYrBmec0jk/70hqRxVZ7B2Uek=;
  b=OER1NZdiJpr12oKsOyQU3rbqwscJ/tZu1bxNTn5vl3iP/FpeFxdyODDN
   z433WE/2S0CBabHqsyZABdKyOvXKLG+CRFQqSL7WyMe2IRVV2FeDm2rM6
   zJRd+RwJPz8SifuJWBllWPvfZ4zW2rw/8F/kfO+faqwyfjC1jAFTCoiHV
   7Qb8m2RwavYpIrX2tgyNkXXVDm/zt5q2s0BPNNg5yVUqceIuRPRqIuSrs
   OVYF4YNKSIxPY8kwKgaUMT2E0rTHzvXNQ8KoRL9YyiyYR7wB48bMW4bJY
   +G00UkyTvfEPbBKkFO2gKOVJIXJPjKoohI9uPpSLZ+ES28sb586IsYCNM
   Q==;
X-CSE-ConnectionGUID: pbMjYv7uRyiTxODUDgDn2g==
X-CSE-MsgGUID: m0Nz6M5cR6GcCQINgZQ5+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7795849"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7795849"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:46:12 -0700
X-CSE-ConnectionGUID: oM6sTgQJRWKOORKaaB5IGA==
X-CSE-MsgGUID: eK2N4OaNSOuxBB+EtmqSWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24691702"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Apr 2024 17:46:08 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtzcj-0005bU-2C;
	Tue, 09 Apr 2024 00:46:05 +0000
Date: Tue, 9 Apr 2024 08:45:19 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-ID: <202404090849.mgJ3z0xI-lkp@intel.com>
References: <20240408145819.8787-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408145819.8787-3-mkoutny@suse.com>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Koutn/tracing-Remove-dependency-of-saved_cmdlines_buffer-on-PID_MAX_DEFAULT/20240408-230031
base:   fec50db7033ea478773b159e0e2efb135270e3b7
patch link:    https://lore.kernel.org/r/20240408145819.8787-3-mkoutny%40suse.com
patch subject: [PATCH 2/3] kernel/pid: Remove default pid_max value
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240409/202404090849.mgJ3z0xI-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404090849.mgJ3z0xI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404090849.mgJ3z0xI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sysctl.c:1819:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1819 |                 .extra2         = &pid_max_max,
         |                                   ^


vim +/const +1819 kernel/sysctl.c

f461d2dcd511c0 Christoph Hellwig   2020-04-24  1617  
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1618  static struct ctl_table kern_table[] = {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1619  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1620  		.procname	= "panic",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1621  		.data		= &panic_timeout,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1622  		.maxlen		= sizeof(int),
49f0ce5f92321c Jerome Marchand     2014-01-21  1623  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman   2009-11-16  1624  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1625  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1626  #ifdef CONFIG_PROC_SYSCTL
^1da177e4c3f41 Linus Torvalds      2005-04-16  1627  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1628  		.procname	= "tainted",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1629  		.maxlen 	= sizeof(long),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1630  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1631  		.proc_handler	= proc_taint,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1632  	},
2da02997e08d3e David Rientjes      2009-01-06  1633  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1634  		.procname	= "sysctl_writes_strict",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1635  		.data		= &sysctl_writes_strict,
9e3961a0979817 Prarit Bhargava     2014-12-10  1636  		.maxlen		= sizeof(int),
2da02997e08d3e David Rientjes      2009-01-06  1637  		.mode		= 0644,
9e3961a0979817 Prarit Bhargava     2014-12-10  1638  		.proc_handler	= proc_dointvec_minmax,
78e36f3b0dae58 Xiaoming Ni         2022-01-21  1639  		.extra1		= SYSCTL_NEG_ONE,
eec4844fae7c03 Matteo Croce        2019-07-18  1640  		.extra2		= SYSCTL_ONE,
2da02997e08d3e David Rientjes      2009-01-06  1641  	},
964c9dff009189 Alexander Popov     2018-08-17  1642  #endif
1efff914afac8a Theodore Ts'o       2015-03-17  1643  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1644  		.procname	= "print-fatal-signals",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1645  		.data		= &print_fatal_signals,
964c9dff009189 Alexander Popov     2018-08-17  1646  		.maxlen		= sizeof(int),
1efff914afac8a Theodore Ts'o       2015-03-17  1647  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1648  		.proc_handler	= proc_dointvec,
1efff914afac8a Theodore Ts'o       2015-03-17  1649  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1650  #ifdef CONFIG_SPARC
^1da177e4c3f41 Linus Torvalds      2005-04-16  1651  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1652  		.procname	= "reboot-cmd",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1653  		.data		= reboot_command,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1654  		.maxlen		= 256,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1655  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1656  		.proc_handler	= proc_dostring,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1657  	},
^1da177e4c3f41 Linus Torvalds      2005-04-16  1658  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1659  		.procname	= "stop-a",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1660  		.data		= &stop_a_enabled,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1661  		.maxlen		= sizeof (int),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1662  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1663  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1664  	},
06808b0827e1cd Lee Schermerhorn    2009-12-14  1665  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1666  		.procname	= "scons-poweroff",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1667  		.data		= &scons_pwroff,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1668  		.maxlen		= sizeof (int),
06808b0827e1cd Lee Schermerhorn    2009-12-14  1669  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman   2009-11-16  1670  		.proc_handler	= proc_dointvec,
06808b0827e1cd Lee Schermerhorn    2009-12-14  1671  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1672  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1673  #ifdef CONFIG_SPARC64
4518085e127dff Kemi Wang           2017-11-15  1674  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1675  		.procname	= "tsb-ratio",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1676  		.data		= &sysctl_tsb_ratio,
4518085e127dff Kemi Wang           2017-11-15  1677  		.maxlen		= sizeof (int),
4518085e127dff Kemi Wang           2017-11-15  1678  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman   2009-11-16  1679  		.proc_handler	= proc_dointvec,
4518085e127dff Kemi Wang           2017-11-15  1680  	},
06808b0827e1cd Lee Schermerhorn    2009-12-14  1681  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1682  #ifdef CONFIG_PARISC
^1da177e4c3f41 Linus Torvalds      2005-04-16  1683  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1684  		.procname	= "soft-power",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1685  		.data		= &pwrsw_enabled,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1686  		.maxlen		= sizeof (int),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1687  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman   2009-11-16  1688  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1689  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1690  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1691  #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW
d1c3fb1f8f29c4 Nishanth Aravamudan 2007-12-17  1692  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1693  		.procname	= "unaligned-trap",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1694  		.data		= &unaligned_enabled,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1695  		.maxlen		= sizeof (int),
d1c3fb1f8f29c4 Nishanth Aravamudan 2007-12-17  1696  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1697  		.proc_handler	= proc_dointvec,
d1c3fb1f8f29c4 Nishanth Aravamudan 2007-12-17  1698  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1699  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1700  #ifdef CONFIG_STACK_TRACER
76ab0f530e4a01 Mel Gorman          2010-05-24  1701  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1702  		.procname	= "stack_tracer_enabled",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1703  		.data		= &stack_tracer_enabled,
76ab0f530e4a01 Mel Gorman          2010-05-24  1704  		.maxlen		= sizeof(int),
2da02997e08d3e David Rientjes      2009-01-06  1705  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1706  		.proc_handler	= stack_trace_sysctl,
76ab0f530e4a01 Mel Gorman          2010-05-24  1707  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1708  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1709  #ifdef CONFIG_TRACING
5e7719058079a1 Mel Gorman          2010-05-24  1710  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1711  		.procname	= "ftrace_dump_on_oops",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1712  		.data		= &ftrace_dump_on_oops,
19f0423fd55c30 Huang Yiwei         2024-02-23  1713  		.maxlen		= MAX_TRACER_SIZE,
5e7719058079a1 Mel Gorman          2010-05-24  1714  		.mode		= 0644,
19f0423fd55c30 Huang Yiwei         2024-02-23  1715  		.proc_handler	= proc_dostring,
5e7719058079a1 Mel Gorman          2010-05-24  1716  	},
5bbe3547aa3ba5 Eric B Munson       2015-04-15  1717  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1718  		.procname	= "traceoff_on_warning",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1719  		.data		= &__disable_trace_on_warning,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1720  		.maxlen		= sizeof(__disable_trace_on_warning),
5bbe3547aa3ba5 Eric B Munson       2015-04-15  1721  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1722  		.proc_handler	= proc_dointvec,
5bbe3547aa3ba5 Eric B Munson       2015-04-15  1723  	},
^1da177e4c3f41 Linus Torvalds      2005-04-16  1724  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1725  		.procname	= "tracepoint_printk",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1726  		.data		= &tracepoint_printk,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1727  		.maxlen		= sizeof(tracepoint_printk),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1728  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1729  		.proc_handler	= tracepoint_printk_sysctl,
1c30844d2dfe27 Mel Gorman          2018-12-28  1730  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1731  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1732  #ifdef CONFIG_MODULES
8ad4b1fb820534 Rohit Seth          2006-01-08  1733  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1734  		.procname	= "modprobe",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1735  		.data		= &modprobe_path,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1736  		.maxlen		= KMOD_PATH_LEN,
8ad4b1fb820534 Rohit Seth          2006-01-08  1737  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1738  		.proc_handler	= proc_dostring,
8ad4b1fb820534 Rohit Seth          2006-01-08  1739  	},
^1da177e4c3f41 Linus Torvalds      2005-04-16  1740  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1741  		.procname	= "modules_disabled",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1742  		.data		= &modules_disabled,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1743  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1744  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1745  		/* only handle a transition from default "0" to "1" */
3e26120cc7c819 WANG Cong           2009-12-17  1746  		.proc_handler	= proc_dointvec_minmax,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1747  		.extra1		= SYSCTL_ONE,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1748  		.extra2		= SYSCTL_ONE,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1749  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1750  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1751  #ifdef CONFIG_UEVENT_HELPER
dd8632a12e500a Paul Mundt          2009-01-08  1752  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1753  		.procname	= "hotplug",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1754  		.data		= &uevent_helper,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1755  		.maxlen		= UEVENT_HELPER_PATH_LEN,
dd8632a12e500a Paul Mundt          2009-01-08  1756  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1757  		.proc_handler	= proc_dostring,
dd8632a12e500a Paul Mundt          2009-01-08  1758  	},
^1da177e4c3f41 Linus Torvalds      2005-04-16  1759  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1760  #ifdef CONFIG_MAGIC_SYSRQ
^1da177e4c3f41 Linus Torvalds      2005-04-16  1761  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1762  		.procname	= "sysrq",
e5ff215941d59f Andi Kleen          2008-07-23  1763  		.data		= NULL,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1764  		.maxlen		= sizeof (int),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1765  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1766  		.proc_handler	= sysrq_sysctl_handler,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1767  	},
^1da177e4c3f41 Linus Torvalds      2005-04-16  1768  #endif
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1769  #ifdef CONFIG_PROC_SYSCTL
^1da177e4c3f41 Linus Torvalds      2005-04-16  1770  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1771  		.procname	= "cad_pid",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1772  		.data		= NULL,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1773  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1774  		.mode		= 0600,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1775  		.proc_handler	= proc_do_cad_pid,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1776  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1777  #endif
9d0243bca345d5 Andrew Morton       2006-01-08  1778  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1779  		.procname	= "threads-max",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1780  		.data		= NULL,
9d0243bca345d5 Andrew Morton       2006-01-08  1781  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds      2005-04-16  1782  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1783  		.proc_handler	= sysctl_max_threads,
9d0243bca345d5 Andrew Morton       2006-01-08  1784  	},
1743660b911bfb Christoph Lameter   2006-01-18  1785  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1786  		.procname	= "overflowuid",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1787  		.data		= &overflowuid,
5e7719058079a1 Mel Gorman          2010-05-24  1788  		.maxlen		= sizeof(int),
1743660b911bfb Christoph Lameter   2006-01-18  1789  		.mode		= 0644,
6b7e5cad651a2b Matthew Wilcox      2019-03-05  1790  		.proc_handler	= proc_dointvec_minmax,
2452dcb9f7f2ba Xiaoming Ni         2022-01-21  1791  		.extra1		= SYSCTL_ZERO,
54771613e8a7db Luis Chamberlain    2022-01-21  1792  		.extra2		= SYSCTL_MAXOLDUID,
1743660b911bfb Christoph Lameter   2006-01-18  1793  	},
9614634fe6a138 Christoph Lameter   2006-07-03  1794  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1795  		.procname	= "overflowgid",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1796  		.data		= &overflowgid,
5bbe3547aa3ba5 Eric B Munson       2015-04-15  1797  		.maxlen		= sizeof(int),
9614634fe6a138 Christoph Lameter   2006-07-03  1798  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1799  		.proc_handler	= proc_dointvec_minmax,
2452dcb9f7f2ba Xiaoming Ni         2022-01-21  1800  		.extra1		= SYSCTL_ZERO,
54771613e8a7db Luis Chamberlain    2022-01-21  1801  		.extra2		= SYSCTL_MAXOLDUID,
9614634fe6a138 Christoph Lameter   2006-07-03  1802  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1803  #ifdef CONFIG_S390
0ff38490c836dc Christoph Lameter   2006-09-25  1804  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1805  		.procname	= "userprocess_debug",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1806  		.data		= &show_unhandled_signals,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1807  		.maxlen		= sizeof(int),
0ff38490c836dc Christoph Lameter   2006-09-25  1808  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1809  		.proc_handler	= proc_dointvec,
0ff38490c836dc Christoph Lameter   2006-09-25  1810  	},
e6e5494cb23d19 Ingo Molnar         2006-06-27  1811  #endif
77461ab33229d4 Christoph Lameter   2007-05-09  1812  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1813  		.procname	= "pid_max",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1814  		.data		= &pid_max,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1815  		.maxlen		= sizeof (int),
77461ab33229d4 Christoph Lameter   2007-05-09  1816  		.mode		= 0644,
26363af5643490 Christoph Hellwig   2020-04-24  1817  		.proc_handler	= proc_dointvec_minmax,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1818  		.extra1		= &pid_max_min,
f461d2dcd511c0 Christoph Hellwig   2020-04-24 @1819  		.extra2		= &pid_max_max,
77461ab33229d4 Christoph Lameter   2007-05-09  1820  	},
52b6f46bc163ee Hugh Dickins        2016-05-19  1821  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1822  		.procname	= "panic_on_oops",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1823  		.data		= &panic_on_oops,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1824  		.maxlen		= sizeof(int),
795ae7a0de6b83 Johannes Weiner     2016-03-17  1825  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1826  		.proc_handler	= proc_dointvec,
52b6f46bc163ee Hugh Dickins        2016-05-19  1827  	},
ed0321895182ff Eric Paris          2007-06-28  1828  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1829  		.procname	= "panic_print",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1830  		.data		= &panic_print,
ed0321895182ff Eric Paris          2007-06-28  1831  		.maxlen		= sizeof(unsigned long),
ed0321895182ff Eric Paris          2007-06-28  1832  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1833  		.proc_handler	= proc_doulongvec_minmax,
ed0321895182ff Eric Paris          2007-06-28  1834  	},
c9b1d0981fcce3 Andrew Shewmaker    2013-04-29  1835  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1836  		.procname	= "ngroups_max",
f628867da46f88 Stephen Kitt        2022-01-21  1837  		.data		= (void *)&ngroups_max,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1838  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1839  		.mode		= 0444,
6d4561110a3e9f Eric W. Biederman   2009-11-16  1840  		.proc_handler	= proc_dointvec,
1743660b911bfb Christoph Lameter   2006-01-18  1841  	},
9614634fe6a138 Christoph Lameter   2006-07-03  1842  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1843  		.procname	= "cap_last_cap",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1844  		.data		= (void *)&cap_last_cap,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1845  		.maxlen		= sizeof(int),
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1846  		.mode		= 0444,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1847  		.proc_handler	= proc_dointvec,
9614634fe6a138 Christoph Lameter   2006-07-03  1848  	},
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1849  #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1850  	{
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1851  		.procname       = "unknown_nmi_panic",
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1852  		.data           = &unknown_nmi_panic,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1853  		.maxlen         = sizeof (int),
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1854  		.mode           = 0644,
f461d2dcd511c0 Christoph Hellwig   2020-04-24  1855  		.proc_handler   = proc_dointvec,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1856  	},
6a46079cf57a7f Andi Kleen          2009-09-16  1857  #endif
cb8e59cc87201a Linus Torvalds      2020-06-03  1858  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

