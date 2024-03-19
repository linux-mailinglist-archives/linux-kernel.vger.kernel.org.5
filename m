Return-Path: <linux-kernel+bounces-108062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C739880570
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CED31F23671
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3D55E40;
	Tue, 19 Mar 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUl22+Ly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B53B2BD;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876584; cv=none; b=PsvA0H38z/oohnAMnpZtGyQM+a8ivVdyw/D8I6AZt+3gUZKXarWsizwot3J4v2sOOrG/F5viumGbPzxyST0eQnOsRWTzChFKh7wj6kZsy7Ig2RAOOPPA838XlMznVbbbUYDb78dY3OYEys0TzQZdy8CpBgPhUSB881dukW8qcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876584; c=relaxed/simple;
	bh=9SQmJU74OhhFkgIfqWX7WJDys09b7gaWdEJeUfI8ZjQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=neu36+wNNlte3nHoFnnhi367e2y5YlK5bP36Lis5EqZ9iE3rG6xQMmun+iMEMGXzEd94HUVTmDk7MTvsEyJhJaTZS5cUIRiGFsyL80PsZhSgF4PDp5L5cq6fqECzLwYBw8l/o+k85TYwq8bopM4n+sAKdfr5ag0fwZXtRgyojBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUl22+Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45AA0C43399;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876584;
	bh=9SQmJU74OhhFkgIfqWX7WJDys09b7gaWdEJeUfI8ZjQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sUl22+LyvZUjJutkOMRW9IzD0wZR6j12s75IX5PcIHQjIZGLXOTR8lP4LWrxhwfAz
	 zwyTNBOzHz5f5AMu0PH8GKAoK+fO7Qo9fmb9rJ+u6iE7rnkyfps5FSP2JeET/pbOT8
	 4S7OvCc5lYkcZkogiXRx9eQ0IWGDz3D4kM31IO4ct5EaMgaAUbCGxPyrLdir7Q0gLK
	 uIkmCvcHSYYP2zhcXmI4s/xPSBqEZ7yXiMwO6hzWi+M1zVYyVX7Y9i7lu3bncd8B+D
	 Wt1TEtpVCww5pBcQBjbd7I6eaNdVAK2NDSktPM8pjH+8R19Q7t58xFfafaRx+RrhVf
	 OSI00ZEAFSGyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CE5FD84BA6;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jjQ90P=+oQKdA2VY-8r0QAXjXfq50UMRDs6=XbcJ7R_A@mail.gmail.com>
References: <CAJZ5v0jjQ90P=+oQKdA2VY-8r0QAXjXfq50UMRDs6=XbcJ7R_A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jjQ90P=+oQKdA2VY-8r0QAXjXfq50UMRDs6=XbcJ7R_A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc1-2
X-PR-Tracked-Commit-Id: a6d6590917ec352270bd3e3c040240aab31f2e90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbd88dd05780ef9b0026b09edcbc57a77742cfd6
Message-Id: <171087658424.21820.4134470598308063543.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 13:58:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbd88dd05780ef9b0026b09edcbc57a77742cfd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

