Return-Path: <linux-kernel+bounces-84466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A920686A723
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DA91F2C197
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CE20327;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhYAR4Th"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E21DDD5;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090432; cv=none; b=Qo7fMjrC9CMYH9FFIcwSbg3aEF+aPUyRlVZmIgwdh+NR1V9j8OY/Y7DbKapJKMBp6uJ4kflkdCPjVWQYDPh94jd0FuqqX++yez/YsCtPtKXzswOMX2riGKuFLJ6lEvNk/4TtW/RNWt5ZMgiczhib/MsAAJkLtph+8orQhjfaZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090432; c=relaxed/simple;
	bh=u0axjAWtAcxEr7ZjPkE5IqKAR+IemnMqd88N4WKuBBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QXmUlXHVioqRozNDgOjJO6TaMtRjbg672kN3MLP1EH78TrAuJTP+mjeaQP76BsitPzk2lmHZwQ1YhVk+Ml6PGfMnubKQVyjYjmj3AKsef8Dak4ZPNN5TqIN/QUXUVy9wEo2sW5Vs7/n35Wq8ci3NGBQofzqWzwj0Rew3B0kdvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhYAR4Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A10ADC43390;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090431;
	bh=u0axjAWtAcxEr7ZjPkE5IqKAR+IemnMqd88N4WKuBBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhYAR4ThtSche8nUOdqUa04SsV+s72UyCuiyQo02gy5DxLiaOuj1wNrONe0Z7phE4
	 +8iGJvqcleo0pKN7mmt75OFNkZeq2XdbDaiNtSQe08OCU9RdLNqbnb8zgA8fVRGP6W
	 GUHDy2Y+jNDWPpM9+iE44TronIoxJlkI9uH6vV6czwondDIkOmdek3xIWnUCoB4Jpn
	 hGz803xQ8v2+W7Jb5o84Qv10PxVFWv8P6r3F2dqz8B5mEkAJFgM6BqqWZBH+w2CF9i
	 NLi/CNDFHgGa82DWB9bHyIv1yeHLWihIuwDyr0Nnm6AJ5NNsmkbt07z+XlF90EJ6Bw
	 Mtr0iq1zVDe8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87DA6D88FB6;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909043155.27277.1060670387014071329.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:20:31 +0000
References: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
In-Reply-To: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: peter@korsgaard.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Feb 2024 00:20:06 +0100 you wrote:
> The MII code does not check the return value of mdio_read (among
> others), and therefore no error code should be sent. A previous fix to
> the use of an uninitialized variable propagates negative error codes,
> that might lead to wrong operations by the MII library.
> 
> An example of such issues is the use of mii_nway_restart by the dm9601
> driver. The mii_nway_restart function does not check the value returned
> by mdio_read, which in this case might be a negative number which could
> contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).
> 
> [...]

Here is the summary with links:
  - net: usb: dm9601: fix wrong return value in dm9601_mdio_read
    https://git.kernel.org/netdev/net/c/c68b2c9eba38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



