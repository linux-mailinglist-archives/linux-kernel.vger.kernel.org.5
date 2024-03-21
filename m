Return-Path: <linux-kernel+bounces-110680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04233886253
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D71C22449
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD6137C2F;
	Thu, 21 Mar 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Im4Uh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAC13793A;
	Thu, 21 Mar 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055405; cv=none; b=YZQjY9BWTDwkkSkifzexDFPg1gkMX4xkTmcjEWmtRzokGYTZ9yroaS4v3JKmsUCy3s56O5/xQGbUWHVn6Og6hCV4kE1WBgQh9DFH9fpr3FQ++OFjzh+F1w0a/Df8lc2cwKA27TJKma/nbNTEqRmlCL/Bd5ZysIj0vz3AddLpAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055405; c=relaxed/simple;
	bh=zfw97roRPwNvwiA+ypnoyqxgOFpkjOKwMIhgusYB4N4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=knGhZJu2m9rNKyEVrYTw7tj3MhspK6I7Yd/M0wXc788AiUV1fsMKbygd6/Ps0vFgamMYoXfVWQ5u+sdyAacpUh62fp18rUjwJRFyXvf86UvuccWLZ2DOYD12q1QG4VzI0z+jdijhPqIrPshpnbf15rK3qs/yxY5suPG/l/+ZJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Im4Uh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21BDEC433C7;
	Thu, 21 Mar 2024 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711055405;
	bh=zfw97roRPwNvwiA+ypnoyqxgOFpkjOKwMIhgusYB4N4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s+Im4Uh+ez/TaAMowBWxUGjdxJl2k8lE7gJ7Nx39p9qXuqMgGbEq5SH5+H3lSnL3+
	 H5jqsmIzdwQ6dVPYqEetqhU7FjEACauR/cMuhr/p6ZCmFHDPplnj/lF7rIpvsrBi6D
	 a3rRJ+QGmi87M6b4i2bjDhjeiryo7B33y1E66NU/yzEUwrcjcJwNY4gtSzVLxg8e4m
	 Mouj0JFMbJ5WluTopv1DHeSMiVpqh1sD/nWAED1sFTHaEzcIPr6CB+9dx1tkeJkju7
	 jiWKGc6bvwy+jxYACIGjIJU2Rn4PaDwtcbJ4oLtwzCEgnFJexjsLNKWQ9g1x0O68ce
	 D/qRnCcm9y1VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED999D8C729;
	Thu, 21 Mar 2024 21:10:04 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zfwvg03C-ptMQKVk@kroah.com>
References: <Zfwvg03C-ptMQKVk@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zfwvg03C-ptMQKVk@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc1
X-PR-Tracked-Commit-Id: a788e53c05aee6e3d60792a59e10c0fac56b5086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e09bf86f3d53ecf4da61163d88036c4c16419d70
Message-Id: <171105540494.8284.2741645346835667470.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 21:10:04 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:00:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e09bf86f3d53ecf4da61163d88036c4c16419d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

