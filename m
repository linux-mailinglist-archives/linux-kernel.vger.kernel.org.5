Return-Path: <linux-kernel+bounces-153637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03AD8AD0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308C628BF15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A4153575;
	Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsByQft0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261F1534EB;
	Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799829; cv=none; b=DV8VM0QI4KLiKswwdMiHSTC9onS5vU2cP+WX8NSV7+N3bNjdSZmEcI5pLiqwojWZc1qiMC+03Pkeh3TFQQjj0j4v0wa7F3/8cQp8MZ1YQGwXdpzMGyQVQyvgbNMW3V5nPcqr+bjIdYZfdnA4bLrMIx08USrBSDVaRY3hf4sudRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799829; c=relaxed/simple;
	bh=kBOdztBuRx3LyBj/ka6DXaMiCnKJ+c2up6OXDtfALQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZapLorEV7CKZCH5Ak8dgdhfcA2xRkX24Hs2wD1C1BoPzZXgi1z1+FVt3z8F8jwhVBlY1ulYodx9X/zq4vqVc7uHFqfrVCpKXOAapGpVFF7ccwfHdwI/V42KIBrT8Q5CPGbYsM7B+QqBO3adOJNlryes9YoaBS0IkBO93LJ0KqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsByQft0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3D8BC4AF09;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799828;
	bh=kBOdztBuRx3LyBj/ka6DXaMiCnKJ+c2up6OXDtfALQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VsByQft0K9J5inVAsL7BWPEW0omu/N0N2cmpV7gVRutXaO01+Bidl3LtrFceJuX8+
	 9ysl3inBH/gCyrgoVx53EwQSWKgzUTyw6FJIh968pT6JPv5X32ICwwhb7gJI7+aKGQ
	 s/Yu6Q3+yUOqxCx1bh5sVQO4O8HhTdcj8Ashovaui6N1AWS3u4VZZ9oJoB0eTQjBKM
	 q3i3RQsh8p87oqFswzXV6PhDkbe8hSgS3dXdbmg7NnlMNXUqtqSIU+IOkYGnRdHLa3
	 r666z73wyUhUFR1QpJexflj839/VV/Gl3ffHNC0Up0nvCeyfbwLCecbAvl/wVcmWad
	 7DWL30YUTRL0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8678C433A2;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171379982888.28518.5007665871256276343.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:30:28 +0000
References: <20240422135748.23081-1-johan+linaro@kernel.org>
In-Reply-To: <20240422135748.23081-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, jiangzp@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Apr 2024 15:57:46 +0200 you wrote:
> Qualcomm Bluetooth controllers can be registered either from a serdev
> driver or from the Bluetooth line discipline. In the latter case, the
> HCI UART serdev pointer is NULL, something which the driver needs to
> handle without crashing.
> 
> This series fixes one such issue at setup() time which incidentally
> masked a similar crash at suspend. Fix this in two separate patches so
> that the latter issue is addressed in pre-6.2 stable kernels.
> 
> [...]

Here is the summary with links:
  - [RESEND,1/2] Bluetooth: qca: fix NULL-deref on non-serdev suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/8185331e953d
  - [RESEND,2/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/9201f29be2c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



