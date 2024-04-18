Return-Path: <linux-kernel+bounces-149429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4B8A9105
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC81C20E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8D4F1EE;
	Thu, 18 Apr 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQfN4635"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8253A1B6;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406228; cv=none; b=WnKatNzlkuSQNWeeXEkgeku6pfpI1Ji3dPcOItbmpmxtCbHyFQ0bHq9X1A5VPs8xAI7hEk8ygrdK50kX0abjWGjDpdXXLIxE4kN/+jEEK7S+Nyl7X5+I95tSV4YpW2MSo2HhmWCQmWQchRO07JXo/g69hd5F3Ey86hNuyo9RzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406228; c=relaxed/simple;
	bh=1NyEoWFlnIZwCKkRFjuPR5qYJO8RuWrIDtqwc7X6idA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpgyB/hXcbKDpnvhFVADNfJhZaluX0vZJ8NFeb3+FDbju6YpQhMjrNnN/DpGo3vNnhcMeXUijGZra7pEJjyg3DJqdsbxYgybSHVasa0TG/huArCd00pjzZJg6xZfVDAs8erwX8X46hYCXu1mwFD14koVS1o6VmHyWGmS0a1+TLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQfN4635; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43580C32781;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713406228;
	bh=1NyEoWFlnIZwCKkRFjuPR5qYJO8RuWrIDtqwc7X6idA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQfN4635WdxeOrE8SpYLCKp9+Kkm+SSt3bxqVS/xIMAjfzULXu4K3xi7aldjH6dJe
	 NbOBlRnRamq88p+gh5OgwJfTeudhOELvcdK95AAwxX/cUIPMXx+gMBckxkBbMcdR5e
	 lVEkoO/GyE6c3e/AJOFxb1IbkNvgT0LLw5Trf2gla1bIbankZ7Xxe4zl7LE+pX5d4T
	 DI2oPLUWzGCeTMzK8rBw/HB3LoaXwks//dhrMDo47UESj4+xi80uEhF4CFCeORuBHd
	 TAgsSscOy5O86JM7Gyy4M8yB6S/scigQrWw7UWlOIcZq28VSVZCHgFe5IchwVGuS+6
	 qtL693ATrSEKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3224FC4361A;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net:usb:qmi_wwan: support Rolling modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340622820.10413.13640952951998586061.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 02:10:28 +0000
References: <20240416120713.24777-1-vanillanwang@163.com>
In-Reply-To: <20240416120713.24777-1-vanillanwang@163.com>
To: Vanillan Wang <vanillanwang@163.com>
Cc: bjorn@mork.no, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 20:07:13 +0800 you wrote:
> Update the qmi_wwan driver support for the Rolling
> LTE modules.
> 
> - VID:PID 33f8:0104, RW101-GL for laptop debug M.2 cards(with RMNET
> interface for /Linux/Chrome OS)
> 0x0104: RMNET, diag, at, pipe
> 
> [...]

Here is the summary with links:
  - net:usb:qmi_wwan: support Rolling modules
    https://git.kernel.org/netdev/net/c/d362046021ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



