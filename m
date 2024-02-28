Return-Path: <linux-kernel+bounces-85674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A944086B908
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32107B24224
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041815DBC5;
	Wed, 28 Feb 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOoZ0TZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FE15B10D;
	Wed, 28 Feb 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151757; cv=none; b=nbAULJWx18x5ST5TpKtC4Mssnu0vsTm2x98UmfmfIj5QCWUHjPWprAhp8cIIm4lmFYcOrv7y3pOfSv3Spr/bOz5Gmqt3jQn+IiycyRB4Eo9UQvmPz2NQMvOvjxH/QyVlQRfIJIBl0CL3RUx6cDuAq9VJpAhCOXRspx09uJ//L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151757; c=relaxed/simple;
	bh=p1Jm3Uf3zUKPsQBO/xGU8byAjQkMSqdVbYGaqKjEVoI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BoBqRwJMCAWCtyxHSQ884zEcQTaHVKMWtwcB4PJ2ELCQu8sOiauO6qmvV2RZ2UPHDfjLlCBhrEB8t9GcLH30d7QjFG8tDjrt7tsuaPUi+XupLsx0tIJSbF8X+hHLKPNdSfca3d6YgFzp5sNFTV9aBbgOiR+N5+mKc5U3OWCfYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOoZ0TZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5888C43399;
	Wed, 28 Feb 2024 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709151756;
	bh=p1Jm3Uf3zUKPsQBO/xGU8byAjQkMSqdVbYGaqKjEVoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XOoZ0TZUVSnMsTimsz3IgERfMn+UaIE7xwOI1WYIvDnN9/CbnbuPi53zD8TQOlRPT
	 BGk4hkCmgHRd54JgzzrBy08jDw8vt2RVr5B4X32giniEJmB6IX+Ia27JcjPCJYtGPl
	 ewVPpxRTXCiUdn6HYu+fsazkT35sIWzGLi/JJTSl92SIhedEuh9sd9RHs14sVuL3m3
	 KYM3U1Bkol+yQ2tROaWfWJ1Vup9HUtYZ9HMdWlWrwvQMejzDxI7ES+IpF4DY4S2v5T
	 bwSzLHFi02qGKTkDT5hGZopRph46bzn3CtBlWS7oH+MJq0FGNeZxO5R7vADjNRnRHs
	 OKxh6mYcWm8Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF276D88FAF;
	Wed, 28 Feb 2024 20:22:36 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jnP3cJ=tVobm310iLQR0A7n+_wtp9vAefGC_NJ0G2aGQ@mail.gmail.com>
References: <CAJZ5v0jnP3cJ=tVobm310iLQR0A7n+_wtp9vAefGC_NJ0G2aGQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jnP3cJ=tVobm310iLQR0A7n+_wtp9vAefGC_NJ0G2aGQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc7
X-PR-Tracked-Commit-Id: e0359f1551b8d4a8d00704699c07fabb11a07cf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
Message-Id: <170915175684.10893.7032623085625306754.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 20:22:36 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Feb 2024 20:35:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/805d849d7c3cc1f38efefd48b2480d62b7b5dcb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

