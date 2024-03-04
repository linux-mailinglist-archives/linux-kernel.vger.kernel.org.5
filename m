Return-Path: <linux-kernel+bounces-91307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E79870D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D750628C3D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA317C6D5;
	Mon,  4 Mar 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPczbBJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E607A70D;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587827; cv=none; b=oF+qtRhnsX9N9X/SZUDNq5UrPnoZT1e//iabJmoXIgQSCkOrDedS8HJDH7+0NW58Fn9yP1QJ4I3Vf4wP/sCBXrapZLrPQzXroaiZiKbvyyAlF7d1oDYvEWQAuuuZ997i4juzw/SuDUfIXdb5yiGvZaof2QG2Lemw6ZjerW58Gts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587827; c=relaxed/simple;
	bh=O5yUEyAsxwbc4QeVxv+falkYGWSwkd6xqczAATdlKJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cZjpaLWWMVfupNfH37UZtQ0R7RKFEgqHga5om38iSuCgTWX6ccevvXBR5u9LvEauq+zvWVhTYyIp1JkGf5kmFL7xP0KOPoMB2uxVvAE2sVeimk+4MzoVo+aiKXwcoKZ8f6KWOSV+vzZZrqjsasYok6gCka/Fozc7dXPATUKc7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPczbBJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B017C433B1;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587827;
	bh=O5yUEyAsxwbc4QeVxv+falkYGWSwkd6xqczAATdlKJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPczbBJHb+yrMK/lyQ+UtlmGPDJf+ftV5Sq/1dvdCCejNURk6HTbrjeJ9DGHdb5ca
	 xChheXwXsSvqL4yVha0SVTJxR5FvgILbXIx2Am2gt7ge4uhsNigyomQ3ssGeobBkSe
	 jRtzjL6/wj+egMQImwW/1d4MMWGfruo3iB3HSDPhh9xG9W05ORTOqrgP6Y+jfDvR6W
	 RRj8uEVTythAAHGQiHthPD8+HwD6BzROMjDM8V5xCTP2gEM9/Du7dFAVaBIwTotmXi
	 YlNYjNQEKERSt09LCQdl/63QvEaQ49qgzbNDNxoFX6c4dMv9gWmapsMPbzKf0lTXCm
	 SI1jD2NMeBBnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C23BC595C4;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958782730.29902.5440375216953533108.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:30:27 +0000
References: <20240227102914.8341-1-tiwai@suse.de>
In-Reply-To: <20240227102914.8341-1-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Feb 2024 11:29:14 +0100 you wrote:
> Since dracut refers to the module info for defining the required
> firmware files and btmtk driver doesn't provide the firmware info for
> MT7922, the generate initrd misses the firmware, resulting in the
> broken Bluetooth.
> 
> This patch simply adds the MODULE_FIRMWARE() for the missing entry
> for covering that.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa1767a3fcd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



