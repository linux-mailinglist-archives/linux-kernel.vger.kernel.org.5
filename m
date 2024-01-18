Return-Path: <linux-kernel+bounces-30474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53291831F22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866AF1C2326D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA92D7AD;
	Thu, 18 Jan 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ16sr5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F732D634;
	Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602929; cv=none; b=DG0Zp1yqwOizq8+Wa0WfGpSCFn5aMSU2zqs5tcq06phsUobil5igQy9mNJRtrxKh7mQ3lA1jNTqz1Rz66UOFeYZOu0RGlCvTGEMCEcTyVGRHiiLw/ayqzREPpWV46ZF8hpo76QnRNKjZTNNMznjWJQlta7PbeZGeJF2IfLqWXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602929; c=relaxed/simple;
	bh=G4JRChUZ3z8uj1hPlPWCb30wwi9Bx4liiAUUpued/6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AgareqrShwJ6u/2a2iae5XolVn+G9Y2r6NC5kEgI8hEbMI8iYBJS4NpurrzE7Krb+a1Nl3K2LRQh+rklFsR7Pj2/WwI593aiI36+TmMdEqP0ACm/ebfjdSyCiBkrswoiK/xAbu7wdsPwelNdA1kBUa0TFFmSOWDNwieM07+OwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ16sr5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDE3FC43390;
	Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602928;
	bh=G4JRChUZ3z8uj1hPlPWCb30wwi9Bx4liiAUUpued/6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oZ16sr5DGanPzLv+/vsc/Y7E5BLFZ3+bobnWOmIPEJ2QiTjjIcQkWsE3i2iLbf6hH
	 vm+G1ej1+S5tN0rOAUupQiJNPuGYaobW2GxxhtPyblR5VIql2NE5Jwz2PixWL5c//t
	 nb0t4u1FngeOGy3e6mcwuRdbaFjkNb2ePjptk1lokoIS5mMZhdsd81RNBfdDyns0yY
	 vZX2LtChOH1d6dpvgOgmOflcZ7ZbHs0Uk0lDwfQjSkRvlaBs1oH8HjZpvPQxmx9a23
	 5v3CCQ0mMgJmleGbPWHjzQaLyP54uGUE3y6dUHLevMWtTowGq0ZWYWmeYZj9y7oc3b
	 kzgY7pDOXpEiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE74FDFC697;
	Thu, 18 Jan 2024 18:35:28 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zae2Tg065gd6rQUV@kroah.com>
References: <Zae2Tg065gd6rQUV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zae2Tg065gd6rQUV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.8-rc1
X-PR-Tracked-Commit-Id: 0a46c21c21c1f1c9a65e29eaae243d0f240bbd6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e38f734add21d75d76dbcf7b214f4823131c1bae
Message-Id: <170560292871.27544.17564401153174503233.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 18:35:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 12:13:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e38f734add21d75d76dbcf7b214f4823131c1bae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

