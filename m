Return-Path: <linux-kernel+bounces-112497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137E887A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D24282047
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C265B5BB;
	Sat, 23 Mar 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmWsfZi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798B5A4C6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230964; cv=none; b=k++DNFU8ssQgKgWoiJuEIVhUs9YXeT/2W+smNGtyOu1ehPk3T4nPCBTRP2PtaqtaNU3YOmo/Lo5v80U3YAVLhEs87H6fg9PPGdD45zTUZ1bbwq1pesEjBjIadKRt0KY6ef1oGfoJoEy4cNwK07C1lNNuO1bfJyLSEwUyi+OpVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230964; c=relaxed/simple;
	bh=Ixf7LgiVSlaYtJUjyKECFjg3mZsyRPa2CEtC1n56zoA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pSjUPnE/2GhAWWimNAYcxGTPrn9ggDayk/KBEgEm8JHQ6YaOGV4yrRl4L327tXwD3CKQgt2eHbi34rNUwvA1XW2YuPaQtJF8sSVjey8+mQzxf7m5UkOrb+wnoO1daiM4Ln3kVNxH8PEtWWlWwH1rTHHNRDtmYgVb4fp/QvBp2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmWsfZi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3C82C433A6;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711230963;
	bh=Ixf7LgiVSlaYtJUjyKECFjg3mZsyRPa2CEtC1n56zoA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JmWsfZi4TpqAUkaKMakCykD6JYvlncQwGmWEgN2e6Urk+H0mb9+DUA4RIQxVLoQ8k
	 qVs/zt/m7ve9qt4iBuEG7qPzDzLRSj330WOXYkiwucb4wmszWccLySmdqPiLzDXZML
	 8R72VpkAcvtR8Kpy5zXv+qac0BXqmVcvR9YVQ6ZX0papA6ZU9aEYXEOGjzZzxnsHOp
	 +pyRmCBHYQFigJCTEGwIvCOyuDuZF1Z2eSV0K7/65R9HrkjKFpV6Jup35mirFXhL0z
	 Ajknagq+BVFIKxUV9Eu9w4phJLLJ/oJs7z+gAC4nm0Ss30skHEnP2Pz86jnqCaxLxc
	 P2z2RIlhxM/Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9594D8BCE4;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171122347264.2772088.18245020534552619618.tglx@xen13>
References: <171122346785.2772088.10596056144848184713.tglx@xen13> <171122347264.2772088.18245020534552619618.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171122347264.2772088.18245020534552619618.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-03-23
X-PR-Tracked-Commit-Id: 03877039863be021a19fda307136657bb6d61f75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70293240c5ce675a67bfc48f419b093023b862b3
Message-Id: <171123096375.10193.9030615912854423445.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 21:56:03 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Mar 2024 20:52:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70293240c5ce675a67bfc48f419b093023b862b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

