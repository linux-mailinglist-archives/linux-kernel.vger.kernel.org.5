Return-Path: <linux-kernel+bounces-56848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802A84D033
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2EB23301
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7822383A16;
	Wed,  7 Feb 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhFHD4k1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5798286B;
	Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328232; cv=none; b=RA3F4TwQxtw4DLwDRMdvMqkLhmTNBpz4u4cUV35xTLCm+dxWgjavTxrUEknu1QIf9c7LGvIcR7851eSqLrm0LIQ8YQDQ5sdcahMhFASNCiF8oDcPqJf92yxjndZDhB6vx0Iip8CA5WNvOGMvSCci97KG3/+ltLHXmxMOhTZG8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328232; c=relaxed/simple;
	bh=7eNeFJx9fu3HeVGO7sMld6c2F5KIY9EmjAc86hsUYLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p2dpGv6BaIrujKzcwFwRzqfuYzzElzERglrqL/mohLazijteef7gll5pFdvKrb7CYZE5birLDVvDCX0/XvL0CJjKYPuBtQ+jGwQYvZZv/cbtR1nmrTDKCPAAojFCvx8xrNe6Na1FwODk7hZmt9c/FGbUJzfP6uSuW7ntzJeqM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhFHD4k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0749CC433F1;
	Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328232;
	bh=7eNeFJx9fu3HeVGO7sMld6c2F5KIY9EmjAc86hsUYLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhFHD4k198OhWThXBYOyswAKv+ZIcyiq4S9Pi9AXV1zc1CJAPqrazJFR10x/xCz6A
	 I4fE9YaUziSN9jxMc9WlaOpUFoPZkto4rE4CykHad5FV8lgNmgbekNiRsyly5YfPIE
	 65VQRNMSgeODCu1doAL6u0AUTE+ilAZBqVqpZYuycLU0OxEPjUSOtWxsiVBH9ByIqX
	 2zNWPshTOAICmo7FChItAcn/F51AFKX05zCryWTyL23La3ldK72xgepnKBfLpWkyp7
	 DmKmtY4ywjZBubcl8Roe9GyzCN+lUOtdnxeNGPaxKvVlJwnbKj8Wtbi2FhLPlaOgFB
	 rkwhSk2Ocxw1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E55AAD8C96F;
	Wed,  7 Feb 2024 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: intel: fix old compiler regressions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170732823192.3503.5684754555089844535.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 17:50:31 +0000
References: <20240206022906.2194214-1-jesse.brandeburg@intel.com>
In-Reply-To: <20240206022906.2194214-1-jesse.brandeburg@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, arnd@arndb.de, geert@linux-m68k.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 18:29:06 -0800 you wrote:
> The kernel build regressions/improvements email contained a couple of
> issues with old compilers (in fact all the reports were on different
> architectures, but all gcc 5.5) and the FIELD_PREP() and FIELD_GET()
> conversions. They're all because an integer #define that should have
> been declared as unsigned, was shifted to the point that it could set
> the sign bit.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: intel: fix old compiler regressions
    https://git.kernel.org/netdev/net/c/75428f537d7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



