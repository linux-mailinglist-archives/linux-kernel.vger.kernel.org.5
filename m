Return-Path: <linux-kernel+bounces-131816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C42898C20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5729C1C2272C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681961C6A1;
	Thu,  4 Apr 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKdhiajN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98314285;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248229; cv=none; b=IOvQMElZxZdKK4Ybz3u6TEEkhv3Hdz9MoF4Td0Zb6301klafTlx+gsM1ONbq8TjLcAJhfUffx0Px7aSfwT5kKkkwNE01cKWAIVFbA9aNhzHk7h3DP7oj+Rdb/vqJ1OZtSG/C5FFX9pEhGlgmZz32wfL9Zfo4flYjRlV+1/SV8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248229; c=relaxed/simple;
	bh=usR5faDmxVumxXCqbcLkB9ZucPwxHJeu1sjbARO4ux8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kPPFiJs/5fsf0ztWlW2Ah2Fk3B++l962apafQSKgclpjXxdmyBBB98i89eHJMe8TC1ZXSGOV2EttQ4J7rs5V4Ezi79Ekf7IV3cmrLzADrK/So4nLvNh8zvLAaQ+s85+rsYhRrrdB85cdfzYuy9cv0t+DlnFqW99p6WDf20qJw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKdhiajN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FCA2C43390;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248229;
	bh=usR5faDmxVumxXCqbcLkB9ZucPwxHJeu1sjbARO4ux8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKdhiajNxpwLMI+G6/f12W3PXxzKv5r7Z+t6HFhtY3oyJXdRYUj0P0hViTJE4ka9o
	 BIBrbpP4GFDpiqlausr9I4EUdDXtJr4j0Iatp0dIeFd9/8MVkUkF440XEDBraLmXxq
	 HiWsAmrajtROsz5Uk7aEyXzkGOJTU1hKAh2t3I4QGGJR49sGVm2orvtp2yMU6C4hD1
	 Exxv6WIKNv8us8vzF24oevqRRlesbCqN0hqdOnXVInlF1qTtvJv+2A9VzdDuissbMm
	 fAQB9h1U2nKiI+yQl8x5/InFoZ4Ys9zXYc0/hbikN/V3kpfbTxLtjyajiAxJBUaMe5
	 NSYfrDQ1+sKyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CED1D9A150;
	Thu,  4 Apr 2024 16:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Fix multiple issues reported by
 checkpatch.pl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171224822918.32019.784278169246902514.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:30:29 +0000
References: <20240402183751.107948-1-me@wantyapps.xyz>
In-Reply-To: <20240402183751.107948-1-me@wantyapps.xyz>
To: Uri Arev <me@wantyapps.xyz>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Apr 2024 21:37:45 +0300 you wrote:
> From: Uri Arev <me@wantyapps.xyz>
> 
> This fixes the following CHECKs, WARNINGs, and ERRORs reported in
> hci_intel.c
> 
> Reported by checkpatch.pl:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
    https://git.kernel.org/bluetooth/bluetooth-next/c/54b53156ad36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



