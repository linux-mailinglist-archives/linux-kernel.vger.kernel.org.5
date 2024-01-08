Return-Path: <linux-kernel+bounces-20054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC778278C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B56B22DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F555C1E;
	Mon,  8 Jan 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of11SOuH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEF5577B;
	Mon,  8 Jan 2024 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D0FC433D9;
	Mon,  8 Jan 2024 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704743424;
	bh=j1K6uvKTfv8SeRcBwXRHL201MxlihPet/CzG7DA+U7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=of11SOuHwSS+CXYpcp5c8E0tY1FY81lsvT6ujUOK6hbnsG4w6nr1dP0kq/bDofmTH
	 cnP7TfVGQ9kdUCTuBSXh0xE09NHwfgqxEnB/NXdtlGLnQrKIT2qM4X9g24AUkuyHml
	 3oyqF0I2bg+4xvP9/zZrp3E9nBYphceLrcs1kETkX2a3TaFx6xuYYJRvSjKazRyqzZ
	 9lPnBRIYy8FsVO3jd7rmMwFW6QKUuL/eodujIJFEQ+EzpmxTf4SluW+boVS3bu2/O3
	 RMGtSw6nH+TPpdKV3fpNCVhLquRPRBsvIRbWZ0uUWZtqjTCZMLkvSBB5LPZw1c5m62
	 TCdhLAfd8Vqcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFAEDDFC690;
	Mon,  8 Jan 2024 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] Power off HCI devices before rfkilling them
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170474342471.29412.9439877422079885487.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 19:50:24 +0000
References: <20240102181946.57288-1-verdre@v0yd.nl>
In-Reply-To: <20240102181946.57288-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 asahi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jan 2024 19:19:16 +0100 you wrote:
> In theory the firmware is supposed to power off the bluetooth card
> when we use rfkill to block it. This doesn't work on a lot of laptops
> though, leading to weird issues after turning off bluetooth, like the
> connection timing out on the peripherals which were connected, and
> bluetooth not connecting properly when the adapter is turned on again
> quickly after rfkilling.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
    https://git.kernel.org/bluetooth/bluetooth-next/c/f48705f473ce
  - [v2,2/4] Bluetooth: mgmt: Remove leftover queuing of power_off work
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e7a6a997c9a
  - [v2,3/4] Bluetooth: Add new state HCI_POWERING_DOWN
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b16c80d8011
  - [v2,4/4] Bluetooth: Queue a HCI power-off command before rfkilling adapters
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



