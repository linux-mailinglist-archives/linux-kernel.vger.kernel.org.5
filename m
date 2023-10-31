Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA87DCFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjJaPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjJaPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:11:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA81F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698765059; x=1730301059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sncHb8N64StAqzTXvm19WT9pM90bLF04U6+sY/o4zzk=;
  b=L5bV7N6hLmTIJ4PdPRDouPLL5R0fljLjm0OCE7VMnkSj6GD7LjZ9QSV1
   0YsFLU66Ax6D7aQmLf9AUGwU/ydydXNrSV0JS3awbX2yu1tLL4zJlsVkC
   f56YyJBfwqzvljAGwO5yvm+/5QVeQZR809Wuvns4pJkOeP5sBLzp2J25Q
   hq5B7R3jozuF1BzyHq558IIzWKHOdl3oU75X20K2aEKBtZDvN63IM1/q8
   cIEI6fy2j/xBo8peHqYSsq+Gykofses8ashzYdulRev63zzs0T7uYHzYY
   3A35faGgDP0tLqt+SEtdMgJUdgSyd5i6b2wpsxIt4B4b9PsdVZfTVSFRI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373357176"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="373357176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 08:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="710452564"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="710452564"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Oct 2023 08:10:28 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxqNu-0000EW-0R;
        Tue, 31 Oct 2023 15:10:26 +0000
Date:   Tue, 31 Oct 2023 23:09:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>
Subject: kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202310312340.LW2o2xTj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a6a09e97199d6600d31383055f9d43fbbcbe86f
commit: e240e53ae0abb0896e0f399bdfef41c69cec3123 mm, slub: add CONFIG_SLUB_TINY
date:   11 months ago
config: x86_64-randconfig-a013-20230614 (https://download.01.org/0day-ci/archive/20231031/202310312340.LW2o2xTj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310312340.LW2o2xTj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310312340.LW2o2xTj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1096:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
   kernel/fork.c:1096:19: sparse:     expected struct task_struct [noderef] __rcu *owner
   kernel/fork.c:1096:19: sparse:     got struct task_struct *p
   kernel/fork.c:1310:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1310:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1310:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1310:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1310:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1310:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
   kernel/fork.c:1637:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1637:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1637:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1646:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1646:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1646:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1647:9: sparse:     expected void const *
   kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
>> kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1647:9: sparse:     expected void const *
   kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1647:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1647:9: sparse:     expected void const *
   kernel/fork.c:1647:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1648:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1648:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1648:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2074:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2074:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2074:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2078:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2078:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2078:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2398:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2398:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2398:32: sparse:     got struct task_struct *
   kernel/fork.c:2407:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2407:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2407:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2454:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2454:54: sparse:     expected struct list_head *head
   kernel/fork.c:2454:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2476:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2476:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2476:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2497:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2497:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2497:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2524:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2524:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2524:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2553:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2553:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2553:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2555:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2555:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2555:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2998:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2998:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2998:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3079:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3079:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3079:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1742:9: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2119:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2452:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2453:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1088:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1088:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/fork.c:1088:23: sparse:    struct task_struct *
--
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
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
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
--
>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void const *
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/cirrusfb.c:1853:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     expected void *
   drivers/video/fbdev/cirrusfb.c:1853:17: sparse:     got char [noderef] __iomem *screen_base
--
   drivers/gpu/drm/gma500/opregion.c:294:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct opregion_header *header @@
   drivers/gpu/drm/gma500/opregion.c:294:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/gma500/opregion.c:294:25: sparse:     got struct opregion_header *header
>> drivers/gpu/drm/gma500/opregion.c:324:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got void [noderef] __iomem *[assigned] base @@
   drivers/gpu/drm/gma500/opregion.c:324:20: sparse:     expected void const *const p
   drivers/gpu/drm/gma500/opregion.c:324:20: sparse:     got void [noderef] __iomem *[assigned] base
   drivers/gpu/drm/gma500/opregion.c:330:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_header *header @@     got void [noderef] __iomem *[assigned] base @@
   drivers/gpu/drm/gma500/opregion.c:330:26: sparse:     expected struct opregion_header *header
   drivers/gpu/drm/gma500/opregion.c:330:26: sparse:     got void [noderef] __iomem *[assigned] base
   drivers/gpu/drm/gma500/opregion.c:331:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *vbt @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:331:23: sparse:     expected void *vbt
   drivers/gpu/drm/gma500/opregion.c:331:23: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/gma500/opregion.c:338:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_acpi *acpi @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:338:32: sparse:     expected struct opregion_acpi *acpi
   drivers/gpu/drm/gma500/opregion.c:338:32: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/gma500/opregion.c:343:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct opregion_asle *asle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/gma500/opregion.c:343:32: sparse:     expected struct opregion_asle *asle
   drivers/gpu/drm/gma500/opregion.c:343:32: sparse:     got void [noderef] __iomem *
--
>> drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse:     expected void const *const p
   drivers/gpu/drm/gma500/intel_bios.c:548:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/gpu/drm/gma500/intel_bios.c:549:40: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/gma500/intel_bios.c:559:24: sparse: sparse: cast removes address space '__iomem' of expression

vim +1647 kernel/fork.c

a016f3389c0660 JANAK DESAI        2006-02-07  1631  
a39bc51691a0c8 Alexey Dobriyan    2007-10-18  1632  static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1633  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1634  	struct sighand_struct *sig;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1635  
60348802e9cb13 Zhaolei            2009-01-06  1636  	if (clone_flags & CLONE_SIGHAND) {
d036bda7d0e726 Elena Reshetova    2019-01-18  1637  		refcount_inc(&current->sighand->count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1638  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1639  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1640  	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
0c282b068eb26d Madhuparna Bhowmik 2020-01-27  1641  	RCU_INIT_POINTER(tsk->sighand, sig);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1642  	if (!sig)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1643  		return -ENOMEM;
9d7fb04276481c Peter Zijlstra     2015-06-30  1644  
d036bda7d0e726 Elena Reshetova    2019-01-18  1645  	refcount_set(&sig->count, 1);
06e62a46bbba20 Jann Horn          2018-08-21  1646  	spin_lock_irq(&current->sighand->siglock);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @1647  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
06e62a46bbba20 Jann Horn          2018-08-21  1648  	spin_unlock_irq(&current->sighand->siglock);
b612e5df4587c9 Christian Brauner  2019-10-14  1649  
b612e5df4587c9 Christian Brauner  2019-10-14  1650  	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
b612e5df4587c9 Christian Brauner  2019-10-14  1651  	if (clone_flags & CLONE_CLEAR_SIGHAND)
b612e5df4587c9 Christian Brauner  2019-10-14  1652  		flush_signal_handlers(tsk, 0);
b612e5df4587c9 Christian Brauner  2019-10-14  1653  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1654  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1655  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1656  

:::::: The code at line 1647 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
