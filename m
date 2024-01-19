Return-Path: <linux-kernel+bounces-30709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A52832365
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1844B1C2309B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A66FD7;
	Fri, 19 Jan 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRgCOB/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6F4A04;
	Fri, 19 Jan 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632008; cv=none; b=s+WpHq4qGJklXdQn9ISs/eX1H+f3HQEx6ku4LdWEsJaUdxFvFtxwQt16UTO1iQPb8GxunZJ5etlj3SFChDGe9G5UXaueFWQ3S4rI6cN7f1xN45g/qmrEAHw0tU62OS2C9WFefi+7uCnQKFMve3Il8uThw4AC1LOjEtP9TFTM/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632008; c=relaxed/simple;
	bh=d5Wu5DOZ7buDo5uhuytAjORjXQK+wcLiCvi7l0/d770=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MP88DwvJbU90QkXWIlaliCybUAEiUHi2cd4khoXYtFbpGLi8sUKumbkVn2iLzvNY1QZlkMKbDErF/d9pKivb9ip8jMObNn+TViKYH3UMxu2wLSzfPu5Q4nZLuSSZSkQllCjd52cPn8X8RcAxLgVKstV510ivQek0LIBiO56vWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRgCOB/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7EC9C433A6;
	Fri, 19 Jan 2024 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632008;
	bh=d5Wu5DOZ7buDo5uhuytAjORjXQK+wcLiCvi7l0/d770=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WRgCOB/DwZgtuqoc1vgXNLjvE92CGbosCYJ4fCN8C/JKgUr66JTx7Os1hOHCg1o4D
	 1P9xNfUiV+IyqdgPwmhdZviJFlTY9pG1Tx65JDvGF48kusDEnfUeeXzHeln/SPP55F
	 KZqhkWa011RWUaFTbjGKXd518QUlDN0MwBnUs/GAFqjmBZ66d6X5Hhm9KX3Q6/uC/W
	 3/lS/b0qOAC9RKzBMvnCKmNvHDYop7Cf8FqXDGrqIrq0Ch9Nvw6ZW0cecOvtX/Pjbr
	 U3egc9QgqI501Ne+Ttc3JldR/zMt9VFqNI/KZjyFQAxlgLwthkCsYcCyHi7tLQadR9
	 /TfipgS4i/qyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98C28D8C985;
	Fri, 19 Jan 2024 02:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <2024011821163467921dbc@mail.local>
References: <2024011821163467921dbc@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <2024011821163467921dbc@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.8
X-PR-Tracked-Commit-Id: 14688f1a91e1f37bc6bf50ff5241e857f24338e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 378de6df19800dc2c18c355c8c2c5528f98e879a
Message-Id: <170563200862.16016.16414897393157919120.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:08 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 22:16:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/378de6df19800dc2c18c355c8c2c5528f98e879a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

