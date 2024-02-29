Return-Path: <linux-kernel+bounces-87427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADF86D447
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D77F1C20D10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDF142904;
	Thu, 29 Feb 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PazpmRc1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8312FB0B;
	Thu, 29 Feb 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238834; cv=none; b=gn1OajWIQMdrQzvRLMfKQbByO8HDynb+F5pMTFdIBw9tgff3b8URHDMt4FvUcu0FCLKpuvZ+iOAjM/xQp/Q52jZN9Sfb6zNLvLPodXUDqF5boeUqhWGA198wnqby0HDVxqBs5o3/XyyT7oezhtUy0A4fE1GGb02qfHrcdqhnAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238834; c=relaxed/simple;
	bh=+iQBVNJxN0LEeCJh48ysrWufn7QoygNi0ZKhPfZOmOw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JnfRvwKu2NoJ4Ms8AEpeReqTRrFXWnPX20D5twcEm+xj8XUGQVKMUQ3QOA1x3xiTeZ3sSAWtGG4t7Tf2W1ODNc/qBgGK3yssdBScxhvdRh3nhlunAwkH5It7W8/TBy/I2zP+onsqMy0FZW8LpcaBNFXK1iV8O1cPW+WKSNtndZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PazpmRc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB5CFC433C7;
	Thu, 29 Feb 2024 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238834;
	bh=+iQBVNJxN0LEeCJh48ysrWufn7QoygNi0ZKhPfZOmOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PazpmRc1qzXCZ2d7ILOeza4Zjp/JbzvslBSamTb9BMkT8oAHVV24WY2Np0aTeh05s
	 5ReQYmM7O1O+A1AYGmVJCqppukW74ci8i7XXrfB/TNQ8fME6FTfAQiS7yGKFj/FCnP
	 F1JsHO7YfkB0ouRpvVFaKrJUwCu4WxBhTtBSrvYV1TXhVG7aTFT7EVP0Qyz0VXMwPu
	 nVXU22sNmWDm83gx+4/p1iCB07XqOeL7pO1CI+b4T+fD/OSdN+fRJ/P1SReSP+NA2W
	 7TOIffmRG01a35npj0lDYCb0EF/WuYg0wsZEZQWlQYDc6pyyvuzmuAlAhEeYmNcgKm
	 15l6gVPy9WDKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 996ECC595C4;
	Thu, 29 Feb 2024 20:33:54 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240229181802.371558-1-mic@digikod.net>
References: <20240229181802.371558-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240229181802.371558-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc7
X-PR-Tracked-Commit-Id: d9818b3e906a0ee1ab02ea79e74a2f755fc5461a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f76f8065681f55b3c69073829fe7e4c70c0818
Message-Id: <170923883461.18497.12558452908908206066.pr-tracker-bot@kernel.org>
Date: Thu, 29 Feb 2024 20:33:54 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Feb 2024 19:18:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f76f8065681f55b3c69073829fe7e4c70c0818

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

