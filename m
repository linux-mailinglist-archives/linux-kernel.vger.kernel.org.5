Return-Path: <linux-kernel+bounces-29395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F833830DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32211C21C83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378E28695;
	Wed, 17 Jan 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBMb4GgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78392562B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521832; cv=none; b=tmK8w83U3wntYAgclAgmp1D9YDTJJkpim8FD+TTDP3O0GPEqdb7pn+L1LhR0T2MuhsL/F9C0ADUGfoqljcBv160HEvjFXCdSO9M7mLJ0NNxa+2VLgiU9r/OVUBDmSOmqyaG5lttxrQFV/kLXmeb+2X1X1jlZVdMYmN96fBU70ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521832; c=relaxed/simple;
	bh=xitC+Ek/KRT05A5Cyy0Bf+rJEufXj43pjVj98b0DuDA=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=pE8x2qMQ4vcKkD7jfT1d6raRFwsExz+QSJLPKcSwuDsnCZ2Q8aMyUwb2xIgjDVgINjtqul7n07R9sB/TnAQrlrZwk0fZrtkFq6OuCHKDCotvqY1tZzoGLy+CWmFkx/qpX+IfEg9QDU8EoWpsdScPm/tvJybqhTH5S/KtZxm6qRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBMb4GgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F95BC433F1;
	Wed, 17 Jan 2024 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521832;
	bh=xitC+Ek/KRT05A5Cyy0Bf+rJEufXj43pjVj98b0DuDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vBMb4GgNRXzPQWr7UAyk5yTRiNxWH+Sjzx1ysrgYIMC12rudiqJwqyHeh/gKCHS9H
	 MC62GYCoYG1HLTXlZbddVMU1nRYPdfovUrRE5K90SxI7NfU23XqoS4CdOViQ3tQUU8
	 vp7fE0V2d1bp0PH+nQ04qAGDbkLRud+isZNDiK31v6yFOUFwfh6LxC8PnPJ57RzXyM
	 pBe1Ho8KDIji41fwE4zmAn1Vfat4n0KIYsXF06c5jwb8IKBqFtFPIPLarbNMRKMT7k
	 y92kdeWtnIjftiOIg0OTSr3d+7FZJJMZGxRYkvqr1+lnMviz45UqApHeUEML0etwEZ
	 6LlUhlwFMwoRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C21FD8C96C;
	Wed, 17 Jan 2024 20:03:52 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1338470076.231558.1705178301103.JavaMail.zimbra@nod.at>
References: <1338470076.231558.1705178301103.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1338470076.231558.1705178301103.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.8-rc1
X-PR-Tracked-Commit-Id: adbf4c4954e33e623897058a617c583d65a177f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c6bc37255927cf2e2cfdd9dc9bd1eced9c166de
Message-Id: <170552183250.2985.633302158236120005.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:52 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jan 2024 21:38:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c6bc37255927cf2e2cfdd9dc9bd1eced9c166de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

