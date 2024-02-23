Return-Path: <linux-kernel+bounces-78999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E9861BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE521C236C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C21468E8;
	Fri, 23 Feb 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjyEoVoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056B142624;
	Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713848; cv=none; b=Kpye2Beri5xbB4Gk26hIe06KCvDJRhnVkJemRKlnpE5Uoa+OYY2vxY5d4dU4Hy610UWBFc63vuOXyr4XfSnCDhCLNC2oMa71w8pnV99IXPSJAQG120RMjSLiS8LAFdkC/WB6QHpORyG8FuJP3OqxGf1w/vxkIBmycKLoe1C+Amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713848; c=relaxed/simple;
	bh=D13TRonenIxzOiDbt6eJEBI48/PNOpUryod7mo72sGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UwdyIfnMiXkn0xr2Uqr0dvQwKqkhQJTDP5i6DdXIHDYdUu0bKYPOFbhmHrXjfx8RrQZOKatSPkMo/i0xtuHmBEK9fxlar3lfKU+JNwowem0SAzdmx2hlPTAhOveF1losQuhKNVg2geC1gBP1AjW6k3fQRJ1l5xkeVWxa+cugWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjyEoVoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2EA6C43399;
	Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713847;
	bh=D13TRonenIxzOiDbt6eJEBI48/PNOpUryod7mo72sGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HjyEoVoZ6m5PMgsSt0Wshkc/wYcFVkJE3QFigChvf1o0TAAgAuRCG7gAL8vwzxya6
	 OQ0S1ki5EBk8/00H0UBKBKlbfLPoOBTIQBcEVAenKsVufjFaMEFRR1QQ/E/xoZlcXD
	 0ku97zPQrFl/exlCixeLl3BsvQx9VWrZwdytey3YgWzwBe7j6CtlMxZH1vsjNenMHD
	 EvwM/LxGd2owSeUGW/m886d9fbIA6LaSF5LQT5EkFPfSDtpSFxZPPrxwPH7m8HVYgr
	 8bHW9vdbOPVMnWJ9U4/zUtFeJYT0HfcnVNJ3ukp5sgA23DEd57yGlsg+ysW0K26xJg
	 CIY3uyXs9C86A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0B33D990CB;
	Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240223155220.36568-A-hca@linux.ibm.com>
References: <20240223155220.36568-A-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240223155220.36568-A-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-3
X-PR-Tracked-Commit-Id: 5ef1dc40ffa6a6cb968b0fdc43c3a61727a9e950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5efa18e8626aa34559b72981ebf5d1af60cb3976
Message-Id: <170871384771.26987.13053694842760009306.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:44:07 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 16:52:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5efa18e8626aa34559b72981ebf5d1af60cb3976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

