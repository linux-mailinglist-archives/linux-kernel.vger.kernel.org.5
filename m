Return-Path: <linux-kernel+bounces-133404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEBC89A34D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9637D2842F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A03172772;
	Fri,  5 Apr 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/UKDd3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1717278F;
	Fri,  5 Apr 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336998; cv=none; b=Ya5dy2a4LtFfXNG1IYhyzJL+674VZ4hDa/+7pFgouwMxytHPKHM4r8I8Isokbuu54QuSa3axTi7R25FMDkqTStqKTk/OAnaT6/gp5ykjbaosR1OpTP/Qvgtm7vM/oysF8mpchd69KuBj3QLgiiAdOIWJ7FqUyGSimpj/CFcEvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336998; c=relaxed/simple;
	bh=Z2hc+ZYkjgBazXDC1sPFI/6dpyCQHn6NZVkCaZMn36I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XNjx6HvXwkfwrtexJagwQKTxu1LWTccVQz4t4m28pyZoWUJw/8MprC7KrINJGRZw+wlZIMaiIcoocjIYQYEb5TQFmSJ1EE6sMRVQB5yo5ptpHXFnW3qIdS4D4lKrGIXMOHtvrTr+LZCH/fNcz6HZ92kq4Ze0t5Hykj/ztFzaRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/UKDd3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E71DC43390;
	Fri,  5 Apr 2024 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336998;
	bh=Z2hc+ZYkjgBazXDC1sPFI/6dpyCQHn6NZVkCaZMn36I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y/UKDd3Mom31/r6OsMHT1EOWO7iA2BD72pwW8/KSxn/RsaaAwVkYh2cJIopgDbV7O
	 3B5QRJvfBQhhcy3tgxbu7RI4/SFXPYyhnTOtqrHQSPYvKiIwGrOb2wApJc2ZiQzrj4
	 iJXsDeqcWBRKg8lMl3k13ENxMaxFCrxpLft8cfzz6RVaAC1BlbLiQcmpxWOZCiUWT2
	 U+HTYLgmmEjTSwCy/4YSPt0DIsLYwHQMRZ2TMnH5Ptrs9JDNue6h6JCYOfw4E9/JXE
	 +xUdTtmCyvnl9OnkMgC9qkZeADSYSUVp03gbvthKqTvJ4EaP4gb84L+bWM/IhF8LDC
	 7QAZWC9qld2Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9462AC395F6;
	Fri,  5 Apr 2024 17:09:58 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtksWKZNn7WmHGT4t9fi6duL_nuTgdMwrx9c2gqw899YQ@mail.gmail.com>
References: <CAH2r5mtksWKZNn7WmHGT4t9fi6duL_nuTgdMwrx9c2gqw899YQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtksWKZNn7WmHGT4t9fi6duL_nuTgdMwrx9c2gqw899YQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.9-rc2-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 5ed11af19e56f0434ce0959376d136005745a936
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 405ac6a57277f09a49635714b07a34cc584d9cc4
Message-Id: <171233699860.9463.12873185541943534308.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 17:09:58 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Apr 2024 22:15:16 -0500:

> git://git.samba.org/ksmbd.git tags/6.9-rc2-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/405ac6a57277f09a49635714b07a34cc584d9cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

