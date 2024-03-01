Return-Path: <linux-kernel+bounces-89066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149A86EA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4481C24914
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7253C699;
	Fri,  1 Mar 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCxXNAvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4923C485;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324241; cv=none; b=Gnk71647CYzc4k7DlikEcarPqSJoBgJYBHXbQsdsNVumkOqZEacKy7SKYNq4FeOBVuzJifHPdpTgT0WzhH9YE2Nak5CamkMZBqe/vkSAS0GFVq8tGsc9Abj5kpQxqWnyWWHa1cwjt+3viaDMLzBc1U3r3FnB2pbbDKsnD5/HQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324241; c=relaxed/simple;
	bh=RrYOevMe/KU0yaKVWwcIE7GVvLIdnVcsE/xOFdiptik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iDlDsQv8vYXuvyASt5McYbrG6hHlfIoeLzraMVxLtxnsssaiUaE1sq0kql2uYRI/Y0BKJsvjO7qF+Ie3f+PE0uUp4Rz6EAi/aAWWQQyr7Tk09NGzgA1vDy4SP6pHXavhAm8atuBSDfJt0A1rYMlhujTUnmHTiy1FmXKA9/fnf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCxXNAvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE45FC43390;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324240;
	bh=RrYOevMe/KU0yaKVWwcIE7GVvLIdnVcsE/xOFdiptik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VCxXNAvOdDAHJ/bvGH3qZCvIWKf65rC2VfS5+4aIP4YtnCzLu+q5jxEPpa5PDq6VD
	 2713n4ubs67ka6q7yOb2vuUa+vPo+M+1OtzX7PrJm0ACBdHTCdrepl0McwsKTO6I8L
	 Bx1JC1WXEvKcTN3lAPnVKdb3+dPO4+vSsmjU7m/sqCfVWqqHxEi3Bs1CLXnqKvU7Gr
	 XmyExabPsxiVAjUAzlfZyJGHoKbmq6eEvn4AZ3+OLRqhgMmXpINC4lM+GA6AdpBDWd
	 5K4iNMdHxVr66rcRWbdaljcPVoiVmpAGPiJWYjCiMhWgI4uw5J1JqILDXXQcUdpuX7
	 sAnFDfCZIxHfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADFBAC595C4;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301100736.3789777-1-ulf.hansson@linaro.org>
References: <20240301100736.3789777-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301100736.3789777-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc4
X-PR-Tracked-Commit-Id: 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 371e4a1f914aff0d128c518895495ef44059ddc6
Message-Id: <170932424070.25962.11947312240744185499.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:20 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 11:07:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/371e4a1f914aff0d128c518895495ef44059ddc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

