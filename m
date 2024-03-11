Return-Path: <linux-kernel+bounces-99622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99916878AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506F51F222B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5C58AA8;
	Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKlcAJWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCCB58120
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197078; cv=none; b=mqf7c2YfB1FOGWa7ClaPQeRh7J81taFzk7o0VyZIkqcOTy6EWrmEXf13e2H/9Xen9NqMARmoa4//KcmHd4crxtc/QhHeqojSD5+DDma2lLB9oGQU+M381Bh3GK2GZeqOfm0Eyj+7yua9cBMertrBIYyP2EtK5X+Vn1qmkK5Vp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197078; c=relaxed/simple;
	bh=TkC6mPtOmUZXwBBdEJ9AxlaOUZCE5j8DrjcqMH1nasQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R+4l44rgLsmzYYJWm9FslkKOyne3yI2gVHx7gZ3OWQuiMFy5J7Pny2OT9mEDVtNFmXZtaRAn5okE6sWqyKExhmNqZsVaZEQGZKRJt5MfIbK9hJrTMUgocxFjhHPLhECiYI2h+jI2WVYL0mLxIyJF50NcWJa9YFYBDZwnMbgZgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKlcAJWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAAE8C433B2;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197077;
	bh=TkC6mPtOmUZXwBBdEJ9AxlaOUZCE5j8DrjcqMH1nasQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OKlcAJWc7RI3mJVgPby1DTzqPltDLq3+HJ869rV7RSjQdQQWB7lPPqd0blW/EDaB9
	 U0l3N2mxnp23i4yhEIU+0eeFUwk1m+wB1BTxW/Vl7eIhxhj1fnV1U8q3T6zX1T5BWL
	 zUaXsvO5IxwhMPLmP9/Q4OYiw1tAQu2ld8GD8l1NMNDgroYSOhHWi7HYtXjA/dF9qm
	 +pGZrNaKHG0dBd+RC3ru277RB27y6G+gABm1TEkdsCiNKEr3O590NRQ5mCTuJbL1pZ
	 eY9IpMyXwfgNcMcxJoHx5vspvAF+8oGSkmM9hdYHVY2gVMvOcZwFG6CdkucAK9xBY6
	 hDtRM3cU1qUCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B263BD95057;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Subject: Re: [GIT pull] irq/msi for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011361412.2468526.4705040722498114628.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011361412.2468526.4705040722498114628.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011361412.2468526.4705040722498114628.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-03-10
X-PR-Tracked-Commit-Id: 678c607ecf8a9b1b2ea09c367877164ba66cb11f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4527e837801e76bbb196bb3b19375d8e43d636be
Message-Id: <171019707772.5315.6032330876179994086.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 22:44:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:52 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4527e837801e76bbb196bb3b19375d8e43d636be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

