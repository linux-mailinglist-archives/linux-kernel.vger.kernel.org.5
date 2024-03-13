Return-Path: <linux-kernel+bounces-102433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5187B1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E714F1F283F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC90626AB;
	Wed, 13 Mar 2024 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8pJQgu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3B5EE7E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358100; cv=none; b=o0UjsXBS4kppRkw84pjmTrMRDzH2JOXm8X6RUmA0ibq3WUyvuQuQwFL5B8NogbwmmJ3VdL/GLDrqJMmHuHZZ4mtXnNEf3naf+U1paTySlS0gvc0klIb91LfCPZF7kDbeI+4cDOP1N69GSM2r06jbHFKcaQtPeIu8oCYpwwSnHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358100; c=relaxed/simple;
	bh=J+yhx8CDs0RjV5zrthtGqQh3sZHfR3DlyiCnFJoqLRo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qf+h2MckF4DrWJqG0XRfnkCWlQuW01VsqcFAcEwL71JSbEYtM8oK5BAw55leQoxKPAOH57xVVxtwObfBoGoBXJucfHSn3mkQd1H08gUKgX9TkmxYxTYnkZ0DTj7RzTKvnXuax6Vaglyi9qXbTob7PXDeYKv4uGNoJtcljRhbwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8pJQgu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E9BC433C7;
	Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358099;
	bh=J+yhx8CDs0RjV5zrthtGqQh3sZHfR3DlyiCnFJoqLRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u8pJQgu6P+unZ3AetKT63onvh/avsdO4B2tlOx8o5LuHv7xNV6WQu+0kJ7QFQVDp/
	 YD2dCKbvjzENwy9UnGs42WicljolHcKEfyUcx4BlMQpgvSE59KwRlUSj52R9gvjPvH
	 tip0L0mza7XfWRVLJmUpaFRPPtHfhn0Q2sK6sr/MQM+fkKPyWQQAeipgPdCJn+0bNQ
	 28VD9lmKJSmuDojUlf7gBhFEO2S/XYT8/sPPDK0JHyYe1yMRkR7zaZdEgLpgH49O/H
	 X1CIGJ/PZfYTUmcNAwRfgJLS+lJz5IMBVIx3zHUlMEIejQFk+NSkhZ3xcKa7tFuLfm
	 tsgfSLzIPL1Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73E1AD9505F;
	Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ebsgtolipefn2id5vvxxhga6de7gvatfmzvehu5fj5dxl45j7z@yp2jcj4njfht>
References: <ebsgtolipefn2id5vvxxhga6de7gvatfmzvehu5fj5dxl45j7z@yp2jcj4njfht>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ebsgtolipefn2id5vvxxhga6de7gvatfmzvehu5fj5dxl45j7z@yp2jcj4njfht>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc1
X-PR-Tracked-Commit-Id: dd6c6d57ab61d496f6ff7d6ca38611062af142a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aeb152910a7aecabde5c5f0477a08b397e94059c
Message-Id: <171035809947.9850.13850214484637403368.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:19 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Dharma Balasubiramani <dharma.b@microchip.com>, Dong Aisheng <aisheng.dong@nxp.com>, Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Jerome Brunet <jbrunet@baylibre.com>, Raag Jadav <raag.jadav@intel.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 10:16:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aeb152910a7aecabde5c5f0477a08b397e94059c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

