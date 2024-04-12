Return-Path: <linux-kernel+bounces-141837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A68A241C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBCF283DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348817555;
	Fri, 12 Apr 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlrcimFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9D134B2;
	Fri, 12 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890830; cv=none; b=R9Zsiik4ssI/Ik8vNdZat7mIt4rPPegcu7lW33GfxvRtP8qMuW72N9NLH93cbDEv4Y6sbgZJzerE5FXnBf6nN2VmXlgrA7OV4AphVMeOmlKqHb7PRZYrOzqz8EMlL5VRSBNMfuKOaXKKTp148ZeX3gERpFZRXfbGfcTmK1JouqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890830; c=relaxed/simple;
	bh=xgQp/R0CH63gDutvRq7lxt37zWTokqFaNm+/NVS0NVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ix9rM/ttsebEJ7MTROMXvYRtQ8cpfL2No76zHLbJ0DSKqFwZsU8uWv+0TmnqRqiKpNTR01tIVAcwhAG2zwXsce9xK9D2waxhBLYgc3R/XVBlHVcFqs4vvuQx+Mxgvm/V8u0GAtiV0jqXgXnzsrYJT00ohmGqDUzBZC6uMZ2Xsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlrcimFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0753C113CE;
	Fri, 12 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890829;
	bh=xgQp/R0CH63gDutvRq7lxt37zWTokqFaNm+/NVS0NVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RlrcimFQylvNQpfFXiWOhGYAhm6ZIeKw5VwC6Q33ypikmnxXIdFnzI6kSaRN448q4
	 GAO9v/YLFK16yOCbygQhxellsj/JanrMgWAk3bLflPOFQHxMhkI7CkuMSJOk2ehW2+
	 fg3aZU4L3cfyW6I60+s27F4Nf4ZpAO3hX5bAmosEeYeXpq4PRSywbwezN/kVrAWK3g
	 pnUIAeeb54GmyMJtK6PYB0q4oDKMa3Qufwr+X3SZHA/QRaqgOFIFxrHBRd0mPg7sKj
	 itH6Dv5fOPnKqNmPMxVyKCb+l6Bj9K8BcifesQQKF6IQUkElmscUhL8EkpmK1b2smJ
	 RfZDitqe1hcOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDF23C4339F;
	Fri, 12 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: usb: qmi_wwan: Leverage core stats
 allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289082977.20467.4450257396019552508.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 03:00:29 +0000
References: <20240409133307.2058099-1-leitao@debian.org>
In-Reply-To: <20240409133307.2058099-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, bjorn@mork.no, oneukum@suse.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 06:33:05 -0700 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: usb: qmi_wwan: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/8959bf2acfbc
  - [net-next,2/2] net: usb: qmi_wwan: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/3cddfeca9f02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



