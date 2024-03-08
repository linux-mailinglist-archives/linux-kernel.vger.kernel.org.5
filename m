Return-Path: <linux-kernel+bounces-96517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E2875D64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1254B22A97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA23D37171;
	Fri,  8 Mar 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXo6oWW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA12E85A;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=m0Z9Nazr9EqF973vn060Z4pNOtOIYgy8rPUzVZi9H6T39wWlQFsJMnt5gYeIFTgw6Oog2TeUhAImig2inmZ8RR9o4GLqHD3t0ZDe1/F7aiSgKqp0K3R36Z291TCzJBSDidPka0bhomO0nrr+3amIaYdCPMGwz83IJ/OwcMRxymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=5C1CPdakz9h1M2QOj502KAmjWGdW2B9uCUojD3Ao9+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E8Vu0uzyYln1VTmuzjMh20NLX5xlADxGgeFVxGnwwjHp8QhBqCWfmp18/K5xKPUBlno0QJkElsreyNvw/F4mCx95awBoFUzqQcAwoibpIqN8XGPeHhX4YAaxFIoNVovVzdrZRomnlr6NZhwdP72mKbsW4ZBm1Iqs5AzfCDwezcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXo6oWW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6ACBC41679;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=5C1CPdakz9h1M2QOj502KAmjWGdW2B9uCUojD3Ao9+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TXo6oWW2vAR9lVW8YGthY+5zGlfYYyXeLgw6zuhy0hYkm++pynxyA494DbjAwzOCL
	 ERtCkdjHSNEj3dISDN3sk5ie/KiAOtYztve1G6dDeHZvbgfstcFU8P6Yoyf+sbNbd3
	 ijpuxV72NkstXBd+Wvs6/g1wJYbBnCpOikbOcFnAm5PFHf4yB2Oav/h8+yaHvd4Vyh
	 uJ8d5wKTmdiy5LIL2apS/A25ML2HgM8VgSC/FQ1dBMS43cvULYw+ECtbJMKV/vaDQs
	 koxwj/TfP8jFUZoH1R8wWSxWu1GdQH/xgllf2H1AwFtNfI4BWe8I1z/pRvpaEQ9tmS
	 lpCyV5XBt7KUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92B9DD84BD9;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] isdn: constify struct class usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403759.8362.17894165442379063106.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
In-Reply-To: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: isdn@linux-pingi.de, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 Mar 2024 17:04:46 -0300 you wrote:
> This is a simple and straight forward cleanup series that aims to make the
> class structures in isdn constant. This has been possible since 2023 [1].
> 
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - [1/2] isdn: mISDN: make elements_class constant
    https://git.kernel.org/netdev/net-next/c/479b4bc867b9
  - [2/2] isdn: capi: make capi_class constant
    https://git.kernel.org/netdev/net-next/c/12fbd67ea3f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



