Return-Path: <linux-kernel+bounces-14950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCE8224E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2A01F2375F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ACA17730;
	Tue,  2 Jan 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLiwZxOi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F817722;
	Tue,  2 Jan 2024 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C54C433CA;
	Tue,  2 Jan 2024 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235224;
	bh=TYmyaLmtrD1cirMWGNO8g+3fto9TzrYtNubox6icnAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XLiwZxOiZosnthuFXBIG2y1aPYcvYRawalg/x73AEZfoq4ssPQrndx2gOtCp/xbyr
	 hSFTA31e7JoPYAwFNphYdBQwytVxpOniQ3PfgvmqNqe1sFDl9Fmsdabnol5El0YxD3
	 gHcLYc6aCl4bFT/3nowuIpeOmkRGKmBicUs3o0/bvVOmel5EfY8PI/Jnxro4qPU+3c
	 t5Q5fy8klQJ0Bxqn3cHeDgVgF3aK71SMEHE2gHEvbUNSmswfdbDGEqVP8yoK/TQ1vf
	 VWbwXcBje+zH/vCwGxJIhkQlGQ+zgzMnt0XNi4b+ssEUj9FwY/Y73Uqcmg94+BUECI
	 2GUBqYOxksxRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE547C395C5;
	Tue,  2 Jan 2024 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/11] renesas: rzg3s: Add support for Ethernet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170423522471.27299.969624057457704166.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 22:40:24 +0000
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, linus.walleij@linaro.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 claudiu.beznea.uj@bp.renesas.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 09:06:49 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds Ethernet support for Renesas RZ/G3S.
> Along with it preparatory cleanups and fixes were included.
> 
> [...]

Here is the summary with links:
  - [v2,01/11] clk: renesas: rzg2l-cpg: Check reset monitor registers
    (no matching commit)
  - [v2,02/11] clk: renesas: r9a08g045-cpg: Add clock and reset support for ETH0 and ETH1
    (no matching commit)
  - [v2,03/11] pinctrl: renesas: rzg2l: Move arg and index in the main function block
    (no matching commit)
  - [v2,04/11] pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups
    (no matching commit)
  - [v2,05/11] pinctrl: renesas: rzg2l: Add support to select power source for Ethernet pins
    (no matching commit)
  - [v2,06/11] pinctrl: renesas: rzg2l: Add output enable support
    (no matching commit)
  - [v2,07/11] pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
    (no matching commit)
  - [v2,08/11] dt-bindings: net: renesas,etheravb: Document RZ/G3S support
    https://git.kernel.org/netdev/net-next/c/060baa9b90d4
  - [v2,09/11] arm64: renesas: r9a08g045: Add the Ethernet nodes
    (no matching commit)
  - [v2,10/11] arm64: renesas: rzg3s-smarc-som: Use switches' names to select on-board functionalities
    (no matching commit)
  - [v2,11/11] arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



