Return-Path: <linux-kernel+bounces-48844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05284846243
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F81F26AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29B45BFC;
	Thu,  1 Feb 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzfJOXj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6A45BE6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821356; cv=none; b=FG7VxV/9C/KDBnK9JvCG7DRUWFA7CfRJxRxiuNM8PMyOl4IShJqEZSHr9qlufuKRbrMoiPKEzwEbzfNLwkSBVMjyZeQX35n/+1pAUzAZZSg5an9HXhHim7gj1A4iqs3wNsryWK4TO5GgrYJZZ3iTAE+rAXR0LhgB9FS/MWSdDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821356; c=relaxed/simple;
	bh=gTJygwG3oqEWtrsAlB1dGRftY+XxXUyhw+CveuVfFqY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VMZjuaozXTKDD+jFgPTKUs1aLmjHhP4x2oZejsRYJ7NGtDsthgSpm+5hTFkbU+SbTNY704p7yj5PBUI55qHb9Pv0zpOkU4+IYyyflC59HIMFCPHeGjR1vArQYiYKFYFTJUzlCerfbbeXt58y/K24BH3csy3qhbnra+FEIOhBxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzfJOXj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43067C433C7;
	Thu,  1 Feb 2024 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821356;
	bh=gTJygwG3oqEWtrsAlB1dGRftY+XxXUyhw+CveuVfFqY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tzfJOXj6UTbjs8bY/rzH7HvNCC/LQmpUaWsy0wz/72iUE+h8Ulc+5YYZ2osct54sJ
	 1urTAUOgP7XU05wp2Z+X/zXk6Zg8eT3iT5VQ/d6JFea4g9rgpiFaILNquOtPxsABiZ
	 pvmTC8RWid8eS8sdmlLFj8ZTkCL566jEAbbVygWugVSMS2T0CyFTiWf3ipmwUoxE9Y
	 6H/kohDh5TsuFMw5CCZYxa7H3VKnJcUIh1nWJtQvGoYg37Fni57O5wicMUU3Lg3N98
	 jc0M+UztWtx8QE/dFXnnL6mrn8/b9p3IDj+nDA4fHKRMAdRvf9yG9qxk7sRJLx0Q1b
	 j9KGgKJf1EtaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27753E3237E;
	Thu,  1 Feb 2024 21:02:36 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8hypJfgauRpzQ3-oHr9CybwWe406sxjKp8U=icU7=sJw@mail.gmail.com>
References: <CAKYAXd8hypJfgauRpzQ3-oHr9CybwWe406sxjKp8U=icU7=sJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8hypJfgauRpzQ3-oHr9CybwWe406sxjKp8U=icU7=sJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc3
X-PR-Tracked-Commit-Id: 0991abeddefa118479b0af32c28bcd662dec1561
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49a4be2c845e3a9efebb1e16a7ef379c1fd37664
Message-Id: <170682135615.25707.15728552368697631683.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 21:02:36 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 21:54:53 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49a4be2c845e3a9efebb1e16a7ef379c1fd37664

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

