Return-Path: <linux-kernel+bounces-104889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046E87D50E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D32B223E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093D55E58;
	Fri, 15 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJwPEyXy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7C54BD2;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535056; cv=none; b=BwhfUFAPJw1SY7ame6CcLG0n7awEi+e4RSLI6YUB1vInRrESGjIOKTSi5DpQ4+2TS9wiVxcppsnHhVqXuX5sl7z8JLoXtyEnFW/x96v+SdPpMoDKEgquxjJF391GVcYAG6Z/ZTAaSLMGCiY6BLl7GBZhAdhKbNPdXp67NGFlj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535056; c=relaxed/simple;
	bh=k/+QP+0pqlN9fdfJ0QydLQh082QFIfNBvpR1AbkDP3s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qfSSNuMtBkUsGR4nD9wLOUAxeFelNrboPDnuyh26FPED9e+ygk8bUUrj6GH7iG/MLoCr62MfacC1S3kamEwkDgf0QmNzbjq6YiQ0pk78Zr/TOl3dtHLQaksXRRTF4+azHHUKsQXfa62cZBDJ5qbrg7kTJWVLlKdqdLWoKLoITgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJwPEyXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCA03C43601;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535055;
	bh=k/+QP+0pqlN9fdfJ0QydLQh082QFIfNBvpR1AbkDP3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UJwPEyXyZLpas9fNfiCpANnRdGXsXtsheLOzfA/MC8gQL2AM6bkCnwYF7cS6vlgC7
	 0n9zTFeDmubF+9lr54V7lDBrSmvbIVPekpmF9z+A3dRMjb5EWZpohZOt7P+i4E6r5j
	 YQsLdAIB8FJVcqJYMXVjhxTk05L7rK8VRKj73MUIHwDh7cyU2lQgIDTrAo9I9f2Kfh
	 uJh3WLsVdcjDx0mOSFEPFg73smxZn3L4hy1xg2M+Gu3L7tcSMhfGsx2m0VFMaz+9Vv
	 mACNyteCvKalDfLHRmE/IcMD82wB+uHqc3HQfahrCrxcVIR05US0MfXsboeGN5bbG5
	 sfN2VV4Dof1eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C47DED95053;
	Fri, 15 Mar 2024 20:37:35 +0000 (UTC)
Subject: Re: [GIT PULL for v6.9-rc1] media updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240315103113.26f9dad4@coco.lan>
References: <20240315103113.26f9dad4@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240315103113.26f9dad4@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-1
X-PR-Tracked-Commit-Id: b14257abe7057def6127f6fb2f14f9adc8acabdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb7cca1faf9883d7b4da792281147dbedc449238
Message-Id: <171053505580.29375.6567152831261898962.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 20:37:35 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 10:31:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb7cca1faf9883d7b4da792281147dbedc449238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

