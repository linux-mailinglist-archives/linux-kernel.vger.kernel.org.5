Return-Path: <linux-kernel+bounces-126380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E72893602
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8451F21D63
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253C147C7D;
	Sun, 31 Mar 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbbtnwmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905226AEA;
	Sun, 31 Mar 2024 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711921909; cv=none; b=p/Y0v2MMPk40M6XaPeIdYfK24WtIFSqPSTj6bJLALXNs6XQkjusDt4O7VQ8VafcLcgDo5ts7bfZoCJkkQwecjC74HdpT00HPD7if4ljFsTxqsymBTtcS3gT6oPcpCjSmpynOOJZj3iyIXnoRoryrNrw+oJFkc3tU2Lkh/pxiyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711921909; c=relaxed/simple;
	bh=Oc1J7t39SKPLxzB3yMIeFILvvqwvdfOGwJ6ABt+ezPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CkNQAJmRGPgiTek/nYJvYMDAEY1tgZw5jeladQbsjJY8Z6XgZlS3e4CS3O4ZfJxk3rx+FtEEElct/TNCHw2M0vXHSBqLybcjOavK8QxEMzfEdfluz6XbS2bDQgJoxyG9Ux0YPxpwKSd9hh9yQEyOqGhkGchd57ks/OuaXjBdxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbbtnwmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59F51C433C7;
	Sun, 31 Mar 2024 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711921908;
	bh=Oc1J7t39SKPLxzB3yMIeFILvvqwvdfOGwJ6ABt+ezPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bbbtnwmjWICVKHHVUOMjTkmPLu6rybVGlqGbDeEKKNgQLBuZ7f963TA99JN2/LAiG
	 m+iQgRf1MQ54E9BWnH0gPp8tfTDYZaWeHbPphbm0MI0j7e2TULMgJgfG7dDK6jXgi+
	 DN/owfWn3OloAboo3aJlpolH8EOh//ECrADzwPJ7J7vM/+NKeU8ncJI80nqWDOAlJE
	 oaSPs9dF/m4vfvIt5uY+8F1/9OGyQiXF9qn3UalSjTOWqT81MY+8cZKYvnt1dRClPG
	 Ozd6+ayyawvi5atBlvRgNYRakMVWTTFDEV/O2aWRxTxQkuGnVZzr9aFf5TxtkpF9zZ
	 +ij9vIMx0qyPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B0F1D84BAA;
	Sun, 31 Mar 2024 21:51:48 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATTLAtXYZEfmQg8dLsu3A0e5songZrEayo3ateQ6dTmJw@mail.gmail.com>
References: <CAK7LNATTLAtXYZEfmQg8dLsu3A0e5songZrEayo3ateQ6dTmJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATTLAtXYZEfmQg8dLsu3A0e5songZrEayo3ateQ6dTmJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.9
X-PR-Tracked-Commit-Id: 89e5462bb5aee1e634a3d5bd41125809a929a486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e40c2100c87e8f11c270b4ddbe0bf8534dcab21
Message-Id: <171192190821.30761.11933117276766654558.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 21:51:48 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 21:22:49 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e40c2100c87e8f11c270b4ddbe0bf8534dcab21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

