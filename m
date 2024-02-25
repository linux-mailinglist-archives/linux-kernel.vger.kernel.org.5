Return-Path: <linux-kernel+bounces-80240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C9862C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4F1F21488
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7E1B7FB;
	Sun, 25 Feb 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPmzk/2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61077175AA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883879; cv=none; b=koeo8Dbrm4/0oPPzAEsjRnNECfGqvuYTgZxCEs8JMHgILw5JnCtK7lo7ekd4ASK1a4YPcK8Re93ARKyA3F2PDFKiqFUne5CirQKqQ1SyXBDmazHylJJDsVDaBc8Cl54OO5A/NRD0OL3zkWez1yCDdc9HF14mW7V9jINmC8Fy7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883879; c=relaxed/simple;
	bh=Tlli2nQbyZyMNmz5Q3DJIVV4D/y6FRnznxHtHXDK99o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t6K931FVCb/4fY6vPBsIIreW/qedfW8Y/XlTXIYNQdDyjLoB3KStVqBwIG18N3o4k6+dzj5srz8YaKsn62VDyEfb1yGig5FfI+3JlIBCmE1uUQN9cvcGvgRAoVQwfrGXz4HaTsiP3y3obKQmqZR+IOLu8ZZFX7e/c465uYpfiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPmzk/2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D868C43390;
	Sun, 25 Feb 2024 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708883879;
	bh=Tlli2nQbyZyMNmz5Q3DJIVV4D/y6FRnznxHtHXDK99o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lPmzk/2UF0F6JSPrx7cCffW0nBZ14t4lDZMtJc7upuEJXe49AhXs2/Q7U2BVl66BD
	 do1VeaTxmrROyX8dGNZcLRzM04A5YSVpGbpjDQ8mp6JucfnC4+9JYl6oFcdvzcAQ4+
	 qLne/k22u8EUvBal14MExsh53Q+6ZP28tPN2oOUonNz1Uc4AfThJUIuIuyFVfY1D07
	 1jYRgNRpK9TD+x3nD8nf+Kn0hcR79E5zCJwfNMF3crrAXcIZF5Ag8BMWVHuUstAJ9h
	 YJg8L4M7tA3hZTd1PmbO1+DHb+XZHxL+3RvbKeqyb/N8WmNTuA4nThbnGrqQSh6ueF
	 sJrn+wfDJDlwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B581C04D3F;
	Sun, 25 Feb 2024 17:57:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdtEwtN2BsCYnCeY@debian>
References: <ZdtEwtN2BsCYnCeY@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZdtEwtN2BsCYnCeY@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes
X-PR-Tracked-Commit-Id: 56ee7db31187dc36d501622cb5f1415e88e01c2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ca0d9894fd517a2f2c0c10d26ebe99ab4396fe3
Message-Id: <170888387916.1439.4286947576052324363.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 17:57:59 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 21:46:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ca0d9894fd517a2f2c0c10d26ebe99ab4396fe3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

