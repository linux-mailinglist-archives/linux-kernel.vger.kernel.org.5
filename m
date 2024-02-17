Return-Path: <linux-kernel+bounces-69988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2E85915A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93296283274
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5627E583;
	Sat, 17 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJG4GCS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6D7E0EE;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191610; cv=none; b=AqhrQcx/0sO4Io8QrwdjvNaM1RMOOJpoE8aAyBn22uBRHKayB0Q9XG0rz+P/GhaQIOL9W8YASjIl1hHmlc8lKU1fT5fXuK4NXDAQuQdtLMn8HmENZIVSJ1ChAxvk45DP02U8p0imkd5VuQ1N4agTjcyI86vzPtOzBUHaLxzW67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191610; c=relaxed/simple;
	bh=YVSn+NdiR9DuWStsWKVIoAqCZH2bodXIDfVE0fuIOmk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hTsAyDEX+AZZmqL9t1f953e+lUBj9B1+mgEQ9qQt/7zSjL2SQWN61KUmfrcf+TbZyU5Xp9d1jPOId8x9/CvxkCD5mSzIyr5yEYkbV2swpIjdpJVgSJ1YbRH+RWtFq9lIkLMMDhppikMQQVMmfzehsbf0PsYPDZWh3D1zQqu24hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJG4GCS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 943CCC433F1;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708191609;
	bh=YVSn+NdiR9DuWStsWKVIoAqCZH2bodXIDfVE0fuIOmk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WJG4GCS9hBf1mzBEEDPOh37O0zHTcEb1dt+zSG6qpDHg0w9fVoZ/gUz002iSqFsq0
	 JCAZ9TfqQ51X1U+XnD70rAWi93oY5jFbRIqBoet2c9a/TC6DyqMKeO5AohnuwbD1SJ
	 Qr3RnSITHDC3dwfUNqjC0KI1eODtgBljWUltan40dA/BLBU4owo8PUKMbUJwlTKK1u
	 QXVf6jBnU0+xZcAELBCTb8BRv+LLYQvbyp7ulggsqXgRhFCBKA3pQ2XiY5r8wZFmj2
	 xXIvUMWj6wdiXYbgZSTTX0HDSGaFIXOxfV10ZhcsfEaUKaQITsC9YO6l/Mff/H5Gym
	 k+OhD81RJx/FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E445D84BCE;
	Sat, 17 Feb 2024 17:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdDNFfwclvmprBoR@kroah.com>
References: <ZdDNFfwclvmprBoR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdDNFfwclvmprBoR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc5
X-PR-Tracked-Commit-Id: 7d708c145b2631941b8b0b4a740dc2990818c39c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3a7d1627429545cddcc60314f1596912138daf1
Message-Id: <170819160938.11002.6532437579882499303.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 17:40:09 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 16:13:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3a7d1627429545cddcc60314f1596912138daf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

