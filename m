Return-Path: <linux-kernel+bounces-112496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B7887A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C901F21902
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEA5B5AB;
	Sat, 23 Mar 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsOylyeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA159B40
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230963; cv=none; b=qhE6SwupeEIX07ul3kHTWcHzyoEFVH68DA4Qs1Apd69pt8zHTb6rvna3P+brZXZiuQCpJNqb8gnuMN5PXEUSB4Wex1xGZttlODWQkkZjHTFVUJziQvRvRlLiNLTwAv1bPTaVG7ff4lp5PS9Yi7d0o4jH4Fk8Ox14EbUHGke9MRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230963; c=relaxed/simple;
	bh=708R4ZlieJpl9itlERI17vQufgoFsRuuvTnmYB/VBV0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BvcoUtwSHe7uMOWZK5ZHJwxjh0jIWZvSdjLyCRnbpuuwoPl2eQQds5TdFFOFixntfCI03nssuqqjpW0by9mGl+OQmCdbg2WMLPXOg4bW7F4gUQN9gVP5R/hcMMEwJIdq9CvA7DBUZ6ulWbOBK5y/MluLwRe2dIikISxL3HbV0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsOylyeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CCFAC43390;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711230963;
	bh=708R4ZlieJpl9itlERI17vQufgoFsRuuvTnmYB/VBV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RsOylyeTiuBbWf6OmiUs5Mh2EY2O/iSSgyEYD5PgWw9p6P9xvqt5nT6hBC1kFaTPF
	 7+djj52gc87Zza3XXWNFaW+r2aot7G0C8ktCVYgYVhtR3+KDRZURVe9wz78oHJSiEm
	 bnixuXtipy+1if/KcjEdKDGZ2xuMtqyMpDvOOVBwNvyTkrYGHjKanl/m8al6qLaC5t
	 PrfnofzmNcegmcgvxtmpRfsYMWwe6NNOIsWyNdIsPw1t5zweiXmjMGu8F+bs4ubWns
	 2/RQr8RoAB+BlR27Sju7M5ytIbvg7uUkQ2kltPTdLSE5xHLdLo7VnKuMB6I4iT76cf
	 A80fxUoZOQnIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B77ED8BCE3;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171122346956.2772088.12525594748449004875.tglx@xen13>
References: <171122346785.2772088.10596056144848184713.tglx@xen13> <171122346956.2772088.12525594748449004875.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171122346956.2772088.12525594748449004875.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-03-23
X-PR-Tracked-Commit-Id: dce0919c83c325ac9dec5bc8838d5de6d32c01b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a39193137e8dc35707990d8b28ea4211ca9c105
Message-Id: <171123096356.10193.10027927293187920363.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 21:56:03 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Mar 2024 20:52:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a39193137e8dc35707990d8b28ea4211ca9c105

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

