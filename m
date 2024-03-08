Return-Path: <linux-kernel+bounces-97651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E09876D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C5C1C21911
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459B60DC4;
	Fri,  8 Mar 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7yzQ7oF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48560BA1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936906; cv=none; b=YCiafutEHaKNObm0wzg0eQoW5qoPaitirQOckDgw80Mi/b1pZ/r/3wNK94sKtclgwbpULNKtvEQNabwKKT+GFZajLupgqyduUch+xCd2TeYJqlMdWHnPmpt66CsSzPW6+81ItMyomGHpxabDBkX+c5FUbM694WOLqbfWWVccBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936906; c=relaxed/simple;
	bh=Y3sq+Pl0ZfmumdNiP/vSozJvAuRMe9Sob8o18gbF3Nk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JVDR59TvrT4GCCPWP8sHKV09FtE/BI0CFBPgKEaGvXE/vAqXx2h+IiVCbg2dJ0sphk1uW6ZNjFtEa14mMRFch3NgqcqBl6CPobUCJo/hDYyqgGMznsduSdt9mLyIklEdKGYxAVALoRKTGOZpmfvtGYRe6rqxuC7Rg7MPtgh1bQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7yzQ7oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65D14C43390;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936906;
	bh=Y3sq+Pl0ZfmumdNiP/vSozJvAuRMe9Sob8o18gbF3Nk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n7yzQ7oFarvLCuEQJCBu4t6MjaJrIVjo/fpQ0Yr/9wuKno5yRhr1RzuwRSAwcWN/J
	 3CEJlpZBfKl2VfZjY1FwiiON8ffzmOr4oEkpnHTlwLeaV5+A57e4zBDyAYFURPMgYI
	 JKYM5rg6KVOeu9YMU3cLvsRJWBJhQr3UOcZfkvpcK0YVx89nGjUZwO0l5IF/rB+oxT
	 Io9cHuE1Pxm1FSiO6BNip0X+RC8+5Ins8fl7PoBp/K0Mim2WPhz+1Ln1Alr0UwOHWM
	 3xMo6HDRbiWqs6DU/gUDtLCS7sNx5hAKNx7jABipfldjqjfCRLHhnMmKwfgVZ2T8PD
	 Me0KFd2vvogvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55DF0C59A4C;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZetLL3YjQ32l-2pW@kroah.com>
References: <ZetLL3YjQ32l-2pW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZetLL3YjQ32l-2pW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc8
X-PR-Tracked-Commit-Id: a0776c214d47ea4f7aaef138095beaa41cff03ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10d48d70e82d7d19eb9157fdb599bfce4a5768bc
Message-Id: <170993690634.2485.17884541593739279482.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 17:30:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10d48d70e82d7d19eb9157fdb599bfce4a5768bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

