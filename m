Return-Path: <linux-kernel+bounces-30544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DF832016
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277991C22D36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798A2E648;
	Thu, 18 Jan 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkwhO/Qk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62E2E400;
	Thu, 18 Jan 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608017; cv=none; b=JTEo8un2r6TL10tAYykZSNM3gjfbDaCW7aQIaAOMkMiv4hpiP8zz3Sn2Gi5e1MQ9Z6sb9Ca91qBYAEBAFMGqnsbfrbfb226m3WYUD1kEtgfnQdZH1UR8gSq3poAl5qPXOIU7GPSqUpCWRN1vVVbvHxUYnpd3Ru+XZHbpy/VuNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608017; c=relaxed/simple;
	bh=njXGg6x76cMiY3j8khQKG/+JoVClVJiYU71bPIDSRFA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K5UGYyRmusoBdfHw0V1McC5hqMEd9et6dS8y7wMunZR09uiEXWjAjrY2Nc5D73XZTPYJW+XurjnQMyQHEugVbCYS7mFV4cQa146vbdm0Nwcc8BMjhPZRT201taXqLo7Wkkj0u+JFap6XdL3iWUjR/JQhcKjztjEVhlOXOSjDcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkwhO/Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC076C433C7;
	Thu, 18 Jan 2024 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705608016;
	bh=njXGg6x76cMiY3j8khQKG/+JoVClVJiYU71bPIDSRFA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RkwhO/QkB/1iNWLsObYEuFkZNwE+93ssOH6Y34ZkCjgT2PLPmSeOoZDTwvCy8D8HB
	 n6FzivlpFziTibc0VP2jnagEudX/gvsTRfOwxXRqj0U1UxM7D+LqwucZbK7Q4Gg8Fa
	 OhT1WDIjGGpbig7759ymzblg/HVOfHZmNMhCd+BT6td81pPqCS3dzi5AU3KcTUuWMx
	 q2I14IUH9oJ1BCx3+/eblYY4zBvGP7f+g9mr3smxTFr6/aRuchUtJXPNrBqXTViAnZ
	 Mw5+ahAn1hnObms0WAVsJDEotderkPqrD5h5NzuCKTASkI0/EPEoLaX0RkBY+XurCb
	 WB5Hynz1H88/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2AA8D8C970;
	Thu, 18 Jan 2024 20:00:16 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zae2ZrJthYx0tVSd@kroah.com>
References: <Zae2ZrJthYx0tVSd@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zae2ZrJthYx0tVSd@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc1
X-PR-Tracked-Commit-Id: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd736f38c014ba70ba7ec3bdc6af6fe5368d6612
Message-Id: <170560801672.7899.2933714878712582045.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 20:00:16 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 12:13:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd736f38c014ba70ba7ec3bdc6af6fe5368d6612

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

