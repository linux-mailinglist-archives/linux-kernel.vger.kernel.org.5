Return-Path: <linux-kernel+bounces-102426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382087B1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A2B1C2366B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50CD54BF4;
	Wed, 13 Mar 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah+6yLvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725560EF5;
	Wed, 13 Mar 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358077; cv=none; b=Gm08y6gSidO/girLhDFgxgM6jh2m3CU//y/guhmAV7j8mRob7AqHMrQHTDL5wP5Hm7yuo1KMId+LFUcXvgUc4sm3PTRR7wxbePDbp4YupI41S2i9Igu7woR9WASegLik/BZHceMDpr6Lz51HQME2LfqjHLFb0+5DVVP5Z+AwrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358077; c=relaxed/simple;
	bh=ORDYS+PcTkbLydmWwil30ax5ySWUxRgZLJa9XR/t0NM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QVZSKCIeuQ9j39E5dxmwU/fhfx+LwzzosGaZWieqUuTDMF05fQ0uj/ni5us7eCBKpTWfX6n444snyE71tQp/ZvfnNRlPW51E4SSJRRhizhWMml2PQp81lOX+lwntTyCA5h60Y9S1i54K9sORQn8RWfaAEn9Q34QoxrY7ygQJBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah+6yLvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3FD2C433F1;
	Wed, 13 Mar 2024 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358077;
	bh=ORDYS+PcTkbLydmWwil30ax5ySWUxRgZLJa9XR/t0NM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ah+6yLvU9nYr16zMzPzbqHLCvTlNmc85iUwYZ5CfQD63wPwSS5gm5U3aW1ugR3tO2
	 dlLa5n5RXSxr5Xw6weudcCduf8r/vURbdtqasWwpKugFDDs8SrTo2879oJgSOrkaK5
	 CvKON49ONs5N403mJS6c7r+62h18qfl3EYvdoFeWlaWSfdIsa2GLu4qzYuh3NkYb9f
	 EK0ZupA+1xs/hpBRi5gJXgAG2WcHp0Ypv9DUrByUToWPjlG0rxRQW1YE6M+rdLAEzK
	 7Gn1kJMt0VG6xkuynHVoBxiN/bQTdrqNUiwzLN0vdc/juX3XxCTAxsIFJCibHD7aMc
	 B0jeYzX0HzScw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3869D9505F;
	Wed, 13 Mar 2024 19:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze5tZoBl4glQOR6o@google.com>
References: <Ze5tZoBl4glQOR6o@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <Ze5tZoBl4glQOR6o@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.9
X-PR-Tracked-Commit-Id: 8a0a62941a042612f7487f6c4ff291f9054ff214
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa7d6513d68bad539142f9d6c3e2faa629bc27d8
Message-Id: <171035807692.9850.6110238831766356853.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:27:56 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 10:33:10 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa7d6513d68bad539142f9d6c3e2faa629bc27d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

