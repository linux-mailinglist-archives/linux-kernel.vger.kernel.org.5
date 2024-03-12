Return-Path: <linux-kernel+bounces-100651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA4879B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC581C22761
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6513B287;
	Tue, 12 Mar 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frqpI73b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C513A255
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267609; cv=none; b=JAn6ysuNCSYprz3erLycWxJBI6w0RIHGdRZHBVrLVNLtFkJ9yE7/4WDFWHxnj355lhaHe7IleepNUHzgw6VxnN8Knrv/KD7g3umjV4CBgf9SHQtQPPATPnMOhRWIT/ySSqfOkoAz47XsA0c4I5caobRWoG9ZFAIrOfqe1idvEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267609; c=relaxed/simple;
	bh=iKKG8b8VBJyVvAI550zEub4d/4WzuLk65zDq5tJCWKY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nv0LDg7hzLUvZSiG8JLXZUpBb1oHb+bWXp963UGmNubTpqVZxAyMJ0gCESCkYZ2hIc4nio2I8mpm8N+uExzI23tlaJ4zjL70Htd80SUzOWfzxkxyvSh6RnXlg0rGG1isJS03ardmwqe4Pd9xNbJh+OcrbfkUd9gSO2xOzBlvnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frqpI73b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5FFFC43143;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267609;
	bh=iKKG8b8VBJyVvAI550zEub4d/4WzuLk65zDq5tJCWKY=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=frqpI73b72DHJW2C5biTCzds195eosMRjD7J8zjmzKHWj+mhLea6Mql8/HReMt1fr
	 7dQlqvUlu0rnApHs0VKyS96aLFkQTg9p+Fiq+ymLYHw/CAOMXmp7lOO4Cs1PU6otCj
	 DEDzLUQrpo5xItuOH3RH92iIVIHRoHCAGdzebImswuqSgs7Vh1k7u0jzobscePgVd/
	 MW+on9faLkJlqMpTxc2o73+3nUPv5zDf1wTyZ1HBYWfzLK7zVbdCjRc3LpvMpa7sfp
	 O74ZInCY33Zpz6FLXlH/vPiz4mEIuLYiTIZ2jVbdgQoOFAzDPC9/7worRl378+Mop8
	 DAWlmpR0/53NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E784D95053;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL 4/4] ARM defconfig updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <a901bb0c-bf09-470b-98e1-10ae1cacf0db@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com> <a901bb0c-bf09-470b-98e1-10ae1cacf0db@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a901bb0c-bf09-470b-98e1-10ae1cacf0db@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.9
X-PR-Tracked-Commit-Id: d8999d151e4110effc760397f500dda25d7a60b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3efa10eb97e98cca0c80b5b293a149eba8fb1d7e
Message-Id: <171026760964.25732.18094585711986480809.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:09 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:47:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3efa10eb97e98cca0c80b5b293a149eba8fb1d7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

