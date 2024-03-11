Return-Path: <linux-kernel+bounces-99621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B6878AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF291F21821
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45458AA6;
	Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTgPJyKB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582E58119
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197078; cv=none; b=c9MygFy3cXu8NHTY8zflCUhXGulOMnB9XzDzxNlK7Dkmhvv7Si5HP3R3b9VCGmY1F+doRqnXg+DRN2c/3bz4KMbuAmKJhocZKhyaxKunmblkvAsgHvHAKuYBm+xwTULV8xU7gt1qQ8Q/AvWFJ1eladjbhlFTLwFb1VwUe1JLcgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197078; c=relaxed/simple;
	bh=9pniSFC/pHc6OGbniStmWqGBGZJiGpy2aXDxq2afGsU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ifc02hpFwqjkYzsyOBgnAp3Hpv/ZsZ8YqeWMXYvq5bE3kbE3g/VW9dnxpFdAOLPxuBfgi9lxRq6A7JrdS8xyst9uEHSus/c55MKf1sUDnMBi0SCBSGBTvzzKsXyM5ALNGocWT3o/wQplyLw1+9C5FN53V88zeGwqeczjrsGMh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTgPJyKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BEE3C433F1;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197077;
	bh=9pniSFC/pHc6OGbniStmWqGBGZJiGpy2aXDxq2afGsU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HTgPJyKBvrXdkjRrB1mxLUi7NthubP0ZVLMiY+yiPeeAJZZUUsoA0pOhGqsxAtkCL
	 FyyJI2Jueu1yuevIQTQ2YC+BdpK8EwcNcGEskBfEnwOdjrXYdSLJfGsyPoh+NhHhx4
	 Zf+4fjbCnRT58Wyb4BYnUi4uf+HRClWAUcklrjQNnppF3WXEyE++vCXer3O9RwNBVB
	 6WX5Bd5CHOGD5KaCJcW1jccHdnk5I/tI4Sn3KPbMlfUPdcAChR+7k2k+LSHyDkbF3f
	 tEbMNr5t2/iHaSOh4jV8e0KOJbJ8DEfnjYvI6TkHs5kv6LzuLSlhs70MV5QjfYjMZw
	 gJW+kQPpTFTkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 510A6D95056;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011361564.2468526.10150004610808473613.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011361564.2468526.10150004610808473613.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011361564.2468526.10150004610808473613.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-03-10
X-PR-Tracked-Commit-Id: 266e95786452d97f42dcb9a881bba223584b9648
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397935e3dd133da7eb579dc6de51b93b363588e8
Message-Id: <171019707731.5315.9024090679233516099.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 22:44:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:54 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397935e3dd133da7eb579dc6de51b93b363588e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

