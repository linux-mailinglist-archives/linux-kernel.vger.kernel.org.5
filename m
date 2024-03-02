Return-Path: <linux-kernel+bounces-89290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B538A86EDDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EE31C2215A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2F6FC7;
	Sat,  2 Mar 2024 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4A8RTnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0E28EF;
	Sat,  2 Mar 2024 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343081; cv=none; b=eqew8HlFe8z2ELPpsyLrqyWvgTyiN6VyBLUM/S4OJhyHgq1asGuYv3/l68UsiJ34+Qsm/8QG7pC/ub0fyLfJ27aUSpuUv8dSG9R7PC5Zq7/Q2iI1DpblFGQOPg8uGBnrlWhwgjFOySuTi3UhP/wjgTSMxgIQmzXHRQ2X7YcCIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343081; c=relaxed/simple;
	bh=HYtZOXn44DDvUc6B6X64Rgp/A49cSC8E0yw0ssYDQQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VKZA/D+lBqPV7/u3DV1Vf4GplgdpvOKa3hs64w7Hn2Z/BffR2fNnI62dlzE209TqebLPJhvY+JB/AcQAPkpnsdaNxGRg0SNCc2607GDBwxpy/4CHU99inysYNuLLlnNUo3HUY9cpTQFG7WDFQuHbsMfY3ClYbLnP2mBRgNR+2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4A8RTnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 719E2C433C7;
	Sat,  2 Mar 2024 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709343080;
	bh=HYtZOXn44DDvUc6B6X64Rgp/A49cSC8E0yw0ssYDQQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M4A8RTnt0Oufwy0lJ8/MTjxvGCPQnuKpdD9ymYFezT8kjvrWpFs1Bm/TkXdLXwXQE
	 hW37pxLZMAbqnZ7Mbnjbm3s6ELQ5V+z9ljJwSBg2BBIaTFzhobQb9bveFAgXMaS35I
	 hMRENtyXWLDjZOVkZc1T7Nor8CTi8FbfTi9x11+LM1JC5ZwHO/A95JuYRUTE38Tfgu
	 HXs7qn0wUhnsCJ/yAukphTY0BObngY6bAD6NV3loxmXI4EV7PHLEeuCFzW+RWvdVm7
	 UJ8vd2NctHIoXxVly5JN85XrS0apINwtycI4HrQ1lxuuyTfRpXBYOtYIqruc0QOACU
	 OZMXz2M1Kp7AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 592A5C595D1;
	Sat,  2 Mar 2024 01:31:20 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <l5h2m2msmj7xp2awqq26u3qbllvjtk3xj772q4ek5ty7vqjmno@2epgarrb3v4d>
References: <l5h2m2msmj7xp2awqq26u3qbllvjtk3xj772q4ek5ty7vqjmno@2epgarrb3v4d>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <l5h2m2msmj7xp2awqq26u3qbllvjtk3xj772q4ek5ty7vqjmno@2epgarrb3v4d>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-rc2
X-PR-Tracked-Commit-Id: 2df70149e73e79783bcbc7db4fa51ecef0e2022c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
Message-Id: <170934308035.29596.10898116321340736606.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 01:31:20 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Mar 2024 01:50:38 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

