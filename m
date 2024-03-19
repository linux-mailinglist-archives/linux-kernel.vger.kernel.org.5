Return-Path: <linux-kernel+bounces-108059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6420880567
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7067E2844EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076A3A1DB;
	Tue, 19 Mar 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkMaiN1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268339FF3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876578; cv=none; b=oSYVaIwM5nWMY+FvlNG6xBCQLeCOY7Txl2fEpPEHKoJmhi+vbHecePLgNvO0WUExwa7Fb0WwVLHF65yjHwtk8F6DA8Ojw0mh6MoMf65jn6KEgc7WrBghNG/z0hE11fx3FeGoiODDrowuclhFp3wsjEgsaIfC6Cwmf5d+IQRW+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876578; c=relaxed/simple;
	bh=XBwcvceklDhaxQrsFLdGls4TXb9+1SQL1zTg6B54TcE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ihdoxk0uKUNbU8zZ3leCVK7FTNWC3fNXw3J8GikfuTRzP58yJcEkMAy0AUxO6f3B7PZEULZoZ1uc88cLLSwwCaYuQh3a4I80lDVojOJO5XFp26m4a3FuAV8klAgjKUqo7MZbwMpA8lmUmbQX9jjMoAhRtXq4rOHSPJCrzvzIWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkMaiN1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE156C433C7;
	Tue, 19 Mar 2024 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876577;
	bh=XBwcvceklDhaxQrsFLdGls4TXb9+1SQL1zTg6B54TcE=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=WkMaiN1FI39mKgp0xwz2DH5xzD+tYWm3acfIFWAA1/HuEuDS/4/bu03huT81kI3Gc
	 +0swYRnKa7uwNSbsjr5B27elYBof8IFuDeA6+TqILGarD1sHsiCgQ0EkssmRry6Prb
	 KNme/mL8cnTolwMFAyn/yBZh767ONPVjRJXhuLnBl6b8brVq/BFIquxSkEuRj5bUPH
	 /bviHl46VM6JslIQ8lwpnyYvmgUOV5R3i/w8U/Dpk0g+vqA3/VOK/hiTu8Vmi1n3P8
	 fFapHHhH+Mfd0bLMAL8VicY6Q+ZpkTgEECSaB+YfRlf2SBDk5CDyh3SfUYwl7sEaQ1
	 3QbpBanMhT5AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C41E4D84BB3;
	Tue, 19 Mar 2024 19:29:37 +0000 (UTC)
Subject: Re: [GIT PULL] ARM: late SoC changes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <2227a206-d1b8-40e0-812e-c9b601bc0cc7@app.fastmail.com>
References: <2227a206-d1b8-40e0-812e-c9b601bc0cc7@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <2227a206-d1b8-40e0-812e-c9b601bc0cc7@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-late-6.9
X-PR-Tracked-Commit-Id: 72ebb41b88f9d7c10c5e159e0507074af0a22fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78c3925c048c752334873f56c3a3d1c9d53e0416
Message-Id: <171087657778.21820.7525957113688823111.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:37 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 17:32:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-late-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78c3925c048c752334873f56c3a3d1c9d53e0416

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

