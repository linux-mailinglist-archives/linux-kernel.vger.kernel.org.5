Return-Path: <linux-kernel+bounces-97647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D8876D14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A67B21D65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906FA605CD;
	Fri,  8 Mar 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC1VNXvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451C604D3;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936891; cv=none; b=cTJxhSPpdCnZ44elYEsXww2Hk0qHgEq+MdjRPDzkvT5VglseT39rOdogEpBoBXIboRSQT4S/JgIkLuL6uXgMrAOLg2p5epp59AlwBs1xJhKEmIspBxGAzKCe/V/zopENr9qcsS4d3fvQTyHXzcghlmJzA4l+Uih95GcHOxuMr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936891; c=relaxed/simple;
	bh=CvoY6vSt7iz0VNedo4vxLAAei6D70X7uV9G+ZIx+Jwc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZsTcX/z4dO51sdPCTJ8tGVJcqA4F9E1QUGihZVb2qF01b0I895QIyaVSaDN8QYNkyY29rfGjQ4GMVul7m1VT04TxK4w5pybQ/el6J3uWwpCjk4N0zxmb2lSnzTIBr/8APjilQOz5tvLNGemEGijty7LqorqPWfgUiQsbgBbM2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC1VNXvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5BF3C433B2;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936891;
	bh=CvoY6vSt7iz0VNedo4vxLAAei6D70X7uV9G+ZIx+Jwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MC1VNXvZmQaTy2RxsII0DPDJFqf7Uy1ZYrxMRmhTXuQ8siIZ5+ec57uNd7OoaQ2X6
	 NnZulbdcMByseMhw0KE+wjoFJ4wFrbut+kyiO1sXE1zZnr/1Ke7jYUTTDnhUmy3tQx
	 q/BWil41ljJiX4l6xf+n930aQV6CvWONqqZbtMNQTEX4Thhp3XPtaXxa+ITeYbaFw5
	 3cc7bQkPmAotxS6y7iaTwCqn+G6oFsT94gT50YG8bxr6i8qJP/3AuOOATpuv//DnuR
	 cuZV2FRlJ8OZFpSZzkuH7+AaSTmRKTFGQEeiwkfkWnjLB+mgxu+laBfq2tHDO6S80o
	 PD4GZbqkqumHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2151C39562;
	Fri,  8 Mar 2024 22:28:11 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZetLF6nPrugVB28o@kroah.com>
References: <ZetLF6nPrugVB28o@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZetLF6nPrugVB28o@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc8
X-PR-Tracked-Commit-Id: 3d9319c27ceb35fa3d2c8b15508967f3fc7e5b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 563c5b02f299f4374a157ae6423f8465a2495dd2
Message-Id: <170993689165.2485.12374684903832550704.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Mar 2024 17:29:59 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/563c5b02f299f4374a157ae6423f8465a2495dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

