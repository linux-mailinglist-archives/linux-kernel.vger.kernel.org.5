Return-Path: <linux-kernel+bounces-154013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8F8AD61C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA01C21679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB31BF24;
	Mon, 22 Apr 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krLcnxpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8811BC30;
	Mon, 22 Apr 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819028; cv=none; b=l9CIJt/Xr6dWZu4JdoP68aqWdFmMsm4u7WYxrQfkHIKMI9D7AiuatWQvqoXYHApgaPZLsPUkby6EsLWIA1Ow4dLcAWSgcKq1vo9yq/q9Ggotj1hs+EoVT+wQoavl4MMPPcRrlNT+80uFxwkN8iqY9oqvlcxIZF/9l+79TFlJaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819028; c=relaxed/simple;
	bh=9DYgO8wYupT0QH7+jRJ6N9SDSP6xXF8Q2+hPl5QnCPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t6N/7nZj1aIsdCPINytkZytycDiQr2TkWmHvi6rILm71O0ftvgBqvsF6NE6X38b16oNcIYDLkKvBU1wY8y8Qb8m7KiauT/WpNHEF23gxW8nWXizkGV8p/SqVui/cbPer6fpjwMPqSNcTRHDYJKIqevMey8aIscszEKwKIcD7EL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krLcnxpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70A3DC3277B;
	Mon, 22 Apr 2024 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713819027;
	bh=9DYgO8wYupT0QH7+jRJ6N9SDSP6xXF8Q2+hPl5QnCPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=krLcnxpex9izlLPRauXEQ1kz7zE9HBdNc/XxnINmxXWSs/sRqzDCbVdK6aD8aJgUZ
	 yRASmHsN8MpAVumKZ1GZqDrzC4DrLyzCPEjQphUZg1RudddpY0TYP00Kdbb9UAghaX
	 VSZDhvujUEzI9Ey/Q182TN3XcbptBJlIvuxWl4MY9GTq/aq/KLL8YN4QLuwg37HjuE
	 t1HSrhnRkDG/7TI1P5PXeRmjtrrXVHwMTygaImpuaAtQnRuedbQbapx3nIgW5X/itS
	 JcQsfaWEA23qh+lewnjSh3Prpk9d2f+PcIEsS8rm3qXxublHAlQm/KaE4Z8dCvfVsD
	 w6NIgwjkxJYAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5902FC43440;
	Mon, 22 Apr 2024 20:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mv88e6xx: fix supported_interfaces setup in
 mv88e6250_phylink_get_caps()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171381902735.11970.5485641059317378577.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 20:50:27 +0000
References: <20240417103737.166651-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20240417103737.166651-1-matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 12:37:37 +0200 you wrote:
> With the recent PHYLINK changes requiring supported_interfaces to be set,
> MV88E6250 family switches like the 88E6020 fail to probe - cmode is
> never initialized on these devices, so mv88e6250_phylink_get_caps() does
> not set any supported_interfaces flags.
> 
> Instead of a cmode, on 88E6250 we have a read-only port mode value that
> encodes similar information. There is no reason to bother mapping port
> mode to the cmodes of other switch models; instead we introduce a
> mv88e6250_setup_supported_interfaces() that is called directly from
> mv88e6250_phylink_get_caps().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()
    https://git.kernel.org/netdev/net/c/a4e3899065ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



