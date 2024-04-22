Return-Path: <linux-kernel+bounces-154208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3CB8AD951
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358092871A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBC4644C;
	Mon, 22 Apr 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re217s3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE145BE7;
	Mon, 22 Apr 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829861; cv=none; b=tvX530wKr+//mKd6Igyjy4+0v2IFzEV/mv28OVs65kYItDZPHj1/rnLRCdhPQC/SsYwwxA5vmgl/xo56okCAlWQx7wBA8ky/zyxeGrI5o8PlgVYnjzdyE1LCVwssLbpRMk4EV2mXY9MLvyM+ae73x1FUe6fIr4RjkTuoQpXogao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829861; c=relaxed/simple;
	bh=vJSspK42O2Pamp+qaFGJFE9yyvgPgv0uqX4P2q9XpB8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J5/hsXuTA9Oc7ie/kGpFlMmCxx11uyhEYUsw3mm0cZKHaNu0Rh4UzFLBIv5tu7K9oB4uFGeJdhTq3fJJEhoSwFEkmt7lNLnLXr6tynqNS95og4a7exL9LY52gjD+DcrJSfE4ErtnNIm2eZ+O5+4tUdqhOU84jGkxE3RKBATv7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re217s3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84081C2BD11;
	Mon, 22 Apr 2024 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713829860;
	bh=vJSspK42O2Pamp+qaFGJFE9yyvgPgv0uqX4P2q9XpB8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=re217s3L1e+o6lwvFJkwIVwsnMMsGRlcw7MxBHuWh2PYlS/7Bm5U0d9LGcHsnWldb
	 YlwRr+sDGiN9XGtf6q6LvNf1FWq4Y82NlNivDMrjBUgES6w+sEw2xMv8OTkz/MB1TU
	 vf3+8C0Uft4cc3EzONWIzPzEp2L6Bl7FGo/FKV+3NJtQW54RbUu0uuSeBaO3tOgOyp
	 aVHhSU23p/fDiPvtbTYB9HyEC7FEzyO8/C3PkWgelNoOc35wFc4DFQvZq1sqwMkNjT
	 LfvStjLQWT29gHxwdHzNQEbEW48mH8KpQLYJA8bZmawtRLe6oqI00+14uNbuA2OiBD
	 e2/y5Ae0iXjsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74600C433A2;
	Mon, 22 Apr 2024 23:51:00 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt+jm0-X-zx18QgJ+Q2DX9pCkf+TQH=Cb809xTjVJVGQQ@mail.gmail.com>
References: <CAH2r5mt+jm0-X-zx18QgJ+Q2DX9pCkf+TQH=Cb809xTjVJVGQQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt+jm0-X-zx18QgJ+Q2DX9pCkf+TQH=Cb809xTjVJVGQQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.9-rc5-ksmbd-fixes
X-PR-Tracked-Commit-Id: e9d8c2f95ab8acaf3f4d4a53682a4afa3c263692
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71b1543c83d65af8215d7558d70fc2ecbee77dcf
Message-Id: <171382986046.12241.9020510940744853282.pr-tracker-bot@kernel.org>
Date: Mon, 22 Apr 2024 23:51:00 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Apr 2024 18:20:31 -0500:

> git://git.samba.org/ksmbd.git tags/6.9-rc5-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71b1543c83d65af8215d7558d70fc2ecbee77dcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

