Return-Path: <linux-kernel+bounces-125329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B563E89242B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66541C21A38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC37137742;
	Fri, 29 Mar 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPqZyyU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970613791E;
	Fri, 29 Mar 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740441; cv=none; b=dqSFfzNpSsiboAd/r0OzdXaG7Z8YHqZLfWXJuzOTDoeByUFSs+qkZ2HwPuocOXlIWm7wQ0z61VzamDgXFFNFEHNLAHC/z8ocgQF9n0Fin1ieDT/TJwf13kibfZAcEeHafOfKffTIYCiM7FmbEoqnsj1oiXMtPfVKL2Tg5IYGnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740441; c=relaxed/simple;
	bh=F/BBmFgr3JwXdvTjBXhRZXraS2jhvnjRR5etiussJVI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jcu4XsMtOgH9nxeg+visy0Y6y+ry72oyuOXSUE6782YqfbVhVCVuFFSM6dIyjqnKyzHiINP77XEf8cDmyhyJZ1VFG+h9uYG8UBjYdKJm4YwZaFUVZ10e+TtQRPbOE+G2j7tMYh4QsboY4aCwbBT2tSHxQH9JMQqdq8tKtVAf5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPqZyyU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA787C433F1;
	Fri, 29 Mar 2024 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740440;
	bh=F/BBmFgr3JwXdvTjBXhRZXraS2jhvnjRR5etiussJVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UPqZyyU/flJgJwzJGHR6oH1XAJuRhrbVZhY3tcCZkrjT9XMYaCYlOiwDWTWaxQ+25
	 +4ff415v6FrnL0MR8DEUHKcwYrLApeZWJxr2sWDYipy69dFvMTqp4VhtxNJDJDE0WA
	 uJzqgTTkrCQmi9zZ6tj8WYGavIyOfOg2A3xcxbsaq6DhTRxKLJl9ZG3yMAIdwRjxqz
	 8Jk+wYruZL56mZriT9qQLlbktbxFV5yP4E/FJnmArdO2f8LVusAw7NHhjw9Ws61lqP
	 Gyc/pOc2odkhnuWShedHSyZpwzHN1doudqdMJilrwVylWh8VCumxaOOsUOL4SwGasL
	 sdT4edJbSw0nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBD62D2D0EE;
	Fri, 29 Mar 2024 19:27:20 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jO6Op9u9x0j0XVfaSN-5OguoubAwxTbSacJ_QLX5wCDA@mail.gmail.com>
References: <CAJZ5v0jO6Op9u9x0j0XVfaSN-5OguoubAwxTbSacJ_QLX5wCDA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jO6Op9u9x0j0XVfaSN-5OguoubAwxTbSacJ_QLX5wCDA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc2
X-PR-Tracked-Commit-Id: 6af71633b04036a12d165d03ce6f21145ec5a555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab317b32cf5b68b1d49110ebef838d112370e55f
Message-Id: <171174044082.16736.17088023562591375262.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 19:31:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab317b32cf5b68b1d49110ebef838d112370e55f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

