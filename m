Return-Path: <linux-kernel+bounces-152539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC98AC041
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA261F21050
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647FB29CF3;
	Sun, 21 Apr 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ydGVO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29C182B1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720225; cv=none; b=i9dV1gcp4WxhNwNIzqWvO7kd9xAzkc47r3cNOkLVns2ynjyPfmCyBomI0vwhrPZpXf0+hLXj4dmYdLago1ScvfDzekLbPv1B4D6k+wsKQX7xJts9qj4XgvFS/D+7wQwwYcA/OvIaGD132G5Q7XooryGQ+ETe2z83U2+BNCqL3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720225; c=relaxed/simple;
	bh=uhk2xLasHZ6rGWS4/dPJQGdMA9WiKNhYBpi9yLDT7T0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U/rbiHnNjWJulM6Yjo53qozl6V2DFGW7AxqX1SIY81B8oLw0GWkD9Ct6UMaql/vOhd6OefZ0iW0vNQguez74s1R+c+2NV+VZle8+4h6KRTx0BxVfKHkn4TcVcoMkhHPC0VszJo0Q5MSg+Q1WZKEx+LYpbS+soJf1eK5vfnWzZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ydGVO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4360BC113CE;
	Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713720225;
	bh=uhk2xLasHZ6rGWS4/dPJQGdMA9WiKNhYBpi9yLDT7T0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U1ydGVO7vm2wwIXS7JsIcPIZwikouftZSisZvSRt453kxDnVOlvvuMPKokBwtNL7Q
	 jVLsqMRUYwuKgPya1us8kgaV5CI9AixH1j4H2fwmEIdhPcDQSYX00S0BqYTIJpyOmn
	 Vus81T6qEXj8MW6qV4hD7y8i3wbEewd+1Yt5JA/jrmtNZVVZADh2iLXR8w+RNi0gse
	 8S+Me1B9jPm5YDC/PTpIGEfcj3eMPb2l8r28yOQpFYZgSWLuVjAFhCq6ZEPtIexeTP
	 WJk91Vzyg0IAtXZ5ug9rwq6agfil3xVaShpH6MaP1WBFz++jvoHDHfIJpiH6ojr8DO
	 vra1PZbOUXsIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 388C3C43618;
	Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240421084149.GAZiTRTSIBCq70LBEN@fat_crate.local>
References: <20240421084149.GAZiTRTSIBCq70LBEN@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240421084149.GAZiTRTSIBCq70LBEN@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9_rc5
X-PR-Tracked-Commit-Id: 9543f6e26634537997b6e909c20911b7bf4876de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d07a0b861dfd8a525ffb015b05648fb4065c5bd2
Message-Id: <171372022522.8168.17331718983607681402.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:23:45 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 10:47:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d07a0b861dfd8a525ffb015b05648fb4065c5bd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

