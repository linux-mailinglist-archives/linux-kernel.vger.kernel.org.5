Return-Path: <linux-kernel+bounces-51486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5386848BCC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2228EB24142
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F94BA29;
	Sun,  4 Feb 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZri2QtZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A298468
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031117; cv=none; b=gm0blfLEMogXADLR/mO/XTUr3tsIc5fO+fHxhR/nZ4BQdToVF0TGbpXQaiz71ce2tUbqBOFQk5kEPnm1mCZV5omOTGFkbl263AEwEylJpWbSZJqSKKAybb6tW78C3bMqOn1RXuZXZROSgVH5awxbQf+nhzZ1L8+hYOUSy0Ny6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031117; c=relaxed/simple;
	bh=PZgj6B3XsTx16xhV0ttPql3JMNX84uxGMZCjdNsaAro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CrlHK5gmbUH3sHvuvtbNZPNQ5D1s6l3cMw6EyG9cjoZleJZ1nRfAf3ppHdv1DASuqAHu4z5C9g+HEUSbHUvsDN1ElWivX5wPE/ctbiBiPO+m15YsHhCL7/kPFsm2XgbylG5H81is7mWi0Z70fzA3GOusdrk5lVzcStr6KXi7DNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZri2QtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C9D1C43330;
	Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707031117;
	bh=PZgj6B3XsTx16xhV0ttPql3JMNX84uxGMZCjdNsaAro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fZri2QtZy+eEdTFepjAFgH+6H5kpJ2NWu8OrSvKV7xnxmdD0asa+UgulUswa+KV0L
	 P7TkrV7La0Em3Py+/hIgaCFtN+br/ttKNB3X2/be7gstxu6U2QYbkba7bhWJ8PzQJg
	 koLq2Yl+W6yu/DRFTNVqlkNNdTq6prZTbzyWcHNzQ40xQIn3e/zV4GstebmVOb3R7u
	 Gb818+QAFOXA8/ip+Nz9N7iCU8fpF+s0awrkS/5O9rBEZTgvyr+U8CYjC8ew335BRO
	 US9Ou2lyCmpJpbvE+6jdYqiz7kMlY+HdjaYgQhmKlH9JNbzL7YgzW4Fg4UxMi0fWc3
	 /pCwym/+pkSIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A5CC0C40E;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zb61EW7GkqldLC7b@kroah.com>
References: <Zb61EW7GkqldLC7b@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zb61EW7GkqldLC7b@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc3
X-PR-Tracked-Commit-Id: 97830f3c3088638ff90b20dfba2eb4d487bf14d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a0e922079408c6749770f38a2f4db10dd4d0927
Message-Id: <170703111693.23816.11465408194685327048.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:18:36 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 13:50:09 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a0e922079408c6749770f38a2f4db10dd4d0927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

