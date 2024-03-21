Return-Path: <linux-kernel+bounces-109639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E84881BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52C01C217DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0CC126;
	Thu, 21 Mar 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnoZHerJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CCBA28;
	Thu, 21 Mar 2024 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993628; cv=none; b=pFUefTAXvZROn1BTqc1GouqYB2ZPEs3Ju134ctK3KBwAiNK1fOaLJqHePc985NIcymO/kR8Fxql9V6eMfwNb35J0QYiMMSX/AYAKC7stohCV2O40dwlTMjQfYjzFK/2//UcOoDKa8yIC2ZRaQaJaiMnD92YDvjM4M6brzxktBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993628; c=relaxed/simple;
	bh=bjFLNpeRhfYq4j4b/kx/9OPoNhhslRv7ROvHKUXSjUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6I9MAd1rZfKoV96QC4gPhwc5ahjTrFy8duHppGaa2L61FrVwSdMNuF++L+LDWdkV43GXOvNcPWlaeyyJ7sFdoe9Y9o9UY85/W8O2ljL/g9M2iPPEWh8kxKeTz+Tkz+1grOItOIV/FJc/VgAmCWkC1BoMbj5bL8dQ8frsP7SRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnoZHerJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F0B3C433C7;
	Thu, 21 Mar 2024 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710993627;
	bh=bjFLNpeRhfYq4j4b/kx/9OPoNhhslRv7ROvHKUXSjUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UnoZHerJ6EJGQKsnnDvaqF7GjaVwPJgYcHUZ6exWOWYrilIHjDJ+FI89nG6fGV+zS
	 3mfIVb/LLH/9IcITePNWE9aqTlGJb1zcj94wPcUPa+tbEfPEi4RTwpsW7Ym7AGwIVQ
	 rfAdjr3dUYlV2xKTUKNNshxjXv+ZU43qMIMCLawtLk+D/EVpGaZrHTLHmN3zjwRStY
	 xauplWTdUxWjakjp4HX7auyNLTW/BDxiSAPH7FqwwXMG3d+a41nmYFp8ZA8JFpgJ+8
	 njPW9agUmZySg4qGspJcc4woKaS/hTigGcqcDTntSJZIKzkxvM4JXe+hyDAbSxyNci
	 z0HcIbWJAzNEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CC77D982E3;
	Thu, 21 Mar 2024 04:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171099362744.2982.459226661917199251.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 04:00:27 +0000
References: <20240314120006.458580-1-herve.codina@bootlin.com>
In-Reply-To: <20240314120006.458580-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, christophe.leroy@csgroup.eu,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Mar 2024 13:00:06 +0100 you wrote:
> The make htmldoc command failed with the following error
>   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
>   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> 
> Move the visual representation to a literal block.
> 
> Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-kernel/20240312153059.3ffde1b7@canb.auug.org.au/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather() kernel doc
    https://git.kernel.org/netdev/net/c/2d9d9f256c8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



