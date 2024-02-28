Return-Path: <linux-kernel+bounces-85148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3686B11E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EF428AED3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872D15A493;
	Wed, 28 Feb 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suaf1H+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0E14F992;
	Wed, 28 Feb 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128833; cv=none; b=gdOmfLXOmzzVA42BepTtiMSC9oN2xhoJKd3JGxOR2tFe41Io3Qagg7bOjPs/6P1Wd+HqRP8KxwkMxSJ8QfmWPzbNGS9QHrzgg9PCd+zKV7N3Rbb/bu6U8QqRbyCCsvGHFx3ingLeZtk0Ep/3eCzXEY0/ijWZ2952ZS4euG+WnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128833; c=relaxed/simple;
	bh=FRGldkwfIaBwPgBrOO7G4I2QRVPXPDq+/BE5aGCJtLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mTsnBjCxbUdn0kA58fuOqGMPVgc/N9/pEu5HStPGlmcPDIw2Y9YMAw6SBtqDuE54ZQdjX9c/OT6yoM7vnIGbWs8G5M4VyIgB+Sggat93qr0C3e/8l186wbSdRqN6ZpQh6L54qyx77QVRwQEiRPbgImltI40lUglQ2exMBU9Etvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suaf1H+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED332C43394;
	Wed, 28 Feb 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709128833;
	bh=FRGldkwfIaBwPgBrOO7G4I2QRVPXPDq+/BE5aGCJtLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suaf1H+W9cIihL5Rj91Wu7gJtVNybvYytAzgvhIjM0+1mL5u7C9I60MkvBh1bUCNS
	 ORkNsGWkk6mx/jCfO3362jzBZlZXEr1Aba1fnMSyD6M7xoee1YhfHE2C7Zcq7NyLRy
	 H0KcwwUEAd3LJY4HUh4l53I83euYNaPCbhTfqPJXMxsouUUT4o1qd0rbCkDjNE4Xro
	 hV8XQwTUzsTtSaUWp9ey/KCb0NaBsWfBIkYTEIJdIjXYVHp0rU8KaQ/dWNBQ3/Zsev
	 ICfz0XWMCrvIi7WzGCIwAXPSXSI4uwZ4In8Igul6XfcchEYutYADziMdYNCkh3BEB4
	 /9CWzg1HJLbgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0DF5D88FB1;
	Wed, 28 Feb 2024 14:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btrtl: fix out of bounds memory access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170912883285.30835.6246607641130073666.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 14:00:32 +0000
References: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, hildawu@realtek.com,
 alex_lu@realsil.com.cn, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnaud.ferraris@collabora.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Feb 2024 00:37:02 +0300 you wrote:
> The problem is detected by KASAN.
> btrtl driver uses private hci data to store 'struct btrealtek_data'.
> If btrtl driver is used with btusb, then memory for private hci data
> is allocated in btusb. But no private data is allocated after hci_dev,
> when btrtl is used with hci_h5.
> 
> These commits add memory allocation for hci_h5 case.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_h5: Add ability to allocate memory for private data
    https://git.kernel.org/bluetooth/bluetooth-next/c/171271f419d8
  - [2/2] Bluetooth: btrtl: fix out of bounds memory access
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8f519096785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



