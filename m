Return-Path: <linux-kernel+bounces-11543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCC81E7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553E91F229B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B34F1EB;
	Tue, 26 Dec 2023 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iupV3ZoV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3904CB4D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703603387; x=1735139387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pHSU8MVo6p1xyF3f0c//8aO9HHhpPsw0Hxab4DhSaD0=;
  b=iupV3ZoVdTd42qI0z1xBFqVC73fz3CDvCzNUwdM6yS+oYbEFpqVZvEdk
   YefevgXZxA1XieCxotHFS5YSgZHYSRZMMb+c94y9FCq5KYfyIWiINJdqU
   9XDZlybBU8G1pRLk+0flB12AtXAwha5AV9LuslcCo7B2/4cw3TjbP7tju
   Zj+6uUDCO9g6xNMNSSOrb9HWt1SdKrbj/Til1liHJTD9E4+ObLFTbNGa7
   eWwzOnY7pwvilQJ7YeqVZDEaSMexHgOsOATce6GixF2tQ8U3i3sLXDszd
   5cdLFAHU1sxLxJjSMcui2w/hvErD17oZlK5ctJ6aKpuI5OYBNNIwebY7c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="375848606"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="375848606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 07:09:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="727768230"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="727768230"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2023 07:09:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI93t-000EYH-15;
	Tue, 26 Dec 2023 15:09:41 +0000
Date: Tue, 26 Dec 2023 23:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Elver <elver@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312262344.c7Ep2cj3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950 kasan, x86: don't rename memintrinsics in uninstrumented files
date:   10 months ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231226/202312262344.c7Ep2cj3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312262344.c7Ep2cj3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312262344.c7Ep2cj3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void *p
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *q
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void *p
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *q
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
--
   drivers/acpi/apei/erst.c:272:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *src @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:272:13: sparse:     expected void *src
   drivers/acpi/apei/erst.c:272:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:275:13: sparse:     expected void *dst
   drivers/acpi/apei/erst.c:275:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:277:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:277:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:277:25: sparse:     got void *src
   drivers/acpi/apei/erst.c:283:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:283:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:283:17: sparse:     got void *src
   drivers/acpi/apei/erst.c:284:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *dst @@
   drivers/acpi/apei/erst.c:284:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:284:17: sparse:     got void *dst
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void *p
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:793:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_erange @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:793:20: sparse:     expected struct cper_record_header *rcd_erange
   drivers/acpi/apei/erst.c:793:20: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:830:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_tmp @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:830:17: sparse:     expected struct cper_record_header *rcd_tmp
   drivers/acpi/apei/erst.c:830:17: sparse:     got void [noderef] __iomem *
--
   kernel/fork.c:1110:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
   kernel/fork.c:1110:19: sparse:     expected struct task_struct [noderef] __rcu *owner
   kernel/fork.c:1110:19: sparse:     got struct task_struct *p
   kernel/fork.c:1334:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1334:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1334:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1334:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1334:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1334:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
   kernel/fork.c:1662:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1662:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1662:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1671:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1671:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1671:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
>> kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *q
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1673:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1673:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1673:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1767:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/fork.c:1767:9: sparse:     expected struct qspinlock *lock
   kernel/fork.c:1767:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/fork.c:2090:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2090:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2090:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2094:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2094:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2094:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2414:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2414:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2414:32: sparse:     got struct task_struct *
   kernel/fork.c:2423:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2423:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2423:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2472:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2472:54: sparse:     expected struct list_head *head
   kernel/fork.c:2472:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2494:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2494:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2494:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2515:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2515:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2515:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2542:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2542:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2542:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2571:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2571:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2571:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2573:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2573:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2573:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:3011:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:3011:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:3011:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3096:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3096:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3096:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2135:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2470:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2471:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1102:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1102:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/fork.c:1102:23: sparse:    struct task_struct *

vim +496 drivers/video/fbdev/hgafb.c

^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  482  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  483  static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  484  {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  485  	u_int rows, y1, y2;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  486  	u8 __iomem *src;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  487  	u8 __iomem *dest;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  488  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  489  	if (area->dy <= area->sy) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  490  		y1 = area->sy;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  491  		y2 = area->dy;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  492  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  493  		for (rows = area->height; rows--; ) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  494  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  495  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d drivers/video/hgafb.c Brent Cook     2010-12-31 @496  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  497  			y1++;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  498  			y2++;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  499  		}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  500  	} else {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  501  		y1 = area->sy + area->height - 1;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  502  		y2 = area->dy + area->height - 1;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  503  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  504  		for (rows = area->height; rows--;) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  505  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  506  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d drivers/video/hgafb.c Brent Cook     2010-12-31  507  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  508  			y1--;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  509  			y2--;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  510  		}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  511  	}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  512  }
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  513  

:::::: The code at line 496 was first introduced by commit
:::::: 529ed806d4540d23ca2f68b28c3715d1566fc3ac video: Fix the HGA framebuffer driver

:::::: TO: Brent Cook <busterb@gmail.com>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

