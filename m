Return-Path: <linux-kernel+bounces-70485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB463859883
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510602816FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218771B43;
	Sun, 18 Feb 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD5MOHBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154226F507
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280529; cv=none; b=E92lurFwVafoojwRQ7ZfVNjML/Enq4CZcNjMCcvOS18eZjtZm+v1XOXd0x2RtszOG5Lc/zlynGG2Ly8v1LiIq0dAg+N5ORuX1er8OY6uKLJaqy2r66h+ir1spfn/DgKMSvFqbmdMSKYrJjhlpN2n7dpEojbTN9BLyVlmhCpY4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280529; c=relaxed/simple;
	bh=VdO7ptTLue9LzmCDF01I6sKH7f3rvUm5KmCRkmsl9LA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ncPJVWFOmS6eI0KQG28IyJSSYKWhUcJrL8eF4hQSvAuahov5OUbgF+YyGtF1H5TQMWt3usO9ch03ql9DE5snr4MWad6tsVZNmyeVTqGR+0Azjyfoy1VBWAA5ORKXC17PQIhdH7x4DoOBETvjRQetLRUNLB5EcGqp4xv6JLCyZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD5MOHBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAD47C43399;
	Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708280528;
	bh=VdO7ptTLue9LzmCDF01I6sKH7f3rvUm5KmCRkmsl9LA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OD5MOHBEkEe6LujVN8vK4WwUvvuOcPEYr8qwMFdt/D/mFCnPTBYSPjwoABN4WS/ka
	 mjw0VOS8PS0ppN/AvOMH8Mse4eKsQ4V+AmBrX0fPKLZUY6RYuLA9eMA261dWPvvDRE
	 pRY07PVjE79KBUdfPLL3KZ8hTHb7TGYrMSGYk25aQZTsZsGQ+gI5ECJdFgsd0c/sHh
	 KOux1yBv6SBiGMwknQeOIXLuEPKlZRungYE01jCfQgW/r3/4LpnTGPTDxexuQkQPP+
	 VwEbpEDhJzQnT+NlV61QOjogyT3gWddaGP37ske7/KkF4Tq2jrXlEVZD4AFUyTVGUm
	 z9SLUv2DQcGFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C66E2D8C96A;
	Sun, 18 Feb 2024 18:22:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240218104631.GAZdHgB9eMrhITQgyy@fat_crate.local>
References: <20240218104631.GAZdHgB9eMrhITQgyy@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240218104631.GAZdHgB9eMrhITQgyy@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc5
X-PR-Tracked-Commit-Id: d794734c9bbfe22f86686dc2909c25f5ffe1a572
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddac3d8b8a48dda6447a7f7a15f8124020a5add2
Message-Id: <170828052880.10456.12450444848106568606.pr-tracker-bot@kernel.org>
Date: Sun, 18 Feb 2024 18:22:08 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Feb 2024 11:46:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddac3d8b8a48dda6447a7f7a15f8124020a5add2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

