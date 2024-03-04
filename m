Return-Path: <linux-kernel+bounces-90938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E41870707
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F0C1C20B63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185E4DA09;
	Mon,  4 Mar 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TteyW69m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84342071;
	Mon,  4 Mar 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569829; cv=none; b=jGw8CR+OK2q+FoIkSTEOOc1SYfGVELot+TZ7wqUcPgz4aUuDvhjlQiB7gBWXTAbjyzrUOtZRPpbFVkBH8+MP9q3umk9eec93bq4pGXhP3+OlOtL14kPIyck/1EC5Wte05X8TfZOFQBFDjYncCrFcnXcdis8ymj6Ne41ZJnokZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569829; c=relaxed/simple;
	bh=OSXo1H5aBhl5e2r4vyWeRTS/snB8L/hD9fmPaQ9eJVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjDLcm9dAGwor4Zb1n227UfqNTMhf1P9jzUqC1nSkpFqO/Xq2ANdwMG1ETPDhtzBCjeG94apkmGA5ZWtkTdzJeUgR9VvPi7LEq8qsENxSw1OnbEQggjQj8RNXDsSYija5iPbEwgoCDtmzY3BOHH2GsbalFIuL8UL3odX0eZy708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TteyW69m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C5FC43601;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569828;
	bh=OSXo1H5aBhl5e2r4vyWeRTS/snB8L/hD9fmPaQ9eJVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TteyW69mbX0Y4JV5NE7oDqRnEESPRxny1kHjL3sDpsoEkR0xagTuTvcw39ZI2xIGZ
	 5gmdF4T8HjloSS0u6PJHKWXEXtdjvduE8dgW43NJJKYjfBV3D+KqfIqBZtiL0MydZX
	 7U2xzfTONwwv9l9GPQRsoSb4eKmZG2IwLQm6zr++0hUuYJlWP/+2nN/jvPvwSM74sO
	 qs4D0Or38PTpGORm0UJZdXFD+Vj4QRvwfZ1GZzcLinyGTSTFiTLufjDMd7dPiEcZZj
	 DpNz1FIo/PwUEI0/h3cWolsCXZb+7ppgttGLbUO1ZmUykP4I9aXe7B/JhRxKEDa4mA
	 cgDliRXCxvStg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D13C7D88F88;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Clean up returns values in iso_connect_ind()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170956982885.9053.16120975602469036766.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 16:30:28 +0000
References: <5f73d9d7-61d7-49ab-a5e3-adda72685122@moroto.mountain>
In-Reply-To: <5f73d9d7-61d7-49ab-a5e3-adda72685122@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 2 Mar 2024 11:30:43 +0300 you wrote:
> This function either returns 0 or HCI_LM_ACCEPT.  Make it clearer which
> returns are which and delete the "lm" variable because it is no longer
> required.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/bluetooth/iso.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Here is the summary with links:
  - Bluetooth: ISO: Clean up returns values in iso_connect_ind()
    https://git.kernel.org/bluetooth/bluetooth-next/c/d64e5af89e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



