Return-Path: <linux-kernel+bounces-119318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF7888C702
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849E9B269C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC613C91B;
	Tue, 26 Mar 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqFxomEA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8E757FD;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467040; cv=none; b=LxWsqklMJzSCUdvNglf/l4jEIqihOaVLQLtyXZhG2wWflAL4fuz5Cz1trJAMQ7Iyy2LGFOfV2xkDmGocdqzv7QJDNEsgJstorxCA6UABMqnN/Uv6FG6LHpCp6XCevcilk0tS/oOOFm9yyA7IWn6ELO0dA4qWCcu2Jh+eTK64+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467040; c=relaxed/simple;
	bh=o6CYcZxpDQIt2/pbcizSI8kvPoWkCHq1wkzT2k2XcIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JO+GCtn1miHqRhxYSlwYsSv9xihLiu1sdbCgnANEEMox5z5wUCjVPZtvtcSFOJiimU8eyXP4Z/DMzRDNs0mX+uvkQnS6532Rj8hYxkRkv8BUttjAf6lsWhLKSdivC5xE/NgKTiwxYrLF1vFgIH/wjR+JPt/NlPzoOfF/IBsKzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqFxomEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61DCAC43390;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467040;
	bh=o6CYcZxpDQIt2/pbcizSI8kvPoWkCHq1wkzT2k2XcIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pqFxomEAFsI0Uc52UqguqMRU+vuximhONo1wk9jsKiAAvfKpoMjaUMRB8pdyxqLTW
	 uV1FlhJB6uqhOdhBER+T8uAKjX4K/++ylq56UCZK1p//0u1jYEhYqWyaHvlT8WEn8Y
	 nlolO/GGGgM+PgqOTxVBove7AVZLypFqGGuP6xml1wxnVEw/GzNzAGP+gUoYAyCu1Q
	 FYH/MLuVUv4v+QB41lN0Et+IFwelaQYPGuAaOv+hyI+yB4HlTpYwLOYKH9bd+DSakR
	 0AWjkwgmcG+VnVc5sghWjU7GV5r/D2tk2tmTlCHp2l+F0Pg1wM9d0TGM/P9AzbXV4m
	 49Ck99G1lcteg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CCB1D2D0E9;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Bluetooth: qca: fix device-address endianness
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171146704030.9961.6734393156915246148.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 15:30:40 +0000
References: <20240320075554.8178-1-johan+linaro@kernel.org>
In-Reply-To: <20240320075554.8178-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 cros-qcom-dts-watchers@chromium.org, konrad.dybcio@linaro.org,
 johan.hedberg@gmail.com, quic_bgodavar@quicinc.com, mka@chromium.org,
 dianders@chromium.org, quic_rjliao@quicinc.com, dmitry.baryshkov@linaro.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Mar 2024 08:55:50 +0100 you wrote:
> The Qualcomm Bluetooth driver is configuring the device address in
> reverse order for none-ROME devices, which breaks user space tools like
> btmgmt and the 'local-bd-address' devicetree property.
> 
> As these Qualcomm controllers lack persistent storage for the device
> address, boot firmware can use the 'local-bd-address' devicetree
> property to provide a valid address. The property should specify the
> address in little endian order but instead some boot firmware has been
> reversing the address to match the buggy Qualcomm driver.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
    https://git.kernel.org/bluetooth/bluetooth-next/c/ea56aab91231
  - [v4,2/4] arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
    https://git.kernel.org/bluetooth/bluetooth-next/c/c4406d97b78c
  - [v4,3/4] Bluetooth: add quirk for broken address properties
    https://git.kernel.org/bluetooth/bluetooth-next/c/ddaa064664fe
  - [v4,4/4] Bluetooth: qca: fix device-address endianness
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff2ed85c0122

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



