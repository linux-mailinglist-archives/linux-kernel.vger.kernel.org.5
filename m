Return-Path: <linux-kernel+bounces-103857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826887C5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5ECB20AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019BFC15;
	Thu, 14 Mar 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWPUhNW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C2134C6;
	Thu, 14 Mar 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458041; cv=none; b=u0RTr/1mSWnwtEQjQ30ooZPhjnsgOwVCrUK+ffjo950bwVqZt4/lR9GaJqxRrSBl8wpmpkF35lf822Lz4xl6ZIoVHSQhnfFatNGO7rNeDdcYFItFDS030JbHOwvUTpYsXo2pFCyx9dOBIg/ONOhIOCpKfU7tXcoi0LWMHfZhYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458041; c=relaxed/simple;
	bh=DmmBocbrlDaAxCpjeauF7wicLAVTLJmRzOHpMrcruyk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jpC2YhKSA7/cY+TQsVkiZNhSum+zDt/q5Hk7U3GZ/w2EMfWZNCY0378B8auBzfhYKvHk2NKeM/TXEN1waiAy5bVxn98vDnhwsIz5mKa+srFQR2haEC8dfwPBeJRMZp1wB2RDflLgbzwqwiVFrdHMxUbLElPv8ExdMXJ+McLc4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWPUhNW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77816C433C7;
	Thu, 14 Mar 2024 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710458041;
	bh=DmmBocbrlDaAxCpjeauF7wicLAVTLJmRzOHpMrcruyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DWPUhNW2SyNYlIJbk+lQciHhlipRcMNaXwjSYiE3JMDDKkD6Nxlxv0Dl1cZ6I2hiO
	 G8Qd0f4mKIiuITs4zspd5xeNgsr58t//oijcO0G7s/33GuwcmTZ53sN3j1N45sFUrT
	 4IZOARBbEmfX1/RJeDbbisG1r1OuDxAPNFz/leA8MoYEsqZfFNJlDRDEwuJU7NOtI1
	 KxHatpr0IMIRKRF+U4xlxhVSQAQcG+6N4LgNQM8MaMykeI7Zw1IooyWhAmfxfILbJn
	 O0Uoy98d9Vy0dPDWiK3QabT+NardoMmUPxpMKFiVQMlW1x0RSneJ7gmX5FmC5JHpYk
	 cMv2uPdHNSRRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D233C595C3;
	Thu, 14 Mar 2024 23:14:01 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313175307.714251-1-mic@digikod.net>
References: <20240313175307.714251-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313175307.714251-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.9-rc1
X-PR-Tracked-Commit-Id: a17c60e533f5cd832e77e0d194e2e0bb663371b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35e886e88c803920644c9d3abb45a9ecb7f1e761
Message-Id: <171045804143.7563.17783103162372991743.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:14:01 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 18:53:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35e886e88c803920644c9d3abb45a9ecb7f1e761

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

