Return-Path: <linux-kernel+bounces-51496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9508848BE7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A941F22784
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCABA2D;
	Sun,  4 Feb 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA5MmX2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE07C8DE;
	Sun,  4 Feb 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032680; cv=none; b=K8QGQ4g0eu+B7lfQgJY2JDxPdD4aQnrCKFPoNyU0iP2m//TFz79EWqzFDi9TvRosOxxxcmry+wUf9miDgpMKtAKFixOxVErywOzrK5RzPhmngufmPG/58EtjbQbLR1e8BQLGBd4+MmvgpYxqhIV+1GjGXqffdctuuYE9ZIFEhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032680; c=relaxed/simple;
	bh=sILQ9VZBDR1OqWqF9UygYcGdPPc6HN8uAqrWCZcddog=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=arNrHEvF9wrvsj4COEHQdMnxA0a0PqqknMYQcowoHIQn+W4zDSYLFmlWAAxIBVhcWKy1DJyBv9D95nkxTFrw+eS5e9HgphLDJfrohrDTNpJdtQCZANgeSDZykp1WkQn3MjqpMz/QSOUOLLCkHq44j832GbcyLqxhQ5jIHKIdUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA5MmX2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3161C43390;
	Sun,  4 Feb 2024 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707032679;
	bh=sILQ9VZBDR1OqWqF9UygYcGdPPc6HN8uAqrWCZcddog=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dA5MmX2WsIi005mMyU1COXVA4LCKmQvVVsRCdivQxkigs+0irFUIhDoGNdb97bW7A
	 X2H0H5KUCQ70G8AB7kk5wisw/Q77RrPHFzAdKLOGGKq1+opOW6fjwskiqcNZHiQyOH
	 DmPOFnNauCqsW9RaNGVX4G/Qo2hh2tpp+eoM9MsbRE6ef1YEpmPICgFtAEkGTK1GH9
	 cKU6iHqzeAvD6OcHMnthw2R5eQz4YWabCOdCgQP+CYA0Ltg4mC1Tc+DaewZizCqfST
	 0EXh8UPIvHPovTUCueV4YmasORsqLYmsJgIykq9SuSj7EcfEG2ulMyv53qWlJMjAW4
	 C1smMRgUXpYOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADEE4C0C40E;
	Sun,  4 Feb 2024 07:44:39 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvqa_RSjwQ1oqXt0a51KVu46Bov6_X-x6FUH4s8H1wVRA@mail.gmail.com>
References: <CAH2r5mvqa_RSjwQ1oqXt0a51KVu46Bov6_X-x6FUH4s8H1wVRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvqa_RSjwQ1oqXt0a51KVu46Bov6_X-x6FUH4s8H1wVRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc3-smb-client-fixes
X-PR-Tracked-Commit-Id: 11d4d1dba3315f73d2d1d386f5bf4811a8241d45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e28c7a23bac7452935d1768fbfedad113586f9b
Message-Id: <170703267970.4518.7127461965102732836.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:44:39 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 14:47:21 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc3-smb-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e28c7a23bac7452935d1768fbfedad113586f9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

