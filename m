Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D187C4AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjJKGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbjJKGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:49:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F99B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697006945; x=1728542945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hlyGqO4XGzUN88csFWRMFotKs6jChLeK0gfu/Wwm6PI=;
  b=czXgptSSbGrVONnVmImEoG7X55S0vz/KskBtEFaBkAwBXvzU2zh1cB4w
   p7JC+LUWDUm4+/NjwRpJRjzCs+L+e4EmsaXv0tX4yF2n4x0ayIWC08EoY
   2E9kCdsHOYwe7AhpTkA0ZcGHJ68z9PCQ1JMNOU8POqE+28vNNALp733zL
   6Z9AwluCbOUp8RxolWHaaP1P6CYLv/DiqxCHxIVPptOJ0iTqiB3Tn1XsR
   KkuYQYBnbE1iEmyj/mYgVfYrnKyGCpZ+kiEGtEgCFGrh6cQG6c3CQkHMX
   WNjK84i/0XE0UMdemqs9zcojJUE2XcqpqbBXapVgV3X+8fONcIPXdYWIe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="470856929"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="470856929"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877553708"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877553708"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:48:59 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <jamie@nuviainc.com>
Cc:     kernel test robot <lkp@intel.com>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: Fix remaining kernel-doc warnings
Date:   Wed, 11 Oct 2023 08:48:42 +0200
Message-ID: <20231011064843.246592-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reported kernel-doc warnings here:

arch/x86/kernel/cpu/resctrl/rdtgroup.c:915: warning: Function parameter or member 'of' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:915: warning: Function parameter or member 'seq' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:915: warning: Function parameter or member 'v' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1144: warning: Function parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1224: warning: Function parameter or member 'rdtgrp' not described in 'rdtgroup_mode_test_exclusive'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1261: warning: Function parameter or member 'of' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1261: warning: Function parameter or member 'buf' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1261: warning: Function parameter or member 'nbytes' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1261: warning: Function parameter or member 'off' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1370: warning: Function parameter or member 'of' not described in 'rdtgroup_size_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1370: warning: Function parameter or member 's' not described in 'rdtgroup_size_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1370: warning: Function parameter or member 'v' not described in 'rdtgroup_size_show'

The first two functions are missing an argument description while the
other three are file callbacks and don't require a kernel-doc comment.

Fixes: e651901187ab ("x86/intel_rdt: Introduce "bit_usage" to display cache allocations details")
Fixes: fa8f711d2f14 ("x86/resctrl: Pass configuration type to resctrl_arch_get_config()")
Fixes: 49f7b4efa110 ("x86/intel_rdt: Enable setting of exclusive mode")
Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups' allocations' size in bytes")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310070434.mD8eRNAz-lkp@intel.com/
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
First three warnings originally reported by kernel test robot are not
fixed here since they have already been addressed in [1] and merged
into x86/urgent.

[1] https://lore.kernel.org/all/20231006235132.16227-1-rdunlap@infradead.org/

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..a52cdf97c21c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -895,7 +895,7 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-/**
+/*
  * rdt_bit_usage_show - Display current usage of resources
  *
  * A domain is a shared resource that can now be allocated differently. Here
@@ -1123,6 +1123,7 @@ static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
  * @closid: Intended closid for @cbm.
+ * @type: CDP type of @r.
  * @exclusive: Only check if overlaps with exclusive resource groups
  *
  * Checks if provided @cbm intended to be used for @closid on domain
@@ -1209,6 +1210,7 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 
 /**
  * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
+ * @rdtgrp: Resource group identified through its closid.
  *
  * An exclusive resource group implies that there should be no sharing of
  * its allocated resources. At the time this group is considered to be
@@ -1251,9 +1253,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 	return true;
 }
 
-/**
+/*
  * rdtgroup_mode_write - Modify the resource group's mode
- *
  */
 static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
@@ -1357,12 +1358,11 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	return size;
 }
 
-/**
+/*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *
  * The "size" file mirrors the layout of the "schemata" file, printing the
  * size in bytes of each region instead of the capacity bitmask.
- *
  */
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
-- 
2.42.0

