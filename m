Return-Path: <linux-kernel+bounces-91318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B44870E12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59791F21C31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37667BB08;
	Mon,  4 Mar 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv43hwON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CD1F92C;
	Mon,  4 Mar 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588429; cv=none; b=uin3kMH5UARJ6njdLAHiyib5EIqgObqkGvILcFpFhOzsqoGRI5dwB8Nm1+JbFw49zMnCYg55KF+46ZcybVmCTcZaM2w6rzNNw9g7YuG9D7oPisYC7Bf15jjlBY4fc3JC8tD7SPaZ7c39LNGbxVECBGmdW19g1VKbJpQ+z8nJMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588429; c=relaxed/simple;
	bh=0yqtvKb6euEXfWCJ5BupuWOTgDwHxNA52Wph41RVxls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odUiJ3iuJmtTXhK8NsQhQzbWtBL4SN69aRD/CFnZMgLaiSP9TzkrvIREECws2SJyhgnfMubbmFF5sZJ3+mI9XcF3jE8iRhmCqykg7ZsIccObme2xhX5tnMzshYneDlqrDeZIeTZ15jhPR5XqlppYwTne+mVD5aCNr2BJKCtOgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv43hwON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 760E9C43390;
	Mon,  4 Mar 2024 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709588427;
	bh=0yqtvKb6euEXfWCJ5BupuWOTgDwHxNA52Wph41RVxls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cv43hwONEsIKBQ2wAnPHyKgBXY3Qz4Yq5mTh4jqxkMmXkuHWyQxYPXmCcHakE9vlh
	 AK5n9xvDKKoYcGxVaRypsGBGZcTttntFuHhJe5V6wdf6MnArXFdqJ5yIgeX6xJ25bt
	 DjlyKmzZcGanJf/42sZmdzwgzZJGBOSr/zJNmm/Pf1XC+szC/LNoSvdlcOf2pNl6zG
	 ZpAueehZgD4/M0O/c1hrDeeQKe8Gn5eDNOYhDoTv9X3oW5P9a/3HZUZid5HbjOPaUg
	 W6j8lVtPdOtNRJ9bGeInbcOJPR/lKZks8MkcIXH7YYJBEMuYq3Yc8177bTw5wbngZ0
	 uYhJVfQArBJlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55F16C3274B;
	Mon,  4 Mar 2024 21:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add new quirk for broken read key length on
 ATS2851
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958842734.5292.12544056625468291768.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:40:27 +0000
References: <20240227014328.1052386-1-nukelet64@gmail.com>
In-Reply-To: <20240227014328.1052386-1-nukelet64@gmail.com>
To: Vinicius Peixoto <nukelet64@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Feb 2024 22:43:26 -0300 you wrote:
> The ATS2851 controller erroneously reports support for the "Read
> Encryption Key Length" HCI command. This makes it unable to connect
> to any devices, since this command is issued by the kernel during the
> connection process in response to an "Encryption Change" HCI event.
> 
> Add a new quirk (HCI_QUIRK_BROKEN_ENC_KEY_SIZE) to hint that the command
> is unsupported, preventing it from interrupting the connection process.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add new quirk for broken read key length on ATS2851
    https://git.kernel.org/bluetooth/bluetooth-next/c/88f741deaa76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



