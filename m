Return-Path: <linux-kernel+bounces-38787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89483C5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EEF28D141
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6073174;
	Thu, 25 Jan 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSpXFasW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C323764;
	Thu, 25 Jan 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194827; cv=none; b=iGMR/NqYVTPkdBwDG5r7+9B4cBiFNVXJf1B4taDN+VqZ6ZTgCcNN2lzJbShzVD1vhGnEWSiAm2tjzMeubxNzn78gbS2Reu2by9ejdGS7u6RhcJZFQ3Q2H8P2zGutpXLezvRLUJqe1Gdyzc0qDYsYjhmOJu6LC+54CHV6IwhSDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194827; c=relaxed/simple;
	bh=eJ0fPZy5H3HPFj4qbHHzlx5qHvg0wqNVEjDL2Z6lfPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gcgn3Pmr3dW4vVxa853uIRgC3RQCXoEHL1VGM4WAGMMUMMk9fkP2rv6gKnmE15U5klxW4TncDaQ9wsxyxPdOUFiDI6QWc80U+pRVizC+y6yF2K78jlzB6ZU1GEMAxHs5Aobj3vUPJmOoks6cAJREIEkxGKlCFB4yD7hLtDYsWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSpXFasW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A49EBC43390;
	Thu, 25 Jan 2024 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706194826;
	bh=eJ0fPZy5H3HPFj4qbHHzlx5qHvg0wqNVEjDL2Z6lfPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MSpXFasW/lWHRJZ/rNGQYjVPz2RcWSJE1wv0XkdNwcjHHyt7zD48+qzoaCT2ry07L
	 jujebahj6eccGcPEGAN2vPBuj/TXJLe3Y4srogK0w5tq3q4AqNSI2GkiF7gx5TCE9h
	 jnh+PpPOc7U/yTlymPLdNmeXPnhixcT/xAKv14M3Q+WuRDiIlMeANS5woqHUMiK05Y
	 HC/7jTwGIM7wIqSh6fQUJlhFE128uRfxy8nuj0wHXYoP23WHRLZAQdAp7o16xnnuKV
	 NoKb88xMwchfej1nh7WGg9RBpp9xoKs9z7B88ky/cAjuXYy1D0HRjAaDuXdgJIrteQ
	 yrV6+ltSsphUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 867FBD8C962;
	Thu, 25 Jan 2024 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration of
 switch MDIO bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170619482654.13332.18301642158515027225.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 15:00:26 +0000
References: <20240122053431.7751-1-arinc.unal@arinc9.com>
In-Reply-To: <20240122053431.7751-1-arinc.unal@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCA8YXJpbmMudW5hbEBhcmluYzkuY29tPg==?=@codeaurora.org
Cc: daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, mail@david-bauer.net,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, luizluca@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Jan 2024 08:34:31 +0300 you wrote:
> Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
> can only be registered as non-OF-based. Bring support for registering the
> bus OF-based.
> 
> The subdrivers that control switches [with MDIO bus] probed on OF must
> follow this logic to support all cases properly:
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mt7530: support OF-based registration of switch MDIO bus
    https://git.kernel.org/netdev/net-next/c/91374ba537bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



