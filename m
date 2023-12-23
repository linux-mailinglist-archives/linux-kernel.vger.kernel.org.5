Return-Path: <linux-kernel+bounces-10478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CFB81D4D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8F91F22150
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA4FC18;
	Sat, 23 Dec 2023 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZScKfS1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF70DF63
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703344854; x=1734880854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/NIzd7yX1JEMpdJsT9uPluoDW3utdI9u9GJ4bU3W66I=;
  b=GZScKfS18WQNxgqaYJZFyJYxemr8SZ+BQYyGfVCydwQa8EXKdY2iV7MN
   gp3PWPYX5XzirCikOnfv8OmzR0G7mEhtGISwboFzv14eT2LPFArTkFF/F
   kH0FGxN8pt/p95gYMwp9UdH8PYRt7WbicDtCUm33d5GP847VGUiIXihDW
   /S3XxW6MIDZyMJZb5TlHzgHN5f81/1gDsRMzeJBLP3Utg/gneTAo/uDPF
   d0qJLe0qhs1+He5mkvpHbbeXEtwbcSXYtCvxRUsmsF8JoIpkIlthJEnhZ
   lIrkQEQTGjAByH0KBYIjFDkDj21GX3+EVUOg/nd3690i1cDBmEXLByFU8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="375695817"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="375695817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 07:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="11818305"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 23 Dec 2023 07:20:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH3nD-000B8r-0R;
	Sat, 23 Dec 2023 15:20:09 +0000
