Return-Path: <linux-kernel+bounces-101067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA8D87A1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F4C1F23A03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68724DDCD;
	Wed, 13 Mar 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OciRbn43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FAD51B;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299688; cv=none; b=kCFxh36WiLh69qo/AlXUGI0U8PF4oNT5zDFYX/TRO49Y9Jjedz6w4t6I/Vz85Ndjk3lUoVXbxD5tTge377YexvORKxtyZzfAeCXOjOJ/6tTigvI9EyR4utT313wZ8DnEbzD5t8B5eqWJnMNnqxaiU2d9ctXPzoxPCxbCQ/Iv8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299688; c=relaxed/simple;
	bh=rXLHqjyqj74avcQK6J4nFtB1zbIiMNZlkV5WOMMv3m0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gRaZwr8w4a/b3zRD8lH+yeajA4+U00XAJ3yfnL2/0g3HYxqAt69YzGA3WFP1+Jv3qE/Qo+dtc50MmktYvOdkwLbN20APXp7XQm7/xBKhjX0KD4PprCiTY5kHMyDViNELmqXchSQaj71fyMgieFPPNK4trxDWwzNcfnmb29TZK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OciRbn43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 858C1C433F1;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710299688;
	bh=rXLHqjyqj74avcQK6J4nFtB1zbIiMNZlkV5WOMMv3m0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OciRbn43ON+17u9lZYLZk6aPqHyhVLsMXMTvuiFNpWioZGc1jQfm6viRt/vo26sfl
	 KmCnCmQfEpHdFkmZ4K+xRjCWXtS71aB34gTqMIx5tO8wSkqnLkOeLtRbiEBzP/m28F
	 6HyQINwtZ2PzxSD5/HI5RbGGJyFl8eSIBEIjT73XMl9QIKgC0VsqjSkLPshYtf/wVA
	 PObH5YueeAbiXSqjqDFwj4aeywCvWtFLah+3gpDtCPwH3KGSBC7KzSqjtQsei6UyR4
	 FMdfmwrJ/SaJsDOSGHxoIBryyAa4U0+fx0NqShXidMZ/6yaFXL44YZoEs9EHfIAz+k
	 pwVX7ZL7OhW6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7488DD95053;
	Wed, 13 Mar 2024 03:14:48 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240312
From: pr-tracker-bot@kernel.org
In-Reply-To: <75311f9f32a3cd6e4528459ea986dfcf@paul-moore.com>
References: <75311f9f32a3cd6e4528459ea986dfcf@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <75311f9f32a3cd6e4528459ea986dfcf@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240312
X-PR-Tracked-Commit-Id: edc6670233a333ccfd1ec0548f068bd121d209c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc4a875cf3b3bc07d523ea85b8ca45da1ca4f4e6
Message-Id: <171029968847.23890.14718879130667517113.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 03:14:48 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 19:20:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240312

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc4a875cf3b3bc07d523ea85b8ca45da1ca4f4e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

