Return-Path: <linux-kernel+bounces-62462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2485211F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997641F22F98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE84D5B4;
	Mon, 12 Feb 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIa7InYR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C944CB22;
	Mon, 12 Feb 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775993; cv=none; b=UxMDzbjGCsihfYSl7c7OP4+38WC8scJWA5odMVyflAWh0Pt2EEyea+l8DD6W/ElPXBih9MSLvz++CRuiZaB8PTXve/bzyLS19JQfc125160I7DUPZ8BIair26Xjpr7OIoTizw72OnITJ/EK+YCXIUp4DhU65tfqhwScCWGR9oVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775993; c=relaxed/simple;
	bh=SDBjZNJSlI8khI3Yh6gcu+kDznObYoNuS98OzSe2xJU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k3pvMXN5+ZRd9n2upB/dvVXg5R8XE0x1mUknG7OD/7nlbRaJDsZQ4E5pwr+1vmaRjbsfca7+4ewiiKV7yA5vFJjISMsccDCiZZojTHtie4kCs8K9w03YQ7u8Z3y6s5Vxnhs5w+CRfNi+dlE9u4HvouceLZE7rBNbc+VmLr2Uzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIa7InYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FB80C433C7;
	Mon, 12 Feb 2024 22:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707775992;
	bh=SDBjZNJSlI8khI3Yh6gcu+kDznObYoNuS98OzSe2xJU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GIa7InYRLQzvrXGcJxZgKiIJCLzr+F4TEmg+IEb2PY24ZOUhrESnD6EzMxbIAn1g1
	 YjMKiItzl1OnqKbYNuEu5N4My1E763yl+EZJDo4/ppjJMpEw3DqhtZWfqJr7FVfzeE
	 QI/EiVlkZHuDhy5/ilGqP4Ulb6sr88uSlZFvO+es8UywHjg9ulk4d1oZv/9tUvKws/
	 Jpzi8TsL2JwNDlrdC/kR/WQWtC3c3Xwv2kOxb92hMFjhpqgYkqCOfPvDFbSvHYQhIG
	 w/gos809hPOEkHgQXfUF0RvUQjW8tAp17FJ9nWMheCz49ufEyXp9LayHa4CpKS28U5
	 UtdRFO0QmhMnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A5E0D84BC3;
	Mon, 12 Feb 2024 22:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fix for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <871q9h8hz9.fsf@meer.lwn.net>
References: <871q9h8hz9.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <871q9h8hz9.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.8-fixes2
X-PR-Tracked-Commit-Id: c23de7ceae59e4ca5894c3ecf4f785c50c0fa428
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
Message-Id: <170777599255.5978.8885975399696872697.pr-tracker-bot@kernel.org>
Date: Mon, 12 Feb 2024 22:13:12 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Feb 2024 14:56:10 -0700:

> git://git.lwn.net/linux.git tags/docs-6.8-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

