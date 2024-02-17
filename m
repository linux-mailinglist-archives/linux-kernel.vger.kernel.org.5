Return-Path: <linux-kernel+bounces-69965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825538590E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43121C21052
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA77D3FF;
	Sat, 17 Feb 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwjgTI9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6769DE6;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187222; cv=none; b=MWjV9LaE/dGIQLbz08JIrRlCVg4YlKd+EQ8/XJ/eG551IjQdIA91mkiLB8gjAxIfgq7LGpfsdJ0s0TBC9BFuv37w1muNn/p7Ea5c31zuuB8GVrNDz0ZyndEoPJig8yZCdrhnSP9rRYoVy5torzSHEvOesimXwib4JD4CxXcZ3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187222; c=relaxed/simple;
	bh=MBgSokN7ZiPU9LhzZx4Q9Xt4H2nFm04NGskIE8WDX9w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=arsQvznsQZwip3IUacfUFFVvApqEm7MyUUBMSKT7tcuS29ZvL/wmXlW97cHCwdzjoLnd7hkq376JHEs/4+5Is9olL40JPRVM0SdjlWfLNOd4ThlFNU6MY180f1HspGOMYUfkietcXFmVELYVf9IL0KzQOD0ymQHyR9h0E3XjDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwjgTI9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C2BBC433C7;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187222;
	bh=MBgSokN7ZiPU9LhzZx4Q9Xt4H2nFm04NGskIE8WDX9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lwjgTI9ZdO0p3Djhi+1JJMdCHtY4BDSoe80FcxbMOT0hcGtuNoI6kEWj8fz1DWbog
	 4XjjbO6HGBlXXZVTtB5YHxcY9yikfY3y9JJmS3w8a/kCfl22CX/RNGwb1b4KjY3IEy
	 /JIYdQM01u6eN8SjXObgl4YxWkbyWKemed3wxWwOR+omGkvefu4gUAJ75z+eMwEl5r
	 6AEtBiXxYgQXEXIMj990svgsA+fn9b0Yn62QC7FDBH0DIns97WDvh2BcMS9r3f3syz
	 7ttXNp88gMxd6OX0ZV4QvdC2uOuHuD/FMPlhmVdBZpeEBPLhLI7CSuWYk4cPUPHpbM
	 Lhea+som9dugA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D889DC99F1;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms2_5PDfLSMJLA-_r7CtqTEchqJAToWVHV+k4WFQu9E=w@mail.gmail.com>
References: <CAH2r5ms2_5PDfLSMJLA-_r7CtqTEchqJAToWVHV+k4WFQu9E=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms2_5PDfLSMJLA-_r7CtqTEchqJAToWVHV+k4WFQu9E=w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc4-smb3-client-fixes
X-PR-Tracked-Commit-Id: 4860abb91f3d7fbaf8147d54782149bb1fc45892
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55f626f2d0c81b33552ce0e59b63a0110807bad2
Message-Id: <170818722205.7289.12984294771736247938.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 16:27:02 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 22:28:30 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc4-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55f626f2d0c81b33552ce0e59b63a0110807bad2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

