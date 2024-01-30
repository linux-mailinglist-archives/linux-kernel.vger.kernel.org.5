Return-Path: <linux-kernel+bounces-43728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E484186C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF764B21713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF2381C8;
	Tue, 30 Jan 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTmLfjtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2037712;
	Tue, 30 Jan 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578562; cv=none; b=pouPSMUSf2gNnuwGoWrNVL8gPBiFH519Yeyg70OIarZHcYDbK0TlHnCwnWnd44rJXaU0TYd34agV+N3fFyeRlCA8T/rpRVF/2A0Wa525o+oj2h/UIeQlze+1ZH4ywf3drO+Zm8RwIWFF9yo7i8DG7zU1uxuygFdheI1OhciCFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578562; c=relaxed/simple;
	bh=gcC9dmoQX9j+tKrb8TrQMZADNHfkIGHlBl+HK47V+ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhAYper5gA2flDSwZUupx15y2KUuHwNsZhAwKEt/Z8D8sDpxS5huHKqqrt3JGYR+afVMtvEQ7neJX+rGXhYDmdcAQsiDL2GQL20ssoUuutJQAtUNNCE0DAKv4bBx6/Lrx/MedfHAYttptHECAXIqd6/inWWsHtQsWw4xqP2ARlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTmLfjtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AE4C43399;
	Tue, 30 Jan 2024 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578562;
	bh=gcC9dmoQX9j+tKrb8TrQMZADNHfkIGHlBl+HK47V+ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTmLfjtG2USxU7mvIhukf5t+rtNA8FRgHeVMxqey89fB+cw41bjtbJ0ueFc38YwMG
	 1GZRhvbIf8nTIBUWdJNAhYNnK4dDfMcibwZaDavmibS4wMMyapIrWDLAvXdUdwneWl
	 ev39nvyIALH6/rtT4PyCtZHilUMxBH6g9myOiTK+t5TsP+hnfNQGUsmEncCI/ikxjg
	 7lQHveRVvEGITbaaGBHa3V3zlNBd7Je7mb2udpOJ+wZpXpegjej8rse/u3SpKAta3c
	 bHEd2Xd4CnXuF3foqFXqLXiSLMsM0sX5S86kR2MIhHmmgTW4nOOcfuguf7K7YIdU6f
	 4wg1U09cC5rGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] Docs/admin-guide/mm/damon/usage: update for monitor_on renaming
Date: Mon, 29 Jan 2024 17:35:47 -0800
Message-Id: <20240130013549.89538-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON debugfs interface sections on the usage document to reflect
the fact that 'monitor_on' file has renamed to 'monitor_on_DEPRECATED'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 29 ++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 5d3df18dfb9f..58c34e66b31b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -629,8 +629,9 @@ debugfs Interface (DEPRECATED!)
   linux-mm@kvack.org.
 
 DAMON exports nine files, ``DEPRECATED``, ``attrs``, ``target_ids``,
-``init_regions``, ``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts``
-and ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
+``init_regions``, ``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``,
+``mk_contexts`` and ``rm_contexts`` under its debugfs directory,
+``<debugfs>/damon/``.
 
 
 ``DEPRECATED`` is a read-only file for the DAMON debugfs interface deprecation
@@ -855,16 +856,16 @@ Turning On/Off
 
 Setting the files as described above doesn't incur effect unless you explicitly
 start the monitoring.  You can start, stop, and check the current status of the
-monitoring by writing to and reading from the ``monitor_on`` file.  Writing
-``on`` to the file starts the monitoring of the targets with the attributes.
-Writing ``off`` to the file stops those.  DAMON also stops if every target
-process is terminated.  Below example commands turn on, off, and check the
-status of DAMON::
+monitoring by writing to and reading from the ``monitor_on_DEPRECATED`` file.
+Writing ``on`` to the file starts the monitoring of the targets with the
+attributes.  Writing ``off`` to the file stops those.  DAMON also stops if
+every target process is terminated.  Below example commands turn on, off, and
+check the status of DAMON::
 
     # cd <debugfs>/damon
-    # echo on > monitor_on
-    # echo off > monitor_on
-    # cat monitor_on
+    # echo on > monitor_on_DEPRECATED
+    # echo off > monitor_on_DEPRECATED
+    # cat monitor_on_DEPRECATED
     off
 
 Please note that you cannot write to the above-mentioned debugfs files while
@@ -880,11 +881,11 @@ can get the pid of the thread by reading the ``kdamond_pid`` file.  When the
 monitoring is turned off, reading the file returns ``none``. ::
 
     # cd <debugfs>/damon
-    # cat monitor_on
+    # cat monitor_on_DEPRECATED
     off
     # cat kdamond_pid
     none
-    # echo on > monitor_on
+    # echo on > monitor_on_DEPRECATED
     # cat kdamond_pid
     18594
 
@@ -914,5 +915,5 @@ directory by putting the name of the context to the ``rm_contexts`` file. ::
     # ls foo
     # ls: cannot access 'foo': No such file or directory
 
-Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on`` files are in the
-root directory only.
+Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on_DEPRECATED`` files
+are in the root directory only.
-- 
2.39.2


