Return-Path: <linux-kernel+bounces-147091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3498A6F60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78625B241B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A0130A69;
	Tue, 16 Apr 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5XETTx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E0130492;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280234; cv=none; b=jVyz4qlA3mFOJRd6uzpzKqPiiLXdqDybdyIuJ4+xlcTebBmZsMxM8t39D064ALLLyVW8BDKetApvUlsJmzW27ywhwOrAQpeiVXoKRLjfTZksyHc1jw1GmC3SJuYwBwNqvubjRW5sZsoB9zGOnsBncsW4wrNS02WRoMNOlKJJA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280234; c=relaxed/simple;
	bh=nxyADXIj7ToWnQ3DESNbTFi4qaMN9HcWjTWckTpOI+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j03fz8iy0U1ZS34Xwavrr2YafrA/XB/O9Vr4NrHEtii8wVfeQ7/Emp8YNMnlfFITl9AnZOPAbY4Qovn0m3JN1kFdbO9CpFwDsWw4gzk5MheyRCTyJDXXRPV9FjrH4Q/R/PVQML9IUiti1aiLCPFRl2CLiwt+r4Y2oaVUTpLEZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5XETTx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3678DC32783;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280234;
	bh=nxyADXIj7ToWnQ3DESNbTFi4qaMN9HcWjTWckTpOI+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5XETTx+jZEk3gkreJ7pC22WS1SK698FAtRVMvhgxTEZyuXJjbbwv3CQ3jGTeblWC
	 2EX364Mqt8xlzTw9Nt4QAj0Y8U1uA8HGVGmXYYk65xTZS7pDfSSIq5b69y528blmGw
	 LKXyA0SL0QsjJrgWBTbaSPs9HlyRcwED63rwxmtNgxASVJBQHp2VegDJECUKJfmS3S
	 7GGXBsBfGqyjJod3s3mklhQbyGjEV3ZolqBGsOY2D6Y4tl+LZNxxc37pH8E2ktyLSK
	 dzV/KtQjFtbba3PlwOka1t41W0UEmQwZa7uNZE8nrnDJip8sOJeGuTc5tiqhePo8MA
	 BIk62PIjJ5T+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22ED5D4F15D;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Fix the patch for MT7920 the affected to
 MT7921
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171328023414.16225.12939333659144302573.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:10:34 +0000
References: <20240415141922.25055-1-peter.tsao@mediatek.com>
In-Reply-To: <20240415141922.25055-1-peter.tsao@mediatek.com>
To: Peter Tsao <peter.tsao@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, deren.Wu@mediatek.com, chris.lu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Apr 2024 22:19:22 +0800 you wrote:
> Because both MT7920 and MT7921 use the same chip ID.
> We use the 8th bit of fw_flavor to distingush MT7920.
> The original patch made a mistake to check whole fw_flavor,
> that makes the condition both true (dev_id == 0x7961 && fw_flavor),
> and makes MT7921 flow wrong.
> 
> In this patch, we correct the flow to get the 8th bit value for MT7920.
> And the patch is verified pass with both MT7920 and MT7921.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
    https://git.kernel.org/bluetooth/bluetooth-next/c/263296438807

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



