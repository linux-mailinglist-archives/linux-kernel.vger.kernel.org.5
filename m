Return-Path: <linux-kernel+bounces-101068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43C87A1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994D3B2033E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8427E10953;
	Wed, 13 Mar 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLH7gfOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6645DDD1;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299688; cv=none; b=r9QAdNGraP7d/b03gdGLx7GUhRUYtxHHqh2EtEVfgRTbQsz8sqSLnrBhTPVvsH/eNPnuWYLwtXqCkeYcRu9MRiiPBsRkBm306GCKsHstzJr6kcK0BvXxEAm6Ye1J3Yh+fS3K3Z3x1UgrYKODd8oAqizjPCvyM/g5S1pGjzaJTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299688; c=relaxed/simple;
	bh=fMzuWh39HrSr6LJuUun9tILqEcsZfaAZv5ySGOklm9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PaLf9+n5yvV8oRWcs1ZYKcpwIar7izfL5N47GF1lQvK85ThDPv9OtyeRZkum0mJ/1yS4s+VJl8pfq50TOFaj6r1HYrTrRAaxlADRTizrBeLrpj1DESayqdnzf4pMX3zr8DBJuNSWHkWRNbUARr0kv2BYPIdTm3xGzf2rSE0CemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLH7gfOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52F5AC433C7;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710299688;
	bh=fMzuWh39HrSr6LJuUun9tILqEcsZfaAZv5ySGOklm9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iLH7gfOpL8ofKE0feNTzJQA+LbSowAmIJVOs22XPptKvF/gEpdhDJ03NEbhHPbrLK
	 FqRY4txDQUsWcRHlBYlTuvo+5Sz3iJxB5Z+YICqkXaycTG1tY86MA1KpAtJPEqLOSd
	 UM7HdTPBHwPreeanJUbQaJqdcxQI9uOYOOhNtriBnVZ0LMByC1JGmzdBOM6Z6420ij
	 H1xdlMbqkBpThPLOgZXT9Tj5jRr7vG/5Vg7PP+nCU5idv2xvkd0oSdyHNTsXzAa2uk
	 OpqloCpcWRyEEMSpX1nH7zXHC6xumZYQ0xSWeQRtBKapCRf1AOe8Otj+f2semEHIC9
	 /EF9ZzNO9i/ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 419D4D95057;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240312
From: pr-tracker-bot@kernel.org
In-Reply-To: <f584f8da8096351cc7e941d0586b2fa3@paul-moore.com>
References: <f584f8da8096351cc7e941d0586b2fa3@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <f584f8da8096351cc7e941d0586b2fa3@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240312
X-PR-Tracked-Commit-Id: a1fc79343abbdc5bebb80c2a9032063442df8b59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca661c5e1d89a65642d7de5ad3edc00b5666002a
Message-Id: <171029968825.23890.18315375045795766853.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 03:14:48 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 19:18:26 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240312

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca661c5e1d89a65642d7de5ad3edc00b5666002a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

