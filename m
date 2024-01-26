Return-Path: <linux-kernel+bounces-40841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CEB83E6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F6CB24D24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A963604D1;
	Fri, 26 Jan 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDapvv9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A4604B9;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311332; cv=none; b=UZPneBX/GXmgyitD0uqdJ8JRL/exU1MLkADJno416Y2v2hmyV33+fOPdJ1ASE2Pdb8mY7Y+IjQ65EMAg+pzPd5cuTeBQ/1F32KDBAUsk9reC6T53yTemD0kHp/K2rQhm0LrKSbX+tegESITx4wst+XISaOcOvB+vsHv5lTdXZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311332; c=relaxed/simple;
	bh=G5gRTlL3CwNuEX7plhd6p1NIMXajLBg3muloozKmK6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U+PXvW3I7w35fkeq+LnUrdoQO4B7lWgdgXS2iXZQMF5l82VUCE5GmpBhmOecD96RQTghKdvO++cCv/Zk2LLuTmmMvcBdQ9W4vosiUSs0qyfDMkXTnFh7HExOHkmnWBSxuwq2IhUyVGxgwj/GqdwvcJAKywQozbrPDP4vIuj+4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDapvv9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69397C433C7;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311332;
	bh=G5gRTlL3CwNuEX7plhd6p1NIMXajLBg3muloozKmK6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pDapvv9i+hY8S711Moql5mFDCOuZvWIo2wxEGEcOQKOnJ/OHsIHcye8MVAN8VLAWB
	 XLZKM7ktBoYDhrgI7T31uZQPF2IWU361d1L91DjNNXz55SrmGDkuYXEbvewSLovlSY
	 lL56o1OnPrZKBkBEZezJxt+33DAieArn6ghnbuYOKJtB/CX3IWRTGUbfbEYi4DZUTK
	 0l0zeNxaWJCn4JPlMmCnpPfUJCXLEpRi2XIRfYZJVHuHF6z2zV4AYgIRC9puyzjmhq
	 TIGNkXh4VMGygOQJZ6SKKpAY7nkeOXPKZ3tbVA+JwNcT1dE2wwARVMdaACp0Oe/RDL
	 SRoXLA4JKZGBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 518C4DFF765;
	Fri, 26 Jan 2024 23:22:12 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0icsP3F31gR2crrA4TrJRiYWFUJSdU36o7nnhpVSGzLRA@mail.gmail.com>
References: <CAJZ5v0icsP3F31gR2crrA4TrJRiYWFUJSdU36o7nnhpVSGzLRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0icsP3F31gR2crrA4TrJRiYWFUJSdU36o7nnhpVSGzLRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc2
X-PR-Tracked-Commit-Id: f3bdd82c5834219a5b272c2310c83aef68667486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c879d88138cab3477eb71dda962cb13b3dd8973
Message-Id: <170631133233.4030.8056337095444534901.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 23:22:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 19:29:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c879d88138cab3477eb71dda962cb13b3dd8973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

