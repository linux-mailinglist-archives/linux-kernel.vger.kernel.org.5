Return-Path: <linux-kernel+bounces-73572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA485C45D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D571F250AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82D14A4C0;
	Tue, 20 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVP6t+dA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28D134CC0;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456229; cv=none; b=Xji5FOE5YC7TzK5rrs8qTsBiFsslqKGgxCdHkfzaC/tKjdxUeIFw+K1K+RVajzGtxuHCsTxnggBuN8Or5GWLQ5OEFqMOGlZuXhCNCyBU7YPgnBoY7NTkldHCcGIglSQsdgnJMHEpAfzyXGxWpdkWFSLyMrAyUFf6c5LzpRv6oY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456229; c=relaxed/simple;
	bh=27nB2IlG0oC8pl+ybaf2Om7tssbnEIBfziDJLNGJSok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jE6zNk17/LkRzOQJre6XOjZy1dSuzBCJgIX2s1T3+46QVzEJ/+oe4xhgknlASUedcu4++hT/mh4qWk1gANq/VO1iZHnTWcmylmCGQ1h+1gAVNoQ+UosDQ3vpMLpXYu0gsgQ21CGEDImzfavcrc2dfqOhXf+hpcZDISMEFbghYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVP6t+dA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B451C43390;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456229;
	bh=27nB2IlG0oC8pl+ybaf2Om7tssbnEIBfziDJLNGJSok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVP6t+dAtJQokj8FfTq6+AnOPOR+LMbEANCMVHPKcWUwwc+DX74J7NVK4Rr3+EVA/
	 XKOruX5SBzACWyfMVFi4ilGr0ybprB5YKXa1QKHQ8+0gKci0r7fVXGwbg4W3/JM2Rv
	 jSYp6eFF4dHC6iLLDrHOzZIUHhwAnvcjL3Oepd3szUM+5H245YIJSeUXFEoojYOIZR
	 b9hBuAkNbxo2udYpiRUV0CBAMR0GKR0QJA4aXEUfVWj27dDrKxs3gTOcPJHxnefZ1y
	 IFN2hNyQOV/ub+r/SFlscya7Yv/Ya5LNGnEtEt9W/Ad+1+bMkTfAIwz8qj2kSXxltZ
	 RKeL8ylOkO9Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40C31D990CD;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: constify the struct device_type usage
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170845622926.2554.17835222559444960671.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 19:10:29 +0000
References: <20240219-device_cleanup-bluetooth-v1-1-dd81ba00c95e@marliere.net>
In-Reply-To: <20240219-device_cleanup-bluetooth-v1-1-dd81ba00c95e@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Feb 2024 16:46:57 -0300 you wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the bt_type and
> bnep_type variables to be constant structures as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - Bluetooth: constify the struct device_type usage
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a496378559f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



