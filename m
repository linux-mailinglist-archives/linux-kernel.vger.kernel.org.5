Return-Path: <linux-kernel+bounces-141508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C78A1F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638531C24004
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE916419;
	Thu, 11 Apr 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efNAkB6G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5117BBE;
	Thu, 11 Apr 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862560; cv=none; b=riG+h21v8ZlrMtopn2vrxfyaJy1hHi3eRypY65dYYsaMFSqXQcbZnxuyCnU6UaDTxwUBySrBBZrszdwiRB7msKFREa4YbesCMHYIatzMzAPGh5KpnVqOF2bbbcSrBiefUUUA6+wg8vPsuQ7QGrPpnBaVB159Ba/BB31tbqxSA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862560; c=relaxed/simple;
	bh=gAfs5y9SAYEpHJutQhB7NYB+Xjsh7Kv3ujDpTrxVrj4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XlWSxAi7GTMIhzHxCN5IwVl8iV/hAgGA5GojcvpCIRBLadiFFMA9mRtRhau1X+jgk5h7tIclNiG/L+dkFU/Yjw701gPkES9/YjBG9jmxIdQwD9ozxTfZ1HIVTxYhkD9HyWVsYrqbFvd69TymvgUneiXGKREBsJDk3boIdnwMO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efNAkB6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABA0CC2BBFC;
	Thu, 11 Apr 2024 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862560;
	bh=gAfs5y9SAYEpHJutQhB7NYB+Xjsh7Kv3ujDpTrxVrj4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=efNAkB6GbgSipAHEL0DrnoXwroqgvjiaCuWIhvz6whO1/GHnOLs6a4zfsu9FuJe5L
	 +o6QzQsmOxyO2C5nxdsXNuAfUR32JKWUH3b6fpLBG3q4f3ro7KE/QXpF/IA5duGg9l
	 tMRSoczp+IZZ16GCToVIO6NbO9P+Azuu/+68D1BFWkAcfLz7o4O74ouuEPT5h8E5H+
	 UQvgkzToGYHwQp3s70WPNgtfVNSFyY1nOHLfc6yutRjBD77FyfWNRoOFR0OxZdUIph
	 MoJQTg14q8LRvDPGPU6PcoD2ZFRaMxdunHUf3ZfjUpG4GUmO+H9Mh86lgrBFALs/zV
	 5jzT/Knht9drw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A116FC433F2;
	Thu, 11 Apr 2024 19:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhdKeS8lzaJLPlMM@google.com>
References: <ZhdKeS8lzaJLPlMM@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZhdKeS8lzaJLPlMM@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.9-rc4
X-PR-Tracked-Commit-Id: 5e700b384ec13f5bcac9855cb28fcc674f1d3593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 346668f02a770f84bfcbac0c07e70569349eba08
Message-Id: <171286256065.2172.11301167562372481094.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:20 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 10:27:05 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/346668f02a770f84bfcbac0c07e70569349eba08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

