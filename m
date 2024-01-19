Return-Path: <linux-kernel+bounces-31569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB657833038
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F213B23A71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09A58123;
	Fri, 19 Jan 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmv9uNRo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB11E4BE;
	Fri, 19 Jan 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699639; cv=none; b=IjVhyzQaunQww0frpzM53612jBY0JlopyN6uVkucDuH0Iuj/TOO+DXIZvvTZqam5EGeYy1DevhWg/2s2nWgPSoweUhnXIWPFmDtTjUwcJnA2SEQn9HAAcbt7ZvlpSkPBhYkGJCeB/9O7l/vgv6U1mUfqV9Qlkk0YoPkRw1a+mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699639; c=relaxed/simple;
	bh=QsovPZjIu89HKIkqNuPdbPiqFPhiANcaJdE/6rFxvaY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OefcFXJVva0mMuc8ag2H/VwMuUKH9lIZLAPxaFhe+s70fedJFkOjd5uiKEiZbhgRdoPkZ3270lnagXhO/1Zd3v11dSaLM8mVFmFoG+wwccpqNRhntr3/YmdvoSuIpRssN9/UNOi12JfU4eND8d6D1x5KY7npA1WJ3Z04EkQLjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmv9uNRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8E56C433C7;
	Fri, 19 Jan 2024 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699638;
	bh=QsovPZjIu89HKIkqNuPdbPiqFPhiANcaJdE/6rFxvaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qmv9uNRo5IEVAoxoRhbilnnqLJwahqPAusLbixLFXQo2Kt5cuyFOFD/JdmVitZZOG
	 /6d1tufM34gG0CKIElmi/053z2/c2ZcQKPL1ZKY4vmqU4sfhvx1u8n8LiDjFTPlyQu
	 V4VaXx0sLEuZN7Cfw6wAnBhkwdiiZ5bfgXRF6/kzjS8zjb7RJPqnYic2ukQMp6o5ZX
	 f3mcKiYQ5wz5KuxnPTKFDgU7Rfwx/Z3/gWmHXS+0m+i80LhifssOULq3OlYlywp4Cj
	 jpqzjf3hTb+pLqN3/VW6+nSxSI52iIUoqjEyHH+cx7AoJ74fqLLXWQYzXQs0GZmoqI
	 sBLBSfWJVJMfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C960DD8C96C;
	Fri, 19 Jan 2024 21:27:18 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <9fd4ffcb-3f88-4c4c-b580-86895396e933@canonical.com>
References: <9fd4ffcb-3f88-4c4c-b580-86895396e933@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <9fd4ffcb-3f88-4c4c-b580-86895396e933@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-01-18
X-PR-Tracked-Commit-Id: 8ead196be219adade3bd0d4115cc9b8506643121
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 237c31cb5d83b3f77715f6d6a185f46a5ee4ec88
Message-Id: <170569963880.21908.9009512679223737044.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:18 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 15:52:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/237c31cb5d83b3f77715f6d6a185f46a5ee4ec88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

