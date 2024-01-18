Return-Path: <linux-kernel+bounces-29574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2712C831058
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F96B270A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303259461;
	Thu, 18 Jan 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTcAoJ1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D5259D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536310; cv=none; b=OQEvTO1MJZaPxTHuI/HVcyRs2WhIx3lxk+P1sNHwKAQaYXMApWGl98RjKp0GW42qVaDvf7c5S1rndOSihCYBVatStVW2PYZ5z9KSVhRpSJAUtdLbq8dmsuckkkeRgcPFkuuGLSwfIxSlpaY6yynXBH1TKp+uRvhmNQVV3F55ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536310; c=relaxed/simple;
	bh=6AkSuwkbZj+COwq5QVgcG7vZDrrHigBazCPay9GHETs=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=lXG6Iw6N2XCSfwjEDIddcE6AjZDWjs6S1ik0n0JbCodKzx7Qc4eQm/256UHiQbm0l4TrP5O4PVHr/vmbfWuuAxbdQD/Pmbp8PQH+8mb8Y+MQu35m6io1OkkegFNERbMJtkwOaOZTyxaXAMH8ZVgBWlGyhHKnKnc31YOEkAh1ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTcAoJ1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E6DC433C7;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536310;
	bh=6AkSuwkbZj+COwq5QVgcG7vZDrrHigBazCPay9GHETs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bTcAoJ1YHBrT9baRAXctoOYg8B0mMX28D7qTKpQDpXMKqHFql1XXxdjySfaZhBv9l
	 QzbBtiMk9cC2f/Saounyi0rLY3o701gO5Ly2AqXGnQ2fE+GzCxV8A5hAM8h5Rk63ZH
	 sexYvH376r+ozTrIl79vX0p4eR76Xs3efqTUVbb0QUSYofTv0/K96yK1iW6OuAIP0Q
	 kyzVCrFwKSQXYkNERV9+imB11GcvyDJj9khdpul4eyuBVRSAkiL128G0i8B5scGJ/Y
	 DYmosA5/hwajRUOJovd1Gb5MkcVNOf/jfkogr4GMDCM0thNKBPVp7g1ytorpvtemPq
	 Lt+K9Gjh3DYPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05CE8D8C978;
	Thu, 18 Jan 2024 00:05:10 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240116163709.GJ1920897@google.com>
References: <20240116163709.GJ1920897@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240116163709.GJ1920897@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.8
X-PR-Tracked-Commit-Id: 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2385018a4e5eb4f06cf110cca80d0a4ac8e27297
Message-Id: <170553631001.10877.9736570906070314278.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:10 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 16:37:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2385018a4e5eb4f06cf110cca80d0a4ac8e27297

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

