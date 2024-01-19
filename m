Return-Path: <linux-kernel+bounces-30710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F0832368
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0975A1F2369D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0658C1F;
	Fri, 19 Jan 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1CdaVVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3096ABF;
	Fri, 19 Jan 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632009; cv=none; b=NW93n2cSb+gyo6IMFaGpCdkZJm5oN7Y54aXZ/jrE4lAZ9Jn8jPYSU4aLPaOPOqByQzStJb7ckB0a9F9CjgMp+EsGPLFiFb/RSe/6L85W5uPEZ0S+/Dm5070KuNV66CA260THOoTra3ehwcqzP3mfxsxBtSd9PaRItb/oOCdZP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632009; c=relaxed/simple;
	bh=UKZYC8dCEgMbui+2TV9BpcgHZtaeq7r56Mka0vrIUtA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qmk8ulMxs1Vm9Y/+63YOqeNcRnvAW0qR60AbpAqbf6IZV4rzjakOzvP0SRqFo8RrKtC/ONbrzeB4kHIJ3amO9xc4QEtZfAG69U95ugia/2CQGHiZisIy9B7a4CWVoVScpcgS+PYoiuvVVJonp3WIG2a5nYa2lxUOIc8HIkHrwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1CdaVVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F585C433A6;
	Fri, 19 Jan 2024 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632009;
	bh=UKZYC8dCEgMbui+2TV9BpcgHZtaeq7r56Mka0vrIUtA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a1CdaVVIcOD6npmN8dyB0BhNtveaHrXlz2MpfwhEMAOE+S4eyLEQrIXSC2cHXZ5ZZ
	 a9sKzlsgkS3Cm8VJPrbZHb+hg6bSyNXaShMCJU6//gMam55p9gTIucZJVbMZZHam4n
	 yFgoYBEeQJ8rfljqwItceMXMpuyndu+/WpPdtk6s4/OUpFjYV6CplWCfz6FjLcTcU4
	 Cpg56i9WJE9F9by91TUhiqZ9LiBW8Nsyv7yZnWbUijOPpr7KCuJrxg8M8Znju58hR5
	 sbDey6Z9sy02Y9sdTfSkBBHBgH6jXL8tZVkezllRqOLvK+JmfGNfiy/rMiUdG+frOD
	 W80oIn1SSdlgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18CB3D8C985;
	Fri, 19 Jan 2024 02:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARUOCnNNH3s4XigT7-nDMHv0gWUQnk9H7ZVov0GrvAfRQ@mail.gmail.com>
References: <CAK7LNARUOCnNNH3s4XigT7-nDMHv0gWUQnk9H7ZVov0GrvAfRQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARUOCnNNH3s4XigT7-nDMHv0gWUQnk9H7ZVov0GrvAfRQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.8
X-PR-Tracked-Commit-Id: 6185d32170b683abadddf1e68be998e24f3cc5de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f66ba2d07180706ffa10df07f202335df190f1
Message-Id: <170563200909.16016.4023377216837945369.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:09 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 08:45:59 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f66ba2d07180706ffa10df07f202335df190f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

