Return-Path: <linux-kernel+bounces-20053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F88278C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6F31F23E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C50D55C1C;
	Mon,  8 Jan 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXkQnT4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB85577A;
	Mon,  8 Jan 2024 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D11C8C433C9;
	Mon,  8 Jan 2024 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704743424;
	bh=0R3bpc27hcCzzufZYy8bYrLwXlIvquQi9vH4lSu1txc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uXkQnT4GkZK9j3hsFkK7Wa4gCks+oVxf+oU5Bjt9LDpPVP3wzxajXkOJIHKodqO4y
	 XLKMulzxatP9ASPPWSXiRxcxKdwpXcYFLBG+Y6HFQWyfggeTKhItqZZ6C4bLO6PA44
	 mSege+o7McbESQCY4arkPh5yrRvlOmFEG0NUZC7Hz17p8duzX7dkT+OvRQ6tgXFJby
	 OtIKlJtEHqi9oeL/DmWfho33ubkV/r8relvmNGBAClxTlJVK/oBZyKg5AZ2kJuIuSJ
	 U4tGyVBUCWj5tygSMuBj258m1DosIBguXXzsLk7kNWfq1eZN4AUh5Y3g0AoWBledEf
	 Y8B0UFXGLddzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8BFBDFC686;
	Mon,  8 Jan 2024 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170474342475.29412.16996245383427159713.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 19:50:24 +0000
References: <20240107180252.73436-1-verdre@v0yd.nl>
In-Reply-To: <20240107180252.73436-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 asahi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  7 Jan 2024 19:02:46 +0100 you wrote:
> Apparently the firmware is supposed to power off the bluetooth card
> properly, including disconnecting devices, when we use rfkill to block
> bluetooth. This doesn't work on a lot of laptops though, leading to weird
> issues after turning off bluetooth, like the connection timing out on the
> peripherals which were connected, and bluetooth not connecting properly
> when the adapter is turned on again after rfkilling.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
    https://git.kernel.org/bluetooth/bluetooth-next/c/f48705f473ce
  - [v3,2/4] Bluetooth: mgmt: Remove leftover queuing of power_off work
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e7a6a997c9a
  - [v3,3/4] Bluetooth: Add new state HCI_POWERING_DOWN
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b16c80d8011
  - [v3,4/4] Bluetooth: Disconnect connected devices before rfkilling adapter
    https://git.kernel.org/bluetooth/bluetooth-next/c/088656165c2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



