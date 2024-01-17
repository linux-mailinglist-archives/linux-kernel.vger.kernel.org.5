Return-Path: <linux-kernel+bounces-29524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC94830F97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BD2B21B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4428DB3;
	Wed, 17 Jan 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGYk/O+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0311E887;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532295; cv=none; b=POPtyV8PWfDBMZkpkj1CqQR45j9oii25ed+bwNXpemmpJdtkpT4pEz2wWXcicTDfMBXWL8T0OJ4t/TIZuGnn5ZwRx8yNIeWsACJ5Zt8B8Qvx4ZdSZrFib76SUxBJddMxy8MXe1MNA/U7E1n0/ga0ZXwVPHVNIpRhXl99LR11ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532295; c=relaxed/simple;
	bh=Q7R5C6ZR8jmFPH3FzxtY/87JnSAImBiR+/MgbD8kCfk=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=Mie35fclzLYHiD7RjWsxVSAQ7goMVg7pGliw1wemndxHDuiuzqyKH45Y97Bk1OW7nqae1VVur4BNKFScnkZXtcoxNHGdh380yr1pK9J43BlXkw5+7smcoWGlvzxbat0Z1B0HFODqoNq9TBQkSbALiFkr/Fm1SiJIhZDvXrnuAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGYk/O+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 932CAC43390;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532295;
	bh=Q7R5C6ZR8jmFPH3FzxtY/87JnSAImBiR+/MgbD8kCfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eGYk/O+yYD8ZGkkpd8nrexVVMOj8oh2sX49Xgsjj1bLLbN0O1MghsLFV0xI32dRW8
	 LI/hHJU8X79VfJ8pSH/OJlDSqea80CF3Din5P3I34J8m92vRnLTXtnY36Ug4iXzJoo
	 AkG5SQUw30CDhJLnTQlsXC8K9n0Abzga4/eTQ4R+bgCLo0dtGGgHi8ge6KnIF7YVF0
	 WX9tEQV3NTby9Y6R67J+nph3KgxNStKiR5paBZzB5w4nhMbpkfvk83/5tJZzYRSAsw
	 2xqParYSIWed7r9GVXEBNDcT4Tjvoy5QAUylobebXCQlv1+IBqJgy6pW5uFypqzS8n
	 jmNm+xD4wrZIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7893AD8C97B;
	Wed, 17 Jan 2024 22:58:15 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j6AXAw2igWvHZN+GybT1pgjkg4_tDVMZwLEbuj7zHsEA@mail.gmail.com>
References: <CAJZ5v0j6AXAw2igWvHZN+GybT1pgjkg4_tDVMZwLEbuj7zHsEA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j6AXAw2igWvHZN+GybT1pgjkg4_tDVMZwLEbuj7zHsEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc1-2
X-PR-Tracked-Commit-Id: dd75558b2d0b5e2b36ec0ef7e494d2763517d801
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8e6ba025f5e45cb0821298919b0e07130cef877
Message-Id: <170553229549.5987.13279493776083203202.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 22:58:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 13:10:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8e6ba025f5e45cb0821298919b0e07130cef877

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

