Return-Path: <linux-kernel+bounces-50467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465C847976
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0007928B204
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC9130AC3;
	Fri,  2 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTXKrRDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77441308EB;
	Fri,  2 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901029; cv=none; b=KQ7cCrhEVSQUA0O9IvO0qIR4tG8TKP4h+G711lMJDmlW7GyNHtTgzXRPZqCkVgz/OjE8rxn+2KlrtFoFlFv2OMUvcvR3iCL61XBv3f+oi/o+dVeB85RcPlT5Yi3rWyl2pcfg8VRFGUBuJDviF1tAIim5JEqxxfGMAKjTwj4FXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901029; c=relaxed/simple;
	bh=bijxA1yrZckpJTvIg3UrhtTJuydB4SUWQPVS+AlKkhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hs5rlWvMJQc+4x2sFuSQ1YcaMX5Jhl1xSVCIvF16oZvjftpNiNzRt0IHErbrWIg3FumwtOy6iPMbBXyLvzr2X1E7X3FE7rcB/rcRH9pvSww46cNPcn92FuLdwKJRCDgTYAajuVUWyBI0l4hgwXdLbHGagvg0AyPiHzin2ZhyGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTXKrRDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03EB4C433A6;
	Fri,  2 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901029;
	bh=bijxA1yrZckpJTvIg3UrhtTJuydB4SUWQPVS+AlKkhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GTXKrRDp02WHICaPQXIl+BfYfNrP9743mrubTsqOkj5z8Y1n2nYdVY9uTrxggMaOe
	 OGgYop8Y63V5zqtBE5utsAzSGzQGBcy6ks0IujXwjwjUUwpC8K1NWOFzQJWv770HEp
	 8qhF5f/Y2QdFMhab60VSH4Xt3NKmpcFGvpMV/PFKbgNpthecQc0//Q1fwqJI2jzTql
	 Vad7fc+zYap4UgDsjv+mRQja1CCEQtBhC1M8838TgXVMhgHLWXidLukKkFxSaxG8Kj
	 xV0IbLaWWYtiq4einKK777ys8vRjmMd5l/GjS9feQ2ocohk5qq6dAF/zny/4f1RCZI
	 4YLmvupCBcWHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFB10DC99E7;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: hci_qca: add check to set
 HCI_QUIRK_USE_BDADDR_PROPERTY
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170690102890.13805.16122669095392697041.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:10:28 +0000
References: <20240124143042.27790-1-quic_janathot@quicinc.com>
In-Reply-To: <20240124143042.27790-1-quic_janathot@quicinc.com>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, quic_bgodavar@quicinc.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jan 2024 20:00:41 +0530 you wrote:
> Changes in v2:
>   - Addressing comments from Paul Menzel
> 
> Janaki Ramaiah Thota (1):
>   Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
> 
>  drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2,1/1] Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
    https://git.kernel.org/bluetooth/bluetooth-next/c/e6cc937460d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



