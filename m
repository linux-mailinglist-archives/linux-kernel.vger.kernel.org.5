Return-Path: <linux-kernel+bounces-102434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48887B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BAD1C26212
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF636626BF;
	Wed, 13 Mar 2024 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZjdpZGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C385EE87
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358100; cv=none; b=hrmpK33bxe5o0cJlt3dRzolFdMsv3ZZd4vcCMr2mgDpsbX2XTdIRigO4MZxY1A7l8tCrOH7xj5wFNVNGaHYCpN4aLRNvC3Ckv9vqG1DQZAPMsPLvX2Z6REDIR1pfIdCRrQQE515VBZuTqWnYv0rfvZqbBfUGpDmsq8vZ1++3UtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358100; c=relaxed/simple;
	bh=7f+6y16Fkr7zMCvnShWdlSYd3kqwdfuKL3bfdCY8o9Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DQpljSvQhdvn6S3Cg3YKiBpQmThENK2R7KYBKffF4NZUdHFQsz67MQP8LEL9+MQX4BUknmDklFfkQEE/7I0PIPzI3c/MDDif8t/36r1fldRy4/nFTp/g+I+HE7U8PSz3PfYGHfe06I9KjEynguJrSlEGW/SeQynqLRcmzcU5w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZjdpZGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF4B3C433F1;
	Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358099;
	bh=7f+6y16Fkr7zMCvnShWdlSYd3kqwdfuKL3bfdCY8o9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cZjdpZGZy+wWieQN6hAd1R7+V8Ofpw7E6dA1JNL5VXJgc3gFR4JdYNUJlCrk+nNt+
	 YdVw9njDWmhXS6mGupqYsaPFzRXNLKIfSKeK7JNb/dY3yzI/IDiJKNwWkzBtT/1miJ
	 p0oMMRRWYY0HSEP0nyqFHLGrkPC3gWaXSV9CTo5HqBYi2J6NyhGskIcjFgBYe98htg
	 UwPa/gB7fuRwO2d5RDpx6ANlgQaXcowCPfqUfEFKqMkk/tfHYAxgbgSvr3WF0VWneo
	 0Z46T846yt8eUazLTQYF4BWPwXsJA8MGQUoQAEOwrwkP5enfcXn7qukjPgnSKXRlIH
	 I63TYdrdF9g3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD17DD9505F;
	Wed, 13 Mar 2024 19:28:19 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311151253.0E617C43390@smtp.kernel.org>
References: <20240311151253.0E617C43390@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311151253.0E617C43390@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.9
X-PR-Tracked-Commit-Id: bb92804ba2b6636e28db05f589a9a8ef62a07917
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b30f2db0b79055149ee115fb7b3c86add4d9596a
Message-Id: <171035809970.9850.9024728513186886911.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:19 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 15:12:40 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b30f2db0b79055149ee115fb7b3c86add4d9596a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

