Return-Path: <linux-kernel+bounces-57511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974984DA08
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D9F2843D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B07667E61;
	Thu,  8 Feb 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSK2dkqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087167E67
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373490; cv=none; b=PqhpJ6qo/eseeNG+xJNVIT9KQ2Lv/amONA7Ebagxi0tkfvVHaIPHiczDLQrImnY5HNm8uCa4D+6qe4wZ/QiHqWpEqMoYLpBqrYBRM5tlKsWo5MkWqAqOmAALwT+o/4Je8Pv1XeNbGJONVslFS5VczAD+Vx/w7yet0rAiSCKvwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373490; c=relaxed/simple;
	bh=owPdNZi9h+GBmuCz+AP0KT9ohuNaRk86URWvrTvmHXU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=suirqsZzb+aqX5nlL056MMfFWfPzrfN9ARBDDPQVGMdILXrYGDPU7d3xnATdUnGvaTV2CEbssMKZj4iHTqonQs83p5mZguUpvuOEaoFE8BcWjM1YkkgJAhugc0s57moi4Kn0V2/Kl7BI+pVOKiXwMNbB3/b6FLJqJ8nRmeat34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSK2dkqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBE69C43601;
	Thu,  8 Feb 2024 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373489;
	bh=owPdNZi9h+GBmuCz+AP0KT9ohuNaRk86URWvrTvmHXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PSK2dkqIozJn/HI4qLLobf8dl8+kO29+/WK5nltdqoKE++Bx9eCMr2HOhQpd9CSus
	 Y6VUnc6X1KeReulNgqklJF6d4OrNf+atsG6WIJGtGMBsiyYxR7CUFRhXuEVms6LncA
	 JeyVNr4PMKOqnjn7ilxUsQ+5CMFfx5u4dd3a2KvU1Tpsc95IAtV6D05DThepu3Z8n3
	 eGo4ota0f7tkxlsiaYQTV0tc9KGlyG9kAQqWHwaSxPrUbPUCHiPHLKu04WfEifunZO
	 6BawLRFHxmygPPod1D3O4gk2ndNZI/PYZMhxFSUtCegtmvK1+94OwIzrtDBWXviicr
	 pbvY5NU0UWGrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8B7CE2F2F0;
	Thu,  8 Feb 2024 06:24:49 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZcQtvkrWhIkRVfS9@snowbird>
References: <ZcQtvkrWhIkRVfS9@snowbird>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZcQtvkrWhIkRVfS9@snowbird>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8-rc4
X-PR-Tracked-Commit-Id: ebd4acc0cbeae9efea15993b11b05bd32942f3f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 860d7dcb20105af1fc7228a162886c421296cd86
Message-Id: <170737348981.17177.16622837033304946277.pr-tracker-bot@kernel.org>
Date: Thu, 08 Feb 2024 06:24:49 +0000
To: Dennis Zhou <dennis@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 7 Feb 2024 17:26:22 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/860d7dcb20105af1fc7228a162886c421296cd86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

