Return-Path: <linux-kernel+bounces-102428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9BF87B1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86691C273B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C56166B;
	Wed, 13 Mar 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki2bJA8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19660EF5;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358080; cv=none; b=MTQOWnTlkmCWmWRwUICrDZIeomYP1cx+RagS0IQ/J/7MlebB8xcjMqLy2g3Ypcp7FWyW2ZiIKrWOivSTLut907ddEjTPK0A3R2Fyz6ywJ3vIHMS5AoVpJJbYvwZn1bkNPnJ08jdlGuwxRiz1eZM1LljarzWxCnDahdbGhAk5yCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358080; c=relaxed/simple;
	bh=n3Cs5QQvddi7+BefqHuuGnzJS/Fu0ThoVCI6b3nHwr0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SweG4rUByrdNe+I2TLuDkX70utX5qMUs1VmwbivgEURKjWVhB/IhgIsKcV2iuOJ/zsmNhl8ick/dPjqt2pcqzip8jfYe6HTkX/FvPszHzqyxnkw0SxG1dW3Wi15Fy2Ivrt+ymvD3JF/UuvH4KJhaWVCXp7XY+VrK+D8w695Cu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki2bJA8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3891C43390;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358080;
	bh=n3Cs5QQvddi7+BefqHuuGnzJS/Fu0ThoVCI6b3nHwr0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ki2bJA8Bj5gkMU9h/G7JJxHub5l+v6IIyRx3YqVbmmJ5YqY6cW9ObzjHJa5m1uSiH
	 pUUchcAz4C+3eq20GyUjwXfAQssNxTm9afY9jzKnXoi8eJiNPG2j9StPmbzd3io874
	 trjimNGXZ845kCO3aaYJrLm+bOgOY6jEm/3AbEYd4hMaK0KYzRejHnh8N20sZhDB1g
	 rCznJtalZKlZwKuHtVHcz5+bHtXDsdDjz6nyC2Q7Pacp05UNl+fVf4bszW/cGo3yvW
	 nhfGp+S/3YgKa7zB3qCdaEqBRKk08GFPIgGMWat6+B7B+ezl1RIauuTmQhQVUghKvd
	 cOXEEY8xs/3DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 912E7D95054;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gvbDaDihXq5WTocekjDgL34v4L9ZWVMpnFkkCC0p4Ntg@mail.gmail.com>
References: <CAJZ5v0gvbDaDihXq5WTocekjDgL34v4L9ZWVMpnFkkCC0p4Ntg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gvbDaDihXq5WTocekjDgL34v4L9ZWVMpnFkkCC0p4Ntg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc1
X-PR-Tracked-Commit-Id: 817d2371e4d53be202bb6d7df9a9b9c0c342ab21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 943446795909929f261565cebafb3b56d66cc513
Message-Id: <171035808059.9850.7264767971340511676.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:00 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 16:59:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/943446795909929f261565cebafb3b56d66cc513

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

