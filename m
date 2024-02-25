Return-Path: <linux-kernel+bounces-80259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76891862CAB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F0C1F212D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1119BA5;
	Sun, 25 Feb 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjiHFFz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BE3212;
	Sun, 25 Feb 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890778; cv=none; b=rNg8s2EjIycnrbDpbET1dOZx2uIaGdhvAmhalQNqs/BDjzkI5QYkfdsKhdrEPsgBuzvQj+n4Eof07CiKqY08G1skdhx+NftC25DsD0ykb3tvJOatySNZvqO1X2O5nlek5vMGllrz2WJu0viH423fFWZBM0NMtpUgt/CkBx6Qbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890778; c=relaxed/simple;
	bh=8GNhRqi7Vuh1WOHAeJoQNPHbOmC5+3e5XCSn45x+kz8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AYGcWFzS8cH6E/xNVSHge00NEVVqMmSZogOHC8vRcnrwTsMjVvZnb01toqhkZhNJhtrkiRvoW5gtp5wqwaNbpBhhFg6wqZXDfzd2UgY8RygQ3YAc98s2z+HsxGLwy0/BcNpGRRHkhUqwtFkCGH5syox5hzskQmW2gBQEmJw7bTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjiHFFz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF23AC433F1;
	Sun, 25 Feb 2024 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708890777;
	bh=8GNhRqi7Vuh1WOHAeJoQNPHbOmC5+3e5XCSn45x+kz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mjiHFFz86VP3LdA/11bfmZzefCRC5qlwyFm3jOVdON/OkAj4g3XVZUeURfoTQPrjt
	 DL4RjWg8KqctjYQuk3teil+/ZAO43OnYuYCRdPOLwBJHwVMptyo7hqIXW5d5A74QKL
	 vy2uybgSEsXFW4cPx4i3Uj/qDjGe7dO3FNFlIMZ5WWsHfFr96yIDvVYPfK9yawos2Q
	 YmuxLhXYwerdDe40y5lZovbLn8Qs5kpi5A9h8L66giQTD/hFrr1gX8byvIyRWrafW7
	 br7VLB2WHd41sjNU7t9sRhU/6h0VaqREYCYaI5GtAUh4Zmzc8NdQUw/t23CXZZSZiU
	 AAGSvl7Ony+lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB774C59A4C;
	Sun, 25 Feb 2024 19:52:57 +0000 (UTC)
Subject: Re: [GIT PULL] Two more documentation fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y1b85qeq.fsf@meer.lwn.net>
References: <87y1b85qeq.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1b85qeq.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.8-fixes3
X-PR-Tracked-Commit-Id: b7b2ffc3ca59b06397550f96febe95f3f153eb1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
Message-Id: <170889077775.21635.6225591635939745564.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 19:52:57 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 11:50:53 -0700:

> git://git.lwn.net/linux.git tags/docs-6.8-fixes3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

