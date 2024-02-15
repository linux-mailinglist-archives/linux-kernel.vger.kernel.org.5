Return-Path: <linux-kernel+bounces-67610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08256856E08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DD1C241DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCC13AA41;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL+5Nqtg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3613A892;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=dAJHYH+MQ+7XWHwPCZHsZJTMzyaYPez3blk+IrBXMZvh+fKMX4LNE8mP7sZzkOMe3jNbm513s7GeDGSCFZBNwcqPpLryH1KmL+IrQPCCIdMax0EnhwvJJJfPXlixmvD1VFECl6hA5Zu789CrV9tYXMf/5tkOsii+o3JhKypYxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=vM9Yjz8P9PsfT49l0YgPkh1MPfH5J9+hMQAKATgMV/A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rM5NQ31QGZ9TFeD105nQHSRUG7YApM/16uR5P9tiifFYjQ7TRmPHsIJFLhtDOUP8KK/y+PCSj+OnH8oP/0G8qfTMOdq+V+FL24sRyWpt8O+4OWMpJo3ONgObiyJJ8hrtjELdQDcpgyaFlmtE1LmukABd9Cd0T1hVsudIT7T6yJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL+5Nqtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09662C43399;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026607;
	bh=vM9Yjz8P9PsfT49l0YgPkh1MPfH5J9+hMQAKATgMV/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uL+5NqtgoTxqwHst4dylsj74ebfqmK9UE3KPkD0XK52BWSthfSsjbACpMGSupV1fW
	 JqZ2fPX1pbTtL9FgyeddeKoVYFBAXVd1g2sICTFDpKyZyi9Tqpr937nLwMSFfgESG8
	 OwgadTLrH6kfGUTqRAR3BfZqj29MGUq8wUhmQtcof3MPHWEXeW3on6UCwgu17EHMyp
	 WM83zIKxN85OLmEGPxkg9A08NSc52/WKiwJZ1zIky133r4GsDEetwWYzcRosdgm3Dt
	 Vcc6JLqJGltiMP6i3sWOCpwf8ItNcjij9J2Bo+XfcZ+1PE434mywj9hhpjoMMceG7j
	 L0j2WT5Axhj7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4A45DCB6F9;
	Thu, 15 Feb 2024 19:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240215133916.F0534C433C7@smtp.kernel.org>
References: <20240215133916.F0534C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240215133916.F0534C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc4
X-PR-Tracked-Commit-Id: 269e31aecdd0b70f53a05def79480f15cbcc0fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a00cf1988a1359452cb4fe64d75e7a1da12dba4a
Message-Id: <170802660693.17476.11267718874913072443.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:06 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 13:39:06 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a00cf1988a1359452cb4fe64d75e7a1da12dba4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

