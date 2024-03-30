Return-Path: <linux-kernel+bounces-125838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF8892CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C411C21484
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901C4B5DA;
	Sat, 30 Mar 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0VjBPuO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BF45013;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830120; cv=none; b=PM0hUhBaEVXv1/9Nl4d0odJYX1dPgOrcL72AWbQ0UUFdV1/xGYZ/J29KSykgnFt1GA9MZ1FfDkfyMAqfirvAI37T4HuH09q1URiaEHUH7VYiJBfdcH6hDbGF0blGGqHZ1VFXDWsoM+o0GcVXZJ/V+tiRy4lNJiok6SVjAN1r+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830120; c=relaxed/simple;
	bh=eixB4TLeK/qnld9F3Wjde7VArKE8AQancMAaev9RXDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UZrpbvjxne13ForKck9twe1I9n4d08dWlkYvNEgtOl63+xPqXLmQvaS5LhXMeIMM7LPT1mVgbwdpi5yYwbJEyaIcpCBfNsiujF0g5sUJ92f2EpqAhU/j6kLciXqkORg4hH969p+QFRHD51PW0z1Ya19xKW5urpUWbYK/oHG9MnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0VjBPuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DC7DC43394;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711830120;
	bh=eixB4TLeK/qnld9F3Wjde7VArKE8AQancMAaev9RXDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C0VjBPuO3U5KrfOPlwkSWTlmcFilg8C1RL+3o1NiMeVHPz0YNnVS435tRfdjZf6zX
	 qDiydXpRRgSxC6Gb1hldYj/RSVPJludh0eY7BIJAdO4kd6BpcAQTG/GxRZKVjtJnUZ
	 VWd720lGKOxYwBInmKJytO32VfWEfegpBCqmVHfSg7T5EtyL5q73FDULiKNhjipYhW
	 jvZu7mQDpmCxgdHVoGn2nyZO32jgsjQLjXO9Hk6RBCkdrn5GJxsfoFcQ9otQsLXzaM
	 3iGPWIujPvMCoxWKedW0kZz3uazb11Ex8NKlmdPk9c8VVzCpdqPEYF2tS+74KldYqE
	 NNllz7FfM+ulA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53EC6D2D0EB;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZggmzvmHwewWq14U@shikoro>
References: <ZggmzvmHwewWq14U@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZggmzvmHwewWq14U@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc2
X-PR-Tracked-Commit-Id: 2953eb02875b42c96e5ecb2d1061d0a2c1f9972b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac6727189c070863587e86705554bed47a85ff55
Message-Id: <171183012034.3897.1814588348909367851.pr-tracker-bot@kernel.org>
Date: Sat, 30 Mar 2024 20:22:00 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 15:50:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac6727189c070863587e86705554bed47a85ff55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

