Return-Path: <linux-kernel+bounces-103655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBA87C27E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEAB21DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FE75818;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT3r0NPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A367580C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440433; cv=none; b=T9uQpIXTlqqiM0KMahzPMre3xYtWQ2Y/dLVWPvNTDvCTztAzcO+Y1HER2iYO7W/IbY0j77kOInW/IHihkdpDsHDQ3Prrcx4RKW9xGpENZNIQJBHvgZkNYk/CqIsQcvCHrtsT5YSdu3q50ElbhBDXOXVxKuA1BX+DLNiqzYek5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440433; c=relaxed/simple;
	bh=JjrLmipJztKYnoik8xnFhuADx7TrprU6XFflt+QWc8M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KziBAHYczhW8jpNXjxVrW/QSrAfwFqzZF9PyAK/t3ab0lkVxjV6aqMs8HQv0htZmYPwQVv5yx4jXOSQJhHlkDIJQ4gDE17QqzuVVxxFyPBw2Spal2fAjyBv0xMejpvMHOEwOyXP0TT9OC53YO2LU3lmTWAJN8guciI3Amw2M+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT3r0NPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A4FC43394;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440433;
	bh=JjrLmipJztKYnoik8xnFhuADx7TrprU6XFflt+QWc8M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fT3r0NPVGQss6AREJ8xDGyzq2+0i3C92v0/Ru3U+qGOsi8fQ6pU/0KdKR/DNMgYLe
	 USgne8qaUw2VOnEV0HSJAgzsdR/fG4eYMiJMdfPSd/gMd6WB5kyO1IH1ljKEamIMjf
	 TiJ7TuAzW/1I2wK6bxBMG/g6r2psciGg7fRVCkYON4umGriAsqzbEWBtmKG+eGIYJb
	 G6bmkb25nw4m68bJbFbUtJKnnU7+JN4adwHL0Qz/4yVvSICfB/wI39av+05inHQ+54
	 S08OubU+uySWWLnvfZaTAIO2y6DXSu5I7tpqnPOcIIUdY/GdLmYZF6+rb8CRmG0Q2T
	 hEhEayjS5ZJFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E358D95055;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <jp7jclyag7qcknwl3zryrerud2dlrcssh3o6oqexs6oe2z27np@g4aahpksii7x>
References: <jp7jclyag7qcknwl3zryrerud2dlrcssh3o6oqexs6oe2z27np@g4aahpksii7x>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <jp7jclyag7qcknwl3zryrerud2dlrcssh3o6oqexs6oe2z27np@g4aahpksii7x>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.9
X-PR-Tracked-Commit-Id: 3693760295e8c8a1a88cb3da5b178959b3cc7c75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80d80de4b75edb7c83c68107098aa338364dfa62
Message-Id: <171044043351.24196.11979549631972871317.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:33 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 23:12:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80d80de4b75edb7c83c68107098aa338364dfa62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

