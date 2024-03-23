Return-Path: <linux-kernel+bounces-112404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE588795C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8542628236A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EB446D6;
	Sat, 23 Mar 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIcg4FAC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF5523C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211092; cv=none; b=FumkrTFF+GvjLjdh2tNTvfGlMKWk/E7oJyT8T2I4iCSn46hXaviaQlHUzC5tf1lJ/72OtrJr+sUgzY9ocxV3kLR3RU/PafME9CWGcaD5rOlmNwttessIeHOUZTynMQLupWLTM6PAA+VGBz66s8dGMPKTzJ5XAwulgcAx19YWo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211092; c=relaxed/simple;
	bh=T3OAyKyJpcbqAIQyHuZW09u3eIcA963sn5FOSQf9ROY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ydd6VfabAI4IJMbk28H0TRNTudzYh6JAkpAqRbG0zfQNQw5/F6hFjmbiRKwn6GzViIUFz02DKHTZ2E9zB79++aZgm5lFRu3bqjjLfRgCT3LiD/YpM4LVrFVK52wpMgNCoMFotTxr6xwN7RxV2SAgWz8lRUonsRr8dpw6Vgns360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIcg4FAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 252D9C433F1;
	Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711211092;
	bh=T3OAyKyJpcbqAIQyHuZW09u3eIcA963sn5FOSQf9ROY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UIcg4FACYS16+O2uIsLA5ERgr+Zak+DWfradJRPzhFtZcYLF/JCxCRkdUMRkXKyAm
	 rrLOxckhyzcAKBJbDBCAcS8Q/VINEqGBpGjohK3UtqpR8zdCL8An9IFJ+GKGAPnxrQ
	 NM6sJcJgTGQfNmzNaamljx3R8W6r6jRS1LHfs+LU9YQ9zXPU8Ih9RKWufB05MeFSut
	 BWhP7v0F4z2eSNiAhizTDPJF/r24vQJ7yn5e7Y5LZZTs2dsiPFjKBGqGEGJaqTFI5i
	 ipcTj199sfSl5HqY8uZUMSAbLeFjmSMsR4DplanVAQyTCLEmUQ2xcpTu5DKxIhW1AT
	 xZ9ynmS9Ana5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C228D8BCE3;
	Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfupix7p.fsf@mail.lhotse>
References: <87zfupix7p.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87zfupix7p.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-2
X-PR-Tracked-Commit-Id: 5c4233cc0920cc90787aafe950b90f6c57a35b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 484193fecd2b6349a6fd1554d306aec646ae1a6a
Message-Id: <171121109210.3260.13947764386545794887.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 16:24:52 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Mar 2024 11:54:50 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/484193fecd2b6349a6fd1554d306aec646ae1a6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

