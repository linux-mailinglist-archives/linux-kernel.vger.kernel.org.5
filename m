Return-Path: <linux-kernel+bounces-159074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E348B28FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0684B1C20E49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FC15218A;
	Thu, 25 Apr 2024 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfbmZltV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CB2135A;
	Thu, 25 Apr 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072963; cv=none; b=EaOn0LCPtfJCBvZd9VYZpLFZCp9aRbcBEN/GgyZPQLcku9JrWgX+uS7c5i2WLEhYPmo1DMDV0rgtFcuSF7BlaelG3tAQzca1+n9Frhu6zEHSCPxpi7aGFSTDKWHMYt2VRTrZWOjzfP1I6R15uBZKT2ax+wqqSS9L+D362qM3m/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072963; c=relaxed/simple;
	bh=cz0pPDYjZArRjw9lao7XG6kuE2hfIiHk0HAq9oMYnJY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z/N9lbHSsX/DPUZfZQ9Be4Xay/rZv2GhqSGh5Ugbr7U3g1k4aalp8/cn/hMUVTcZPf/Xmg3lsMWetiv2D4QIcMeInhNqme1xKE+z08InSPvHUGNTsxCj94kIffk5mtz3T/Yfat1rs0gtroJV64xX6NOEGaqFTT5lKdurSfZ5oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfbmZltV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F51FC113CC;
	Thu, 25 Apr 2024 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072963;
	bh=cz0pPDYjZArRjw9lao7XG6kuE2hfIiHk0HAq9oMYnJY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EfbmZltVd/6Xs3J0ovFlHc021f2OHSjBH9wWhPrHJyF7yfJygFE/UP0V8Vn/QyQ7Z
	 4E0KfPTUSkHpn2IdVlB+8d8JwzmXPiWggGVDCcZQoB5iDyVsfFHonlctjj9F4Rf/Cf
	 xqIDx58ZTJKFDZnkvYytv40/CUtnEir4OrICXvbck2fG5upX95Wy061Ia/PzkMO/p+
	 TdDLftnHf/aDkUB55ihrSPG2Wj7ebh70fPdUey8CUrIVgGcJSVvXDSSK+LRYN76YK1
	 uSt8W1AJsqWzh5bHzZqacZbczJzO9YaWskUxD+348+2m4RLNXpbPI9xkWfirnSjVb+
	 rvNQKa5QaDlVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DDEFC43140;
	Thu, 25 Apr 2024 19:22:43 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc6
X-PR-Tracked-Commit-Id: 2ad984673beef7c3dbe9e3d2cabf046f338fdffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a93289b830ce783955b22fbe5d1274a464c05acf
Message-Id: <171407296350.14238.4863038391831730239.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 19:22:43 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 19:45:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a93289b830ce783955b22fbe5d1274a464c05acf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

