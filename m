Return-Path: <linux-kernel+bounces-48686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFD845FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A922F1C25EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBE85270;
	Thu,  1 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma6CkSE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331A12FB38
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811792; cv=none; b=IO9A5cTMu7EjBqnRstxzsxFgBnAH2R70qeQS4CU9s/cEaK8L0lweS3Kp66MCH8LVpJhETqm2B9lEaqEHKCWZCf2BZnSkqer/P5iD5nQC+30svA2WuvYGouQ8b4EybyhY9mtAFGcuAhzjmQgfg+P6zFgR53KPNcDr8sCWlq3qkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811792; c=relaxed/simple;
	bh=Rfq/1EbOlZ+uf0g++56AeiUKr/p3cQK/1XhmbONGGPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fFqubQMp3MRz3PWA6OBL6vGBCdWBS2qx5HqUee2Wgppksm0fK96c8w4gYme8tloxoiz5Sqc0QpOtbWZ6ZHqUrVN0tb8tcWY5joW8sceI2i6fy+PEWqRvON4mDJG/PLCAnPohXttsZbsdVRVWDpftmSodphJuW1pAnwKYGgTfDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma6CkSE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9D2FC433A6;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811792;
	bh=Rfq/1EbOlZ+uf0g++56AeiUKr/p3cQK/1XhmbONGGPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ma6CkSE7BKVBMoMLMkhmCz9NKmWS7uzpJZ0KjCPxdRvk+9ainRHSl5jGZoEnsB5MD
	 fymy4dNoK+GggX/KVZBOWnAEWpkNDusApzOMZCELExRxDTOh25B/VGaFbE6sMP4NrR
	 LppXzLpLwKKM25/APNL3RvOw7DBFS12/qur7ah4xjzvFeWboLna/pnjLkCAn+fzdkM
	 5h13opXe8DXaRzJ+9NZJp/LseR3ALTIhePiWIymhXTxgHJU0RatQ9NXD2gHdha8BOk
	 0frYW9xOkARkHRc5ETRsEPfBVSasiygvHdZ5DlXUIKx5+Nm7y6S+htDDLrlBg9U7iz
	 wOfucuL2KFXGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97010C0C40E;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240201121926.GA87292@workstation.local>
References: <20240201121926.GA87292@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240201121926.GA87292@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc3
X-PR-Tracked-Commit-Id: 47dc55181dcbee69fc84c902e7fb060213b9b8a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6cdd897cc7030a573f56ab1e9ebaece26c7c10c
Message-Id: <170681179261.954.17356427499585105372.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 18:23:12 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 21:19:26 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6cdd897cc7030a573f56ab1e9ebaece26c7c10c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

