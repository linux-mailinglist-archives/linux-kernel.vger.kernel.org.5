Return-Path: <linux-kernel+bounces-77286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53086033B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C96B1C20FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A426AFA1;
	Thu, 22 Feb 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY1m26yR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A85491B;
	Thu, 22 Feb 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631485; cv=none; b=F3XI/zdJAKvVAH8Ehxj6AxsxYU3xF8mPbiJz6X39ChU6GQ1/BPdYWrrez1No/yWv70iIs4WL6CO2S7wy4IspeW4qc0F8mcvnaZcbsZ727o/vvIYUwfvanYGPvKFPR2w2sdtQQkonadR7N3yFw1t2dnByk7gn7zhWUMLTcV9/tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631485; c=relaxed/simple;
	bh=eZ4iIJtV4LjYkW49xR3Skc8t8FF7LhGrp9QOOC8AqQU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S1foo2NNVo2ncVylhHhCgsQ3aq0IfoV/JVxV0QIBjVrpj6NPAnMu6Zd+U7lkbARoC4f157YRQVP7eeZgO6guQPR1uctrcNe0YqGSeZOB1KdEPmn73oDRZAANYNJr9KDZgHIpDeO3N18gRDp7qj5vaG1Rs9qzEMRokWM2M3J+GGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY1m26yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8061BC43390;
	Thu, 22 Feb 2024 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631485;
	bh=eZ4iIJtV4LjYkW49xR3Skc8t8FF7LhGrp9QOOC8AqQU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nY1m26yRQdmOyv5Zf4MD4YrUqBAvbm1ISI0zOSCwEdIpPFxBtntlengGBdL4FMk09
	 lJil5N9fhsppCdyFQUbfg00Qbgd70ThQ4wnFewgF7vCD1aGoa2wHv3jkpAFTjy+q6B
	 hB5RwfrB7iA454FDE0/1+vc5+9JfIiTFWZi7AAi8d8TxN+lMvOppGUp7Ju2AXXbNCu
	 5yNLg7Ev6eED05oL1sIwt+8AbDGAp+iJKV0Xnz3KrO7inprB0BhTdZSa8h2rxUMrAo
	 mKZ8DgoLAskVkALGWXedde3nbG/tSr1nVgn2onqjEGiV6+LXPikTHjhXZmN38qt+Zb
	 ClhC/XsTwyA7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E2CFC395F1;
	Thu, 22 Feb 2024 19:51:25 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.8-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <2b496ce8-4711-48cd-b1da-d70522bc0580@redhat.com>
References: <2b496ce8-4711-48cd-b1da-d70522bc0580@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b496ce8-4711-48cd-b1da-d70522bc0580@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-3
X-PR-Tracked-Commit-Id: 427c70dec738318b7f71e1b9d829ff0e9771d493
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7138f7a354df7cadccda31173617a7f30c8b6c6
Message-Id: <170863148544.11658.13967952660084009980.pr-tracker-bot@kernel.org>
Date: Thu, 22 Feb 2024 19:51:25 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 14:52:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7138f7a354df7cadccda31173617a7f30c8b6c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

