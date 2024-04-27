Return-Path: <linux-kernel+bounces-161138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946B8B4783
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6564128252A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A8014265E;
	Sat, 27 Apr 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdspbK0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8263D552;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245428; cv=none; b=LUvaQ/eNp4CS5FejZ5Sq10V2O5bZZYtzJRl03rcUCT+WggLiVGRSsxeOJD9pWj4enD7rWSY+6moRaDSvP57ftrfSZxBhOrg2GRqP3Fs9WiwHs/t5bG/IrOzKsoD1a/bl7SIwiRMKeSTATJYGzUB4o0eYmo8cpzOo5MAmpdK9spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245428; c=relaxed/simple;
	bh=DoSKC03hXw9doVnbnH37N6qd0TYJGjLM/1MdYDUddGY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MUV3DCHhDgyKtkTkYMLVFzCNKDWgYTAdHQ8VhE2zivwvSakDiLiaFxvR51eXulLqKhNpfuEvMZcF6b6zGlbJD248dwyL0mSNTbjvDEi6IvVyz1NALOgPuFE3zNSKrLMIilsDixEohpgTGTMXxrnONuyORuMa/X1juFqFYp8xSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdspbK0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F209C2BD11;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714245427;
	bh=DoSKC03hXw9doVnbnH37N6qd0TYJGjLM/1MdYDUddGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CdspbK0E9wwhP1i4uIDvHEUUWshnPbQyKsUNSMov9AW40IQ+ByGhQMpvz5n1N22QE
	 qMQl6ChHhGkuyqScKKgLuDnrE7jt1tKcQsS+gBX7yoJXy9/e1efT7Y1kMOFHzRmHNF
	 d9vVuGlQzcD/QNSXU9kv/O5/M6is/lKrIwG6iuDZedd63eKGARDvtY1P2nfusepMlW
	 KhZQ+i9graef8Cu0t5MwFswOTrSq7EqBDoiXSaeby6dHF2y9QZQOItvknTDQtMrksP
	 eQDddY5jgz1YRsC8VVgwqzCbA0yBIfvGVaGEW2KfcK3KhcJ7Y15c2J62fq4t+AH21d
	 6LwwFEhpwnHug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DC78C54BAC;
	Sat, 27 Apr 2024 19:17:07 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muJvf713EeXf81FaVyU9mA9bqLAgXLe036aCHbYKZ3ZCw@mail.gmail.com>
References: <CAH2r5muJvf713EeXf81FaVyU9mA9bqLAgXLe036aCHbYKZ3ZCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muJvf713EeXf81FaVyU9mA9bqLAgXLe036aCHbYKZ3ZCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-cifs-fixes-part2
X-PR-Tracked-Commit-Id: 8861fd5180476f45f9e8853db154600469a0284f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d43df69f3879f32fcc08d92ec47bff86ae0fcfaa
Message-Id: <171424542738.11751.737453055546020366.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 19:17:07 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 11:45:04 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-cifs-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d43df69f3879f32fcc08d92ec47bff86ae0fcfaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

