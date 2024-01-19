Return-Path: <linux-kernel+bounces-30670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD96E8322D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE731F22E56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AEC138F;
	Fri, 19 Jan 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRK1JONJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580711362;
	Fri, 19 Jan 2024 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626522; cv=none; b=kpogygntlLZUapKIwK3ALzetm5zUAT8GEfPzrRj1cXShI3QwQxMcgbjaBUl+Nwi5rfuL3MjgkVV4oUm6zmRaX9yxmwqQvgRAzEhgLzbVcIwK9w3tu/DU5j3Qq3CWEGPQ4UOQMqUrmjE6NAv5K3hUs1hIOaltfIPOSVuXKgHWzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626522; c=relaxed/simple;
	bh=zEsbX23c9+CteZt32EVgQ0qDPcAr7Ettp1p3vW1LKhk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SLugp7xfphgW5tAGYO9wqdRdvEnIAjWtNHnLqgRs7Q3tIwB/TH/lHcDlm2uPxSqHoaqiv73SMjA8A56USDNOG4yZvP1kz66X00E8vWBghuESVue6mFekKmZohBeNvHxqRUrPeT323SlShO0woONjnMz5NjGl4rr+ETrBm0n8ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRK1JONJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EE93C433C7;
	Fri, 19 Jan 2024 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626522;
	bh=zEsbX23c9+CteZt32EVgQ0qDPcAr7Ettp1p3vW1LKhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bRK1JONJnRR2s+FNsiRsHAwKHVfEtC8LjtX22dHcJcC/BSJx/om/T4zx/agkDGlqY
	 UlWhzJHNJpirG3Sl76X9wi3mdUpt5unBYyRfYANQyBTBtTyV8WP9WlhJda433yQn7Q
	 VaOPd3TqUeCrF3jaTNUkOH4WrWV1oHxUUxBiZlPli66IVYYqbqs3bMJqCyoW+eC6eC
	 FnOXCeEEkQscnUK6klQVeuc4uphHfBWLASagPMMR2ol4Ijs30FBO1RK9Owltoe23T4
	 H0TdEEXLAmGLZfTQIhpL5tdlONbxoRz/rbGxkznKDs+OqJLTpC0mDcaAHrYri6u7fI
	 vaEQ9uOY4biIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DC53D8C970;
	Fri, 19 Jan 2024 01:08:42 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.8-p2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240116161639.1127810-1-linux@roeck-us.net>
References: <20240116161639.1127810-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240116161639.1127810-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-p2
X-PR-Tracked-Commit-Id: 2539b15d504c3f9fd8ca82032bf9c80c9864412c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da3c45c721e2807b2effdea8f41ece96bbf47b15
Message-Id: <170562652211.16604.8672079115069964491.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:42 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 08:16:39 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da3c45c721e2807b2effdea8f41ece96bbf47b15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

