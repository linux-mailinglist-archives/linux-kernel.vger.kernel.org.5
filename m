Return-Path: <linux-kernel+bounces-27725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FA82F4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27B3B231CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A71D541;
	Tue, 16 Jan 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6PpYbQl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E31CF89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431739; cv=none; b=h6Bo3xOk1UuvsQvWaD27csnrDx0R4y9lFcpIy/HMYbnXAGdd84/GnuxOTT2zTyQ3UM+zYL4vTUbV07TBLEb2mm99zcs+H8IeMn6tPUfgyaSYFPyF66AIefXQjSLRK/N5ypIS/J02aazelVN1WwyxPSTVD97tdrI0i2rofz025vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431739; c=relaxed/simple;
	bh=nALsHW0nNNJnXAJRWWBsEyVYTDQ9rQY/BR0V0vrFWNI=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p+V/4mygXygmx75PvS2Cp/Ty/NVw5mApvrt3g+DieKVJj06josn4J7R/hkmoyFGWWm8oCxfTvu2VbCTQKn7IAUdUlqOBGExQrxjjvtYrsOVKqyCjl8UAzkYRQgRbZXc9HJzWLgZdPbolCgsV1gZQM5TzqZgOMwaf/oDVdhVF7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6PpYbQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0742FC43399;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431739;
	bh=nALsHW0nNNJnXAJRWWBsEyVYTDQ9rQY/BR0V0vrFWNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6PpYbQlUEiZuShVumRV8qr5Hb38KRxKM8Nz8OxFvaM5KGLNuU0BEDAgpzyaUO09+
	 ukOszsK1sRpK1XM//w3GC5kfKuGl0UQ3ybI/WU7OVHrjyMw6S79dudEJL/7lwMoxVE
	 MaW45AeZKZyvvN+a1+8NTrqL/nWxSFVsQr0jnz1BpSk7UjKbevsp71N3O9LCWG7m3t
	 pzUOAgSBsK4JA99uA+7vUMG1u7LtjRjhnTnRiHGYPAtWkD76xOOdOJ2NgeQ6Dqr/lc
	 I8eXqQA5ywl228EKmPt3WXpxPESlEG+uLbK4m+w1Fgg/vRujuSDI0H4hmVJ4m75Wiq
	 cWkLE+n2N/KxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEBD7D8C98B;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.8-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170543173890.30188.4422376381888328277.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <ZaAzOgd3iWL0feTU@google.com>
In-Reply-To: <ZaAzOgd3iWL0feTU@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 11 Jan 2024 10:28:10 -0800 you wrote:
> Hi Linus,
> 
> Happy new year!
> 
> Could you please consider this pull request?
> 
> Thank you.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.8-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/70d201a40823

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



