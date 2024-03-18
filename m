Return-Path: <linux-kernel+bounces-106770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9587F348
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EB1C216FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD855B668;
	Mon, 18 Mar 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIeJlOIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333F5A7B5;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802043; cv=none; b=uQCXD7K873Vi/HGg68Uz62c0WQsPm0NvZgI4Aq30ERxb6pmWXyEK59g2q9BCV1IVGUSeesAej7FE+0whDrwoIwQe+FWvzKImEOEtoo9RH4dv8EFzGJkLsGiU6+/WaMR9XylPfrIVkc1MMrxwU0QSySTeBjwPYBP4sNovVNjav+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802043; c=relaxed/simple;
	bh=S29ZDlq5zsqiy67Ywa547JogWhdz/uzlq4uE8L+j8Sk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jc98vCRk9gkcjl+p10OcPpd6FZ6NQICWpmevqmXbXsaYGPvlR2drLN/riPDBB2w+7SzmQG6LcMLEoHdevJ+0D/uO9vbZXDQjCnhKPQqXxuJYKXmaozYRf5kafSHnXG9HquGSiq53lxdIJRH2PWBHUXm60GBk/TGHldVO0I5EsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIeJlOIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11DACC43609;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802043;
	bh=S29ZDlq5zsqiy67Ywa547JogWhdz/uzlq4uE8L+j8Sk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IIeJlOIOlxo6fFxMNj03LCzSjCcwtt3yc1H3kByGqDbr7aWXOi+AeePSwTflrrYU8
	 /IDXQD1ydfTMO7VEUAiZcLhyMS4yVdIrZcCQ4mGSkJM3fRLnvGTohmNmKYytm0H2I6
	 ORcBX5zAlP4P+TwHPz/kCY4QT3gTwahncsH1gMpWIbdd7S/Spl+1x/E3QDMZrApk7d
	 GGKGL7Ydo5J+IzQYy3J810K+MI2YcbQ7pi9j/zuWTL/+g1AnudobGQTATQMxyweV+r
	 HTn1ce8Ox7R6fyMfU/MhuV3hen2gKXGIDgRlcyuRrGES5yGrj5oMxiCrkNMo8LAmGh
	 Bar7dEktyHKPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ADC7D84BB3;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Subject: Re: [GIT PULL v2] dlm fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfixMxRWFNmkf-Ta@redhat.com>
References: <ZfixMxRWFNmkf-Ta@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfixMxRWFNmkf-Ta@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.9
X-PR-Tracked-Commit-Id: c53309b912fdd652eb3c2de44626aac4b0fc9bf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3603fcb79b1036acae10602bffc4855a4b9af80
Message-Id: <171080204304.23091.3377206822949979856.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 22:47:23 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 16:25:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3603fcb79b1036acae10602bffc4855a4b9af80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

