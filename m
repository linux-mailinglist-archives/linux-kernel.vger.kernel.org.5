Return-Path: <linux-kernel+bounces-96820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436268761DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4E8282A50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495654FB2;
	Fri,  8 Mar 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUeB2VSz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB084F5F9;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893231; cv=none; b=nEYIvdmX8om0k5gMy9PhwrGkGB9XviSs41WJ8BCnhOUzfArAtZZ9vVepaqoWBGER4PvCVqkC1yHrIBmLJ3OhUm+IXk8BV/7E8JsWGj/Q276er7bBdrsYoG6ddTxvHijC7Cgvf3dde/+sRTDBekjD9/HwKdxZEZI2rsrBz4ET+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893231; c=relaxed/simple;
	bh=FdfTPt0yKjeUfkUPkG1nIroPC69DZK4OHUJS0wvPRGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QTQLIJonBpTXwc6bUts2ZevaVbN5Hr9mKgn8fnvYrizgHy8t/u6VRRyjL1Kc14pi0YkFk98tTbL/wsTjUn4ivIN5in1x6ovAPTYHNcdGPvGRTNTwNKiFY7xk2MyXOy4oAHbgrclUPlQO40lMeatcXAAV/cFwDhuVgvhOhhuiBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUeB2VSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C69C433B2;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893231;
	bh=FdfTPt0yKjeUfkUPkG1nIroPC69DZK4OHUJS0wvPRGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HUeB2VSzgMkt1CvW1ertNGGllRTTM9XlBN6Vv3884mkFJ8pUv62C+EFo7UVGsxn7u
	 wAFBQwkjiN8gN4hYu2qsqhCevi3yw/QAn5aQ9TC75glVouGLT1/BBL8BsL/9eP8Qk6
	 Lw2OsvanYHPTpk37xa9m0XorDFrDCC8uZpCoYy3Mbp50hHYdVFVPo6GMRDAZLJpKL9
	 ZB3ENaj3gYxiC4XDof5w1mlvLGwxFB2Oj9lJuiSTtm0pfHBqUNMntDUNMqIi0iHBz0
	 0N2AFEcKBWg5ZZ82Dq9eui6ubLfOwwm6pSJCux7D7VNxRudvNR9Gv49YZMeVDWxPK6
	 ddOwQBzev/eUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A288D84BDD;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy: fix phy_get_internal_delay accessing an empty
 array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989323116.6327.2942452458797503240.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:20:31 +0000
References: <20240307111906.297749-1-kevin.lhopital@savoirfairelinux.com>
In-Reply-To: <20240307111906.297749-1-kevin.lhopital@savoirfairelinux.com>
To: =?utf-8?q?K=C3=A9vin_L=27h=C3=B4pital_=3Ckevin=2Elhopital=40savoirfairelinux?=@codeaurora.org,
	=?utf-8?q?=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dmurphy@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 enguerrand.de-ribaucourt@savoirfairelinux.com, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Mar 2024 12:19:06 +0100 you wrote:
> The phy_get_internal_delay function could try to access to an empty
> array in the case that the driver is calling phy_get_internal_delay
> without defining delay_values and rx-internal-delay-ps or
> tx-internal-delay-ps is defined to 0 in the device-tree.
> This will lead to "unable to handle kernel NULL pointer dereference at
> virtual address 0". To avoid this kernel oops, the test should be delay
> >= 0. As there is already delay < 0 test just before, the test could
> only be size == 0.
> 
> [...]

Here is the summary with links:
  - [v2] net: phy: fix phy_get_internal_delay accessing an empty array
    https://git.kernel.org/netdev/net/c/4469c0c5b14a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



