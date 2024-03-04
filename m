Return-Path: <linux-kernel+bounces-91308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DB870DAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF0B1F2158E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC37C6E3;
	Mon,  4 Mar 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0OdNdLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9C7BB15;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587827; cv=none; b=GmtBmm1hKkLMRO4hDxEfw2kNkqoVkyDgedbn0EFCAG6cE+MD9UrMlTFJ5GNetsxk+kN7vfb10xOtt/0RNZFarESMQJY7+3Rvk/1YH0orxV8ewA9FmcJ9JOktry7xtGDRkQSbWVgjQOkuFIyezV7J5CQaVAQ9otZlfs1813QoHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587827; c=relaxed/simple;
	bh=wQM4E4uvvREbG1oZD2w8qlYgmeXO2Ul+K0vshQ5kJXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bui80npAGV5NQ1N2GZnwyP20HJ8t6aUKPtSu5a9Rt2533uRe1vQWoid+NMbmW4lxOn/KQHaWfvtPWfqFFeeSLnNez+rw/KlWqkRM6YDfFrY61bYYZ3Q9pkGqL0/OQGgPJA4iADvZx55+R00ru91Xd1sRPpPLz8VRBlfbug3tn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0OdNdLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62622C433B2;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587827;
	bh=wQM4E4uvvREbG1oZD2w8qlYgmeXO2Ul+K0vshQ5kJXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E0OdNdLJwxx4n2N3kns2ufibbx9G5yVLeD1Bn6/FXfZglaOgIoDNrvYrRja9n0zFw
	 c3qE171XnwpBbfNvC1qCbq/fODoVm4gXzgg1VKnjWBQw1p/YEbX15/v3w8gUVSdY1M
	 eOLH4ldNuZxpqAWqbqpKzhXCRzCv3gco7mwpn4X1PG0OeT+uquC6rUOKMpC1kHzoh/
	 VV5WNbRGMNNQgCSgc8R10FPI/lNENlEiS7HUjKID+MckRQpq+EHvgPCTqvJ5ck08z3
	 +5xYb3d0I2IYX1VwsCkrZegosY20KWNev1bIzUP0Q5QUjf6zAaW43H0r6J+nRXkrc1
	 lmW7qfXc15gqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44149D9A4B9;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Fix btnxpuart_close
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958782727.29902.5588082329084966658.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:30:27 +0000
References: <20240304181421.14777-1-francesco@dolcini.it>
In-Reply-To: <20240304181421.14777-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, marcel.ziswiler@toradex.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, francesco.dolcini@toradex.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Mar 2024 19:14:21 +0100 you wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix scheduling while atomic BUG in btnxpuart_close(), properly
> purge the transmit queue and free the receive skb.
> 
> [   10.973809] BUG: scheduling while atomic: kworker/u9:0/80/0x00000002
> ...
> [   10.980740] CPU: 3 PID: 80 Comm: kworker/u9:0 Not tainted 6.8.0-rc7-0.0.0-devel-00005-g61fdfceacf09 #1
> [   10.980751] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
> [   10.980760] Workqueue: hci0 hci_power_off [bluetooth]
> [   10.981169] Call trace:
> ...
> [   10.981363]  uart_update_mctrl+0x58/0x78
> [   10.981373]  uart_dtr_rts+0x104/0x114
> [   10.981381]  tty_port_shutdown+0xd4/0xdc
> [   10.981396]  tty_port_close+0x40/0xbc
> [   10.981407]  uart_close+0x34/0x9c
> [   10.981414]  ttyport_close+0x50/0x94
> [   10.981430]  serdev_device_close+0x40/0x50
> [   10.981442]  btnxpuart_close+0x24/0x98 [btnxpuart]
> [   10.981469]  hci_dev_close_sync+0x2d8/0x718 [bluetooth]
> [   10.981728]  hci_dev_do_close+0x2c/0x70 [bluetooth]
> [   10.981862]  hci_power_off+0x20/0x64 [bluetooth]
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Fix btnxpuart_close
    https://git.kernel.org/bluetooth/bluetooth-next/c/3f40a47f3589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



