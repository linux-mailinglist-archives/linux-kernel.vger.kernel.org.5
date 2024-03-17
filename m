Return-Path: <linux-kernel+bounces-105519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83287DFA6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC6E1F2119A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DB1EB4A;
	Sun, 17 Mar 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnm0M/8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0511EA6E;
	Sun, 17 Mar 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704041; cv=none; b=ZTpAsWXwPWqLyVGvJlrsYOWBfjngOa9cPj1BU9096I+zHGMd30mcmcXE4miVT5TVqXI3XiD8CxioN0lYequXFXR5Cnv1tok2tOuelAFMsd/8cfCnZxsH9izk+Fnv7/7Mr9ZfvzLEiS7BUU80TURhEq3kO/Rnbrn79UlJeAHTTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704041; c=relaxed/simple;
	bh=jkEbHhgdGvDvLCXpLJwKR9V6Idabrm8cBAGmoriFmNE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y8ZnC8BGq5+Ln7b5BbeQQzvi9cxUv62qiSHzGOfr7bAzWRCl6VpgzrPh1x6YUIdCBBK9+2UAPn04iXyDkiRBTLy5zASYIz/jZwt2mgrCPF9ulBPpGll6cK4iB7IUrfr2R+kpDho47roC1rTd4+giKt9FVu1V6VEXbTj58NGkpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnm0M/8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5576BC433C7;
	Sun, 17 Mar 2024 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704041;
	bh=jkEbHhgdGvDvLCXpLJwKR9V6Idabrm8cBAGmoriFmNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gnm0M/8O0Q9l5C+3KJxMM4dPJvH8oLE06Vt0hajI5Vs+8YDJow+jcqAbT0mBVq/XD
	 5kyaZYdd4ad+MQBoJXJNIDOwi4FaqPZ0LaMvYUUVydbPOxqYR97JCiR58b2eDLP5IS
	 NKC8Own9wP3Lmc7oX/VyuMiYCMF2ZdkuIDOLfJYEyoG3JgCnsohC0swUqEStd2NP5E
	 +9g/vwtOODoNZRPaexq8uJJrUmifRCOX095zb1hv938oRHDeagf8VnOdkqubvhrvTq
	 VM16TsBfssol+0ylPtInKfQBgZKLS0+rpAxz7XgDbksUsy5F2P+s0/PyM6nRqJbDOj
	 AwauEbHFvpyAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD3DC39562;
	Sun, 17 Mar 2024 19:34:01 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.9-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfaLw1CiHZDSXCLo@google.com>
References: <ZfaLw1CiHZDSXCLo@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfaLw1CiHZDSXCLo@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.9-rc0
X-PR-Tracked-Commit-Id: 57ed9567e63b59350c21ae026635ae051e247abb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6885d7263ecd8ce5ab06029078861fbeb06c4a0a
Message-Id: <171070404130.21222.5934557076424229119.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:01 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 23:20:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.9-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6885d7263ecd8ce5ab06029078861fbeb06c4a0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

