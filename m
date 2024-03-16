Return-Path: <linux-kernel+bounces-105308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2A87DC03
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5451C20A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AF4594C;
	Sat, 16 Mar 2024 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM83R99S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D51879;
	Sat, 16 Mar 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710632710; cv=none; b=ItC9jajY3fR+PgmHMYTmwDiv3RcV3B223mrg+CL8OU9VbQrvVDcbyq2Jtz/7rVa0j23ClPmFfAHX6osF4Gt3BbA7U4BrrXyxJA082p7wYWQF35ibJ4dASKxFS4h4n19tSij8FcnLhcym7hdJSL9Ug5HgcDoFCpicmhrfqc3L8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710632710; c=relaxed/simple;
	bh=etMX4k+w33ab44W8JLxEvRYm4JGrDNi/rb23PaPSuGM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OaLvzCZWV8q8kehc+bIpwXu5vePzUJamfJbRzEZ8y1nLoIHi3i3dD/ofYSIsSUtDTKYlzgB6VYAzIJ8gnhl3PHpPB/EljXy+vKzWGVGZ40Ao1hKCvl1bZz7hpVX7zWBs0JAHkX61lcfDLEWUz4dnBEDvrbN244vPimQcSNo5Yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM83R99S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FF9CC433F1;
	Sat, 16 Mar 2024 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710632710;
	bh=etMX4k+w33ab44W8JLxEvRYm4JGrDNi/rb23PaPSuGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QM83R99SLI2fU4fVGnq4Zu39V6085aMaPd/t2SP9gfvkVle67gZfSWpI2LRdg6djn
	 /PvhU+jcrvfyzU482+jCwBsJlUIlqt6qmxOsXtQC7FynLRN1+mIt6iXKUgE/TTGzUM
	 RddJmOXiPMJUFQ/ljAw4kvpvzfnTZmYwtwVOM5KIzePdQBdXtwVT9mXLUv6pcdF5g7
	 r1qVkOFDD+OEGs78jZ8H6+pepZ4/WuXfzSOp1abz6OO3OeTCDcNtP2FW32v2uK7hIq
	 Ob7QQ4Rjha3FWAZkuqAZsdxJy6AuyOcjLUFsQqBK5e6JleTrSx/oainxznzah1RiEw
	 47+EXbOOqc1JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7820AD95055;
	Sat, 16 Mar 2024 23:45:10 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI updates for the 6.8+ merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <623833d89c32803eb47f763dc89decb85f53395e.camel@HansenPartnership.com>
References: <623833d89c32803eb47f763dc89decb85f53395e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <623833d89c32803eb47f763dc89decb85f53395e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 517bcc2b4db435f230fe864f3db0a0f21d2f6951
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 741e9d668aa50c91e4f681511ce0e408d55dd7ce
Message-Id: <171063271048.4585.655431329208527185.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 23:45:10 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 17:58:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/741e9d668aa50c91e4f681511ce0e408d55dd7ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

