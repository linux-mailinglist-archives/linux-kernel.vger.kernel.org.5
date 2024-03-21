Return-Path: <linux-kernel+bounces-110526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546D88602A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422F61C21BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB278762EB;
	Thu, 21 Mar 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgCaaBKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF4133404;
	Thu, 21 Mar 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043859; cv=none; b=ONFlygl0nVEASmVZiviSNFSuiHvJpuUdEkzc5ospS3bo8VEaOs/ayQnCTIsmuPeHbE0XAR4M9rlXQdoq1oHXdPMBlGKEmp8yp0+iInaB5llZ+IvYCC83coAjY5txsvU97mZd1yXoLQ5RdOWfH7DolGWc4JdOFswU1jABkZkHdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043859; c=relaxed/simple;
	bh=bPgkyQBeFaVuY3TjumfbcpIiP++LbPvK1F8w4xIhNU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t3aUsX5pxx4k2ceKvqVhSxFYgcWe0sKpWtbw2QaUpMbpizk786w27mvw2N+mGI1Pn/zv0ruQi+Cx7ACnpJEGy/UL7faHDSQGMye5do95iUZFWjuPmR/LWdIvbk9FKHXWMg613MzAujPfCYFWigTPViEHpmIuYHzyD0vA3VIybRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgCaaBKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00A8FC433C7;
	Thu, 21 Mar 2024 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711043859;
	bh=bPgkyQBeFaVuY3TjumfbcpIiP++LbPvK1F8w4xIhNU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PgCaaBKpIM2d3unTxuUmNJNj22yxp+QIsSRpLQx4OBv2GzohOccpIFrEnOjOIYjqo
	 EOmewhnMNowWdimVigKa8QZhKr/rP9yRAIj5f56C7DhIU9ytcQOY6CrTI1euSKZTRy
	 2mQ2m2ltYl424pdhGmIVX9+JNEQXMwaLpMX9M1lWjNHaTr2jKP2QLhIHpQtMKAsfz2
	 k1eVQDgUCxLmfQkRzAP7jKHmZyRcpken1m23KF7wMFQ/rINQ2ygWND5D1hc6Kn3kj2
	 o6ESwGwco2dPzdN229QT+z2vf3SOkUSkY8ZanYYaEiL/GYruPYarQ/6xwvnG/WCtqP
	 xZdZODffwCTxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E46E7D95060;
	Thu, 21 Mar 2024 17:57:38 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240321125653.1676534-1-andersson@kernel.org>
References: <20240321125653.1676534-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240321125653.1676534-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.9
X-PR-Tracked-Commit-Id: b03aa6d4e9a74c4289929b6cf3c6bcc80270682d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f263dda66a2dd4bf0c5d8ad6f48ab9fd5d9eca
Message-Id: <171104385893.25447.15314219291892776227.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:57:38 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Ricardo B . Marliere" <ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 05:56:51 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f263dda66a2dd4bf0c5d8ad6f48ab9fd5d9eca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

