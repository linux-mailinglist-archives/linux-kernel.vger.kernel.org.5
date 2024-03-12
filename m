Return-Path: <linux-kernel+bounces-100879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46489879E88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022FD28542A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE7145FFD;
	Tue, 12 Mar 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDN/I/Fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D1145FEB;
	Tue, 12 Mar 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282255; cv=none; b=MSaPMyeCI79s02GJcGti9OpMwIFm4PToUp/GVToWqt/tsP5jDmyzkXVp0pHtUIYJ3MbxlkoDaa7kXEDm/FYDmk2iU7SaZiW+LhXZldnXbuCdzqUkc6PlNSRwdsrUV/Nw5fR6AGqycu3nw7DX9gRZ4EsCVotbhLdKdah67mMzx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282255; c=relaxed/simple;
	bh=Fnc3Kh2clr7qNEHC+bUNdgBBTjmw15Tn27e6GU21G9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AJdjtg43J8BNDbs6M2iky4Qn+v1GhFfOoWXJ4kl0CEXYsNYSgRJBMR8R8zM9b3MWXLs2wo7Og4ly48Pi7PeICadkvQH3wogluZZ7IBMLZuR8Oa2ETgMJDIJ1RHMU5UoeBcI58CG/QRmXt7b8TuEK2wZ5d7pIygMpMGVBt/2DCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDN/I/Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ACB4C433C7;
	Tue, 12 Mar 2024 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282254;
	bh=Fnc3Kh2clr7qNEHC+bUNdgBBTjmw15Tn27e6GU21G9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sDN/I/FxyLmAC5i8FX4JR7MFo9YdImr010te0mi7kFkdoWyguckZKMXaRWylpRyTM
	 67HN6HM2nK68dgcJikw6MdWI+C5zKoq+JugH8LiMzdrhMwCBtYS4tsdXyEzle5Sdys
	 rEa4qGD5W/ET4Cw1hin2/4CkKXqd0MjFCCUElQ7Ue8oIVjp6d6wrMp7nkNIA46h1Y2
	 V2vdDLjmPc8Ikik0VYYeHhH9SQjcVmqdUx4yX7bDzA37xxRx1zLSm/yCluNDIdYB2T
	 +19GhavEdFhiVlx8SoUNwxy5jFvbPGyLnTWpBqzLzPQVNQinF/81alascnrmFEsj+k
	 FSTxWEYczRTwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69933D95057;
	Tue, 12 Mar 2024 22:24:14 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <87cys0hi8m.fsf@meer.lwn.net>
References: <87cys0hi8m.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cys0hi8m.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.9
X-PR-Tracked-Commit-Id: 0c8e9b538ed7ecf4159b080ab0dafca3941c69db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f440397665f4241346e4cc6d93f8b73880815d1
Message-Id: <171028225442.16151.89890456111229173.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:14 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 09:59:37 -0600:

> git://git.lwn.net/linux.git tags/docs-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f440397665f4241346e4cc6d93f8b73880815d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

