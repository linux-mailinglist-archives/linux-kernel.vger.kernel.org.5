Return-Path: <linux-kernel+bounces-31573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B6833041
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C51C23353
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0415917B;
	Fri, 19 Jan 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A32sE7P6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6ED5915D;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699649; cv=none; b=Uo/DIgzKlFPjMLwNn4767pf17uAT/dYO0VxALiStIRf5jvufI2e/x8IrEgAFbv4AzZNoD6QXUX+uWqQb/2oueTF2FizZzMdC+MqYfrT/Edf9irQoto6X/K0Gnce3OKCmZFrYtbdZqJeq+1zM2MtZNtfmn3JBXIXj5Z0noSgK+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699649; c=relaxed/simple;
	bh=2ZJkAm13/4dfwT0V3aQs+Pw+67OAC6T1PlI6d/xbO5A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XivJAu7LU/FsHR1SxwXT9fyNzhKsFR5H1cRSpU3i/zcJr+WnAlKh8vCGB8IygYNGkrqUfhLDDlOmqdMoPxyQUgrMrr3R2EV1FRDwGfJPBYsuTjUHs0RluQxlfw/Exp2syC5O7OGNgF3Bbpt+yDERmDKmnHuaPAeJjGFmjGT15ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A32sE7P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25DC6C433C7;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699649;
	bh=2ZJkAm13/4dfwT0V3aQs+Pw+67OAC6T1PlI6d/xbO5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A32sE7P6mv92/0aX65SHOZTiyiIUHbsxfLz/R+wjpEM3ZU+zYBM62Uemr8EXjU4Hr
	 /XJbW+sUWbY75xKBun7TOJAAVLXcLvQQWmju+1pVUN6ow8PwRWrAnxStr5HegmZmnY
	 MjnGZ+ugLPvTakvV+wUUUamgZvrLreEf+p51Blix2qOwpQ3UccnFkqIVLQlaydvWdC
	 NIOKJo/PuGvorVaCGIGvX3F+/9dO/lv2slTHnQYdgAMr1Hf5FuVamBbtvWNzCu6BjZ
	 TH4G98KTQ1yM3Nvu5AUKYx2oxIFN89VibbqitMEmd2wcirotlHqcq7s2vzhJPjvJpF
	 M3sCKhXdz9MIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1433BDFC688;
	Fri, 19 Jan 2024 21:27:29 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>
References: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8
X-PR-Tracked-Commit-Id: 05599b5f56b750b5a92ff7f2c081945210816f83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17d49b7e47a1001c8796f05f4a2bbdef0a998213
Message-Id: <170569964907.21908.16920243552615078188.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:29 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 21:43:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17d49b7e47a1001c8796f05f4a2bbdef0a998213

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

