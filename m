Return-Path: <linux-kernel+bounces-79783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74C86269B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DB828235C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442454CE09;
	Sat, 24 Feb 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp5+vTNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790D4CB4B;
	Sat, 24 Feb 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798268; cv=none; b=vEpfJLqdnndg3QGsh+Ht/iwmjI1IJQ5WtLCHE2RECyvExZHMHSVNoWpMsTriIFPOx0DRK+vO2IubzerA9IdtjIpnVndyAKhTG8XRuEK059fLElelmMu3usAdYuPRkRg/0RMiZ/EJv18jxwmdh3Rcf15y+j84BE4i6OQpkPAKguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798268; c=relaxed/simple;
	bh=S9piwdeeRkm1b4NpeHJRdCvWkZ16x79YwijKGewP+aY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bIvnnSQfMzTq2YRGx3ussY7e/8RJ2xCOn70rI8xpMb9Q0VevvfAvpHmsj5layon7XLuNW9Gip4KHqxg6m0V2roqrYK6pGwyx28eEsUMHFBFP8muOaU9T77ogq+8KP5eYIRYlzmpO7Ovj92iTkHYHQ7f2eCYUwigyXGNpo+3LTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp5+vTNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 680BEC433F1;
	Sat, 24 Feb 2024 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798268;
	bh=S9piwdeeRkm1b4NpeHJRdCvWkZ16x79YwijKGewP+aY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wp5+vTNKPzu501lgmfvIar2XdMTaU3HdnljH/84C0/bmFvcPza2ZEJMed6S2LbQ7A
	 QxR7cPc2LbRCkyKbyfBkkfM8JMbJ2mLKeBx8oVi8Iknx4pzkrd+Zf5cr9Ptb7T2cjG
	 LETaN4eIpdGiAtftBK6RFuUj8zvUc0oFplt6ygMnHfdqzg6X9kIL2WKRzwpUgT9nhF
	 ArQsKLZhLpI+yKOW1qg4/J/pdyfXYKHgHzWhEZh6v3/c0RCXr3kI8O1V0rLmqpG+6Z
	 RNkQJ9ZH0eRF5ReLtdFcbrvGHi4l1NLOS67RFZHIj0n9YxeJ4qnqQt3eoqf9ZBtWbv
	 OElssWJqFVDzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5136CC39563;
	Sat, 24 Feb 2024 18:11:08 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <7717849f3c8a7f8d257ecdeab3da860d91616e78.camel@HansenPartnership.com>
References: <7717849f3c8a7f8d257ecdeab3da860d91616e78.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <7717849f3c8a7f8d257ecdeab3da860d91616e78.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 9ddf190a7df77b77817f955fdb9c2ae9d1c9c9a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d20acbf3e3a32d331947dbc3802cf2d1a399e7d
Message-Id: <170879826832.13456.15525430192013507681.pr-tracker-bot@kernel.org>
Date: Sat, 24 Feb 2024 18:11:08 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Feb 2024 08:18:35 +0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d20acbf3e3a32d331947dbc3802cf2d1a399e7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

