Return-Path: <linux-kernel+bounces-125837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFF892CED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA451B21CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F394AEF3;
	Sat, 30 Mar 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlx8y1LW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6687446DD;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830120; cv=none; b=fJtXx5bGxu7cv5Zp9UY4WHjv8HoQuISKStQzntM68C+DPXQxEYNqkyfu+uVzKbiDgG9T6gaKlavNaGdu5vIRHHQE2XbhQ9QYrJVcyYHEzUBQdTTO8c50xnpcbct0LcbLKOco4CE034Ud5NZUydxH2MnCBhMzi8kAUX0ojPYKkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830120; c=relaxed/simple;
	bh=UR0DQqwPRhRQVGrNwU4acAKiGBMRFMI+l7meLwNL7g8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t2YL6g1yRB/f0ZrZ5p+xh8v9Ratkc7RufKXQGHgMMUV/VSIriWb5iK/MvUA1cns68k/FLWAj3JGufFbya62Arlg19caTH4bhNYGajyiUlzzEL5WfjH+I02hTj6qL1WdAiL+lNWbQB4COAMGgyEPTC3LBDhmJOlYuG1/ju8KY8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlx8y1LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49925C43390;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711830120;
	bh=UR0DQqwPRhRQVGrNwU4acAKiGBMRFMI+l7meLwNL7g8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nlx8y1LWNG3tQzr8hkUfUVtIcy1ENwcO6i5+yrZTN2S15zHkZM6aUM2PAG5xoxEao
	 0cVjd2wmxfQPpbKIpYSe4Mmdsl97CvodLNUHvOW3HqDalBP46RxaaRU6Jzvg62C8Uo
	 xpk/EXbFwUri+UlDU9vuqE9oKFIfV15PVzc2N3KfCLQcwxgfAzH2gpMWPXLpEVIhfS
	 J5WZ7v408kUiL/PEnTNOt6S812GJ/rfiC2f3E4mjtSwa28VRusoYGKEdiyuzZzA/P0
	 CxttsMaPp6JqNUBpNeJJqoQ39GU30BCrsxBGJ4nWyFafczC1G+wjxCTTni9aimrHdt
	 n71fJB1GD7wdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B929D84BAA;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZggE0HwcSJTQzE0D@kroah.com>
References: <ZggE0HwcSJTQzE0D@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZggE0HwcSJTQzE0D@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc2
X-PR-Tracked-Commit-Id: f4d1960764d8a70318b02f15203a1be2b2554ca1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff789a26cc3784b33ff4f4cfcbee86cb4aa09c28
Message-Id: <171183012024.3897.5975717252351943934.pr-tracker-bot@kernel.org>
Date: Sat, 30 Mar 2024 20:22:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 13:25:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff789a26cc3784b33ff4f4cfcbee86cb4aa09c28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

