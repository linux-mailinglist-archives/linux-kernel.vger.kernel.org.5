Return-Path: <linux-kernel+bounces-41887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114783F934
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5E1F21DC4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A381E482;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdwR6H8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406752E842;
	Sun, 28 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467640; cv=none; b=O4fkV0El5hUivroZbMfDz12UWe9/pbCVsRndZ8FTDyEQl0j3U/t0EaCBKTPVSehDa73rn9UB2xI0mXmB/uO1qXf7wGz8V5KYZDBwnrXZNxi0opX5zTXUs/o8Y3QKTh6J1vzISnuShd3P8LOce9/rVz43fCUmdReNJAL55HlG7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467640; c=relaxed/simple;
	bh=m90qFZAhwCt4ISXHAmZZoqnbkKEzxvRZWdYjuApRDwE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vxegea/jvkmB8b+MGjRpZ9SCW7z/JL4Xez79l72OblXxwdpnTPOYrwfI/6rmC+U9tR53ikRt4Wn9dROE2V2Xd9otc95+D/8TjDV159WtHUrnXt/+VLzkx0Q4WPwXU1CsxhGuGKGuB25HbfH96iXCbQUDqZQvygjLGgQhmIRKtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdwR6H8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A644DC433C7;
	Sun, 28 Jan 2024 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467639;
	bh=m90qFZAhwCt4ISXHAmZZoqnbkKEzxvRZWdYjuApRDwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EdwR6H8QALyeJSq70PTTBmPBL306jpkYnMdyrGDId0MKvcRa9ToR7p+HUXKwsZNqC
	 kAkBqWpDKh+ntCc0X5cNqwVqAZn1RqN2n6ja8XCGOfozyPuFBM0naUGuEubxnqEQVy
	 TlEDYnpPaHYeQIpREb+qTwlC5X+3DZFhVMKrk9fS3eSvOsX0PjxGeNbfhEEebI05Bl
	 WpFX97jWSQbkmIUWP6aWHRqTfjwdFt7iRoMkonH50P3qVChoTXHrwbtc3wuJqtJNZ4
	 jZqTCvyU5NMMEkWQjtZ4UfLTBsC1tRlrXWzgLSGIB08o+mRtn6CDxdlG53zzbAQvVe
	 y1FdPT8QidNlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91274DFF762;
	Sun, 28 Jan 2024 18:47:19 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
References: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_1
X-PR-Tracked-Commit-Id: 59be5c35850171e307ca5d3d703ee9ff4096b948
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4854cf9c61d060209d2b431f4a787f6952967022
Message-Id: <170646763958.17624.11385086289250038668.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:19 +0000
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: torvalds@linux-foundation.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 14:28:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4854cf9c61d060209d2b431f4a787f6952967022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

