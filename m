Return-Path: <linux-kernel+bounces-102427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25287B1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33833288847
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598E612FF;
	Wed, 13 Mar 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4DRmLFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414955C13;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358080; cv=none; b=HPne7tsOAGoOnHef1+C+BGfOBfNf6G9Y3w2/8I+CIXbo7YdykRtKI47sAkjzGKO7lESKL0oXeljVpGZp53uHNehlpf7DT5XsCn7GYgTPCcXL0lwqcAaltUFbdkxHR1XFdOwAdIcWr7xaGMULuJIjRnH+ZRSG75ggK/ykPSdHCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358080; c=relaxed/simple;
	bh=3ZnCo9XDA1av8wTmvj8BbWRWMQHYb/HH6Ow6nQm8DEI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UQ/Ki0+UTb3AWK3iMCAHrsGdvFNg43Wi4QFbOcDQVfsyO/YdG8XciRF48ZFoR/Bbe1IRRzWd/Rx92Y2Y6UWmIj58+FxVnAY81KZofAXMEDTsQFne5X/z2UfsJzzXkG2dTeCJytvHUVY5GxyR41/VAlYaivc7fGTq31xpw1HZKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4DRmLFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7590AC433F1;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358080;
	bh=3ZnCo9XDA1av8wTmvj8BbWRWMQHYb/HH6Ow6nQm8DEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S4DRmLFPF5TaNLoMTOlV0hSrzuKRqbbSAnW1mlbRz9vaneTjoUg0tdW4wf1+JsKwa
	 e5uJD3Fb0REjKfJzsl8CkfwmAhqV8hXhAobcOpLxUvN6zq6zdDBnqd4iGS6wYpU92P
	 zGRZHS0KurZ7lBKo437fGc9C56B9B3DTXJBn1CgBj+1IPWnB2z/j3iiMUxMgtq1JGs
	 xY4y7ZU32F+0SIw6N/rN6zgXmIz3pXxIt5o8CGE8CLkAmMuGmN8MYfAHTR012ekJnq
	 CMJpLY1HDJmHm29+98o4SQx7DHox+0cow9hzTGoL/9z5g+3psVaT0NNtOrW4vNF3Lb
	 f8JUwQIdXfvTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F9BFD9505F;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h_E0zBPFdv37HkG_zom3g=JWoT9YtjtSKO5Dquh4jb7g@mail.gmail.com>
References: <CAJZ5v0h_E0zBPFdv37HkG_zom3g=JWoT9YtjtSKO5Dquh4jb7g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h_E0zBPFdv37HkG_zom3g=JWoT9YtjtSKO5Dquh4jb7g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc1
X-PR-Tracked-Commit-Id: 866b554c2d3e067751cc2cbad9ed281db2d47143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07abb19a9b201c11e4367e8a428be7235b6dbd0d
Message-Id: <171035808038.9850.16273476874980278235.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:00 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:58:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07abb19a9b201c11e4367e8a428be7235b6dbd0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

