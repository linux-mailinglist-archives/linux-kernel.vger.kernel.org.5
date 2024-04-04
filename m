Return-Path: <linux-kernel+bounces-131971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECBC898E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AF51C21E28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932513119D;
	Thu,  4 Apr 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRyHsPMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF221DFCE;
	Thu,  4 Apr 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256129; cv=none; b=V3Cgmj/rbhZ/SWXARMWhSs+ULMwo7Q40QMvNAAeqFSP69RDpb42D6nu5qSo7/eknXXtZ414Bnqh1atz0eXyaTTUQprQPd4igdSCAJH/R4qWWXH5EB+cOcxqF7GXnVtFyILrQM67OKWjXt1f0WJEiZpiBqB72FWr9wCacOeYozKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256129; c=relaxed/simple;
	bh=cI6azxfny05M3Z//BIhPB50C5DqMX9ELlICE1cUWSHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0n6gMYZjfR306wQHC1YNM51wy1OtsyJ4mglgYpopTBFsn4vJ66wd1JAOokEs+Dvwh+caOL/XYT1UOYYRdBZm0pk1kWki18MmF4ID86XZSBcM5+I0ODjDyZ4/6qMcCZnqRujCKj2UW4cGJNFu/CmoENbkQNeWqLK16aDJ3RR+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRyHsPMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8425C433C7;
	Thu,  4 Apr 2024 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712256128;
	bh=cI6azxfny05M3Z//BIhPB50C5DqMX9ELlICE1cUWSHs=;
	h=From:To:Cc:Subject:Date:From;
	b=oRyHsPMyfmi6kPbFZoTRaX0p6NK5TxA8H3j2eLw/yLIWQae+ZF/eTKV+dBKbeioPI
	 j1ql7RwbK6JXG9ooQxZTpKVOM2w0nQtUjsq4bRdu2BLkTbfBfwuKDbPOpGqmcCMCRj
	 /7cmzAGhnWQ1ASSzmPbzwS1SQ8b54/i0epAx9hZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.25
Date: Thu,  4 Apr 2024 20:42:02 +0200
Message-ID: <2024040403-dwelled-guacamole-b3f0@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.25 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                  |    2 
 include/linux/workqueue.h |   35 --
 kernel/workqueue.c        |  757 +++++++---------------------------------------
 3 files changed, 131 insertions(+), 663 deletions(-)

Greg Kroah-Hartman (12):
      Revert "workqueue: Shorten events_freezable_power_efficient name"
      Revert "workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()"
      Revert "workqueue: Implement system-wide nr_active enforcement for unbound workqueues"
      Revert "workqueue: Introduce struct wq_node_nr_active"
      Revert "workqueue: RCU protect wq->dfl_pwq and implement accessors for it"
      Revert "workqueue: Make wq_adjust_max_active() round-robin pwqs while activating"
      Revert "workqueue: Move nr_active handling into helpers"
      Revert "workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()"
      Revert "workqueue: Factor out pwq_is_empty()"
      Revert "workqueue: Move pwq->max_active to wq->max_active"
      Revert "workqueue.c: Increase workqueue name length"
      Linux 6.6.25


