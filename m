Return-Path: <linux-kernel+bounces-125330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2A89242D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBCB1C21B58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28713958C;
	Fri, 29 Mar 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a021Cm4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023A13341C;
	Fri, 29 Mar 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740448; cv=none; b=Zwt+TQBpKY9UsgEV9GwCKyS/qJVle/3ZnJsWQ1cUoSuyERhLl5QIsrSzMAIO2ENPAMXT5iwhlpDo6/95xPiOVL/TCR/1F8HAttiJiNc9gyLDegdtnjS3c117YBvBN8g5eKuvOSHxzbCfF6Rjq8D+MC57snwOsmykCwrM5VQFmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740448; c=relaxed/simple;
	bh=DQmVx3n9y7d1moDMdjHFKuULGaa6TIgPqNFq6skm/aE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mY4eI/IYdsWIGR2fn4u7emLDJYYVe7v0X1DFQZS2bxQd0tf25NWFJeoALYgmIp/FDWZ/dDDm91RxrnM70yj/RVuJlcC5S5gzoBU/nUKF1TBm0bjbZI144NqXQzUREHYHMaMFk7Awzj1QSNsNYXNUQ7WBoByc9r/tkd+GWFot1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a021Cm4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F97C433C7;
	Fri, 29 Mar 2024 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740448;
	bh=DQmVx3n9y7d1moDMdjHFKuULGaa6TIgPqNFq6skm/aE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a021Cm4rKzvMtw9Y1R0+2EzYmWZrwmzxpzdlJeTZdnsYwesd8y2XX6g9X1rMqD904
	 IpZ97fownz7OOxIwZZ4aLyJCh4vnS8nBj8Vp7yS1ZicZdXk2C+AeDDwdElt9U5ZL/l
	 MDeemWY1ZblTrbDNDTQgcLqETA+FKBrwo3cMHSEGVo/lvVP9TYEY/6b8xfsbnWNQd7
	 nN0+/DaXlZs/onS3r1QcuaMawSjSnnjIWbeRp4lBUjd+ZxmO4ixj4YYByOtu+2IW1A
	 wMiq0aw4nFH5iSmoL8PtppPhDFjLKu/tGHStUl2NTlE7Rn5P0OXq5UXi3MSu2krmOI
	 T0xXPuIpRO8tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 304C5D2D0EB;
	Fri, 29 Mar 2024 19:27:28 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j1X_0bsF86xWxd=SCBNa1-tFxOErw3uKOVmBZLtUEv4A@mail.gmail.com>
References: <CAJZ5v0j1X_0bsF86xWxd=SCBNa1-tFxOErw3uKOVmBZLtUEv4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j1X_0bsF86xWxd=SCBNa1-tFxOErw3uKOVmBZLtUEv4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc2
X-PR-Tracked-Commit-Id: a26de34b3c77ae3a969654d94be49e433c947e3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a3c0de677c83a003badd1010e3ab74240707d9c
Message-Id: <171174044818.16736.4497542056118333549.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:28 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 19:32:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a3c0de677c83a003badd1010e3ab74240707d9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

