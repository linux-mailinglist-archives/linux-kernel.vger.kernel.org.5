Return-Path: <linux-kernel+bounces-104892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B687D512
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A2B22A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DE57334;
	Fri, 15 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikjBjLa5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3DF5644B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535056; cv=none; b=bHOweXmxtGjYGuXYinJte1H5IT3NNcGwbu7SQZRhhiSGlybUpztgx7OnoQrlwS0fdu+z0pep4wRhYvArpBcTLnvUCHzGzJZqXF/yf9KfHFru9umdn8jp1hHZ0uGIrH9+0fGBrMaCKVsqTRLP/imZSVsDjbvOsM3lcva3X5QBpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535056; c=relaxed/simple;
	bh=9oYJh8a/kmvmImXjX9c3NKiWZzK9nX2jU763jQM5mkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fy7T2mCIgL3XPfFfYwScva76mwbYyKDKzi5FUTawA6/7De6f9ATcL3kp2+sLqBFVlUou9i6NDSrqWDj2DwAXomrdRMQDRY9PRxxAcGJ416pMGH8CesczZwGh+1yQa6t67gBZI344XRaLdbnZr3TNFDLFQ8FrSERD1wAWL5rFqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikjBjLa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A92C43399;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535056;
	bh=9oYJh8a/kmvmImXjX9c3NKiWZzK9nX2jU763jQM5mkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ikjBjLa5LPJ+yZ5vH2bAFMBu1xE76K6bjX6CdhNnW+2zqd/b9AygyGy43NLR+B/vM
	 CJ0/GsEjl0QpnKjDQzbCYSnU3bLAHtKaWdgnNq6fZCK0cyJ2Cf5l+DlL/idLlnCwn7
	 rkIMqmsDrwWtms/4TNKROAQb/prPW4q7vE5IaXmer+1Eq1zxvwsset4dw1G+jtX/h9
	 sVaIZdgyz+BLmaD2NJYoRQRIJbXo+r5aHACw1nZkCnfWHHazcqLOebhoifONHBdqa7
	 iN5ytBiPJEWbWakmTu6gxhA+ncfDCwRW0iwGRabtS7eqopfdsKkCfB5fKuKvlpm2UE
	 9xp9w2RCp68JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D93CD95060;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240315122128.42375f32@xps-13>
References: <20240315122128.42375f32@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240315122128.42375f32@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.9
X-PR-Tracked-Commit-Id: 09888e973cc9d3615dbab5d178eecb58d8a0b7ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c5d127fb5aa96e89875fcc92182bc1eacfef3af
Message-Id: <171053505664.29375.10501046435385123737.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:36 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 12:21:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c5d127fb5aa96e89875fcc92182bc1eacfef3af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

