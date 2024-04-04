Return-Path: <linux-kernel+bounces-131973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EC898E21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41801F290ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6541311A3;
	Thu,  4 Apr 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBVX85Lx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F313119B;
	Thu,  4 Apr 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256137; cv=none; b=AMGf/tSUPpAknOmoG7sMpRVBcaH/x0dhJwM99nUa6ZlcVKu7i609Wu/bN6e/HU9qyHR7PYDzxCCX6Cn5jAY3Fz76Rz5G2OANGHwfK9IM8sXjEtUrIi0jvaOkOWmMEhR/Kz4yw2LoA17yQ7AS2qXeZvRXE/GOCSfnpts4Q0OLUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256137; c=relaxed/simple;
	bh=RXwk3mvmfxTlAvcZkMCaK7Rhw/V8MZCUNA1Ak1sC34s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QL8LBOcCJXktvmAG4lUDhhAMxULmoqtEvFISYxgHHBn6/C+2QkBVUiaqAufbB/3aLAiLtKR0aK7EwIEieHQsMDYFePpEt+Cg25EdBBPk/3pW8at0Fvqn7hU/8KX5uYiDBT47VFfCrkD2qeuecHaT2Th6uxRpyRPgXskKhNob6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBVX85Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11817C43390;
	Thu,  4 Apr 2024 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712256136;
	bh=RXwk3mvmfxTlAvcZkMCaK7Rhw/V8MZCUNA1Ak1sC34s=;
	h=From:To:Cc:Subject:Date:From;
	b=OBVX85LxnF1fxGh5r+6IEgng9WsLSO78E67yd+ILTF4Ilmp5P/DbQXDCbAk46M14C
	 zqHzHZirnmsFWiUAIDiQ5iXD5HtTa9Ps5PFxraCtaHDvRZIAFOeeuiMkRzPJ2e+aC5
	 BZaCqKAIFW1uArTdD10c3vlEYAxvj61ReqbfFXUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.4
Date: Thu,  4 Apr 2024 20:42:08 +0200
Message-ID: <2024040409-attentive-raffle-d9bc@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.4 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
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
      Linux 6.8.4


