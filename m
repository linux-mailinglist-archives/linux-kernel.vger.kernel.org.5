Return-Path: <linux-kernel+bounces-166599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A88B9CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19901C22D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B8154443;
	Thu,  2 May 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwDde+BR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240B153800;
	Thu,  2 May 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661433; cv=none; b=jpLkXoBs9qnPUGwJL7QNIidXg7kkX6RN/krguHK5P25DLMd3hb8QLJk7sZqtr+IfszimTqB8Bc0I+j4nLNkGWB6fcoMThi67dm3OjlyxlwfNq9oTv7EQCID/hNZ9OELizeyxJJzbiSFWg4hmc4OkRSek1bRZMrP/uRjjcT+idEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661433; c=relaxed/simple;
	bh=VLCdT8S8RHn0J5m1d4S8joxMLvrBRQKRrINYgfmKubA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yi4G9lIoQ2zJ/QTk5uJb4OGRKphSaFjlq/53bnf+YGZJ5PF5Du87ougX8Mmai4AP8LSepP13S8xjeaMYEoimuGp9Pwr/nObWPzz5///DiRaK2jks7vwegdCy6wCIYRjkSSQWoowrzbG1c16aiB3sCuJSmFfoHfLYAA0sOvJz+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwDde+BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E65C4AF14;
	Thu,  2 May 2024 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714661433;
	bh=VLCdT8S8RHn0J5m1d4S8joxMLvrBRQKRrINYgfmKubA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VwDde+BRMnQvir5Tx8KN74Mo3z9lrZG+Q1cUDRAAdnxbR9bpwHEHWfP9YKhwnVE7e
	 qKgp1hAwOKtleGVsUjiLAhIXRg6xSdXINvfnc7IVqYKEmhnLOVY5Ky8IG2buan2y7A
	 chBN/rm527LAuKkPsNMJCP/lHEm0ZnMbvQI1Zn4ChPPv+86gmeDL7OWPvfzUR8g7Lm
	 3Ja4oyTe6k4qndhm6ys0a8sQekapqPS+l/Wz5q9XqRFWa470pUrcotMN1xMidcG3SE
	 KHpYlVuRcyI1AtjxZOErGrofdGv5HnbJfgM5JaC7AL4+uoiLKuXhG6khUBr7VNpsHX
	 TC2k7QWM2yvNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0916CC4333B;
	Thu,  2 May 2024 14:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171466143303.15417.16267391359658685037.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:50:33 +0000
References: <20240412073046.1192744-1-wenst@chromium.org>
In-Reply-To: <20240412073046.1192744-1-wenst@chromium.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sean.wang@mediatek.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Apr 2024 15:30:41 +0800 you wrote:
> Hi everyone,
> 
> This is v3 of my MT7921S Bluetooth binding series.
> 
> Changes since v2:
> - Expand description and commit message to clearly state that WiFi and
>   Bluetooth are separate SDIO functions, and that each function should
>   be a separate device node, as specified by the MMC binding.
> - Change 'additionalProperties' to 'unevaluatedProperties'
> - Add missing separating new line
> - s/ot/to/
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/556511c33388
  - [v3,2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
    https://git.kernel.org/bluetooth/bluetooth-next/c/f90ac18d01cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



