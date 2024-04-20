Return-Path: <linux-kernel+bounces-152351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C198ABCC4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0D2817EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85347781;
	Sat, 20 Apr 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1REUE7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2429446D5;
	Sat, 20 Apr 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637966; cv=none; b=dSkuqWfg6nRE3lWaf0cogVacYCU9CJNnzDtRvNiu2SqWLEiCMRs4Lb1TOHGC5tzM/FKwV4dmWEmim2nZPtE7SfcmxSE3H6SHZSZdRn8R4dyI0VXfBroBjkXCp9U2+ysijOZCtlWmjm6Fnwd5wRFWvmlpIp0ELp5frtOmt1JRjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637966; c=relaxed/simple;
	bh=1RlqtRyXnSTSoyBu177PHHmjjSSsBh2+ul4eByxZ23Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bD7Ijd5Na70vd80KmwkjuqT0lMx/+d7ACkYYd/StRuiXlEpMlEsLLhSSpRLnfycFdFxJw2nmVdWl7le8XNY6ZCcEEz/FI1g8T0KnnylIYe/pNiUzrpUkBsHe3YAI8kvVHEeM4AEQbBos/7v4zpYYZRFcOXuloPD+3h3OZ3z/qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1REUE7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90DBCC072AA;
	Sat, 20 Apr 2024 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713637966;
	bh=1RlqtRyXnSTSoyBu177PHHmjjSSsBh2+ul4eByxZ23Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W1REUE7UZYiYsNtxH2gaF6aMkLhD6pEuz4zTR4mMfqY+5AAgvZC5ocn/YY80Ob2Yx
	 zbfHV7vwabKauPOwzmIc+zdInzNJOdswV7CXO4QvpvTSdzLULPMNg3Pu4DcRnEYeV1
	 DFJ5uhAu1rc3vTafxrwdas53BThKvzY0sPZS13i1dRnaLQINGWr2TU+BtdopX8+DS+
	 YMQrMyJMgNvIyWC+VhjBhWS46MZXwNaUnvZ0t/aJb8yjih2EAJ/4pLcLY2xmeV3aOu
	 +5n9CBkDH5h+qrBrPex0ah+ig6HHfp/mztb/3btUGfYQcIVBJT+0mDdXxmK6ZVNJua
	 UOqG+/Z/3YhbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85F35C43616;
	Sat, 20 Apr 2024 18:32:46 +0000 (UTC)
Subject: Re: [GIT PULL] MAINTAINERS update for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cfb963420b1848bc2259ae3006b49106b9ae02d6.camel@HansenPartnership.com>
References: <cfb963420b1848bc2259ae3006b49106b9ae02d6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfb963420b1848bc2259ae3006b49106b9ae02d6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git email
X-PR-Tracked-Commit-Id: 366c5cec9ce473f68925d703a07cac56e1d16956
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39316e5fa94157ac1eb481c762d1e688b2f08138
Message-Id: <171363796654.22086.16415349441654723351.pr-tracker-bot@kernel.org>
Date: Sat, 20 Apr 2024 18:32:46 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Apr 2024 08:52:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git email

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39316e5fa94157ac1eb481c762d1e688b2f08138

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

