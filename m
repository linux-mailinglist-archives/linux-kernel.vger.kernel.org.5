Return-Path: <linux-kernel+bounces-51495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F9848BE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C700AB2105A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC323BE7D;
	Sun,  4 Feb 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG0oxloy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF20BE49;
	Sun,  4 Feb 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032678; cv=none; b=lR5cLJIhsJIRgb0Hku5jlqsexGxY2GgqHo2zin6TjGl7G5iMQ8FyGdQ8W18ZYw9DxIZ9VUpaFO39R7BXnNUNpyngON/D808QxH79erJZ3KLD8Kw4TFCY8OAcC+2zMfMA8ae4+lHmYuRsubGyMCM2beRUIKKwiLWRMHas+Hbhols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032678; c=relaxed/simple;
	bh=+ChSxUQxL8MC74qRmkrbO+IxbnULJIW2R9Y8/bomwA8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g6NPhkxB7RbPxDECdy5A5VfMZFRuJzp2Rb6lmmcAuMExRJiEKfGRRPPMe1xMA5RMBXS70EzZKVCt/STUqvLA0SJtGOj6oiGNKsH7B8xkevKCP/oxjAdVJypL0J8R7wVOR0K6UjLueh/yxJ2FFkMa30uy6koFpeVGEw3SmGmCdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG0oxloy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8374C433F1;
	Sun,  4 Feb 2024 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707032677;
	bh=+ChSxUQxL8MC74qRmkrbO+IxbnULJIW2R9Y8/bomwA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hG0oxloyBz6U4fS8lyxwk01/aW3eDwtKPtiIkeZGM66D2nJDDu7RgVCpDC5zWBk0V
	 Rq52BkQNF3YufDd3/To3BtOXkYrlQ+tzfw5tNuv1btvvLK99el/ZaHw6a8hx7XUonh
	 L++Y9JFh99DWHd7S69pF3mw8HWhyq2bIlwJspbcsvAcgtboNP77+2coKSxVYHd/7zH
	 zXcrNm+fDpidL62PLFDiuD99L6STflFMQBBIDmLLdDAQY0njfdJi/2z0s3ogpAypnV
	 tpXgd6tHHBrI1pdLpWVtZUnEFcXHFVvFJhSv8fwBa7lUIML1OxSAsdMIkmCeni6hw9
	 GgIa9ZPggS0FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6BBFC595CE;
	Sun,  4 Feb 2024 07:44:37 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240204051524.GA206753@mit.edu>
References: <20240204051524.GA206753@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240204051524.GA206753@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/for-linus-6.8-rc3
X-PR-Tracked-Commit-Id: ec9d669eba4c276d00af88951947fe0e82a6b84c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f24fcdacd40c70dd2949c1cfd8cc2e75942a9e3
Message-Id: <170703267767.4518.14613545460977800413.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:44:37 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 4 Feb 2024 00:15:24 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/for-linus-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f24fcdacd40c70dd2949c1cfd8cc2e75942a9e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

