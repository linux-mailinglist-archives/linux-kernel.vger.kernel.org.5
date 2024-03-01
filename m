Return-Path: <linux-kernel+bounces-89070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9286EA2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F36A1C24DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392A3D571;
	Fri,  1 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8rSgBZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D33CF74;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324247; cv=none; b=fiXMIz5nk5+eV7JaRbJ2qkTc++IFLAcZ9huv/yKqx7gzhNi6lVLW9HGgu1g0pV85r2tsSzqZYbyDIkH/nC65BQR3gRYjmsreEEGH+c4JRKTJXfCoo329RHOLWTT6tqmEYDxkrVFoeLP7vXlg25EcXjNa1rRyxemh94urqdQPXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324247; c=relaxed/simple;
	bh=QpDhGvD3t9++XK9eHN0GMCkwjtv3kzUfmbnqyWVw0WQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DI3mnODlX2WXHXwDkkh7b28bhlzU9XAyoO6WJzJV8m8eNpaYDACcMWJ93Qro5wj9EJDAKIuO0HiYHE+s1/ki3lHqXEaVL1SgYrRra6Y2C3eglpwZUhKNU3Oud86j33Ecr3oNbJghKhI56u5DGi+Xq0Xm2lU30Z93cYr2afykWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8rSgBZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C59FC43609;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324247;
	bh=QpDhGvD3t9++XK9eHN0GMCkwjtv3kzUfmbnqyWVw0WQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B8rSgBZOFG7UpAxUrtCik/Ec52X95vCcLR9nK/Xo32rZpmkXwN6pSnWdB4rmdvmTE
	 RZZI38mUfDKRPrE1vgxNCRQh6uzPFaX/Y7P1qkcEM66k702JV9Hq+J6i9UkzSvqN8r
	 Wp6wBnNbbgZtMSMC8L4xTct+JMhE/cmlsFEsZ3D952zSTD2Js0sigyGCNloqma0r2U
	 R/W5b0kgLAbg6umxTtWDTpSBQwkbKHOIpWVeSW3fEzFRkJeoheYDR0FbrhlBDVVrqP
	 qbwlsIwqL2YJ3ZPpqhrqmb0dJrtQTXXqR0DD1xjZKQ+SDSvFhNtcD6B6jfTtieNFRP
	 516ezue24nsqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75BA2C595D1;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fix for Linux v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZeHvJSZR_XoebLF8@8bytes.org>
References: <ZeHvJSZR_XoebLF8@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZeHvJSZR_XoebLF8@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.8-rc6
X-PR-Tracked-Commit-Id: 6384c56c99d98c84afea5b9ec7029a6e153ae431
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17ba56605bfd139dfa5eba183f9f53ab90deea78
Message-Id: <170932424747.25962.1629909327352593531.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:27 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Mar 2024 16:07:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17ba56605bfd139dfa5eba183f9f53ab90deea78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