Date: Sat, 23 Dec 2023 23:19:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: kernel/trace/ftrace.c:1608:18: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202312232303.ywYrcraO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
commit: 3306fc4aff464f9c08c8899695a218f4b1125d4a ftrace: Create new ftrace_internal.h header
date:   5 years ago
config: i386-randconfig-061-20231101 (https://download.01.org/0day-ci/archive/20231223/202312232303.ywYrcraO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312232303.ywYrcraO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312232303.ywYrcraO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/ftrace.c:118:59: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:118:59: sparse:     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:118:59: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:212:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:212:49: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:212:49: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:295:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu * @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:295:23: sparse:     expected struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:295:23: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:299:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu **list @@
   kernel/trace/ftrace.c:299:16: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:299:16: sparse:     got struct ftrace_ops [noderef] __rcu **list
   kernel/trace/ftrace.c:299:50: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu ** @@
   kernel/trace/ftrace.c:299:50: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:299:50: sparse:     got struct ftrace_ops [noderef] __rcu **
   kernel/trace/ftrace.c:306:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops * @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:306:12: sparse:     expected struct ftrace_ops *
   kernel/trace/ftrace.c:306:12: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:592:5: sparse: sparse: symbol 'ftrace_profile_pages_init' was not declared. Should it be static?
   kernel/trace/ftrace.c:1045:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1045:43: sparse:     expected struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1045:43: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1046:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1046:43: sparse:     expected struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1046:43: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1268:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1268:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1268:40: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1269:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1269:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1269:40: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1930:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *old_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1930:54: sparse:     expected struct ftrace_hash *old_hash
   kernel/trace/ftrace.c:1930:54: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1445:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:1445:9: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:1445:9: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:1445:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:1445:9: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:1445:9: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:1461:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1461:39: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1461:39: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1462:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1462:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1462:40: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1463:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1463:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1463:40: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1464:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1464:42: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1464:42: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
>> kernel/trace/ftrace.c:1608:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:1608:18: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:1608:18: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:1609:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:1609:43: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:1609:43: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:1650:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1650:22: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1650:22: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1651:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *other_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1651:28: sparse:     expected struct ftrace_hash *other_hash
   kernel/trace/ftrace.c:1651:28: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1656:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1656:22: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1656:22: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1657:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *other_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1657:28: sparse:     expected struct ftrace_hash *other_hash
   kernel/trace/ftrace.c:1657:28: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1908:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1908:50: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1908:50: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1919:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1919:50: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1919:50: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:2993:24: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/ftrace.c:3085:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3085:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3085:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3094:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3094:22: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3094:22: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3546:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3546:22: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3546:22: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:3549:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3549:22: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3549:22: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3913:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:3913:27: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:3913:27: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:3915:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:3915:27: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:3915:27: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4280:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4280:19: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4280:19: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4417:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4417:19: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4417:19: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4423:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[assigned] old_hash @@
   kernel/trace/ftrace.c:4423:34: sparse:     expected struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:4423:34: sparse:     got struct ftrace_hash *[assigned] old_hash
   kernel/trace/ftrace.c:4675:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4675:27: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4675:27: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4677:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4677:27: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4677:27: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4714:37: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/ftrace.c:4961:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4961:35: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4961:35: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:4965:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:4965:35: sparse:     expected struct ftrace_hash **orig_hash
   kernel/trace/ftrace.c:4965:35: sparse:     got struct ftrace_hash [noderef] __rcu **
   kernel/trace/ftrace.c:5601:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:5601:18: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:5601:18: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:5601:66: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:5601:66: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:5601:66: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:5642:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5642:59: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:5642:59: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:5643:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:5643:59: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:5643:59: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:6000:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6000:62: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:6000:62: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:6001:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:6001:62: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:6001:62: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:6047:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:6047:36: sparse:    struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:6047:36: sparse:    struct ftrace_ops *
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c: note: in included file:
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y

vim +1608 kernel/trace/ftrace.c

33dc9b1267d59c Steven Rostedt           2011-05-02  1451  
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1452) static bool hash_contains_ip(unsigned long ip,
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1453) 			     struct ftrace_ops_hash *hash)
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1454) {
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1455) 	/*
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1456) 	 * The function record is a match if it exists in the filter
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1457) 	 * hash and not in the notrace hash. Note, an emty hash is
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1458) 	 * considered a match for the filter hash, but an empty
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1459) 	 * notrace hash is considered not in the notrace hash.
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1460) 	 */
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1461) 	return (ftrace_hash_empty(hash->filter_hash) ||
2b2c279c814112 Steven Rostedt (VMware   2017-02-01 @1462) 		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1463) 		(ftrace_hash_empty(hash->notrace_hash) ||
2b2c279c814112 Steven Rostedt (VMware   2017-02-01  1464) 		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1465) }
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1466) 
b848914ce39589 Steven Rostedt           2011-05-04  1467  /*
b848914ce39589 Steven Rostedt           2011-05-04  1468   * Test the hashes for this ops to see if we want to call
b848914ce39589 Steven Rostedt           2011-05-04  1469   * the ops->func or not.
b848914ce39589 Steven Rostedt           2011-05-04  1470   *
b848914ce39589 Steven Rostedt           2011-05-04  1471   * It's a match if the ip is in the ops->filter_hash or
b848914ce39589 Steven Rostedt           2011-05-04  1472   * the filter_hash does not exist or is empty,
b848914ce39589 Steven Rostedt           2011-05-04  1473   *  AND
b848914ce39589 Steven Rostedt           2011-05-04  1474   * the ip is not in the ops->notrace_hash.
cdbe61bfe70440 Steven Rostedt           2011-05-05  1475   *
cdbe61bfe70440 Steven Rostedt           2011-05-05  1476   * This needs to be called with preemption disabled as
cdbe61bfe70440 Steven Rostedt           2011-05-05  1477   * the hashes are freed with call_rcu_sched().
b848914ce39589 Steven Rostedt           2011-05-04  1478   */
3306fc4aff464f Steven Rostedt (VMware   2018-11-15  1479) int
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1480) ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
b848914ce39589 Steven Rostedt           2011-05-04  1481  {
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1482) 	struct ftrace_ops_hash hash;
b848914ce39589 Steven Rostedt           2011-05-04  1483  	int ret;
b848914ce39589 Steven Rostedt           2011-05-04  1484  
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1485) #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1486) 	/*
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1487) 	 * There's a small race when adding ops that the ftrace handler
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1488) 	 * that wants regs, may be called without them. We can not
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1489) 	 * allow that handler to be called if regs is NULL.
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1490) 	 */
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1491) 	if (regs == NULL && (ops->flags & FTRACE_OPS_FL_SAVE_REGS))
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1492) 		return 0;
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1493) #endif
195a8afc7ac962 Steven Rostedt (Red Hat  2013-07-23  1494) 
f86f418059b94a Chunyan Zhang            2017-06-07  1495  	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
f86f418059b94a Chunyan Zhang            2017-06-07  1496  	rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
b848914ce39589 Steven Rostedt           2011-05-04  1497  
fef5aeeee9e371 Steven Rostedt (Red Hat  2014-07-24  1498) 	if (hash_contains_ip(ip, &hash))
b848914ce39589 Steven Rostedt           2011-05-04  1499  		ret = 1;
b848914ce39589 Steven Rostedt           2011-05-04  1500  	else
b848914ce39589 Steven Rostedt           2011-05-04  1501  		ret = 0;
b848914ce39589 Steven Rostedt           2011-05-04  1502  
b848914ce39589 Steven Rostedt           2011-05-04  1503  	return ret;
b848914ce39589 Steven Rostedt           2011-05-04  1504  }
b848914ce39589 Steven Rostedt           2011-05-04  1505  
493762fc534c71 Steven Rostedt           2009-03-23  1506  /*
493762fc534c71 Steven Rostedt           2009-03-23  1507   * This is a double for. Do not use 'break' to break out of the loop,
493762fc534c71 Steven Rostedt           2009-03-23  1508   * you must use a goto.
493762fc534c71 Steven Rostedt           2009-03-23  1509   */
493762fc534c71 Steven Rostedt           2009-03-23  1510  #define do_for_each_ftrace_rec(pg, rec)					\
493762fc534c71 Steven Rostedt           2009-03-23  1511  	for (pg = ftrace_pages_start; pg; pg = pg->next) {		\
493762fc534c71 Steven Rostedt           2009-03-23  1512  		int _____i;						\
493762fc534c71 Steven Rostedt           2009-03-23  1513  		for (_____i = 0; _____i < pg->index; _____i++) {	\
493762fc534c71 Steven Rostedt           2009-03-23  1514  			rec = &pg->records[_____i];
493762fc534c71 Steven Rostedt           2009-03-23  1515  
493762fc534c71 Steven Rostedt           2009-03-23  1516  #define while_for_each_ftrace_rec()		\
493762fc534c71 Steven Rostedt           2009-03-23  1517  		}				\
bac429f037f1a5 Steven Rostedt           2009-03-20  1518  	}
bac429f037f1a5 Steven Rostedt           2009-03-20  1519  
5855fead9cc358 Steven Rostedt           2011-12-16  1520  
5855fead9cc358 Steven Rostedt           2011-12-16  1521  static int ftrace_cmp_recs(const void *a, const void *b)
5855fead9cc358 Steven Rostedt           2011-12-16  1522  {
a650e02a528ab9 Steven Rostedt           2012-04-25  1523  	const struct dyn_ftrace *key = a;
a650e02a528ab9 Steven Rostedt           2012-04-25  1524  	const struct dyn_ftrace *rec = b;
5855fead9cc358 Steven Rostedt           2011-12-16  1525  
a650e02a528ab9 Steven Rostedt           2012-04-25  1526  	if (key->flags < rec->ip)
5855fead9cc358 Steven Rostedt           2011-12-16  1527  		return -1;
a650e02a528ab9 Steven Rostedt           2012-04-25  1528  	if (key->ip >= rec->ip + MCOUNT_INSN_SIZE)
a650e02a528ab9 Steven Rostedt           2012-04-25  1529  		return 1;
5855fead9cc358 Steven Rostedt           2011-12-16  1530  	return 0;
5855fead9cc358 Steven Rostedt           2011-12-16  1531  }
5855fead9cc358 Steven Rostedt           2011-12-16  1532  
04cf31a759ef57 Michael Ellerman         2016-03-24  1533  /**
04cf31a759ef57 Michael Ellerman         2016-03-24  1534   * ftrace_location_range - return the first address of a traced location
04cf31a759ef57 Michael Ellerman         2016-03-24  1535   *	if it touches the given ip range
04cf31a759ef57 Michael Ellerman         2016-03-24  1536   * @start: start of range to search.
04cf31a759ef57 Michael Ellerman         2016-03-24  1537   * @end: end of range to search (inclusive). @end points to the last byte
04cf31a759ef57 Michael Ellerman         2016-03-24  1538   *	to check.
04cf31a759ef57 Michael Ellerman         2016-03-24  1539   *
04cf31a759ef57 Michael Ellerman         2016-03-24  1540   * Returns rec->ip if the related ftrace location is a least partly within
04cf31a759ef57 Michael Ellerman         2016-03-24  1541   * the given address range. That is, the first address of the instruction
04cf31a759ef57 Michael Ellerman         2016-03-24  1542   * that is either a NOP or call to the function tracer. It checks the ftrace
04cf31a759ef57 Michael Ellerman         2016-03-24  1543   * internal tables to determine if the address belongs or not.
04cf31a759ef57 Michael Ellerman         2016-03-24  1544   */
04cf31a759ef57 Michael Ellerman         2016-03-24  1545  unsigned long ftrace_location_range(unsigned long start, unsigned long end)
c88fd8634ea68e Steven Rostedt           2011-08-16  1546  {
c88fd8634ea68e Steven Rostedt           2011-08-16  1547  	struct ftrace_page *pg;
c88fd8634ea68e Steven Rostedt           2011-08-16  1548  	struct dyn_ftrace *rec;
5855fead9cc358 Steven Rostedt           2011-12-16  1549  	struct dyn_ftrace key;
c88fd8634ea68e Steven Rostedt           2011-08-16  1550  
a650e02a528ab9 Steven Rostedt           2012-04-25  1551  	key.ip = start;
a650e02a528ab9 Steven Rostedt           2012-04-25  1552  	key.flags = end;	/* overload flags, as it is unsigned long */
5855fead9cc358 Steven Rostedt           2011-12-16  1553  
5855fead9cc358 Steven Rostedt           2011-12-16  1554  	for (pg = ftrace_pages_start; pg; pg = pg->next) {
a650e02a528ab9 Steven Rostedt           2012-04-25  1555  		if (end < pg->records[0].ip ||
a650e02a528ab9 Steven Rostedt           2012-04-25  1556  		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
9644302e3315e7 Steven Rostedt           2012-04-25  1557  			continue;
5855fead9cc358 Steven Rostedt           2011-12-16  1558  		rec = bsearch(&key, pg->records, pg->index,
5855fead9cc358 Steven Rostedt           2011-12-16  1559  			      sizeof(struct dyn_ftrace),
5855fead9cc358 Steven Rostedt           2011-12-16  1560  			      ftrace_cmp_recs);
5855fead9cc358 Steven Rostedt           2011-12-16  1561  		if (rec)
f0cf973a224a3e Steven Rostedt           2012-04-25  1562  			return rec->ip;
5855fead9cc358 Steven Rostedt           2011-12-16  1563  	}
c88fd8634ea68e Steven Rostedt           2011-08-16  1564  
c88fd8634ea68e Steven Rostedt           2011-08-16  1565  	return 0;
c88fd8634ea68e Steven Rostedt           2011-08-16  1566  }
c88fd8634ea68e Steven Rostedt           2011-08-16  1567  
a650e02a528ab9 Steven Rostedt           2012-04-25  1568  /**
a650e02a528ab9 Steven Rostedt           2012-04-25  1569   * ftrace_location - return true if the ip giving is a traced location
a650e02a528ab9 Steven Rostedt           2012-04-25  1570   * @ip: the instruction pointer to check
a650e02a528ab9 Steven Rostedt           2012-04-25  1571   *
f0cf973a224a3e Steven Rostedt           2012-04-25  1572   * Returns rec->ip if @ip given is a pointer to a ftrace location.
a650e02a528ab9 Steven Rostedt           2012-04-25  1573   * That is, the instruction that is either a NOP or call to
a650e02a528ab9 Steven Rostedt           2012-04-25  1574   * the function tracer. It checks the ftrace internal tables to
a650e02a528ab9 Steven Rostedt           2012-04-25  1575   * determine if the address belongs or not.
a650e02a528ab9 Steven Rostedt           2012-04-25  1576   */
f0cf973a224a3e Steven Rostedt           2012-04-25  1577  unsigned long ftrace_location(unsigned long ip)
a650e02a528ab9 Steven Rostedt           2012-04-25  1578  {
a650e02a528ab9 Steven Rostedt           2012-04-25  1579  	return ftrace_location_range(ip, ip);
a650e02a528ab9 Steven Rostedt           2012-04-25  1580  }
a650e02a528ab9 Steven Rostedt           2012-04-25  1581  
a650e02a528ab9 Steven Rostedt           2012-04-25  1582  /**
a650e02a528ab9 Steven Rostedt           2012-04-25  1583   * ftrace_text_reserved - return true if range contains an ftrace location
a650e02a528ab9 Steven Rostedt           2012-04-25  1584   * @start: start of range to search
a650e02a528ab9 Steven Rostedt           2012-04-25  1585   * @end: end of range to search (inclusive). @end points to the last byte to check.
a650e02a528ab9 Steven Rostedt           2012-04-25  1586   *
a650e02a528ab9 Steven Rostedt           2012-04-25  1587   * Returns 1 if @start and @end contains a ftrace location.
a650e02a528ab9 Steven Rostedt           2012-04-25  1588   * That is, the instruction that is either a NOP or call to
a650e02a528ab9 Steven Rostedt           2012-04-25  1589   * the function tracer. It checks the ftrace internal tables to
a650e02a528ab9 Steven Rostedt           2012-04-25  1590   * determine if the address belongs or not.
a650e02a528ab9 Steven Rostedt           2012-04-25  1591   */
d88471cb8b17a7 Sasha Levin              2013-01-09  1592  int ftrace_text_reserved(const void *start, const void *end)
a650e02a528ab9 Steven Rostedt           2012-04-25  1593  {
f0cf973a224a3e Steven Rostedt           2012-04-25  1594  	unsigned long ret;
f0cf973a224a3e Steven Rostedt           2012-04-25  1595  
f0cf973a224a3e Steven Rostedt           2012-04-25  1596  	ret = ftrace_location_range((unsigned long)start,
a650e02a528ab9 Steven Rostedt           2012-04-25  1597  				    (unsigned long)end);
f0cf973a224a3e Steven Rostedt           2012-04-25  1598  
f0cf973a224a3e Steven Rostedt           2012-04-25  1599  	return (int)!!ret;
a650e02a528ab9 Steven Rostedt           2012-04-25  1600  }
a650e02a528ab9 Steven Rostedt           2012-04-25  1601  
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1602) /* Test if ops registered to this rec needs regs */
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1603) static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1604) {
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1605) 	struct ftrace_ops *ops;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1606) 	bool keep_regs = false;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1607) 
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30 @1608) 	for (ops = ftrace_ops_list;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1609) 	     ops != &ftrace_list_end; ops = ops->next) {
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1610) 		/* pass rec in as regs to have non-NULL val */
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1611) 		if (ftrace_ops_test(ops, rec->ip, rec)) {
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1612) 			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1613) 				keep_regs = true;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1614) 				break;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1615) 			}
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1616) 		}
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1617) 	}
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1618) 
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1619) 	return  keep_regs;
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1620) }
4fbb48cb110be6 Steven Rostedt (Red Hat  2014-04-30  1621) 

:::::: The code at line 1608 was first introduced by commit
:::::: 4fbb48cb110be653adcd97a87506e0ba8c16d585 ftrace: Allow no regs if no more callbacks require it

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

