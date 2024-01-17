Return-Path: <linux-kernel+bounces-29390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA0830DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6B91C23E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335DD24B41;
	Wed, 17 Jan 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB2DHqsu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902324B4C;
	Wed, 17 Jan 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521822; cv=none; b=SFio1oP4IXgQ9ZttZ30pVGjp+8XPOyhooYx2olVHSVPcMwodvrpXGMyzzIElsJABT6Y8S/dht8swt1UsfUh5+WfIA0QbdtwXFe/m14FniaEp/Bl4PCIT9AOmfuvbLNe5LVnzydKoY/nK8PVn9F3fFIgYCDKTFvw3y2edcBfBivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521822; c=relaxed/simple;
	bh=0ZhU7VkPyhlA18lZwPSz8sWFF7lhVcT02ZaVVFI8RVc=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=Ds3/S75kQQgeRS6KIOGZ9u/3sbbxC7sZuEcP4vXyMemLQcrwVQh/b+rbfRl8Ew2A/+PbRx3OAdIlDXy65E2demBTMUN/jReMcyYp31Do5j3zsEZ1Fb8YM+5q9rarvtKJ7Y2ocjFM+b54CN6CePeZC/dNr1fZ+YvwGTZZEKkvT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB2DHqsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E740AC433F1;
	Wed, 17 Jan 2024 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521822;
	bh=0ZhU7VkPyhlA18lZwPSz8sWFF7lhVcT02ZaVVFI8RVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BB2DHqsuT0GAOgTrzBHNdrZQvH/yUHAcYURayX/B/sgku78DZefXtpj+0lbaYykgY
	 zxR2ZVb2kn5uS85P1y6YlxARjwesEsZApkozuEqDbcUtpwIVdtUEgFwB39lvTv0dFM
	 yZToDrFwodL+Ffz3sqCkjnrF6MC3YwaRPk3eIKmb68PstvSITgkxlJZBoMd63jyp2E
	 MfFfdghDxzzDmyhxX+Se4lp8GAN2YHqKcPje15TcyyXUwMrz+P5k/WlmvKa7Ra4iNj
	 1H/tD+4XGA+G+9nLp5OtM4bHEVOq2hOI+PcfL08Fznt2MofrRR5JxF+4wgJlvutpoZ
	 p9u/2xxu6aERg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6A7CD8C96C;
	Wed, 17 Jan 2024 20:03:41 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZagJuxudO7V510hS@p100>
References: <ZagJuxudO7V510hS@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZagJuxudO7V510hS@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc1
X-PR-Tracked-Commit-Id: 6472036581f947109b20664121db1d143e916f0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bce3b5d6764b1e8cd8e24f4ced54ec0c42a64c32
Message-Id: <170552182187.2985.11526843146157079131.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:41 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 18:09:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bce3b5d6764b1e8cd8e24f4ced54ec0c42a64c32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

