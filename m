Return-Path: <linux-kernel+bounces-165730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3C8B9055
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E21F2386F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00921635D4;
	Wed,  1 May 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G97bP5Ma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF0F9EB;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593633; cv=none; b=Jaw03rXGT9nz9OnDK84P9RR0n2EtIBG+Cfiokr9BN6G5mWc9c1emK7okUV1uuQXLgwEBlBvOfUqsmqq2WCaZvTx4xrisSY+CE7kS83YoSfS+wm3ukecdpXC9NEomQHMxOkvRSV6RP3SAXI7JWEzAbc3xtVUB6g09IaTFmghaR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593633; c=relaxed/simple;
	bh=ih/GNLm1WfdtWekFHhQEBTY1Uux1rbHOHII15bWTT7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lWnOeewhfixcaTLwXn1gsE29jL0/htW79+jJmSpMyMFRylB8EXY18NGmhqiqKH5kL4edxjXw6kFtE/ruJo0kZw5oGs7bg+fCHj7vAaUizBFeLiAmXD+V2dCdqN9rwW2/6vUpdxdgloBdfDyg3npKm+MIM9YiZ1vK3DKuwxhshSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G97bP5Ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CD74C32789;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593632;
	bh=ih/GNLm1WfdtWekFHhQEBTY1Uux1rbHOHII15bWTT7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G97bP5Ma6O1GmaFHCiLS88qaUqCoJRxYZqRJTK1ogOmwN27MRVeBqJ3pGHsyob2uw
	 609DOXu+g1hXMWHcNi/hclKtJrxKcVww/Mlj8Jgc+aoasqExS07GdjOCsdTsMdjo/m
	 24MtdUaIGUjzrfcQAWqHtP9eB+ccQ1zA08xJYTyp9UgSiBuOCNPIEi0Whe0HBUsyzu
	 TJyzuj9oeOTi49q9VVcm5Xmfql+eYMIOwdO7wv1Pw+QHlDEQvUg7N22W5mZ5qRJVwh
	 isL/IMrY4U2Go/Oz1rhwLI1DSVtfThFFWmT31rINcUmZxxlg+XvMeMUYV2n6oZqSJZ
	 eKNOeHhfECmDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79D44C4339F;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] Bluetooth: qca: info leak fixes and cleanups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171459363249.6729.10986328345003471376.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 20:00:32 +0000
References: <20240501123456.6712-1-johan+linaro@kernel.org>
In-Reply-To: <20240501123456.6712-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, quic_janathot@quicinc.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 May 2024 14:34:51 +0200 you wrote:
> Here are two fixes for potential info leaks in the QCA driver and a few
> cleanups.
> 
> All of these can go into 6.10.
> 
> Johan
> 
> [...]

Here is the summary with links:
  - [1/5] Bluetooth: qca: fix info leak when fetching fw build id
    https://git.kernel.org/bluetooth/bluetooth-next/c/cfc2a7747108
  - [2/5] Bluetooth: qca: fix info leak when fetching board id
    https://git.kernel.org/bluetooth/bluetooth-next/c/3e2faecb09fb
  - [3/5] Bluetooth: qca: drop bogus edl header checks
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca8934466039
  - [4/5] Bluetooth: qca: drop bogus module version
    https://git.kernel.org/bluetooth/bluetooth-next/c/2684457bf2dd
  - [5/5] Bluetooth: qca: clean up defines
    https://git.kernel.org/bluetooth/bluetooth-next/c/f50efbe27afd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



