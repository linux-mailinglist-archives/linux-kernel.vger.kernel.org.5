Return-Path: <linux-kernel+bounces-162820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294FC8B60FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3ED81F22172
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3871292D5;
	Mon, 29 Apr 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGR+pspE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AB83CBA;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414829; cv=none; b=pigJBSfrllSylYRyzsxg62dA/8Rirlh6QuGEuoXBLgU4r/ljiEGyAI5K5pm07r/aW1UijjKnbploRLedl0xQW5E2Tm7TIFDQPuKpYIp/868OmsBS8Gq1bj0tjLTuIeK8MW932UcOC74ga58pmLzZThQZrjiesc2yjdA9m7HI/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414829; c=relaxed/simple;
	bh=dGmtY5+jMF8PJ9ZV/XXsNc7WuNrNyi/xT8wF2Jt8Tew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdKzYFR0TFhnC0ObH/CD4YIuUtM/Bw49BvMuCLuk04eBt+6gVVntjMsYP5E7LKzl3kb3PRaNqvSyaOsEb3vF4eOowFQYxQ71/7MQwHo63bK7qngM0O1qxl9ttr+yeofnMIYgA1dI/PGOQXAGuLk4aF8a4pzQy1p7qyzWYuL7qy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGR+pspE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D44C4AF18;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714414829;
	bh=dGmtY5+jMF8PJ9ZV/XXsNc7WuNrNyi/xT8wF2Jt8Tew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGR+pspE7/UvDD/fF7masf3/K/2bOkEpdlDXmCOyyoNPfv1sHV7bGtSBa5fVkKEhr
	 E2M4khx6drfiljSZ0ECBx3uiNeYP1QhFCj0gHm8FJBMr+uO/hTFnl8AyOtqmU8iYn5
	 PxNGp1pUai40N/tYddU4b/VmYDwRvc2YxfYrNufycRewKpdZomgKDu8h6nRPLvrZHS
	 uoT2v/ktmU3eA18ihQwDn3WPC7tMorESQs/WRQKHcsLGJ0O4fX+hyjy5F9BjOF5GZ5
	 I+9SERix7/pNhDlRqQekBzuZ6row2SUq5wJLVcZptoZ0libdm6+qMoDnU6k/49UYpK
	 TOzoDLQz3nwCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B2DFC54BA4;
	Mon, 29 Apr 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use __counted_by()
 in multiple structs and avoid -Wfamnae warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171441482917.19588.12121377571825862900.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 18:20:29 +0000
References: <ZiwwPmCvU25YzWek@neat>
In-Reply-To: <ZiwwPmCvU25YzWek@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Apr 2024 16:52:46 -0600 you wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> [...]

Here is the summary with links:
  - [v2,next] Bluetooth: hci_conn, hci_sync: Use __counted_by() in multiple structs and avoid -Wfamnae warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a4008a5b0e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



