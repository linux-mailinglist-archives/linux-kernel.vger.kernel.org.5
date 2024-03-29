Return-Path: <linux-kernel+bounces-125332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9072892434
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B17284815
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500613B2BE;
	Fri, 29 Mar 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFwIV/nS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA113B2B4;
	Fri, 29 Mar 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740455; cv=none; b=MAUjmf5izrnWqS8gfmfIhe8/IEdO0wM795jyKimzVa15s5XbCTfJGf97oHMq7Ev6zttJY6PGIa+mORxhXAO1lZq3mqWOg9QSiZLlzr87tHn+e0GVcAhQBUITA0lnHrPdPr7J/zLDGjJ1j1Q5htXhCy7WhMI5UFiidD6PR8HjF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740455; c=relaxed/simple;
	bh=S9dY4WP0fK0BMz9iS3TlhNnapIBQdRMrizgtaJFdIr4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jQiP4rg+ZJGZPe5YdHGZDq5fpBidX0cu9Deji/LWYEUiE5E60de5biSfwfze122DizdWxMP6itMrRxNHIW2GoVa7unlbllN0BIP5/vjC36FvoiVSrkIv06In8OC9mGKO9STji+LaPmoYqBwrVcQeXzyXuke5dYMi9u0bPOkddIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFwIV/nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C4DC433C7;
	Fri, 29 Mar 2024 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740454;
	bh=S9dY4WP0fK0BMz9iS3TlhNnapIBQdRMrizgtaJFdIr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JFwIV/nSUo5L4nRpRpc4ITo3ZRw2dAva0AD1QiKmgxujnIiXX2R/rmbFfAPOgSoox
	 BApDb3WzpkKFz1CHpg+gieZFEilrNQ8SJKq/J3H9qGwssN5e7l2uXF9Nhv0tnlcSgd
	 RzvFDyzLaK0UyUDAr4T5+8d0BHK9tjP8k4jayL5jbeaHXF893jtBxzitP951wLCj11
	 B0GdSzXpZsLsZuVYS4025o1Vrv0exF6b+8Fz2MogF6DdRf0e2Ucfw2isbw5myfDD56
	 WuEW8lfwbW/MGb93WNn7kqpmfA4ugwq+jEVsj7gO1rPMq+w8zA/kt2UFis8YqRmU5s
	 HNLpRLbxrNh5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C944ED2D0EE;
	Fri, 29 Mar 2024 19:27:34 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msjPvJv9-aW016XACLRDQtW2JC9EDnDXbYYMz-wEObWqg@mail.gmail.com>
References: <CAH2r5msjPvJv9-aW016XACLRDQtW2JC9EDnDXbYYMz-wEObWqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msjPvJv9-aW016XACLRDQtW2JC9EDnDXbYYMz-wEObWqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: 8876a37277cb832e1861c35f8c661825179f73f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 091619baace558cff8b6dab919294f991fe8e182
Message-Id: <171174045482.16736.4598670003248227805.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:34 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 12:05:55 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/091619baace558cff8b6dab919294f991fe8e182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

