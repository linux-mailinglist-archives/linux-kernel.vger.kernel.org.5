Return-Path: <linux-kernel+bounces-56755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D910D84CEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFC1F2930A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250F811FC;
	Wed,  7 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhgA7COQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD347F7DF;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322226; cv=none; b=cV7GziCTSCesD4BDpP3DiJn4Qz+IKtA9FlAT8LfQGqvMWL3PmJif/8tGfnFCBviMK4iNqJDBcGxRpZMFTXEOdx2Lzg4Lnk0QUTEOwOI6c6aRSKG79OsKP++mf7qa/ijZvgaKUTQreJ9kvw1qmsV8lXJC2v0aMN+IGZZYqRMHImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322226; c=relaxed/simple;
	bh=PJbRFquDFS5PjoXy1Tp0XeTWuHvBy+YC5ZPjygbcMzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJikEvVX1n1oyXZakJVLp3yySXJtmX8jxIKaJHuBngzM3TQtdI0e6tpfxVsGCm3wQRrv6Nrodlw2S82um7iGur9LAzhCoypR+RERAFh3R8qtrbAuiO+FxRpKB97q7XrMm0krqg2u9PugIqn+Vq1L4RnCJJcG17zit2Z2Lf+RH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhgA7COQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F5E9C433A6;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707322226;
	bh=PJbRFquDFS5PjoXy1Tp0XeTWuHvBy+YC5ZPjygbcMzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhgA7COQyuQt+GU35BYtbZ7fpKQmwnqADSmDVZ7xrzTgTx0giO6i+KJavGu4/xjvo
	 Qg2NO3WrgBCFng7gFN9nToVjyEWANNiFppflxK9QmtYiuIDkbkfMM72Ab9Qqp4iB97
	 /ODjPZ/QGhaYOZ95JvFdn9+4Ij6Uv9kiY2bpMHQbDlTybFRXhBETK/y65eqVAoh7zg
	 Qrf+BPU4cxSWa3d1wwe1BYNNgjCoyCDNbdv6/PAdAJQgxoVDzB0ix8uxmom5SFJzBp
	 FgEzqbFquQg6lX/X/18t12oHVeaEc+shhXb5lOl7gbi3MSTtGODn84uzl19OvBH6A0
	 3LH/9zSZ3p+bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35FA3D8C96F;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: Improve retrying of connection attempts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170732222621.9598.18285805408891036019.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 16:10:26 +0000
References: <20240206110816.74995-1-verdre@v0yd.nl>
In-Reply-To: <20240206110816.74995-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Feb 2024 12:08:12 +0100 you wrote:
> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> requests"), the kernel supports trying to connect again in case the
> bluetooth card is busy and fails to connect.
> 
> The logic that should handle this became a bit spotty over time, and also
> cards these days appear to fail with more errors than just "Command
> Disallowed".
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: hci_conn: Only do ACL connections sequentially
    https://git.kernel.org/bluetooth/bluetooth-next/c/456561ba8e49
  - [v4,2/2] Bluetooth: Remove pending ACL connection attempts
    https://git.kernel.org/bluetooth/bluetooth-next/c/8e14d581d125

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



