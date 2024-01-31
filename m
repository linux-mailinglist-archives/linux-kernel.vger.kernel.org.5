Return-Path: <linux-kernel+bounces-45772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC019843616
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3E1F22BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD413D97D;
	Wed, 31 Jan 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4wBA036"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99693D57A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679051; cv=none; b=f2rvknteLtNnLlnuXx0xKVPHxe7FCTBz/ea5+6UJyRENc7Yy+7EM3N8GUQcMxOcpHE/t7F8Z0Xd50wi0oY3zcPZmwo/+HER83U44XwgVXJ2vRLM7hlGVnBfDgUYY+hP8s2rQ+TP/c8e2vEPDZl1XlYk//vqXFAuSuOr+kNeC3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679051; c=relaxed/simple;
	bh=rC3sfYrLQD6PwbHwcd9T+mFvFCPjsMTtROWzuMYyAXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V4uWdYxR3zWlHTOLKPAFieF6fk/abGdSFEi+EQsMNU/NUsLgrIJINZUnwTrguhScheOY2ItLbUSXdkkAV7IOLx2qp5f29DO/NKWr91PBWTpQQmb82An0SMoJEMND5sAQruoU5LCRLtHHe9kIorCLaTIj4yhRczG5kUvqeA6yaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4wBA036; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B65C433F1;
	Wed, 31 Jan 2024 05:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706679051;
	bh=rC3sfYrLQD6PwbHwcd9T+mFvFCPjsMTtROWzuMYyAXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q4wBA036YZEGmHhRr5Dlh9sJ8RPg8a0Lo7BMbEMgNAolchjRKduhglsnVzi3IqNzD
	 zT/EC5qriPRBFCWt8DR9neHHKg+q1zFkw819S9COylFdTjO1ZXhYFv3DJrYdturt4Z
	 icke7R8I0X/NHw7WWzcj91J4Do9d4oTWBVxjdl7hEqwDMWuedrNNkQisQRW9if67TB
	 N8xzwwmIZwyBSgMbdef48H/fbDCVERL7Z7C1IDk8sjbmSNfPfTq8OwkH8N9ZUbd2Ne
	 nmYOniLqwmp6elea0vb7yl6KeAGCi4blOxN9VIds3zBTd/JFB2d8sdUGhIZwUu/IAR
	 kNmLFuIIvo91w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EECDDC99E4;
	Wed, 31 Jan 2024 05:30:51 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbnCP71bgYBzzHA3@debian>
References: <ZbnCP71bgYBzzHA3@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZbnCP71bgYBzzHA3@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes
X-PR-Tracked-Commit-Id: d9281660ff3ffb4a05302b485cc59a87e709aefc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
Message-Id: <170667905118.426.9560450734798875531.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jan 2024 05:30:51 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 31 Jan 2024 11:45:03 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

