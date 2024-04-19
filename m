Return-Path: <linux-kernel+bounces-151778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52E8AB3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C008286B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4E13B587;
	Fri, 19 Apr 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggIU3FV/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0813A877;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545384; cv=none; b=L9R1BHZzqyf46IavdYsDkBuqFzu6FFgKqKPgPI5lv7t1O/P7ejb8xllzzZbdy6Oy6VgAtOktjnohfiX0etW61FcWcJ9Nt/MTpvlu9CVKhU4WwWSJszSbzY5otuyHb6MIWstLwCzaqAaDedlp7p4FqBtOR80t2pWV7ecWZA/Md/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545384; c=relaxed/simple;
	bh=3Lc9XnMx3FYZ2rQc25rU+CkvZ1/GexScTGTaIvSGuqM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TqODlSpwpEuPYJ/iJFvNJaFafDxP6AlO1ePK0aT5o1ILkDf1Zf/tLfWt+ogeXj+FABPmmVySwNTPbJZdFPi6NM/o30zNF0REWfgraEgK6RAROsTKmobA1XpltCM0cNL7uMAalxe4tzjqmN5C7rscxHDlxTfceZxVfnaENlHnY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggIU3FV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADC8C4AF10;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545384;
	bh=3Lc9XnMx3FYZ2rQc25rU+CkvZ1/GexScTGTaIvSGuqM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ggIU3FV/XOPaH+wRgqVziBCm1ayf1XL43KOvk3+YD5rCXxejbG9YRzVCcX93aI5dB
	 tmJ0X7/GU7vtytNDbVanMekfN30wEic+vliV466rKodZ0tZKp1U4nPvHCM+iwJIW1G
	 EHkxqKM18APydd4F80AWwFMkLmoacRVs9Ii0Bz2kHoHwszMG0R3O6RsUrrrjfSkXBJ
	 ThzLgnyYLHU56ZvMS6mhrQ55AaerBBTB0wV3J6r/2X6iThq4kM1SJ8XHifQ7HSDejp
	 UpQ8fdrO9SaXsOS+e8+JwzOC/p8VgvbqYf5zI4Cd1Np4gqK3xgWSEaP9AhLJXdwVEM
	 j06fx2Hxy41PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 623C2C433E9;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ttjxsbiy.wl-tiwai@suse.de>
References: <87ttjxsbiy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttjxsbiy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc5
X-PR-Tracked-Commit-Id: f25f17dc5c6a5e3f2014d44635f0c0db45224efe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c08ab6dad97da8e2acffb64e0a93a0e52c56a37
Message-Id: <171354538439.26173.6805721457665328459.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 16:49:44 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 15:54:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c08ab6dad97da8e2acffb64e0a93a0e52c56a37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

