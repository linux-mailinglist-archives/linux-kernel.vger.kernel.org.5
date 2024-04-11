Return-Path: <linux-kernel+bounces-141511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E48A1F33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9832D2884D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997C26AF9;
	Thu, 11 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxet7s5a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264218AE0;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862564; cv=none; b=s4cdwiD+3kabfMDwD7FmppQqqSA8d9MpqcvS4Y1whRAdyySS3FnKBFG0XdrMlqN7Txad15d45bHgufCtNdSd9Dm48WPv+EL7deO9ndr9MH8cPKVsLCf9DqXnt7Ek+1GqIxDXWrzmyWLgTI8mqy9YxUJasegwoyX+8hXmxdp04Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862564; c=relaxed/simple;
	bh=hDbpAi+COaOsAEb1bsy59WwssefNfq1c1N11vrfipTc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OnoVxWP5gDRIZJOcD6k++8n/T6rWilZTVvocToITvVUF77CI5HWB1C9a1eOYx/gpeLhvCIGdUbKMz1xgu3791dkVBf+gXYfcvy7RpUq9B051bymWwNUjQ8D2YEipoHcWKaQVRrj2npKZ/l6VeVCy38q9Xquv4ywZGO+g4JtrzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxet7s5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D74ADC072AA;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862563;
	bh=hDbpAi+COaOsAEb1bsy59WwssefNfq1c1N11vrfipTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uxet7s5azq+V5vQWMqEjOKKluyEsDwBc4KnzKDTFb7rOyiJJ9PyD8c2IXb/gRUtKo
	 Tex+9IuazASar49X5+W8McV8l79xiVhvb1XZHUM5BuxaFG5GWrfKPig/W4Xie5V+Qf
	 BT9JWUs+/CrpDgKCFXrOVg0FsoWjA+7r8jKRYraunkOeQ9pYWkP1Xow+jPUwpCNTiM
	 3coqgx4I8CSLCf8dkFsZfSaVjiQkiFBzbefpUJ18CPSIIq8IZgPVEM1idlOM+Bdzlf
	 0mTKREv0nK1JT8tfNS5j/v/agbLfzDijUVGeWNXv6s3nerWeY7ViVi1mZoB/DX3y6s
	 1gr+G1wUWYLzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC58CC433E9;
	Thu, 11 Apr 2024 19:09:23 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <3151adf5a1e0566e930454aac1a7c60722f5c711.camel@HansenPartnership.com>
References: <3151adf5a1e0566e930454aac1a7c60722f5c711.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3151adf5a1e0566e930454aac1a7c60722f5c711.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 4406e4176f47177f5e51b4cc7e6a7a2ff3dbfbbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab4319fdbcdca30842b76a30e2acdd52ca8d0729
Message-Id: <171286256383.2172.11057473275474472460.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:23 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 08:37:02 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab4319fdbcdca30842b76a30e2acdd52ca8d0729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

