Return-Path: <linux-kernel+bounces-152542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669F8AC049
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C33281716
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266312D047;
	Sun, 21 Apr 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBNPQO0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343F1CAA1;
	Sun, 21 Apr 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721012; cv=none; b=N0rvaiyihfWYoY3Ezslh8GibBKgVBG+ftjmfakHxDn5RmBcCa+iMbMS76sgw7P4ck8PrWKF6/phpZKa8U6IzaZJrHuJo58htFZ4ZhDXMXBNJxM6VCEPE4xmGaYkZHUBlRfRozY7E/Hj5LwvnzBrwLos4tok5uqjsCFZFcz683nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721012; c=relaxed/simple;
	bh=JHQSxKdOIlARwmrjaH/TyAxzdAYyOn7MGf8TmcjeGlU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GyxdltXVQaLR7OKQEmpdljXB1uGReJoQh07xHgKVqZgFgR6pZS9q/S0XKZO90iCArxE3YIXh2tTOhyA/IQ+I4+fZaD8xyrUHCytAkgVyXyuXMor5RrWVVLkdT7DWCPemgWIa6ljnun6cC+16Gwcm6lU4e0z9hLxt3JRXZMbQ2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBNPQO0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 459FEC113CE;
	Sun, 21 Apr 2024 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721012;
	bh=JHQSxKdOIlARwmrjaH/TyAxzdAYyOn7MGf8TmcjeGlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CBNPQO0EBdJC/CGatD69GcdylYwe0y9B+OagyrPjvoQX/1FBVMdVsoCIwOPYm+5xi
	 VGhDzRMqC6fCVYHOIb9MF4jNgtKybkVhWiHijQxGQgPAzTub/CemwG3xWcBXlG4ou2
	 HWesMoXIm13eFIgwRELK3qvlAqbAUpxCZIbwozQOZN1WKGFrTjUWiGTRkBf4B2rT36
	 gGCmwkl8dQLuE8+iZoQ3+TNyeK6ba5gv3Js1jOf2nrnUhcnP34+TX34ADaWDlvmvo3
	 bUTyK78J1Gowjkz+gKOxh0vSy9NfdyWirWy2bthcvHTJRK50f/yhmN4gY9J0Y7Ny6F
	 cLK2NQwy50q/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CEE1C43618;
	Sun, 21 Apr 2024 17:36:52 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiT6R-j2EEg1tJZH@kroah.com>
References: <ZiT6R-j2EEg1tJZH@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiT6R-j2EEg1tJZH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc5
X-PR-Tracked-Commit-Id: ea2624b5b829b8f93c0dce25721d835969b34faf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0c6b5c090ead778b3a8132201d25040b1fdcbf8
Message-Id: <171372101224.14492.1250482360491505866.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:36:52 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 13:36:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0c6b5c090ead778b3a8132201d25040b1fdcbf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

