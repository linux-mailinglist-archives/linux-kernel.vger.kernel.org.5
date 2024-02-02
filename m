Return-Path: <linux-kernel+bounces-50571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC060847AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D4F1C219F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1938592B;
	Fri,  2 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b05PbVVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16A83A09;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907621; cv=none; b=HjnSXon2TZPlnV13GmNODFPPvIE0/J/KzD5c6J+86yhZxvvvzHC9i05AEBU/Ky0JoNjBLHM+RTLUBwNoAbg9hUf5/5E4IwF8WtY0PCD6y8KovAvzZ0/bNOqqbL9LlSQVQRHfvVQyphvPd7uGOTgjRHEbqcXBLPJTIsB2uafDvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907621; c=relaxed/simple;
	bh=fpsrycZWlW4RGEmSVWv995Cc9qn8ddAmB8Sry2i2gko=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OqsbaqdyewWWd5BQt1TgLQojyuXdB46CR5qe3ykT0lbk4I39jPFZDgrgPL0EasHQNfvzZvklgZsh0rNoEARzlVbOEqxc8i+mqkPjZPf4SWLZDTAuLBqzzZFal6jBOUBLpHegrzLVioVbW9qhwBKQnkH96L0Cu1Kfl9qHpK/dmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b05PbVVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6058DC43330;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907621;
	bh=fpsrycZWlW4RGEmSVWv995Cc9qn8ddAmB8Sry2i2gko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b05PbVVmXGsskLnyUp86GjcmQgyoUocHaDLGiamY2YCW+R6REA+lXcP4ioa3WNfNH
	 uEPh+xWfoYxzzrhSjgp2vBL3p2nJfgw67ZnbnQB+ddIi1/ydnTM5hPsABvhiyjQO78
	 DhFb6XKimpLR2dJydFiyEhPYO8kGGbVa6bxc/9amK0QdGZOEizqPEQdM5ppMDZxTh+
	 tjuDqX0eKGQ55itggxgC0xxpp8yNITjm975hTUyP6nPcPL2/VqWzKCze3zDjapWNy4
	 p05rZ/byY0Q+8jn+LVxtrUNBjSNb5+buR238WFiviVaT4Mq6VV4aH7Dw+7uyF49KYI
	 9WFDbB3Cbf+Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BE6CD8C978;
	Fri,  2 Feb 2024 21:00:21 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zbz4DdrTl4js-w9H@8bytes.org>
References: <Zbz4DdrTl4js-w9H@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zbz4DdrTl4js-w9H@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc2
X-PR-Tracked-Commit-Id: d2d00e15808c37ec476a5c040ee2cdd23854ef18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f18d3fd2975c943be91522d86257806374881b9
Message-Id: <170690762130.8980.2695905021405938896.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:21 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 15:11:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f18d3fd2975c943be91522d86257806374881b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

