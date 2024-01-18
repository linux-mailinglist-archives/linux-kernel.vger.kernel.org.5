Return-Path: <linux-kernel+bounces-30637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B4832251
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D64F2835E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928928E08;
	Thu, 18 Jan 2024 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko7bZkGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD01EB38
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620944; cv=none; b=o/NCIVmoSlYq6IOl3OcWhiJFZjEXmUBXFTZ9xGM/yiycrz7/4rPcJRD8FK1wYL6Wszv8x/+p0fO4aoJAU4R+dUflmWY8lFSdahv6J/AM16WjeT8/rKXHlp/AYYUkEUcp45K695EsHw3y8HmLxyaKaZsxByGhXePzH6YBWMawYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620944; c=relaxed/simple;
	bh=PZxgGjslXh38h/DoG15/Ajoge6uab0gyeSLMj5v1RXM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bhNJHFusc+F7SKhiI2o2VbxM3agM8BDcwjKCyboOSmShRD+/u2XcA0uAuYJ96NrExStgRbbTWap7uQydNCDnlaUt8SUVipz6S8a+xH2tIrm8wEFh3fjIC0Kq8sqFUxKbyCyfwSe3VBFtQG8t8p12EvhJXo5a0sX5GQz+nn5r8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko7bZkGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6091C43399;
	Thu, 18 Jan 2024 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705620943;
	bh=PZxgGjslXh38h/DoG15/Ajoge6uab0gyeSLMj5v1RXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ko7bZkGbKp3hXd78rsgQSd/L1H25HOWCzEhcZzA0G3A1igZTMabRbTtGznb3iJ//z
	 eTvQ2r0A9lhx1E/wXOCA1uHM/KzIgEGmLMS9D4VulsmyiGGrSVLnfC0evfELlUqyHS
	 s+lcsNMZyykp01rKnpZb0D24fD3aZ7S5Gpf8+At9IyJ8Mw6sKlXkNIa4Xwagju2lX/
	 2DPp68yhn3rzxG/FzLW9wb99XcgwYiob1uwjtmMaiwOM5IQ7vRmG+/2c0cJvB5FV0F
	 enUAc/0tXm2XOYSSq85eziUS7cTRR2N4tRQj+T9XWtKWJbz4hTzSKS8t7efDFdgDbQ
	 nqnLxXy3nnxMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C10AED8C970;
	Thu, 18 Jan 2024 23:35:43 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZaHRiNj3biQBaSKr@snowbird>
References: <ZaHRiNj3biQBaSKr@snowbird>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZaHRiNj3biQBaSKr@snowbird>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8
X-PR-Tracked-Commit-Id: 6b9f29b81b155af023da95f560f738f29722b306
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7ded27593bf0aff08d18258251e3de0a2697f47
Message-Id: <170562094378.32628.9103196869336267590.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:35:43 +0000
To: Dennis Zhou <dennis@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 15:55:52 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7ded27593bf0aff08d18258251e3de0a2697f47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

