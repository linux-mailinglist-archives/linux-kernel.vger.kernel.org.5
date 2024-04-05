Return-Path: <linux-kernel+bounces-133552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11089A578
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F044F1C21F48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312D174EFB;
	Fri,  5 Apr 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1lji9UY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434A5D905;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347817; cv=none; b=acp9QlUVWb3euKt2HJMqLa55TF2GNRO5aSgZ4hxK0N2K43BEFGdtLUzLLd0TnUBTXv9RPPQEq+x8VJ3dLDLH4BL6rKLXrqjjJHX4A/89j6S93+1CdeGnzWOC3B0GNqvqzFBeVzwx8sEoLqKPz584aEiERl8C2XM+QOSgZ1Oc72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347817; c=relaxed/simple;
	bh=EuHEvYiZcoT3T1cHekIm1w9orMMvBAHi7erEbh95mhQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lfo0WGYpWXnZjnx6DHgd5Qvpyaa/h2V/2xwEt4f3TMYLgeX5vsvp0Pui0uNsz/R1NBcuwkAFSBymfEhWb8SGvkUJPbPKfOOIFOn5x4FcQbbukmlC1TlQ09LrW1y/o9R+Agb6jQ0613PFTbehWfs0U0zGs9hhiDhiJXoJglpCBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1lji9UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B413C433C7;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347817;
	bh=EuHEvYiZcoT3T1cHekIm1w9orMMvBAHi7erEbh95mhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r1lji9UYxjK4mIWEbEZ1H5cXMfk93SrTpTvNQBZRbNeIy3HYjSGm2WtAghuG64lwG
	 Rroz3VjC/wSPS43JYrigazHih97XbHrChC8c17dFrLbquEjxO4LFriQhmcG7jU1s7N
	 G1F5mtnIdIcYk2roi0KcK2hje0m/0MO2N7S38PHYST8+ISvoQycFCItNk9r6otofHm
	 Fc/IbziDY64MVpA6fGW2uaH5D3yALlEdnIVvWSIzwoP4whsEi9mtvyAe83cAFm4Htb
	 uh0mP0xHpe9/wTVz1zGFMPRbgvL0QuDY5zuDKarP2vxoV5fi+d9VKiLnMiYAoUsfu0
	 tZy1pG+AT7LuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18463D8A101;
	Fri,  5 Apr 2024 20:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hHLvQWGDtwk=yXv_bJxZH2KTW2SWSUopdRDHHQp0sqow@mail.gmail.com>
References: <CAJZ5v0hHLvQWGDtwk=yXv_bJxZH2KTW2SWSUopdRDHHQp0sqow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hHLvQWGDtwk=yXv_bJxZH2KTW2SWSUopdRDHHQp0sqow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc3
X-PR-Tracked-Commit-Id: 6f824c9fccd494319988fa529601923edf5caacb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b21defcb52c67c5580ddba8b9823820bccccf97e
Message-Id: <171234781708.2800.9333198243685544220.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 20:41:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b21defcb52c67c5580ddba8b9823820bccccf97e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

