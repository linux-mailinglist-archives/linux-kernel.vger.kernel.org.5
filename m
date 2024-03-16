Return-Path: <linux-kernel+bounces-105275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3387DB44
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E2A282C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9211C68A;
	Sat, 16 Mar 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoYQuyFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048D1C684
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615070; cv=none; b=dey1YEBW6b163kxpeu4qJR0sLSQPwbej9aylfc2UBz/ZWBR3IBcDvUnISMde2z+qzQaA6vdIBKBQvTjK9ZT+9ji5sDEg9fvaihxh3WkzCfwJZsK21eqg5B8gx+0vf4ZiXln7MrHelMi5sIudrpMDO0XzLnufcjXUHUZnPULGFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615070; c=relaxed/simple;
	bh=v+DF0GhCYikvVe0E8I4YpE3f52qizMkbEmDz5kWZTgc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S6Lb0DXmEjQ/KHGyQ2cgy7QrQ3kV4m5QGNHp5twMuZHu/uP2LDMH+XR1TnX46DIBtwJQbAxDu+hHAh1qS33MzQ/vBt+sFrwMq5TFpmOka9uTU6aIzY225wOwkHuCbHuWw+b2bqrv3ZvH6kkgmOZ6ehOWpfLSIBVzuoDDtAuUNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoYQuyFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8454BC433C7;
	Sat, 16 Mar 2024 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710615070;
	bh=v+DF0GhCYikvVe0E8I4YpE3f52qizMkbEmDz5kWZTgc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DoYQuyFomNUVIK/JZvJREm5AGo1sybs6egPirCwTSEcFuwIpLH1phdald4vOpG46c
	 XIXAHyxF0XTNGm9ju0tK9AvdNpANWvO11dZZuP8hb5xlkdPc87ZnVlbieZO8wdIGdQ
	 tF5/W5awWRkHG1ASyQXVZfNXB5vwlm+MGnxiSgP4jbMF2UZaeYC/qmcuh10uZFAHnj
	 1D6qJMzr+aNF9Gj7bHwcPlw+CPkoKlZdY9wuVwDNZSkjwKRS78ZKBtWBPgJbBG6t8d
	 mVDB7gqMNuZr7q3qOO0bMjqOBTj5T1DbvcqCvp2RIHo/RXXnh8URYuamaJKSmTNp7q
	 nso1FQtA3rFWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72C05D95055;
	Sat, 16 Mar 2024 18:51:10 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfQrAdJodRKKXeBj@matsya>
References: <ZfQrAdJodRKKXeBj@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfQrAdJodRKKXeBj@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next
X-PR-Tracked-Commit-Id: 00ca8a15dafa990d391abc37f2b8256ddf909b35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a498f294c2766f05ba72dbc0ecafb2af521a4c
Message-Id: <171061507046.24411.17718654050929914250.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 18:51:10 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 16:33:29 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a498f294c2766f05ba72dbc0ecafb2af521a4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

