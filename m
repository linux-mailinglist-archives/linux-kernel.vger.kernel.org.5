Return-Path: <linux-kernel+bounces-97749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BE4876ECC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EEC28261C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079120DC3;
	Sat,  9 Mar 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuPUcrl5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A111187;
	Sat,  9 Mar 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709951039; cv=none; b=p4eUIFT8P8ZMm3H3lkCCNLE3iVsXpejCJj1AGxNJh5LAnjoxY7sacXnUWpIfdvDvXjFgWXtL/M4HXqeLgc2PgYwpBFzUhgxY64aFZbnuuH21a1/5H6OE0IsxOxWc4MRt/IxbD8CwXvIoT245xXDqqQSp8U/PEqf091D9dQ6X1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709951039; c=relaxed/simple;
	bh=iSmAGuLbJhm5b4Bu6X4d/jOW0QLP41BZaDHV8Vsi1vY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a0y8X19Lwd6Kvlgj78h8g4xSXzxyApLuXwMQ6DZVYOthqghl3h3wFoJPrQ/uS8kSzMD3ejI9JJJrqS686dZC3EIxuZzJJKFc+ajMBb9wKY2urkuVDQ53RcOSZNQqir855LA8xacAQBX+vUwmY+3Ni8+sjQMdxmBXQAsfRcCXK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuPUcrl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D298C433C7;
	Sat,  9 Mar 2024 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709951039;
	bh=iSmAGuLbJhm5b4Bu6X4d/jOW0QLP41BZaDHV8Vsi1vY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZuPUcrl5gwgb8b0lghlDd2V+htFEtlbIND4RwUEpTkbhH9oMsHVb688xHK5rgrnu9
	 9B9aAPTa9pn4A3o6q+c8grviGONXOg+KSl/9QC9xS9LY04ncOBq6gGEpaQONDA2Amw
	 AN2zpw7s6I7Mh6D8OApW/0iJHRQPkmBZej+PQMUiXIPd5v3Ick9UZG29Qt5xyjVVsT
	 QOL+mrPGDvBijyeqvS5OXLHt9Lhvi0/gwg0e9jtMsuAUTd3xmEt0tX3xf7aOuC0Xt0
	 YsUNp3Nfa1+jN/GeQ2xvifKtxX9BJR56B/tuRV2NkG5fvi7Akhdu/+kC4YX86PxvEz
	 /aZWBgufy7yWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EA4DC39562;
	Sat,  9 Mar 2024 02:23:59 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308225519.2098316-1-idryomov@gmail.com>
References: <20240308225519.2098316-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308225519.2098316-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc8
X-PR-Tracked-Commit-Id: 321e3c3de53c7530cd518219d01f04e7e32a9d23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09e5c48fea173b72f1c763776136eeb379b1bc47
Message-Id: <170995103911.25885.2822617709688513134.pr-tracker-bot@kernel.org>
Date: Sat, 09 Mar 2024 02:23:59 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 23:55:14 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09e5c48fea173b72f1c763776136eeb379b1bc47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

