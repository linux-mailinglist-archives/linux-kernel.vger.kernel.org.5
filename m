Return-Path: <linux-kernel+bounces-30545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCA832017
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046D3B263A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467862E654;
	Thu, 18 Jan 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZycE/DC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D482E632;
	Thu, 18 Jan 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608017; cv=none; b=tbaC3I7435G/hAak40Ez5BBQyUvIHX3AXKOcb07e+ovn0VD0Gf2lhNUxgItlLhlPSskRJ9xrqWkxs71wFjQFbEsCkp9IcHjN8QylYqP8GLtbzb6AgAKGTf+XILqQHDdNkvv1fZd3FCV041qDSHtgZfpPGOIs9ewnakyzZuUlUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608017; c=relaxed/simple;
	bh=3NKKTMLG0rIZlLec5RlAWjDtn0MJIua/4sPIymeWIO8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=itj3P1t7ZfIJGocKkEc9Bs3vlz+MTGQbDe7wpjzJk8wDeNXcs0f/oL/Z0/4WIJ+I358p0A4/yfxVv0afWyzL/NFqfse74P10l0BO4HLR8EZpkAvpOVJzPiaLN4e4g1AcqWjOY3O73ElwGrUluX5utnym3Ao2nsfS/fh16lOPMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZycE/DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D25CC43390;
	Thu, 18 Jan 2024 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705608017;
	bh=3NKKTMLG0rIZlLec5RlAWjDtn0MJIua/4sPIymeWIO8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mZycE/DCqZ++mgOUeiKVGdt2K07Wpj2UHdEXp4SQ50Cr+OexorsQBlel2rg/mQ9Zq
	 rcZv85Xw67B8b4LRqhnBR5hAAOqqHbGqzkSOnIlSBTuW0Bq2PobLeYnCzIoyc1+2d4
	 36hIaQTGKuWc+yjavK8L+rLQ8I2hekFnHYVPVqxhUx4677MYBga9F/dpDk606vzwqe
	 E6F6u2dvJy+kkHpYCRofNOXW9zRAdLMvL/BoyJJdKDEfSIw8jq+LYkXoZFWssyxccD
	 4ypQUQyy6XoB5USptEn85FQwQbL38McsdN+3lMc/qikQ8FFlbLXQ86rHRw1sczxIAG
	 +Ihw2QGrjjqbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F035FDFC697;
	Thu, 18 Jan 2024 20:00:16 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zae2swRz7N7Em5-v@kroah.com>
References: <Zae2swRz7N7Em5-v@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zae2swRz7N7Em5-v@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc1
X-PR-Tracked-Commit-Id: 933bb7b878ddd0f8c094db45551a7daddf806e00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c94ccc7cd691472461448f98e2372c75849406c
Message-Id: <170560801697.7899.5710539703626804176.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 20:00:16 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 12:14:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c94ccc7cd691472461448f98e2372c75849406c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

