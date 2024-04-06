Return-Path: <linux-kernel+bounces-133802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E2089A8E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0432833DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692C19479;
	Sat,  6 Apr 2024 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr++2t1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC78F4FB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378340; cv=none; b=A8UDAjUKhliYOhpmtA063KvP110ZYwQedE1A9EuYN7gMbF7t6Z9oOEgAJcCQCKAy7M6Haj7h/tI9k+B/N+MQ5ouKchBLpOhRnuxs1fviWw2nWiLurZaRgYbwQr/F5hVEezMFkvHAOhzjQ3l4GsDbVjh/uRwsGDQ3qB6dWBxGKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378340; c=relaxed/simple;
	bh=5tMkE//gW8T4D2vY1aLzKtDqmFTQeetGUyWM4MQBCYQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ik99sAp0p6O9ktc1uv6vP71g2XQrMIPgsNCzD83KEtF1BDCVbrKOCqzgp1rTOU/hfe3J6Vnz0Xgjzyd/6ESKrUYcoCD25ANslTSTomQanjAD4q04CpjCqh/dn20vZw8t2kOKl50I0ybYbbkcr2SlON9z5FvfWEXd2xACLGQeDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr++2t1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5967FC433C7;
	Sat,  6 Apr 2024 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712378339;
	bh=5tMkE//gW8T4D2vY1aLzKtDqmFTQeetGUyWM4MQBCYQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kr++2t1rgGOxxPhXVObARmB/VZ968NtujVFgfRhT1MTA+8Nx0V+8Fn1hdVqUdrrqF
	 w9wcsZLNq2irJSayk1+wr7FwhHvAxerycUQt7+gsKKc6ujEcCnxyG0PKZiMHT8tp6f
	 ke068OGrry7tf/Q05LJLau3j2qvWlX75MI69dd4wsIiRoc/4KKUCQ/3wbLzGhRBiTS
	 GI+HaNWHEz9mQYL79DL+0uza3IeIZr7q+eIeHXkr07jzzxlM5x/75kZx0DWHxd2sle
	 M0hixOykljyYi/YA4wXo1mriV+QNhQ7CC63XLISCGUMx1XNZ1xjp+Vlm6spkmKGh4u
	 ZHCOo5ZJJlipQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 500A2D8A102;
	Sat,  6 Apr 2024 04:38:59 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240406010420.GA7197@workstation.local>
References: <20240406010420.GA7197@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240406010420.GA7197@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc2
X-PR-Tracked-Commit-Id: 752e3c53de0fa3b7d817a83050b6699b8e9c6ec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c6e47d69d821047097909288b6d7f1aafb3b9b1
Message-Id: <171237833931.11603.2621668473513492875.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 04:38:59 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Apr 2024 10:04:20 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c6e47d69d821047097909288b6d7f1aafb3b9b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

