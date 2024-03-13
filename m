Return-Path: <linux-kernel+bounces-102432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A287B1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F75028C80B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11B5E3A5;
	Wed, 13 Mar 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeYukPKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D45E088;
	Wed, 13 Mar 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358095; cv=none; b=aORD6cmeWnIuERkBL1zub09Hjo1arAh2oGvkuB7+QddEjZNQ/H/Xy4t+3aZoO3ZUyjaM/i6A6NMrN3yNmbNdqzT+5DR1O+ANCR7Fueoom29jkAiffA6jl9wYzaJih8TGRtRxR+4mIjFAWQdwCTuT1AtG6ZUwZ6yUIHe3XiykRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358095; c=relaxed/simple;
	bh=ihtaLkhmNaVJnaWYn0hgDfF/u8EHUhpmfotySFdTckw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WXIrSfMqYAkovILjT0PPWE28LZ/Bij9MKXnyBAFZoqMLh1H61Kx7/Z+HQcEC5XSnbHkcVymo37e0VkQ2ae6c3Urw/rt9cvGfaxu5RdN70TpSn6D8ZoRWPDl8EHltWRcbFZkuYHqOmlnRifRyxaKrj4URebMmQQdngcnv4TCMwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeYukPKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D703FC433C7;
	Wed, 13 Mar 2024 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358094;
	bh=ihtaLkhmNaVJnaWYn0hgDfF/u8EHUhpmfotySFdTckw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BeYukPKXHRSj2fe3Ri0s9pT03vV216FX9hkbldfBGExyfGPVFA8swtMappjP9jocX
	 +sS/V/dBeaDo02x8SseCdSYW3haH3g+kk2Uk2bg46STxeOfNd9GEPPh9OgeB0zgmhb
	 AmRVXX5aNIPkvnpp1fPv7ASqLS14ETF0P+FuJI8umvhkmNlcp2GHhiFjGgh7UC5ob4
	 s118++UAIjWJh21ofi0AffS5FSrhlt1Il3x3GkUUJ+oHCBa2rVFvyA+FRXZUv4JR9W
	 662zhuMsjC/g2OOrpcMsN5V0mkJlNoqqwVuBz9kriLAxw7VSXGlxu2NWEqpn6PKf0q
	 jmOr82RP2saLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C30D1D95054;
	Wed, 13 Mar 2024 19:28:14 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311125807.1143937-1-ulf.hansson@linaro.org>
References: <20240311125807.1143937-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311125807.1143937-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9
X-PR-Tracked-Commit-Id: faf3b8014c357d71c7a9414302e217a1dd1679af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 245b6f3239d9a4fe72f6fc78fc9a005fff2726c5
Message-Id: <171035809479.9850.15382472080130248602.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:14 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:58:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/245b6f3239d9a4fe72f6fc78fc9a005fff2726c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

