Return-Path: <linux-kernel+bounces-162628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890048B5E47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A49F1F21B38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FF83A08;
	Mon, 29 Apr 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5XEOK4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AE839F1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406253; cv=none; b=iRazLIRvpHOJVSf1oTGyj+3d7oTqKEr9BUdkfBr3Gw31tHeIzg3csEQpY41Cl+aRJUsKf2SyaBB7uh1ZBXk/pvobkJcianmTdch1exfmeeABzzWf8I+QCjXSZfXQg+CJooeIOUjL6tIK1SQP3XUfmmTIZsDyYrkTM40S05qAeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406253; c=relaxed/simple;
	bh=V+kKALgBUFrCSd3iERim7a+BS/b1pVtfqSotzhpBpEs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pmmTkxr38arD9CLgQ8F3iXKKj0dS/E20aCNBsIsw54/TwVklOtd5jF0hFlz+GmbMKpvgkXNN8fDY3aeuvZcIXOkFnwuxsxgiSCb3Kktx7fITHUTVidGNHs8LKtd4PcJsG6b/ROAxGKBOs7G9GoeIJmqjW9GWHH5SycqARytzXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5XEOK4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AB6EC113CD;
	Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406252;
	bh=V+kKALgBUFrCSd3iERim7a+BS/b1pVtfqSotzhpBpEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i5XEOK4KoAL5hu+7ezsB2L25L4ZFFfszPx9AtvtRwyISg45U5QHTFvl1RlLkTZbFw
	 2csagYz0FNDwGNU8KKFo8Ece+F45k78HrnqyFwBRbqilea+GZFkDliF+YSxz2sz4t+
	 5UiDbaA1n9BYwI3uz/YynOXpY5noG2IvsfbVuH2AEY5zXsNIoOMTSU9PsbahiBGKik
	 SS9eSfTLgFRFM70bIk1cywDS05TGOUbnOLa5vYndSYmPHJ0vQOsfGW8H9KMbwKe1Br
	 BzMJvwxQzpsbiHWkv4iq8OaDeC3XhaozhcqtIcFUb1CHAqr9CRyzgbhm7W9QFx+MYe
	 2etnHsDdbbDYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 715C9C43613;
	Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi9wpiog2uo1wGBb@debian>
References: <Zi9wpiog2uo1wGBb@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Zi9wpiog2uo1wGBb@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes
X-PR-Tracked-Commit-Id: 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b947cc5bf6d793101135265352e205aeb30b54f0
Message-Id: <171440625245.25744.17856946532911858716.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 15:57:32 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 18:04:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b947cc5bf6d793101135265352e205aeb30b54f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

