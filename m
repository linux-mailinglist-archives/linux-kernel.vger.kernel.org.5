Return-Path: <linux-kernel+bounces-108061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA788056D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7648C1F239C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86A3BB25;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGGS+xyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7839FFB;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876584; cv=none; b=MnofdlXHPdgcnzVZoCAN6XQ0SXCxpJxJzu+9KINNnVpJP7Wm5ifNXjJIDWS2tVQm/DYA+DHg23Ae+ROFLKfFczjfF2NYP/odyRJ/Ye11j97Mm/rkmbi3dwxIRkVI2LdHRKX5X7taNzsU36Ytdee74oQZVP8BliPYuzx8vNHaozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876584; c=relaxed/simple;
	bh=5anQmS3jsOUfvYL/cz883dX2dkMRuYztf9vijMfN+fo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fil89rW5jvZ0lIMqRR+t+9oqYrwjz1lxrt+3kIRJzR/vxfEIbhYctZ5vdnuuFolenPI2/9FjgD+b4DE5OfVI3v3GN9wmLbD7wxUS72oRyvdu99jKV3NR+w6KW+Eo0pzAyBo+HtA9vG95XLTsoXaD1yvZ80U35f5PI8lUhIjrFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGGS+xyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17F63C43390;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876584;
	bh=5anQmS3jsOUfvYL/cz883dX2dkMRuYztf9vijMfN+fo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mGGS+xyH0vGq8wgQmtzqxrPZ37BNlOw/TnYs/mQrB4dKAcJQABzlWoYn92kV5pPCa
	 09DpBVe3ryD5J01R02LaNGkaolt2gjawFBGu/IddVkMgG+G/5HJQ0GNyihW6t05tgF
	 YOXAlSsnrwSiBKe0Q7FehILVZgfDzqtc+9mqnRd4Wk/EjY4d9CV68YpF7wQ/4dBaAk
	 fr4ywuP8llo3Mk7zxshLl1BWRbj3EqRtetP00OUqK2su1YTNXzhHRZnZ0YhaZYcx6+
	 YAh85CKKD1bnwzcbCBUzIETyeXSh5y1Vsazl8ffJp/fFuCEp2r4QRhPwD5EESVS+8W
	 nakx4I9MVHi4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 107B5D84BB3;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hMT+x=axU2BKz5XHYwdYZzdSm-itYvYD0K16T5NUnuyw@mail.gmail.com>
References: <CAJZ5v0hMT+x=axU2BKz5XHYwdYZzdSm-itYvYD0K16T5NUnuyw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hMT+x=axU2BKz5XHYwdYZzdSm-itYvYD0K16T5NUnuyw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc1-2
X-PR-Tracked-Commit-Id: a873add22a46beec0291c5a40194a90eb92ba3da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d37f7e7d195fb1c2f9cac2cd431771936fd4692
Message-Id: <171087658405.21820.14282277004543750164.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 13:56:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d37f7e7d195fb1c2f9cac2cd431771936fd4692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

