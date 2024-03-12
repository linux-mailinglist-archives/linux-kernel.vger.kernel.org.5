Return-Path: <linux-kernel+bounces-100880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DAE879E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158C7285A55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57888144048;
	Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJf34aNh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99404143C62
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282264; cv=none; b=VE+Q8+OZsDlk+k26om1WxwjsPFT1dMayy75tXrcvynxzDP/1YC2VsTuT+mOZt4fk9PxCsxSFoXQrmT56KrhvNiT9aL4DTr8taYQO7WFrnM56RxQxl2te1IINI1sU9l2MhWZ5IjeYq1Pb9i/d7M8EvptHvDxsgUTSspH3aKg2Ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282264; c=relaxed/simple;
	bh=G6EeWuNGB2EKxP6E8RmEg0CZX84U7j/SEVNRMjtC8no=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tSkEMgQHqTx8IoXPG773Uh5yTypB/URcm8Z++NHrjtasOZrc5J2na2GVJl2XpwDSrO2ZVUHBt5OeOBfXK+7vygYL+p1IbZwRlBcaptKuo3sSfMJ4+ZQI9ruKXc90SORXA1kPas2zdJuSZ+exhaGhu68fBsOlQw3BAi/9hDA8TGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJf34aNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C77EC43390;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282264;
	bh=G6EeWuNGB2EKxP6E8RmEg0CZX84U7j/SEVNRMjtC8no=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IJf34aNhNTQuAhAf5qpsZhehhBNN3hS0OLOnKIZA5v77kwekUjMdJS8ALGDMLZbOT
	 WLHou2kpKBnRzd4UvVL+Q+O0K+nJ8y1i/1xnstJpF7zSTOGLgcffRp642gXC7HjkHl
	 ue9O1lPvG/K2jleCZCy9QClVlFQSmwOSgM5HMS1w3J19dPn38WmiZsIOwTs17gbv1J
	 pJvk2TsrC3DR0jklQP4MatwDk/4Pj+MjIRTBvLexTdyQJs2wEhbAt0HO1+lbDBgKhe
	 Q1gFBJuU1/sGwtU51A3VlYIBapqMpag/A0W+4lvF+VnCs44C3B4U1GnSbDTZ7OExJw
	 NegAq84gMGRPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BB38D95053;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS update for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1710185320.git.dsterba@suse.com>
References: <cover.1710185320.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1710185320.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.9
X-PR-Tracked-Commit-Id: f7c79a40b575f2b6c156c8bee9a652401bf715b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbcb9b5bc9804c2e803f00a460c212f9a0bbdb0d
Message-Id: <171028226443.16151.7234162177197058028.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:24 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 20:30:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbcb9b5bc9804c2e803f00a460c212f9a0bbdb0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

