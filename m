Return-Path: <linux-kernel+bounces-103660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816287C285
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46E2B2291E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01A7640A;
	Thu, 14 Mar 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q27Yprmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C4762E4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440435; cv=none; b=MHYibiLbmzzL56547LjIXnimI7f7/r9IPoen3JDKvRSywK42I4Ax1EZz42tkMxlN+MhscHtMg1wpGMYAuLhzmLB51MFsDs2PKZ/EAlXVAFK7EaflMFauZyiC42T8faiaGdC35tUvVsGGGaLkDAMT8DVxv1McVq+9WTz+A6swybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440435; c=relaxed/simple;
	bh=2KQmT/i7FmSKbewa7WAkoiElBvVFxmEwmoYwegI3uc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CVoCGZD53atLUnl76gqZcPQ8ttoTDjuYkKFi85H8xv+DRPH49hJp3KRImaop6leCo44qcYKvD2OKkqd74ZIoZuqJWV6g/PvGn1LAtisTInGbqFLRR95vJn60+M/mQcPzjTTCbRvfZW9o4Q+YgzppmrS285w0rlZhHi0AyJmQ2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q27Yprmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0D1CC433F1;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440435;
	bh=2KQmT/i7FmSKbewa7WAkoiElBvVFxmEwmoYwegI3uc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q27YprmrvZDkN0RJ3/fgPn4nMXRhCnQamT6C35gIOZHHuLtls/6egoCf1S8TXhIk0
	 YgsO7h6mz9zFZUVNVjpweDj0YWnBZJ/I4VCuLui6tMLVj/e5//XLiv8yVxfOCjy0yO
	 LgANlt8huS9tWXaaKaabTR044WjfhsHVY1BaeTxKFtrb1ABn7+ajwPwVvI0mZicaA7
	 a6eTc7ZpBrFRjbPfejsM4pQC19GxE6yU7L6GXVPEK3YjN+tPwOTliKCCRXKAGkcGk3
	 L8uBZDnAxLP/2K9JBeJobHdPjbH5TBMeeY/oPFNYAQtgwq3mAb+nCRgNq8+VCEQNAA
	 lIcjkoLBQy0Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E25B1D84BB4;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314144350.GP1522089@google.com>
References: <20240314144350.GP1522089@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314144350.GP1522089@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/backlight tags/backlight-next-6.9
X-PR-Tracked-Commit-Id: b49c1caca529c28712ef62bfaabdb9441162a935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3d8f29d1f59230b8c2a09e6dee7db7bd295e42c
Message-Id: <171044043492.24196.2721940402316638132.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:34 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lee Jones <lee@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 14:43:50 +0000:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/backlight tags/backlight-next-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3d8f29d1f59230b8c2a09e6dee7db7bd295e42c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

