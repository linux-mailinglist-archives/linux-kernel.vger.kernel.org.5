Return-Path: <linux-kernel+bounces-45475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4563D843133
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0139D284936
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54067F472;
	Tue, 30 Jan 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKwY2bG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9C7D41B;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657192; cv=none; b=e8WbOejcQORE+egXdc8HXXZfPYJdaMAWMDT9Nob1bS0tqlQVuFAuDvWaNXzQEXmgufcnfjBwtM6L8yI8SxbhyhUN679/VPsZmF6K0O7TezEmBj/NrVYXbPGIwrWzMJcOg0ZeFu7/DE1wwIALoQ6pZMqwX5JfwidxNQy+MgwG6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657192; c=relaxed/simple;
	bh=0KO1BrOsMRXE6mV46aBIwyK1tZIzrQFFbcDsMDvKW/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LdGGShO506EUade+dKBDLl8b6k9+96ZW/kfJNtRMdvusWI+Gr6/KcoukcM6UTZLDEPjz16ckgw3b+Mza/JHvkzCC+BeoMq+Gn6EJ6HuKu/sSqe1yR/TqK7j721buoBLZwl4wF+T8nNa+e+YQCUOUfPQ+5AwjbA7unstF+CJ9/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKwY2bG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63266C433B2;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706657191;
	bh=0KO1BrOsMRXE6mV46aBIwyK1tZIzrQFFbcDsMDvKW/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iKwY2bG7NKEDfoI5y93GncXKxCszxCrT8IfgOAceM+ZYxsoNCxNxaG3HjCdb1sGy8
	 vrjTpyN/iUmsVu/iVQZ57xYBToFm7+2yoUjG7cvgApX9Zs23xlAv6jFdi9XU9Vuq2x
	 /iK4NSfI/2T9Tgcz9oqNywoXo88ykK4cfKq/nAszsnBpH1aVc5qynlrDz5Smklbktu
	 zvRd503Z++eBNmgTMSPmcsf6IWYzPvnSi+i4wjvjnvr73IOd+/1PrabQvJHNsK6eca
	 tRI74rizbn9hNZAlUXFAbMVNXH6phLVm5c/ES1xxGHgahyXhsDGYVTe/SZzK7HVJ50
	 VBtnU1lWMZRvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 446EAE3237E;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <697a06c6-03a7-4939-9821-392239b3d5b2@linuxfoundation.org>
References: <697a06c6-03a7-4939-9821-392239b3d5b2@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <697a06c6-03a7-4939-9821-392239b3d5b2@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc3
X-PR-Tracked-Commit-Id: 1a9f2c776d1416c4ea6cb0d0b9917778c41a1a7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a6526c4f389bb741e511be11721b3d1cbf1034a
Message-Id: <170665719127.18648.8641619027674990464.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jan 2024 23:26:31 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Jan 2024 15:31:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a6526c4f389bb741e511be11721b3d1cbf1034a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

