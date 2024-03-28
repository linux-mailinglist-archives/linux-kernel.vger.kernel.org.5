Return-Path: <linux-kernel+bounces-122722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33788FC11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7F81C2EC07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD87C6CA;
	Thu, 28 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt4wAvzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58B7C08C;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619430; cv=none; b=qt+bUBLwBBBTgo3o5r96KCQJ65xvGpt3rBjoeOkOI1lrcLWzJ+c/+gw+sVLG5DGZ5yGFmlZsn0FU0o2uUsPTwZWHOLLxIIJjtKX9b36riR/l48mOqSYUCo8ge7wSDPBZW1ttB/Uk+R06XoASjUDnVQGDhxQg3VHGSYU7PBCBbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619430; c=relaxed/simple;
	bh=hw9CXjyBt1jqIOFA9VS3MGEAq01vM/E+/Dnp8mAip2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svNcDgiSAulIeMdB4lp5KzDdZSxNQmjO7ruF8M1ganbFVHfSlN9X69UsNdSGiFkljt13JsCW+hUE9sR5hg8TD21DLr1ZrJ7ursupY2il4lHO4rzlfjCIqZkgaNJkCEuPPbEnzJ02SUkoAwRp5UJINPd638OAJb4WzW8sXMfgE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt4wAvzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D448C43399;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619430;
	bh=hw9CXjyBt1jqIOFA9VS3MGEAq01vM/E+/Dnp8mAip2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dt4wAvzN5ozOMy2FY9l0OWR8MfisK06g3BLLGmuDYQZFOoEwAtdrFwQanMBgM80Xu
	 Cbh0EKEp2O3Bl3B224dqiSyfedWDiywmJk+M4s54hE3BAXOAhYDKgFcTtzj2pWiagl
	 zM9Kmj8AcJ4mlItwBaI1oK0Jhc6IfeS33CHVGjT9cQ9eHKVthr+AutAaurFflo4QmZ
	 H661gJJl/ZXFco7TuNL5UxTjLk1+fi/l7mz5NWAlXmu+O+n+g3WxM4xs1O2OVxjU4X
	 P/mjoMgEl5IQjAoLQZ/uS3L9ooXMFwsiqyYjFnxMZ1DpyA3sdKcdM0dP/CyzQyhHm7
	 j5IcpRUD1EF8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46445D8C965;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] net: phy: qcom: at803x: fix kernel panic with
 at8031_probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171161943028.10354.7334071604258663095.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 09:50:30 +0000
References: <20240325190621.2665-1-ansuelsmth@gmail.com>
In-Reply-To: <20240325190621.2665-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, wwortel@dorpstraat.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 20:06:19 +0100 you wrote:
> On reworking and splitting the at803x driver, in splitting function of
> at803x PHYs it was added a NULL dereference bug where priv is referenced
> before it's actually allocated and then is tried to write to for the
> is_1000basex and is_fiber variables in the case of at8031, writing on
> the wrong address.
> 
> Fix this by correctly setting priv local variable only after
> at803x_probe is called and actually allocates priv in the phydev struct.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: qcom: at803x: fix kernel panic with at8031_probe
    https://git.kernel.org/netdev/net/c/6a4aee277740

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



