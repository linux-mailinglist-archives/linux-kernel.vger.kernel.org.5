Return-Path: <linux-kernel+bounces-50573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817DA847AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8CB1C22406
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55D85954;
	Fri,  2 Feb 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcfYMRnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5DE8529C;
	Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907622; cv=none; b=qUOrdJS0d58/jY0bHG/stGO6R9lSPKC+/ohY0+OVT+ulVQoOwulra2hDeCtvhTlUo6K436yeUsTTQiqXPQ4gZxgBLyIcnatdtSaNVgZPeu9L+sZgPvwj+gHSpKefcNQaG9TiK63cp2x0bBQLvkBK1nkTWbixT1+35DyqTxZgckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907622; c=relaxed/simple;
	bh=FlZPkuypdfuwrjUc2hLFLkDIP7we5FEPKOdm+n2I0aQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RXI8INR2VdTT8MNTqa0Rh30u6ysh0rdXWJzDflaqP4h5K5jsA2XvSv41ztvfIxnuZukraGR3RYoZ8cEOG9oehzSZN0Av++l76nSBtN5A7Wkb7En/rzDFRbCaxj6rSMiWdHD3nztLoJxn9HlFBhBvyHnVAs1G+Yn4h4oI//GNk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcfYMRnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9AFBC43399;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907621;
	bh=FlZPkuypdfuwrjUc2hLFLkDIP7we5FEPKOdm+n2I0aQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GcfYMRnSKC/bmvhfnTnvG+ZLHDPYRylIAMa5q7MJcnbezKb7mt7aPCGMIvTIfClIc
	 v5dw0JQfueOXx6KflmYz0dCkZc13eXYjwR4S7B6EAZCBfQpMl9z4bcFYxHcWfJQzcD
	 dcTIeuLCQJyvp5Y6HTUSMhxlhoYsFSpXI4ngKbSrOYd/D6KFWuyRKIC+xYUgg7LS2H
	 8uww7101Ns+v8B8oC/JfT4QfHJklZQqPc/59YDnGmFNg5YK6RKLlUj/YJydOyTlK5k
	 13XpljKPgC+0MtNp4/DtBUSCYCBKNAIeEgPtQdZTLihuCZ63Thxhjsv5CZOP1xR7Ep
	 5DJz4gmezdumg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7894D8C978;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zb1HxLM3Vs9p4MiG@google.com>
References: <Zb1HxLM3Vs9p4MiG@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zb1HxLM3Vs9p4MiG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc2
X-PR-Tracked-Commit-Id: 4255447ad34c5c3785fcdcf76cfa0271d6e5ed39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eab5c86d2413dd92fe94a735673141e8ee873f7a
Message-Id: <170690762181.8980.2833397204010608676.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:21 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 11:51:32 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eab5c86d2413dd92fe94a735673141e8ee873f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

