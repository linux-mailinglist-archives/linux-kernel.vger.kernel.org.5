Return-Path: <linux-kernel+bounces-37843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0283B65C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F141C23817
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536E17EF;
	Thu, 25 Jan 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmhDyFiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF4A3D;
	Thu, 25 Jan 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144743; cv=none; b=mLyqcTqBSJBYz6PztGKkfMs1h77BHz2+vU5JCff0swZhUiGohFwzGcgIGeNJgcDlsNMQNPLpktyW0B1QTVlKG5B/IsYTDcBIz58q1yi7OV98WayIiyKUaeBvVGycWjXwoQMaDE7XA+0tnKaD6PbnLS8Fxl9UOIx/JdmTUP2hdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144743; c=relaxed/simple;
	bh=uXxeq2lK0FWy+zDVwnSmuDgIdQqwKId8o6J78qK5mfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ViFutsrhynXOg4zqA+kskQj7Cqg9S1P/pvfhUJwQhB1CaXKNVQDkd8leUtS1Wyw7db/b0VQc2YPG2mi6GPC6lI/jWuF5SvBYjdBsvlTiFU07nmGAQUxMJv6QeE75O9T6KOrifL8mt6zErj/kgArllDLG4AaOo7TZ7s1OxpebOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmhDyFiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4705C433C7;
	Thu, 25 Jan 2024 01:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706144742;
	bh=uXxeq2lK0FWy+zDVwnSmuDgIdQqwKId8o6J78qK5mfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DmhDyFiIae6JTmnNCIst2saZgT3UGlMV4R3ATBf3NcOn/YN80etj3zdi6BkhQEK4n
	 VLuO5E80cgzXPjcoNRIA0FwmHOe/l3sCyd4xmaJDZwlqu6M7NPnIsByZQYhxRPTFc6
	 6XbTAiBipEhMn5fezMr6hywahHToDLXY3+XRK/lOg3a8Axa+pkSdOOBHtgw10vVaqk
	 Kxk9whh4+N4XB56ZjMReuSw1zqN0MR4QXLVT2pWss+SoOIuY7oIbEGKp+vvrbSLqJy
	 ox+C2fDRo+adT30SQDspjeXKLg5FOUjcKKLwK+EiQL+wC1IqJ/3EpgxOVYGDPXc41w
	 6yboKb95GtO/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3935DFF762;
	Thu, 25 Jan 2024 01:05:42 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <6287f771f498fc189204bd15665561c70d3ed0e1.camel@linux.ibm.com>
References: <6287f771f498fc189204bd15665561c70d3ed0e1.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <6287f771f498fc189204bd15665561c70d3ed0e1.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8-rc1
X-PR-Tracked-Commit-Id: 1ed4b563100230ea68821a2b25a3d9f25388a3e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f22face166ef6327fe5b2cab61d2a78578b94534
Message-Id: <170614474266.13085.16163274921970872170.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 01:05:42 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jan 2024 17:54:06 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f22face166ef6327fe5b2cab61d2a78578b94534

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

