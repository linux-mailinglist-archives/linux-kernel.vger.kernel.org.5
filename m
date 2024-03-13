Return-Path: <linux-kernel+bounces-102435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B3487B1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C04628ECE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E19626CA;
	Wed, 13 Mar 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK3xV5q5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E95EE8D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358100; cv=none; b=Wc9Pq/3Oi0JuXIva/PFfoIunWCg3DsQWfbz1tWn992RGVfIpLniZVvPJdHlaateWV8zmINXIwQ4kSsmH7ewSyeipOiQ45xFvurxRltZ6tFC5YLWLdyo+JchTTsZsq1m+6jPkfT+k9X9MlG9MvMItNgABV1Wrb3qzph/ZW42rNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358100; c=relaxed/simple;
	bh=EL4IfTxTF0tER+aLT0V0ZdDYfNBQ/K7Mtw9kBOcFsAg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZpnGB/0omRHLnp9KMviiQUPNY2pkpMZHLL6TCzw+O7NAZ6PfPoaKJ1ILj+Mh+EacNgpqIpBkqS5QyTrxBQjxBgaj0FBNmftrJgxUh6darnVqGJfWfpBWs71uVluhV5HUiigV1fv/1EyuF9HswyFEhMSJAIE4GcR3kYttBotJg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK3xV5q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0122DC43390;
	Wed, 13 Mar 2024 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358100;
	bh=EL4IfTxTF0tER+aLT0V0ZdDYfNBQ/K7Mtw9kBOcFsAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZK3xV5q5lgEFPkHpB0Msg0PqT011IUExbOT+Hljx/yU4YTMuP2RrdhvqPwdo5Q9KV
	 g1aLfzNsO+/zJmLp8tk0xOUS02dG6uvHYwbnPFCHsB+aUJ3Yr0aOLBkUENhLgWNOio
	 pAeU7sNb9ukbHANp24GOhOvaLKNKexjKT5SiPiVcmFCRW/gYHpztpOSdIBvIujVyKn
	 7Zodcpwbx9fQBR8TeVpNNVLRfuddOfBS3RUbymO49N7OeW7BEqCIBpPcc0geYwthyE
	 eu0+FrJ2VjL0RxwLJRlnZal0DnqXxPDanVTbNJatVijDDJcnUdKVFP3crqUMkatRJm
	 8vAQumNFrnfew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0E2ED95054;
	Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311151308.0406CC433C7@smtp.kernel.org>
References: <20240311151308.0406CC433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311151308.0406CC433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.9
X-PR-Tracked-Commit-Id: e6f0b08a036734552628ab788ecb528ca53814ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21ac5a96513c6588c9a71bffa16d665675930a60
Message-Id: <171035809991.9850.15332467526227106799.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:19 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 15:12:58 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21ac5a96513c6588c9a71bffa16d665675930a60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

