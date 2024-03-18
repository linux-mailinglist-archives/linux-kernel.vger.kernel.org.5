Return-Path: <linux-kernel+bounces-106645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A098D87F17C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EED1F22ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8845A4E3;
	Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7Bbxxom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201F59B62
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794733; cv=none; b=ZQv2822HuULmXIOmo5Ka1nUSF7Gy6bZ1KZIoJSFQk2Y09DYdvFp83meuCi5Et4NLpykodkdRUekeMFIB1wBdyY4GiVFP1XsVWDeHqzSSr7SO4wHPX2s+kDnqNB+sm06uHJW0QiqnMKzm8WVQamVXIWwTNJ5SU+toaSPqrJt+gM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794733; c=relaxed/simple;
	bh=e1W0FzEGD39JFbH0tf9seE7OutBkd433XkofbK52qfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qxlymI+4AekUAnDVveaevFxdEP7kEhjgKagGNrrJnSzyoMGBufb3eRKfFzbSArb+JexIXKgtPog6AP+QMcAnMc8G+LtbVf+I6msIRArbPPAzCPbaH3un1XeUr5v8zCxHkP0aJ8FYYRcYIzH21VIZmef5DOc5tTn1lU5+2e1Kyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7Bbxxom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 511AAC43330;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794733;
	bh=e1W0FzEGD39JFbH0tf9seE7OutBkd433XkofbK52qfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h7BbxxomMPArD9W8mF0GJMXkgFumxEJsSFX/qt7UZ2zJyCocu8jq5qzzH/SVf50tk
	 5HJwPIoMfoYkKsyWBfxqpmsAsxMg65A85MG9I7CE0IohgtbXvjz53vuspr/fF4Oyi7
	 AKgsKj6sQCoOAB13Oa0tG3BZhFlVtdrE/ZmkXtmV/krFuTON5ZZIltdzijhDJ00W6b
	 ovVa85M57DEllvrA8H2QZvsIRMAUXFjS8gTcB/UQ2AkxlSJCalbiUhGKU0xiP1mjbG
	 +K73MuT3hnHXjG8OnPcBUr/fj8f/BEUuRKn4ZVGDyPGF5NvzyYWJh904ZvsHpXRkTh
	 v8GElcsxeJYbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39D7317B6478;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.9-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171079473323.25373.9240563130828543134.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <ZfiBt0gRe_Elp7hE@google.com>
In-Reply-To: <ZfiBt0gRe_Elp7hE@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 18 Mar 2024 11:02:31 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.9-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/c5d9ab85ebf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



