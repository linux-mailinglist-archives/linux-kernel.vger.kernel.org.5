Return-Path: <linux-kernel+bounces-56754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3B84CEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10A2283C81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F9811F6;
	Wed,  7 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWPQwNfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF27F7D2;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322226; cv=none; b=UAXhEM3qfyh3BBzFlHTAJZjppaxcaMa6TomJnm/X6m8enmQnpDLsyHT3orCtP9OH4ISAZ+TfYaE52L6m/0PfGzX+mHkt3IrHYk4cvtqMr4ey/U1Lyy7R93ZB4eAd/U8umkIjrz7fDKO3LfOLHGUeNrmHIjXDR4Upl35V4ICZsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322226; c=relaxed/simple;
	bh=/0o+AWXI7cS8I01oo3UvjEJ6p+YfERImUAKqiX1jcoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQBfNpMx6ImPsJBoHg0Mc3mW2vo9cq+VpZE5S1Uw1+tkkMnpri2xIdeythcfk8oaZ0jOlXtimZsT1ZC2lE72T5AENsMaWNun+B8XnfY1L6xr1vsBleL5Xb9L3zFtT2ALAURkGYYH86HQMkzq+0tU0VOL5sLj4Hca9IxcOw37KaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWPQwNfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A4EEC43390;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707322226;
	bh=/0o+AWXI7cS8I01oo3UvjEJ6p+YfERImUAKqiX1jcoc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWPQwNfZEg8GpPrPJjzlkAIywseNBMsyBHMhhCpzlx+w3hf2G9dBJ/HICqpPPKWbN
	 86V3QdyJ67/GFT7XM5NtCpt7m9R/tJdDPcjJDjlliy8MjbschZgkZgm3iXAxReB41u
	 /tZbLHyLGUPNDFRgnHY+U2Oq+48oHO7xr0g0LodkZd6v5x62K61EOwcuxqTi0lknSj
	 DTJxBPowseeHHUrdNBygoWqyRyYRjxrr1sjkuKAazqzVh48fc7cqpo8h29C2qJzNJH
	 TKqzB2P0BbOU1U8OLJ4YPacbUTHx36GkDWYuYSp1IcX52QYPcOtEVROWjGjnzDGgQE
	 PQGc8ljb19xyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F5BDD8C96E;
	Wed,  7 Feb 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170732222625.9598.2726680402467798733.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 16:10:26 +0000
References: <20240207134211.29201-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20240207134211.29201-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Feb 2024 14:42:11 +0100 you wrote:
> Commit cec9f3c5561d ("Bluetooth: Remove BT_HS") removes config BT_HS, but
> misses two "ifdef BT_HS" blocks in hci_event.c.
> 
> Remove this dead code from this removed config option.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS
    https://git.kernel.org/bluetooth/bluetooth-next/c/854c513be130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



