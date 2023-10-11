Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9ED7C4C62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjJKHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJKHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:51:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D5C91;
        Wed, 11 Oct 2023 00:51:34 -0700 (PDT)
Date:   Wed, 11 Oct 2023 07:51:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697010691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sZF30wAbA82rNqOrNh6BCmdCuBZXTAmOqjYzUziMTk=;
        b=PipZL4XxpAbsi1aSHJdrr9us5RzqC2FOhW7dQERr+8UJJYi2dGcixveVcN9WGWeM/A5t1P
        mYeqzWZUs9ZPSSOLEsTXIKiyvX49nh4b6/pqjWzQ3VTTviInHSaJ2Yw9YDm3/0B9eI9/oA
        OySq86aWfanjFAECqGhCyPKdUIjwkA+b/g7Fo4KJo3LmmDvj4sn1vDGVjvV8l71osdcFeT
        9ZUjGg+DChy1+suKig1XjLFxEadjxx2q5K/ck9ZthZkqjJeqwZIDk0oy96bYiy2uTC8S6U
        6wC+ZuiDR4xcQhJ80yD7nJ7suYrIbvA5QL2JLYdcAUyYJzVIuwq6QWWGaFgsGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697010691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sZF30wAbA82rNqOrNh6BCmdCuBZXTAmOqjYzUziMTk=;
        b=J48X8PFLjQPa4YCJ96ZjHFI6tmmsXFGJxXFUo3fk7bk+vGJwUHeEePztbhb7nobTjV3ZTF
        N78frv4M1ZzGWICw==
From:   "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix remaining kernel-doc warnings
Cc:     kernel test robot <lkp@intel.com>,
        "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Newman <peternewman@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231011064843.246592-1-maciej.wieczor-retman@intel.com>
References: <20231011064843.246592-1-maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Message-ID: <169701069048.3135.14380926776858367197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f05fd4ce99635975caa3e6a0eeb02118637f72a3
Gitweb:        https://git.kernel.org/tip/f05fd4ce99635975caa3e6a0eeb02118637f72a3
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Wed, 11 Oct 2023 08:48:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Oct 2023 09:44:41 +02:00

x86/resctrl: Fix remaining kernel-doc warnings

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

Closes: https://lore.kernel.org/oe-kbuild-all/202310070434.mD8eRNAz-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Newman <peternewman@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20231011064843.246592-1-maciej.wieczor-retman@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7253440..a52cdf9 100644
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
