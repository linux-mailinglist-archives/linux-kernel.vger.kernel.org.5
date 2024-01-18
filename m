Return-Path: <linux-kernel+bounces-30635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1739E83224F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EA3283FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6A23748;
	Thu, 18 Jan 2024 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK70dj65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A21EB37;
	Thu, 18 Jan 2024 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620943; cv=none; b=C/Y5zlIfl0YALqBARWBbKXY2hnmxoZv6G+oMpy7TgiJftmZGHN5caWy06OVAQX5l6d2rtEiyE+QC7+9OpKC5u/KAmFguNuFsZRb8qu8hRZOxpN5BZO+iU9QyburpCkD3AZC92boz+mFFKXOxWG10niCtT1SN0hA1fwyhkuKclpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620943; c=relaxed/simple;
	bh=dkRWvZEnEe+GwwsgKTJN9SBdiUyrs6bKj3vD0Cx19RY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DVqdeUPONDcHER/AxWz2N5P1cr7itai8o9icMGywnZZvY9qWCODuEeVxtRzC6+gEaQaAtktduh6Qsv+C8Kinr2xQElcR8q8cnOo6BZdA55RpE21QO+tvHy6ipqG8vBuemghhOcc5Y5+l8LzRKnQXuS15fAolq+fufvVQZVCg+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK70dj65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73192C433C7;
	Thu, 18 Jan 2024 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705620943;
	bh=dkRWvZEnEe+GwwsgKTJN9SBdiUyrs6bKj3vD0Cx19RY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MK70dj656bWDuUC7qbO4FlxSPouePfMWTL6UCqZOULOYaiujyFsCRiwnjFdqYVqWj
	 vWYooTgWtzPJ1W8EzWkxzFfm62jFijByIZrcuEYHMCfTbKz/wXKvJcs+naPfv16AUh
	 7ST1PVC4876SKLxGmbJWP7QG20PyBXFRtUN7xA/+x1lypgGUmnDa00DP5PkVV+HEzT
	 06s/4+Xg4ouKLLXVLgUFOXthw3HXsMvst6XLqfl8MIRrElnSDyT5Bu4wWGkGBYUSkN
	 /1J+Cf16p9faOlW26jMcPnnbmbjMdXLx7hc9aQFrF6Oiuikta13Ea4JlvJmaaGXdJ0
	 WwCYTcm2UWE0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 625B0DFC697;
	Thu, 18 Jan 2024 23:35:43 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ6JNzDHy8-i0-VU@8bytes.org>
References: <ZZ6JNzDHy8-i0-VU@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ6JNzDHy8-i0-VU@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.8
X-PR-Tracked-Commit-Id: 75f74f85a42eb294b657f847c33e1bb7921dbec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dde2bf67bcf37f54c829c6c42fa8c4fca78a224
Message-Id: <170562094339.32628.16386188822432823790.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:35:43 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 13:10:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dde2bf67bcf37f54c829c6c42fa8c4fca78a224

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

