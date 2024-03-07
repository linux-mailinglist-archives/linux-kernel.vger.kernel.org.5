Return-Path: <linux-kernel+bounces-94971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189E6874768
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07471B232C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E251CA9A;
	Thu,  7 Mar 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwfjyQb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C856AB6;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=it9Y6OaPeffQRtEW+3TrdxfdC5lZWLP7utpi2nMV5SKgqOV2+kZPW21EvaQzHl5AVwapODV39u9gafKsW1fcVnq1cF68U27ywUk8mXhgJr0Bl689O7BMZU6xHCVc6jebFsNDlq36Ind0FQYRPMtqAzFupUPoL4g35+rsggYK8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=F/D0AFTQA1rWt7M3FC23pO3tjkdfYMe57HcF5/pb1wQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pbDaTzP76moJBQM7eQsAjOvLhXG4dAllEeZbyRUIYzbHz4YRnKdhak+NxFONU7c46/bsRRIiG+8+Ji+9BPQsgckXT4PHnLy24FWRocF12xXakJ5wJZjzbf0pyaJZmWUmhpZQHofk3tebYR17CyYs8B6hWzk3sem8OiJ4R/JztEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwfjyQb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5B41C433A6;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786431;
	bh=F/D0AFTQA1rWt7M3FC23pO3tjkdfYMe57HcF5/pb1wQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZwfjyQb9/swVE8cnMGrLb6i+49kwhEEATXm8c+Gi4shi0vtohL98VXUbMgSm6ude0
	 /qxKgSTtrIYPb0U95k/XWFzHKU4l/Iuu4Q+xj9GfTN1iv3wx8rHB8AV3KvvvBHkF3n
	 nJQT72PO2d2pygkcH/H408BSQxkS28+5P4s1l2UXCWFDOB2ywtbKD/1YcE6hh4guZd
	 bLRwCV4FtBru6EpPPG+bMtvMNbFSwPTgi0APDSf6Y/yfU82rcPTQ+I8oBBSgU1U5Hh
	 AML0OAeVkijqGdIAhCk9wvTRETrZsfkaxCWrpMXyvSUCre843NYjWNxv6rD/fZ9ReN
	 ZuStzMGeWq7lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEC70D9A4B5;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sr9800: Add check for usbnet_get_endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643084.7855.4814216830505306381.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:30 +0000
References: <20240305075927.261284-1-nichen@iscas.ac.cn>
In-Reply-To: <20240305075927.261284-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, justinstitt@google.com, andrew@lunn.ch,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 07:59:27 +0000 you wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/usb/sr9800.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - sr9800: Add check for usbnet_get_endpoints
    https://git.kernel.org/netdev/net-next/c/07161b2416f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



