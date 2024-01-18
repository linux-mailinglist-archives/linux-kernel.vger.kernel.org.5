Return-Path: <linux-kernel+bounces-29571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1015831055
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825E02846FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A08F60;
	Thu, 18 Jan 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXyyTONo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEBA5E;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=QsJq3j/DCSuLBDkEXqwv6t7udpbdIFof0uPTFgb1NdYcPPql1lg0CYyPiSobM/9viMGa2PPsxDUN0cz3LxpIHJp0tH1O6nnjYIcXxpmPPZPUb4HxJ1Hw9js6RtgEoqiyIdYVaKCyF6zwHPzFWYn0oZbNoywSdnYbqwYTa7Lr3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=srP6jc4yMDNahMJFKLxCkqIw3EDdKbmVHVa9h7QuM8s=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=n3bUe2ccLi2jha6jNRynDtavDMkdxQEu+j91DWz3lviP14MZQltGKrrX7p7DUmbK3mjKdsXjg2w/6rTT+LDAfv7SoSIZbeDjaSQ5R+1XYd4pCzOyfQx5kKq7BsJdbvav5b9wupJaoe7WlRY4xeHV/VMIW2G5swmp7lAWXsmgDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXyyTONo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A338CC433F1;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536309;
	bh=srP6jc4yMDNahMJFKLxCkqIw3EDdKbmVHVa9h7QuM8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gXyyTONo6QnW/A3YqK5O8yLgj3NeAIvFJLHqkHqJmRt+4/YDlC8Ycx/V8VB5B/1xs
	 aO8ep45fq8bKGkcbj4XKX0J4wEVUiIs29vAUh1FPclvWJ0YDFXv3x/HdgJ6vSDZcX+
	 esPiioegGAJdi21e4s0LQEF0+gKKgK6KBgpHwe7lsP3Jtq59fvp8Q9bbh7fWZOKMFw
	 5Q3QzZfspWh960iiv5mFrU04qRRQeBIXtY9JMLnXrJQbD4dxTh2vSIoWNIETL8bEAt
	 gQZe0z0umwm8lAZ5+iIFZIl3hw87e5kbz9Atp/+CrQ+VDTYfYQnrJ49B2GO9o5MKxI
	 GkEzZ41Rem87A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92EF5D8C978;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] pin control changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaSdLQ7_ekbAPBqyEJSN37w5dmwA0PA--GEpSqEFXDuXw@mail.gmail.com>
References: <CACRpkdaSdLQ7_ekbAPBqyEJSN37w5dmwA0PA--GEpSqEFXDuXw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaSdLQ7_ekbAPBqyEJSN37w5dmwA0PA--GEpSqEFXDuXw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-1
X-PR-Tracked-Commit-Id: 1b09c2b8f849079220a9a9ddf961582f00bdc2c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed6c23b175471d7bdecd06b5f37a0b1057c90cce
Message-Id: <170553630959.10877.6021127309827769815.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:09 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 08:51:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed6c23b175471d7bdecd06b5f37a0b1057c90cce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

