Return-Path: <linux-kernel+bounces-133403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF589A34B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E01F2377F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58717277A;
	Fri,  5 Apr 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Pxq75J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB98172766;
	Fri,  5 Apr 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336991; cv=none; b=UkaF3mG7qdkgmG3hMd3vzVR10+KEnVmRnRU0OnyIjQMV8XfmXfdkE3FEBDoy92EKokpMVYqdT3HGm1W4Jul5c7gG/IncczzAL0eAPh7yNdahzTqi/E82lCtlOZ+YR9Fd7Jhf0abcGBiXxmx+C07++DdioL6RXMUpcSL80juXDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336991; c=relaxed/simple;
	bh=bQahf2Q216hSsDm2fEe0IlXWcWjMX0bEyYarNGWgbE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mnzAubsMjiCYV5Je/cQwh685PneJcdQ4+6ASb+e2V3PGSu2JTq34RhoN8SQoH4WOcRaPTxvRRx9EP2qc9QgnU+EhJe/d9FsaAMn6b7JyPPIWF62xGyGsOA1Wv0C/I8cUFRZXd65T+TKQrSkk1zurnXbiUSpFvTu+/m/oA0lvEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/Pxq75J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB0B0C4166A;
	Fri,  5 Apr 2024 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336990;
	bh=bQahf2Q216hSsDm2fEe0IlXWcWjMX0bEyYarNGWgbE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t/Pxq75Jq8Jq99UfiUKq0+LF6n6tLemQ02CA7iDn8iXUk0kG4tqRrECoJ4HN+ZPHU
	 KJC7vPmlVSWl1x8uuSCDx1ni2x79Ics6bIroaqa87IT+cE09KCqRoGoU6k373403i5
	 1WnpKZq2V2Od6ZuEWiOTazikn6ytQXBsOcml7tSKMYPnrhNcAiI8HAJkq7r46cl1qk
	 +MsRxgV8GTxZMmBv/LxPpwUUjLT4T/gk8+B3doegO5pSOGQJb4RvJsrTM2wJzAkYFP
	 FzYHeLHY1KUNXli9no1IPr8W8GW/kOLV/4/FPMAXHQ8dTnxL39P4zvBtDmeSbcTN/5
	 akoLm7KGDV9GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C5C9C395F6;
	Fri,  5 Apr 2024 17:09:50 +0000 (UTC)
Subject: Re: [GIT PULL] fs/9p: cleanups for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zg_gyHsrkjDiz7lR@codewreck.org>
References: <Zg_gyHsrkjDiz7lR@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <Zg_gyHsrkjDiz7lR@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.9-rc3
X-PR-Tracked-Commit-Id: 2a0505cdd8c8b12670f4b5a6eb5c996c0861c2d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8b0ccb2a787fb43f8091a1eaef9c28a79b00002
Message-Id: <171233699063.9463.8312156596694177711.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 17:09:50 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: torvalds@linux-foundation.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 20:30:16 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8b0ccb2a787fb43f8091a1eaef9c28a79b00002

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

