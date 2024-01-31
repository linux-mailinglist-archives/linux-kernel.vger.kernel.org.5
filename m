Return-Path: <linux-kernel+bounces-46518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FE8440D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CB01F234B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022780C09;
	Wed, 31 Jan 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXtYZ0tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702D7F491;
	Wed, 31 Jan 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708427; cv=none; b=pOAPNdCkWItfEb7Fe3MfUMGsAfNl7Uc0Plpxbx+9+F83ijobYIbj8sE+CeWFjj/hUUiDNdRLtafEqsI1Ckk6nyLBnNv1idfh/UGykaJ3+KkdIbrqEj5yMChaj5mO/4WJP/s6fzgCBYdHhr6FfGtOTJeCjg5B+1AswF8i7kPAkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708427; c=relaxed/simple;
	bh=b21SHlwTN9iL2fIw5Q492N87cW6wLJUEi5V8W/Un3ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BkN0nlo4fslMrIqZvp30hkgRQqS1T0VchhmQYA1OEE1psZFpWqSQX9ePzGerepnd3vQ9JKfktVghIaxvgVXy7Ee1MfyRsdVPq7c7XHuOueM34S4tjk67imPMePFuYt07sCtH+8R1AfT+D7ddJwmhnJOtzE7WFlTjqnPmi7EZTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXtYZ0tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06CB3C43399;
	Wed, 31 Jan 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708427;
	bh=b21SHlwTN9iL2fIw5Q492N87cW6wLJUEi5V8W/Un3ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HXtYZ0tV+ZV6O1/b7q52L43SCRRKJnjThVSWuoUHyTEjj2+8vfwgBe1BfcHRWGnSy
	 i82HSKRdiNNsO1TtT5EE4+c3owyBhbq4pO9KRHlRkXJ0dZexV3de0xjopSAV9S7BLx
	 9gWmINp4GexV+cgJNrfDWR7HMAmpVtRK48SIkS0L3Nj3zSWPQihP3MGMRZSIllDx3l
	 klMVn3x9b2he0bs1OJgOqXn1vp6cRnSGvDX8XB3XBTiAhRyC2SM8e3nxGlR++YRKJd
	 5KUN/lEs8XL87kdM/T/es19zQR1+3Bj6CAMB0FqcT6Q4EMor8biZhURxNQ0QIKq8R9
	 eE9T0C5/HsDFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E08EADC99E5;
	Wed, 31 Jan 2024 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 00/15 net-next] qca_spi: collection of improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170670842691.31681.3525325990073140229.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 13:40:26 +0000
References: <20240128201059.6259-1-wahrenst@gmx.net>
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, LinoSanfilippo@gmx.de, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 28 Jan 2024 21:10:44 +0100 you wrote:
> This series contains a wild collection of improvements for the
> qca_spi driver. This is a follow-up series to the recent bugfixes [1].
> 
> Patch 1, 2 & 3 in this series is the initially intended rework of
> netdev_open/close. Patch 4 & 10 are minor functional improvements and
> the rest is clean-up.
> 
> [...]

Here is the summary with links:
  - [V4,01/15,net-next] qca_spi: Add check for kthread_stop
    (no matching commit)
  - [V4,02/15,net-next] qca_spi: Improve SPI thread creation
    (no matching commit)
  - [V4,03/15,net-next] qca_spi: Improve SPI IRQ handling
    (no matching commit)
  - [V4,04/15,net-next] qca_spi: Avoid skb_copy_expand in TX path
    (no matching commit)
  - [V4,05/15,net-next] qca_7k_common: Drop unnecessary function description
    (no matching commit)
  - [V4,06/15,net-next] qca_7k_common: Drop unused len from qcafrm_handle
    (no matching commit)
  - [V4,07/15,net-next] qca_spi: Add QCASPI prefix to ring defines
    (no matching commit)
  - [V4,08/15,net-next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
    (no matching commit)
  - [V4,09/15,net-next] qca_spi: Improve calculation of RX buffer size
    (no matching commit)
  - [V4,10/15,net-next] qca_spi: Log expected signature in error case
    (no matching commit)
  - [V4,11/15,net-next] qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
    (no matching commit)
  - [V4,12/15,net-next] qca_7k: Replace BSD boilerplate with SPDX
    (no matching commit)
  - [V4,13/15,net-next] qca_7k: Replace old mail address
    (no matching commit)
  - [V4,14/15,net-next] mailmap: add entry for Stefan Wahren
    https://git.kernel.org/netdev/net-next/c/a47996ebbe40
  - [V4,15/15,net-next] MAINTAINERS: add entry for qca7k driver(s)
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



