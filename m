Return-Path: <linux-kernel+bounces-133289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F3389A1C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9DA1F2230F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5779171078;
	Fri,  5 Apr 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNCLxQV/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122E17106D;
	Fri,  5 Apr 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332137; cv=none; b=Mb5torBwP8WpqbXyQ7fyQ63akeUp8+3d1G6Pv0vcSA+A52ygBr79f2F85y/4P0nc3H0+M1012ZMmXFH4FRuTe0cGcUmDr3M3XQhajc/kFhH1cCrKFJA/vR9TNSqu2mY0HBJL8vDC1lzoeoc8TBzovU4vsRpus6iKgOt4qNPzfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332137; c=relaxed/simple;
	bh=IgoFna4ozbyY4uim9EA58wTZVLELUeO04TswSLteP6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzWxP4GQd9O4OIpgLNN3ZAaDloMrUh/XW3kdsdTL9zW+/gJKiFLqFxqTBD1zEZOJPkmE+9lTRVvVCOT3AVaLnQQyDNCoB1oOwAhKnLrgeK+91ZKMSYRI49UcdZeLHj5cdI2bE4XoH5PV01AcNFmrBDqzsAyqWKpBxQXFxIy+ZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNCLxQV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBC0C433B1;
	Fri,  5 Apr 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332137;
	bh=IgoFna4ozbyY4uim9EA58wTZVLELUeO04TswSLteP6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNCLxQV/d9Gm8N9ut19bdF6HDO8Xy+cMGp/jd3klpEHI9GaRqDgTpd+BEyR/Ne7+m
	 jmzc7s4ds+hI4pRDmzI0bnHMXtYvqA1G171h8rzfmeT0U4Taorij1FLbUgitNeitcj
	 HvOLoIXoz+qZzCjTnM6FpZeRSfnt/+czJccKjMFVFU/OsSGZ8tP4qz3ATyVApCe6em
	 sRKC0PXoChZKTfUOybhKGkukVeUuMeOUSif3EmyuqCNJBGtMi3xYqV+GO4gNjnmR/z
	 ua5epYOwdOisi0YLgiqbbvyai5CxnwUubZrMrUinYnVOwmr730HIb6U1tW4zMnSV8G
	 pgE01LuYwi7DA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] riscv: Kconfig.socs: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
Date: Fri,  5 Apr 2024 16:47:36 +0100
Message-ID: <20240405-revolt-food-4654ca0ac5b4@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=MZ6COhcm44GicWVOSRcaxUS9DaBxroGchNqsbFCZFmg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkCsuIr+IwaOV9x8rQLzjqXWXXzZomHRVWxd3DoOmmNX rPIwJKOUhYGMQ4GWTFFlsTbfS1S6/+47HDueQszh5UJZAgDF6cATGTrbEaGB2F7Vix9F969e0Fx VOaE7aXFhWHTlr8TvT2zZZrlUX6LIEaGlkl2b/7KfJCc8Fm175dm+YW5rlzyWkxLQ7ZzTFKa1fu eEwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 29 Mar 2024 01:03:22 +0800, Yangyu Chen wrote:
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already in the mailing list [2,3,4], so we deprecate the use of
> SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from now
> on.
> 
> However, the K210 SoC is so special for NoMMU and built for loader.bin, if
> we share the ARCH_CANAAN symbol directly for K210 and other new SoCs which
> has MMU and no need for loader, it will confuse some users who may try to
> boot MMU Kernel on K210, but it will fail. Thus, this patch set renamed the
> original use of SOC_CANAAN to SOC_CANAAN_K210 for K210 SoC, as Damien
> suggested from the list [5]. Then, it made some adaptations for soc, clk,
> pinctrl, and reset drivers.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/5] riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
      https://git.kernel.org/conor/c/ef10bdf9c3e6
[2/5] soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
      https://git.kernel.org/conor/c/915fb0e31c5b
[3/5] clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      https://git.kernel.org/conor/c/8e5b7234ded5
[4/5] pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      https://git.kernel.org/conor/c/c1556a9b426e
[5/5] reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      https://git.kernel.org/conor/c/68f41105ea07

I added another commit at the end, deleting SOC_CANAAN given all the users
are gone and it is not user-visible:
	https://git.kernel.org/conor/c/0eea987088a22d73d81e968de7347cdc7e594f72

Thanks,
Conor.

