Return-Path: <linux-kernel+bounces-103659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B8187C284
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F40285700
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F47640B;
	Thu, 14 Mar 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1GBwhbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC17762C6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440435; cv=none; b=hT7hxI1IyBOGF8VVkBYe/Oi030o2lBR/Rt1zgRL8qpvxy8ZV+wJKxKeq4iwRkPavR8ZOI/C2IPNzY7KiPLnERZUY0vLp9+iDgnzjH06EiMkKDbKkaw8c0E0PZXyynZMTy4fVNnau41/cJU9sw35epB2UKkpO68FbRg2mJ5YeEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440435; c=relaxed/simple;
	bh=dqhReMsykTy6T/+DFhSz5WAkTSazJl/KIJfgAg/8olk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sWbvQS97tuRWDLWqpjDM1aqT/GGdKXAWJ4wfzTTdmFzb9ghhIsPPrulJwjvjGIwEciId9AmFK3fT0SngF7/LQ1Py9g9EV5yvL1m0FXISyiE5QCB76qcQXViFwscf6KVyqven5kswyCPFasPjaxROkjd2GHBTwKuYsi3c3I2O7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1GBwhbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41E70C43399;
	Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440435;
	bh=dqhReMsykTy6T/+DFhSz5WAkTSazJl/KIJfgAg/8olk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U1GBwhbpKx4M6F4+cZ5fK37VnfegFYoGKgm1R5LFZWvSjDh1VqIgbQn33hEntOsY6
	 EN8BzyMdCEsPdGs4d7i46okxhdO2mp9Mcm4lS3r18ZMj3y1J9xe92s87fJ7flaGThx
	 JVCI8R/clh+QLELr8/YpWQJmHIuh7jn/YqSFy8Mr2YY7tcHnLPLq4jDTl8QyrM5PWT
	 q+lFe5X4yrkdNLSPuBGd7SpUbACxLJZbrm5IcFF+w/bkKbx3lciEvoLuvw01APkQHJ
	 C33IX/TTLAj8woIdQme1kKflNLpvy0eArers9zK6ESJIvIJXhVqSWzQcFCVmWhj9fW
	 DOAttPIO2Ra+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38F9DD84BAA;
	Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314144523.GQ1522089@google.com>
References: <20240314144523.GQ1522089@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314144523.GQ1522089@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.9
X-PR-Tracked-Commit-Id: 45066c4bbe8ca25f9f282245b84568116c783f1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5c31bcf604db54470868f3118a60dc4a9ba8813
Message-Id: <171044043522.24196.5541887241843255785.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:35 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 14:45:23 +0000:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5c31bcf604db54470868f3118a60dc4a9ba8813

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

