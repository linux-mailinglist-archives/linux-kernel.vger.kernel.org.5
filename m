Return-Path: <linux-kernel+bounces-163076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381388B64BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAA11F2271F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3E18410D;
	Mon, 29 Apr 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4gJC3QB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B2946C;
	Mon, 29 Apr 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426836; cv=none; b=Ej612rHbJhkg5x8tUeB9Vwu+fYk3Cm7TUL3GtUyZRA8FsDjzdas+uPBDlsrZZkH4Ro8CjDtTxJN//jFPxmswuhhx3nfc4JqOp9yJHczaDfip6bt829JkAE767wbVb88EiNvcOLepGgUyLfJvOyFR/BmwzCnFXfUC8CXMOMLrih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426836; c=relaxed/simple;
	bh=AHxPDp20WZj8PW7al1712nen9LOxM8DZgTaYmSztiqQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TjkXNJSZOQFy57Sz0u09UeTCUHTwUqyLSzKcE/GYmYFjezz64avHZHFxH+mmYe/09RCdmSCxFKimsyXwU88m1PRU60sbo87NqST3fb92OaWTBE/hryJyfM5moeUKhgpFz8I2NCaRu+sAnriDVpFPMb6tQE+f4krrfpIrHmsqM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4gJC3QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28401C113CD;
	Mon, 29 Apr 2024 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714426836;
	bh=AHxPDp20WZj8PW7al1712nen9LOxM8DZgTaYmSztiqQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I4gJC3QBqL0hzs5AhnSVm5kq4+/glqHv0sBpZy/Tj9bSL1D+dArJILNoorZZ3ZBmg
	 QV17CA15G1pHtyqa8Raru8GzibXfhQfTMKzUUEJZO42EUyEGa0WxT9A6GRPZRl3BVx
	 JLCvEkd0kzDtGw3LOgReW2PO3peITC5GNTdkk1k3Ntgf8Kct33PsYx5kHQtYhbKrWx
	 CN2yAMZP/4p3amiEuyXKcRuURE59yS9t96C9oGnWmOq4D4GgxQl/H+lZmv4+k2hE4Y
	 OX06hqK7wFaILj2lmcItJQZ3MTYSOk6iYBcavE5/2ljm3QbgT9IN7n2hnOugPI4krs
	 mmyq89mBp2/sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DEA7C54BA4;
	Mon, 29 Apr 2024 21:40:36 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <1bbda065d2089acaca9ab88a3938234a60e780f1.camel@HansenPartnership.com>
References: <1bbda065d2089acaca9ab88a3938234a60e780f1.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1bbda065d2089acaca9ab88a3938234a60e780f1.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 961990efc608d559249f5637254fa0a9aa888b1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d03d4188908883e1705987795a09aeed31424f66
Message-Id: <171442683611.12451.6025529635613601514.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 21:40:36 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 15:20:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d03d4188908883e1705987795a09aeed31424f66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

