Return-Path: <linux-kernel+bounces-80248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10806862C83
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDDD28182E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF81B597;
	Sun, 25 Feb 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZuESVNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DABD79C1;
	Sun, 25 Feb 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886766; cv=none; b=pYikVV+xZkqo9YTcl4/pBRtNLqADYWnT4MthMuL6q2Lvz2MdyLZiJjDwwlMcpDxth9TqSyZDIfM+WNN7PewsK79XicLjnqYr4UOkt+phLuIFlG74giAE0mGdIz39LYb+lnaHF/V0KMTXAm020nwAT+X74sFUH2QFiVMv3NW72bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886766; c=relaxed/simple;
	bh=YmBs676U9H4TGDASWPfOGZLIbJLoOIFITEAcTTJZ3qo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tFkJ3SzLFlwnnJToDbtF1nOPBG+QJEF73GrUjByRhyZGQUiYWS/gAltlTS+fPkFTnlqh8k6bWG6uGQvbPvKLp5r5z14NEamf+4VVG6msSXjly+6OamEvAPA8kvP3d15ldyvDby8sgdfe8C5OZOGLAVWVrMA2ay6GUIy6iUbR2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZuESVNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D40C43399;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708886765;
	bh=YmBs676U9H4TGDASWPfOGZLIbJLoOIFITEAcTTJZ3qo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bZuESVNMFOUsvQ5gCf8bH+UbcX7nH4E1KZOI1QRX+MMikCOWwLJ0RXYNUlquCgSzV
	 ansoy8G8V7bYYfaW5ZeDcSnd6OlEfp/gEXyRnJWCt3ixLLYLvt23+GcnxlvqVutjdD
	 x+MAdBVLfjXPisq1+2ASJR4zaTcDC07rQEauD1Jum9PyRDp33cK1jf2wE+B3eGLOpQ
	 EVd1aVe5PrZruW71kzIyyJOxLH1x0SWhYcgv4IlLXO/lsEEfAENasI21kDqwhxtsLr
	 +gdYWAXZo1F1dyKYAzAMZJFeOgtHISP2jtFxJy3KRRMIPDDw1lj8ul3YPSTIbwIetv
	 n8lP+U9w8FYUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C039BD84BBC;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdtHHn2s9ksLd9zT@kroah.com>
References: <ZdtHHn2s9ksLd9zT@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdtHHn2s9ksLd9zT@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc6
X-PR-Tracked-Commit-Id: 69f89168b310878be82d7d97bc0d22068ad858c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c46ac50ebec33907e5768012aa39ba1ab2f0ca14
Message-Id: <170888676578.24357.11548097634735021943.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 18:46:05 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 14:56:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c46ac50ebec33907e5768012aa39ba1ab2f0ca14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

