Return-Path: <linux-kernel+bounces-99368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A23878767
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1634B2246E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFE58106;
	Mon, 11 Mar 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS0UZJrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED75477C;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=Tq31RaNJrJYetllTlEuIjiRYCxAXmWXpduUEK3MRQNbXvdvp7Pbju3w11m0ceZuM0p3VvcGFSRqxRcnWkhCpl8oL1su9DS+OQiSdeuIYQfrZvajn7qpOqAiEaDu1HejWW6cwr0n/Nva/Z3YmLU2Gt71IjLO4+EDyj0fwtrwUN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=c67ypeq4cWbnpw8yAkIox/MUpWv53e1QmGYMtHVQ/+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qt+KboyEtuU3plfmOD5dBaNZ0PiG6sbhKXNY0lc7CZERNc3kpQlo4SffKzQobTBY6OywFAA6XtgPuop7VqIbxidOwtLxhWLyLsbSDgXJqWfXIRqjoxMKCHHgzUeRoVMO/LEb+KpfDkHPUlKXpsyA0IXG0qj76at/l27UQQ6pcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS0UZJrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BFCCC4166B;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=c67ypeq4cWbnpw8yAkIox/MUpWv53e1QmGYMtHVQ/+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WS0UZJrAGJ94pxG0JDgrrCjWlEIXnPSn/HVLGZjphjMtzoXsYszkA4lz2F2dxvoMz
	 3vBW/CFA8YVZ1NKXhKTnbS1VM1ttU/+x4pJMwzDi9ALUUse0Kp5tPthb+4U35J5K4/
	 S+Eu8ctlfbCM7qOLWppPFiWDn1vCW5faDiTuGc9MTv7VjpR/pHplv5AyHIP9RDXnwL
	 oq6b6yGcVed/+3mGcS6JLBwZekdk0U2H5FOIt6aT+Ewf87+SDgFk/zKL3r2TXs3mqz
	 klSSZCxkfs570+2he+YaDpvG9ARye/jHERfsQl/q2CyOVKc9sCRD8+de3BdQDiagt7
	 X+hw5KH0hmTHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69D6FD95058;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pidfd
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-pidfd-b106369f5406@brauner>
References: <20240308-vfs-pidfd-b106369f5406@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-pidfd-b106369f5406@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.pidfd
X-PR-Tracked-Commit-Id: e9c5263ce16d96311c118111ac779f004be8b473
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5683a37c881e2e08065f1670086e281430ee19f
Message-Id: <171018202842.4685.5235650932534959754.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:13:50 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.pidfd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5683a37c881e2e08065f1670086e281430ee19f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

