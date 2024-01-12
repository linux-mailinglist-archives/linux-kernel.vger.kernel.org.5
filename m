Return-Path: <linux-kernel+bounces-25069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70882C72A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7E228172A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0518628;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMW7x0+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB61773A;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C30C433F1;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098027;
	bh=V+G4IWzoepIpnAE6rOw3u+FcMwmZeMNw+UwQuh4yBEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qMW7x0+nZgrtJNS9k8oYKJBRSlmoas7JbWWb98dw5LYB9PuFZJ2FAxnq97o7qDjwo
	 ZwdSc4bFZ/Tf9S+mAkmwtq8NCBfKKjUvVJzBvCPWv9lwPHYme0w7Bo8hUdj+j6O+Og
	 +JGtiEfgZIIYOjSdWt+7mCj1znrJpI751f6b5upH0Y6Qfo8YmYorj2VDlOWArImKGF
	 crm+gKkzmgqBPP9VWwHQa/fhk4Q5NA4Qandnl9p3O4Ajfhw4AExEb8lQ7NKbunut2s
	 keMIPzO+h5cD7YWrRsvMyeK1eLq5FIQHb4WEjEvMK9ZOnG1Uc3oVa6jaJNq22IzbpE
	 XZbaWnPOwib7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43303DFC697;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.8 release cycle.
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240106134410.GA19394@www.linux-watchdog.org>
References: <20240106134410.GA19394@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240106134410.GA19394@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.8-rc1
X-PR-Tracked-Commit-Id: 9546b21ea672aa961d5a89ea754214afed013f02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61f4c3e6711477b8a347ca5fe89e5e6613e0a147
Message-Id: <170509802726.4331.3286600777776918013.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:27 +0000
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Ben Dooks <ben.dooks@codethink.co.uk>, Biju Das <biju.das.jz@bp.renesas.com>, Curtis Klein <curtis.klein@hpe.com>, Daniel Golle <daniel@makrotopia.org>, Douglas Anderson <dianders@chromium.org>, Jerry Hoemann <jerry.hoemann@hpe.com>, Johan Hovold <johan+linaro@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nik Bune <n2h9z4@gmail.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Randy Dunlap <rdunlap@infradead.org>, Stefan Wahren <wahrenst@gmx.net>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Vignesh Raghavendra <vigneshr@ti.com>, Werner Fischer <devlists@wefi.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jan 2024 14:44:11 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61f4c3e6711477b8a347ca5fe89e5e6613e0a147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

