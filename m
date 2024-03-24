Return-Path: <linux-kernel+bounces-112800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72078887E51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37A51C21033
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323203A8C3;
	Sun, 24 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXvvThwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2537157;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304762; cv=none; b=Up8RSa8M26AJt+zET4n7paIeAN9DzTTy6Cc0fj2C9GATahkjyUJDxmblFMek/d6+4yW9SeXbu+WxXDf5jz5tQ/paGc+IMP32bJCV7QIuRNregR0z0rvIiH7TgQJfkTbzYM4aGPVpm5n/TP7rCXXf741Q0LsQrDPRjLNlaw0VjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304762; c=relaxed/simple;
	bh=E3gjHFWhZPLifRb125wIzKQjSoovtj/Sb6hT6swBPVk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IN/bP0pCumSJ72hWJcLFyCni67JME+UyidEiIEiYkAvw0DWwNFkvj0OiW3zgtC5AHx0h5q6Z/zt40thoYvkSF9utIv53AHsBzheoeXTdM3hozORY8ueb//00Zb8rr+FAeKoSkdNpfOP8WtgIloQsTWtxOadBs92fTpkmaL/TPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXvvThwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B09C43394;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711304762;
	bh=E3gjHFWhZPLifRb125wIzKQjSoovtj/Sb6hT6swBPVk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jXvvThwHP1CZG4kUlYbEgnV7gWir8JI8m3ehcAl8gJxV/m+PoGkaC2zutryXfYut4
	 FO0/SLyxCYc38VQAzLJWIr56w93gg537s9Yo6+UCYx8ByIzKBE/HrN7+bDwD+2UZji
	 F15JbH/jdSK8orRl9uZ2n6hp5/Y5qWiaKw+QHv8bpH1OKjDIPG14AtDcFrLgAHBwwD
	 m2hkZ5cQihfh14o7HTO0iqW+X5atgWoTR1Mwim/u+dXMNRripFkqwGl81E7ljioUcP
	 /ykq36MokcEGAnpY18FHINP96YRZmbApr4sBwiYrc0sQvK2aZuoDoEPzYyP+5z8X1K
	 PCt3JCqWhokMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F220D8BCE2;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zf9ur7uQA0JLleTU@infradead.org>
References: <Zf9ur7uQA0JLleTU@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zf9ur7uQA0JLleTU@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-24
X-PR-Tracked-Commit-Id: 14cebf689a78e8a1c041138af221ef6eac6bc7da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 864ad046c15758747809d9397cae621540493bcb
Message-Id: <171130476231.9900.12574763141133315819.pr-tracker-bot@kernel.org>
Date: Sun, 24 Mar 2024 18:26:02 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Mar 2024 08:07:11 +0800:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/864ad046c15758747809d9397cae621540493bcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

