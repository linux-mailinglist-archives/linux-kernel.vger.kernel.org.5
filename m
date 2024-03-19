Return-Path: <linux-kernel+bounces-108063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA9880571
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521481F239F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225057879;
	Tue, 19 Mar 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/tl+5hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7873C092;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876585; cv=none; b=PRv/deOjI6CcJ1TLIgiwnckVhIqDtq4IoTdA2gfE+YWPYE/K98Ma+56rVIf9SS6rSbE6cK+zwByrPXCfCk74g0fhE9Umfj+XkwJWCPOlL1tmRv3KLYDE1kmddiegX1wdxWuF7IcrPmCOMcdctWEbZvcx3TDmdJX3UFZ5/pz2T7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876585; c=relaxed/simple;
	bh=z9qHnltk4Qj282Dnp/XojJ5Si6pKEJZun/PaQBUa6rM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iMv1OE9dxR7mHoC1INfZBey4N1kb1JmJYwXniLkj8mfm7hn3sOrT+rEJqetSs1EccqyUUEiW2vrmC1OVe5zkQCAzKZi/yx4mMnHLVcWA2L8AQdALlRJCjVc6h8HKMCtw3qupIbbiPfM9LCJUIZMVO5d2l6y8BhHchvErZEUQa5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/tl+5hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74876C433B2;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876584;
	bh=z9qHnltk4Qj282Dnp/XojJ5Si6pKEJZun/PaQBUa6rM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X/tl+5hyAnblf1ySJITZUarlUJ4M4iMjN2RGNx98B2jccQNv3yuftcS11k9vmf4EP
	 +w8Sf72XSEP0oQJTNWnJcxzUNnJ9pYReYHBPRdYsR6V8ZttDVF2CqD0X+bJqNHkfEN
	 iQTCtZla8Kql9fPFUXPu2DKjdR9aqTq8xZA5hyDXzFyOx9vt8QRubiLjNd9oMVCRxv
	 aUEpNRHA7dPpNzb+E36qzRttLtUN5/SSzzQAeQ9CBZKZ0yONUw0pQ8Xz8G6vSnqyVm
	 q40wn4BfLkOS6QzLbNP2r/0xE83uQF7SBm/iR9JkWKeWWY9OCvr9JA3+a8OpN0RdHD
	 P9laQTh96yB0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A5B1D84BA6;
	Tue, 19 Mar 2024 19:29:44 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.9 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240319141230.23303-F-hca@linux.ibm.com>
References: <20240319141230.23303-F-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240319141230.23303-F-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-2
X-PR-Tracked-Commit-Id: 64c3431808bdab2ccef97d7a444018c416b080b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9c035492f2010e1e7aede1f1bd32181d7cef2dc
Message-Id: <171087658443.21820.10837170247604201287.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:44 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 15:12:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9c035492f2010e1e7aede1f1bd32181d7cef2dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

