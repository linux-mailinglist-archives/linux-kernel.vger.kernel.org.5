Return-Path: <linux-kernel+bounces-159333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E388B2D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44181C21137
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74909155A43;
	Thu, 25 Apr 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t10FF+Yl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAD15573C;
	Thu, 25 Apr 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085008; cv=none; b=cXvKfSg2mCCVx6QTLkL5yWGODdEDWwHz84U1JEPwFWuYM2kgUsGe9pANawfixplCF6qX4K6OyjZidt5ICJiPBlN35YinlRPg71hkM20tvuywbpEaJ06EQyxG+M+Yq9r6Ea5Aq5VKeGozd56BF4MeI1K49SJeYYhzRgWGhQI92pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085008; c=relaxed/simple;
	bh=Sug9fpDyos9N+b+elODIn4pNf+kgNGIktBZsufKosps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gx8DBcabhqsFl15TfSbkWY076TIV3lAuGqTWsEO3oDwnH6wzBZF8EDF6PJwEp75znesERnoWYajpVvVGACv1KhtpiVZ/RUWavdSW7/U0pYtYrRypTzyMDAk4bcjKhc5GSx/ENGLpXaGT5LGCVfj/pJdo0g5EklSdQ/l+ibJXb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t10FF+Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F822C4AF07;
	Thu, 25 Apr 2024 22:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085008;
	bh=Sug9fpDyos9N+b+elODIn4pNf+kgNGIktBZsufKosps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t10FF+YlBqxHplIJPeTnGOxThsPGnFJKhRC1qWDnu5yg/iJyDrNK/MWEchTaV8Z2i
	 UsyXc2UZKPG4H0UPhYbo4u0NfdD1l0EATtcxCKhz87MiBqDjYy1/PFgFfShRirwZw/
	 q3XdmRDUXJNa/aYC1fn3L0sobPrvfLERXKayH72vamBEK5k6XrvBSKXr9VLtG69UWe
	 4QKvhTuNSLnU9q+SIxg9ddlHUgMi0LwL3QJBOZiXiuoFzO7QMGxTicaBQoqQTkF+vd
	 qwk6z9Ca61r3Xc1J9WU/d2IK9xUxV4EzgS6JjM8PLuO3xtVpJI6eGmFcdav4q2KhKF
	 DOh2XsVwiPqow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40BD2C43614;
	Thu, 25 Apr 2024 22:43:28 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p: fixes for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ziq8YlBcw4qj4K1O@3f3e8491d9e9>
References: <Ziq8YlBcw4qj4K1O@3f3e8491d9e9>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <Ziq8YlBcw4qj4K1O@3f3e8491d9e9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9-rc6
X-PR-Tracked-Commit-Id: d05dcfdf5e1659b2949d13060284eff3888b644e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dda89e2fbc5b7702296356b4a20a5cb66c70e426
Message-Id: <171408500825.32202.14563645924221350260.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 22:43:28 +0000
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 20:26:10 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-for-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dda89e2fbc5b7702296356b4a20a5cb66c70e426

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

