Return-Path: <linux-kernel+bounces-85586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96A86B805
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C411F21FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D486A004;
	Wed, 28 Feb 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlHHd8QQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB93FBA7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148098; cv=none; b=kpqwKwyp2CulyuBlg9OV63nM04u9qp6P+AydIBnQwVyeWurVQjse0Tq7vpZEKNldOMWWTGRwgi73vRmuCw9zk7SmNdOERr5Cfy3JV65JMKz2IBMRaNo7tyqgpKeuIogYgNwDlj8vHWV4TXpbxd5PhBcUdWna1yy+xGSWxkrx0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148098; c=relaxed/simple;
	bh=Y7i3f3bLoCX55YzE4kbV3z7FYgwJ8TeEUSurvPL66Ic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D29tAO9lbbD9IfBbsXueJK7CTyLlDPa2JYZoI1V3pi+mrkijz0NtndRxMwVEehXrSqHGEJygGO0brZ+TECUuqdnIRvtEZcuAWWPsngpsb57kxt4F6SWdC4UnxousbLTLKVSCQaRa+t2+fnklKQ9geP93p3DBLuYs1DAFGDBXmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlHHd8QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8826BC433F1;
	Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709148097;
	bh=Y7i3f3bLoCX55YzE4kbV3z7FYgwJ8TeEUSurvPL66Ic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XlHHd8QQOAoQVsSqJpigEJW9ge4hyJ41et6zff+gLVSdr1u2Yu+U/pXoDAXRT6cjj
	 7Bq05Rb9nnUp3yktzrE+fLje8K1PZZa5VnSSFK7cQIijztoKCTL/z7GMCuy6wVKmHP
	 FtNz6Kj8iW8OYaRTTzFnDCR6N4ZwYwxDsWsNK7Z5x5yTUIwITs5yPo39RwE/qWs/Ac
	 fnB2T6AA5wG79IaeuKx6HwS68M1+4PvGQeIMLjQvfx/DSdG7YOGlCw6pw+HR8NUm28
	 r/3qtH7nvnb1CHfmJ+cn4zm/ysF+HXLTXnXZ431qS2yjI1QzkfCjbtNcqmhkIAq3j6
	 pGuT78rktpKBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 715E1C395F1;
	Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240228180251.CFB39C433F1@smtp.kernel.org>
References: <20240228180251.CFB39C433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240228180251.CFB39C433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc5
X-PR-Tracked-Commit-Id: e5d40e9afd84cec01cdbbbfe62d52f89959ab3ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 628e0594fd00f40b3d24b04174e0cf73cdabd33e
Message-Id: <170914809744.8490.14280890337310122359.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 19:21:37 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Feb 2024 18:02:39 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/628e0594fd00f40b3d24b04174e0cf73cdabd33e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

