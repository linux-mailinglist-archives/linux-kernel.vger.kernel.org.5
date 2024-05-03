Return-Path: <linux-kernel+bounces-168317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532F48BB65C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C4B1F21519
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EC7EEE1;
	Fri,  3 May 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnDWUcIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A24CDE0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772662; cv=none; b=hJAb5v5mjMzIAUWMqY9QdoiIIK/OiTEPQpeRv030KUPFDKZY2fklIPRu2+GFe8j3cVrrBcUqkz6IJ2yvCw8GcSmOqvklTwVkmC2ndrGR1NKydMVT8z0Mi5Eo+1O5kHP37MQSYuNuKYt1lYYLdGf0oS3fps+2EE4UF6mE8YTto30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772662; c=relaxed/simple;
	bh=PUzXMSbC+X5EcWRG/at4HlBAQNJNqZepjSdVbkYW9hw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mCFVCZsRH4J0nk9A4ahjNdV/8v+H/DSpA5tmSfeQquZSrNTS7ewHjilo0jWvkvwH+SU5GQscRWYeOSYA2KTt5fIEFOWCKi4r4HUfGfvhdjLOurgP0GQ1Dss+40oaZOxAOnRxEmZ/Snr+MFo35uyd0ZGOHHNXcK8Sbw4MXVrmL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnDWUcIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D86AC116B1;
	Fri,  3 May 2024 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714772662;
	bh=PUzXMSbC+X5EcWRG/at4HlBAQNJNqZepjSdVbkYW9hw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gnDWUcIB+KvvqI0jQWF+yIL6sQYUyALL1OYAkDRfTTnTmrS+TXRgg9Lsi90PpdduQ
	 hnoPjYtg/ocLBNWcyynP0kHKEW68WX0ecx/4M/PaWOW6CQQpOPgkSy9suVYjIvSHr/
	 r2P8NZd6hGs1ll4kqvYNlh9RmySa/7rxX6WgoIoZ6Zvia7yTU07usXzCF+IABsqIEU
	 aIM7o6z+/Ehv++2CpOG3o9J+0NGavF2t1w0AuAGMlFc6MCWR6WytKq0Pq//qeejmOc
	 kP49CpU40vKB9pjpI1Tg7erW9ugdFkDblaWxgQlRnRXWZBRC2m4aGYFpZKnFpTX307
	 RJYSxYZVS2o0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48585C4339F;
	Fri,  3 May 2024 21:44:22 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240503122028.16437-1-jgross@suse.com>
References: <20240503122028.16437-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240503122028.16437-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9a-rc7-tag
X-PR-Tracked-Commit-Id: 802600ebdf23371b893a51a4ad046213f112ea3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
Message-Id: <171477266229.28875.12276129093596082835.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 21:44:22 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 May 2024 14:20:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9a-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

