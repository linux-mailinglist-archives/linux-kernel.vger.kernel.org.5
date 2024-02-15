Return-Path: <linux-kernel+bounces-67612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF9856E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18DF1C24451
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D713B285;
	Thu, 15 Feb 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfiedAYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AA13AA2E;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=sJW75S7HQXQx5SE0MlYLqxoefsvpu4LYd+N9qKwQmDBndb+E4KsBaGhtTAYsLjLXm3wJTAmfQfQzQ6NiOSbeOeNn8NDoZJxMV1t7MgyFV7tq/AssNdDO/YBL55+hryblQcd28Kgz+b6GNI2+UqkO5sj6Zxiv4/NLf8RGJNAjE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=DdpA1Dbja3N6ziReY9ycdj+R4DLwrgrh9JuBnLGnnO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TmRzfwwnU5le7JBM0OQa+nQlnN++YZ862VqG/vwgyND0bEVnEPu1FZTgSCzq+tlm+qcbvk3hFOJAgZK97pXk6sTeLouFg2M+CqiV+i0JbaUxPmA61icqTLIORQSyNrLMGrHm/30DVbGYoMHUiXB6KMoMPW+f8sQo8H3aSUYsbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfiedAYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87BF2C43394;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026607;
	bh=DdpA1Dbja3N6ziReY9ycdj+R4DLwrgrh9JuBnLGnnO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JfiedAYEJFyNz3uhrPuKn7AF00Xyg7jnYzVPx7MXcyPsTGxWdvVxbi4O/UaTvCwb+
	 ywZnOt1k4aTJ0fq83cfYaU6bL0WelmjAKEcPYlHNuu8ZfFvn/QxQq3uxM1aH1i5UVO
	 ABNJJkU8gPlaOkziwjTFEUC3gOrdyAYR5ZS6Jsadc0Cx8QbdEeZN1kP72iIEYhDtPc
	 iuq9wxSvEu4Luv9gJkJKFVtFSMOOLmXyuuBHBy8mby5FN3VwRUYMamYZMg8XGudFpX
	 ZKfeExMSQhb6GxKDdu0CnBSJ+SypRPujnIqHesAhXcOjNnyjSsS5DmC5Q69rzmykqe
	 ijgBHG80Bv+cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 690EEDD4EE9;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240215172125.400403-1-kuba@kernel.org>
References: <20240215172125.400403-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240215172125.400403-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc5
X-PR-Tracked-Commit-Id: c40c0d3a768c78a023a72fb2ceea00743e3a695d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
Message-Id: <170802660741.17476.1328845857940949475.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 09:21:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

