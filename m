Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC0811DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjLMTDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjLMTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB756B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF17C433CB;
        Wed, 13 Dec 2023 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702494233;
        bh=KJAl103OAFoAr+UeUtJKB48jbALa8Ynn0eVxO6I87hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4ZYtp9e6u1S7vJVoTQuManLwGlrjOeID7BQLcnqFPRmQJPlm0o42k6kIz6uqAfU+
         /HE5a9iWB/nCg4QL7ho2iGnYV78Rzv91bOo4uwfG8hwgqoniBuN+bYKp600U99SX/2
         z4TYpYXhvBqmr2HXUHooXJ56cx0BIyv65XrswEfh3fot7+WOrwj6Dh0fGrxS/qXJ0d
         MwDbUOg8Llty3aCoY3Nb/Jb2XinjBJdNkkEJeB7L5Oujli7nQ2ACJPkBYBdVMKlALB
         XDyzklyW5EI8kshSqnJnQ21yO5J4ZdyD+hN/+Ljd+y7ttdyvcWB2x/pINClxdh92EA
         KiEA+aTGWd87A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] Docs/admin-guide/mm/damon/usage: add links to sysfs files hierarchy
Date:   Wed, 13 Dec 2023 19:03:37 +0000
Message-Id: <20231213190338.54146-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Sysfs Files Hierarchy' section of DAMON usage document shows whole
picture of the interface.  Then sections for detailed explanation of the
files follow.  Due to the amount of the files, navigating between the
whole picture and the section for specific files sometimes require no
subtle amount of scrolling.  Add links from the whole picture to the
dedicated sections for making the navigation easier.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 70 ++++++++++++++------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d3514367703b..671d3e50b998 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -59,43 +59,47 @@ Files Hierarchy
 The files hierarchy of DAMON sysfs interface is shown below.  In the below
 figure, parents-children relations are represented with indentations, each
 directory is having ``/`` suffix, and files in each directory are separated by
-comma (","). ::
-
-    /sys/kernel/mm/damon/admin
-    │ kdamonds/nr_kdamonds
-    │ │ 0/state,pid
-    │ │ │ contexts/nr_contexts
-    │ │ │ │ 0/avail_operations,operations
-    │ │ │ │ │ monitoring_attrs/
+comma (",").
+
+.. parsed-literal::
+
+    :ref:`/sys/kernel/mm/damon <sysfs_root>`/admin
+    │ :ref:`kdamonds <sysfs_kdamonds>`/nr_kdamonds
+    │ │ :ref:`0 <sysfs_kdamond>`/state,pid
+    │ │ │ :ref:`contexts <sysfs_contexts>`/nr_contexts
+    │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations
+    │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ nr_regions/min,max
-    │ │ │ │ │ targets/nr_targets
-    │ │ │ │ │ │ 0/pid_target
-    │ │ │ │ │ │ │ regions/nr_regions
-    │ │ │ │ │ │ │ │ 0/start,end
+    │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
+    │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target
+    │ │ │ │ │ │ │ :ref:`regions <sysfs_regions>`/nr_regions
+    │ │ │ │ │ │ │ │ :ref:`0 <sysfs_region>`/start,end
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
-    │ │ │ │ │ schemes/nr_schemes
-    │ │ │ │ │ │ 0/action,apply_interval_us
-    │ │ │ │ │ │ │ access_pattern/
+    │ │ │ │ │ :ref:`schemes <sysfs_schemes>`/nr_schemes
+    │ │ │ │ │ │ :ref:`0 <sysfs_scheme>`/action,apply_interval_us
+    │ │ │ │ │ │ │ :ref:`access_pattern <sysfs_access_pattern>`/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
-    │ │ │ │ │ │ │ │ goals/nr_goals
+    │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_value,current_value
-    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ filters/nr_filters
+    │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
+    │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
-    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
-    │ │ │ │ │ │ │ tried_regions/total_bytes
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
     │ │ ...
 
+.. _sysfs_root:
+
 Root
 ----
 
@@ -104,6 +108,8 @@ has one directory named ``admin``.  The directory contains the files for
 privileged user space programs' control of DAMON.  User space tools or daemons
 having the root permission could use this directory.
 
+.. _sysfs_kdamonds:
+
 kdamonds/
 ---------
 
@@ -154,6 +160,8 @@ If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 ``contexts`` directory contains files for controlling the monitoring contexts
 that this kdamond will execute.
 
+.. _sysfs_contexts:
+
 kdamonds/<N>/contexts/
 ----------------------
 
@@ -214,6 +222,8 @@ writing to and rading from the files.
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
 
+.. _sysfs_targets:
+
 contexts/<N>/targets/
 ---------------------
 
@@ -221,6 +231,8 @@ In the beginning, this directory has only one file, ``nr_targets``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each monitoring target.
 
+.. _sysfs_target:
+
 targets/<N>/
 ------------
 
@@ -255,6 +267,8 @@ In the beginning, this directory has only one file, ``nr_regions``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each initial monitoring target region.
 
+.. _sysfs_region:
+
 regions/<N>/
 ------------
 
@@ -265,6 +279,8 @@ region by writing to and reading from the files, respectively.
 Each region should not overlap with others.  ``end`` of directory ``N`` should
 be equal or smaller than ``start`` of directory ``N+1``.
 
+.. _sysfs_schemes:
+
 contexts/<N>/schemes/
 ---------------------
 
@@ -276,6 +292,8 @@ In the beginning, this directory has only one file, ``nr_schemes``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 
+.. _sysfs_scheme:
+
 schemes/<N>/
 ------------
 
@@ -310,6 +328,8 @@ Note that support of each action depends on the running DAMON operations set
 The ``apply_interval_us`` file is for setting and getting the scheme's
 :ref:`apply_interval <damon_design_damos>` in microseconds.
 
+.. _sysfs_access_pattern:
+
 schemes/<N>/access_pattern/
 ---------------------------
 
@@ -323,6 +343,8 @@ to and reading from the ``min`` and ``max`` files under ``sz``,
 ``nr_accesses``, and ``age`` directories, respectively.  Note that the ``min``
 and the ``max`` form a closed interval.
 
+.. _sysfs_quotas:
+
 schemes/<N>/quotas/
 -------------------
 
@@ -369,6 +391,8 @@ metrics for the values.  Note that users should write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
 
+.. _sysfs_watermarks:
+
 schemes/<N>/watermarks/
 -----------------------
 
@@ -388,6 +412,8 @@ as below.
 
 The ``interval`` should written in microseconds unit.
 
+.. _sysfs_filters:
+
 schemes/<N>/filters/
 --------------------
 
@@ -483,6 +509,8 @@ and query-like efficient data access monitoring results retrievals.  For the
 latter use case, in particular, users can set the ``action`` as ``stat`` and
 set the ``access pattern`` as their interested pattern that they want to query.
 
+.. _sysfs_schemes_tried_region:
+
 tried_regions/<N>/
 ------------------
 
-- 
2.34.1

