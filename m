Return-Path: <linux-kernel+bounces-93009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD287295D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70B01C2234E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9812AAFB;
	Tue,  5 Mar 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+u7+Uip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7B26AD0;
	Tue,  5 Mar 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673919; cv=none; b=RFEVFLLg+TvnnmW1ixfd3WcmzeP38u+u1ddkaomJmTF/KbPXjoHqQV5x3olmvANWkIh4AV/jkjXvalDo6oEHSvz+4gon8bP7Hyy0tdBWpj4MBPiIxPB9BwkEG1/t6Wzsw7rad07iW9WS2XFiiq3lhAk8B/IoMCgq4XNLJsbY3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673919; c=relaxed/simple;
	bh=KoWPYjz9mQHxw1FLKmnfDuBzXbSrn5K2dOrc5yDuI6U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a9GwSjmVLRrTwfjeE2ywpKqhM5DSH7kP89FE3FsXZz2l+a/l6EDwq9hVujP8BJAXHLDPqUKa/f/DbYl8hiHlURx3CkH4YePh4Qyy8XB0V4nEqFwbqajfH+huw7WWQeff8atzSY5er7eHye0q6Zh+QiWsdoMHT5FudWepS3z72II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+u7+Uip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31356C433F1;
	Tue,  5 Mar 2024 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709673919;
	bh=KoWPYjz9mQHxw1FLKmnfDuBzXbSrn5K2dOrc5yDuI6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o+u7+UipsPozteiEOgLhWYUa3aySdwPkR4xU0M7rx4jaITct1sEOb2cnrHxL8rJFH
	 N9HQyqZgXzAnQUfEAV1qpVeR4vP5/5HtFozEE5E9rTdh6hXtRVqD8wsG4h6BRKlvhK
	 Kef7/8aSMFTmqBACqIJUjodUj3vhwPF62EkqK8mfBHPNcfog5I5LPzYpMbVqjAIHl6
	 PoXKX7OwOgPUvjs/vsf51UJVZeSN0JFjS+izjh9I4DmNRVF5QAa3j5b1Nii7qMlJEa
	 BIr4+ZCGHnZUpagIzJ9yQSOJujaIVwqM5hedcdeAGKWswwlps5GphJ+cEoKRD23gjO
	 aFB1/Si4mok1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E3A0C04D3F;
	Tue,  5 Mar 2024 21:25:19 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem update for v6.8-rcX
From: pr-tracker-bot@kernel.org
In-Reply-To: <987924a8c1e3e4e99a483e432f1418518af0b7aa.camel@linux.ibm.com>
References: <987924a8c1e3e4e99a483e432f1418518af0b7aa.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <987924a8c1e3e4e99a483e432f1418518af0b7aa.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.8-fix
X-PR-Tracked-Commit-Id: 85445b96429057d87446bcb24ec0cac9ea9c7fdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29cd507cbec282e13dcf8f38072a100af96b2bb7
Message-Id: <170967391910.2988.6821418488336748407.pr-tracker-bot@kernel.org>
Date: Tue, 05 Mar 2024 21:25:19 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 05 Mar 2024 07:15:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.8-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29cd507cbec282e13dcf8f38072a100af96b2bb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

