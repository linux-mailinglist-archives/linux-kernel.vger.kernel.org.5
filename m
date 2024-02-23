Return-Path: <linux-kernel+bounces-78995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24A861BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CA4B2305F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D7142623;
	Fri, 23 Feb 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwxvmaKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79A81AA8;
	Fri, 23 Feb 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713838; cv=none; b=MpYF9cR82gCLLVu2uhEyHOqwn/CMN/qXtlt2CFUrv/AswW0n4kF8B3D6ZNiL6QBquakow69XWU4cXkMsF5DAjfN0RP/4WyPvqMasAi14z/TGfU2SLUfPIcuYlQw8uruiPZZlOF4DKMB1DIrY6vv6rq9IKJOfG6L5hJjWA/7SgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713838; c=relaxed/simple;
	bh=wUA3UG2e4eKTv+pNIEpezc24XfVbMnIsRy/h63LSJ6k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=quhmdn0xPE5+5EP0s86EtFM9ZIZYKaU4kPhCYNqrdYDIrZF0Tpgvv7MmD5f7tpPDFjLKusZVGUDs1Bgnz1VsPvBCBI74oMIXArve50vz22oBw9XLdVwuPgUBdv4Y810cFIoDeUay/AbA/mq3zDTDNWAQqzWM/WSGkUNLT4x1djI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwxvmaKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAFC8C433C7;
	Fri, 23 Feb 2024 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713837;
	bh=wUA3UG2e4eKTv+pNIEpezc24XfVbMnIsRy/h63LSJ6k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DwxvmaKPWoeUQf7PwyTRAoozsAhC/bQqjnANklagLqy8GkGITide3cU8KCKEhrSJc
	 zdYKjm6wW5RfNhCoU7GuVoBtJcqg6xJRcQaZXgEfoYDeP1SW6/N1Itsh127iGnHFLz
	 Ps1vw3+w3Fc0cJ4NpXMkqkKJK74p49zj+UQU8P3xLCYybw3Ar/LK6HR5yzSWdKi2EC
	 xH1oJPfGq0JTQa1Q6f0FXMkPxt7q04ATZlXxuKR7zxYBxLemne+WJpfiwD4hQR38hZ
	 jBOgf2x7Ca0cjbDWfnHoQIcBffcsxrxkjE9lO8SwxH+ggH9Ft0XmFE3QWlRnY/o3I0
	 hV4DztIgzqzAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A92F8D990CB;
	Fri, 23 Feb 2024 18:43:57 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zdjb8E0XItxNJyVB@p100>
References: <Zdjb8E0XItxNJyVB@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zdjb8E0XItxNJyVB@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc6
X-PR-Tracked-Commit-Id: 882a2a724ee964c1ebe7268a91d5c8c8ddc796bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 603c04e27c3e9891ce7afa5cd6b496bfacff4206
Message-Id: <170871383768.26987.10381393878040146125.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:43:57 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 18:54:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/603c04e27c3e9891ce7afa5cd6b496bfacff4206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

