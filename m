Return-Path: <linux-kernel+bounces-140180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714A8A0C73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F161C22DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C739144D3B;
	Thu, 11 Apr 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poMbw9Fi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44C13B2A8;
	Thu, 11 Apr 2024 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827958; cv=none; b=m1xEu922SyA9Rynp3q4WTFEhGV5S+BwvML2m9CTs5yuCnnUe+2EaHKMy8/Ybptiq9cdQ0IDoRBIVHUpN+TsB1lTaS1ZiSVpjnzLMeqUMFQWfEDCmLgFxGg1CjLNTY87pw5KVW128pXJ4e45p4EMLCeoU26eLrdybZAuulrGP3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827958; c=relaxed/simple;
	bh=E2fS9i5EEcvCk9a+xW6wInmIjmxmio5+leGF/xordsU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nMcU4scl5m1WH4ZoDtbDHOkRTIgHSIDv+yWQSM1JxI2sNhMCGQW/UMTpDGiuENgztsP0A/ooIm7FG2f+ZFwLNlbZle5iVtJjOIx9UJGEhC/Mdy//Ubs8HTN54Op3kEBsRcoPrD4fKy0bOLglthz6Tx5YjjILwe4mA2nlzwPxFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poMbw9Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC10C433F1;
	Thu, 11 Apr 2024 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827958;
	bh=E2fS9i5EEcvCk9a+xW6wInmIjmxmio5+leGF/xordsU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=poMbw9FibZL+XllAeCoBy1prqFftGnMMs//w0rWLiyMsh6w4s35FFk86t38W5xfUE
	 fWI10n/qYDf9EtcJzsHwdM0ts+nIjJVJiNpE49yVsOUP9vnir+gxIPzT5DZrMnS61e
	 24wzEXUYLca5yTgWlchNbMBhG5HfJfOCSZmZRcTi2hDDJzKOvqvd4UFl4QMo7PVspI
	 cOCzmKX0yvAAUgtASi+IL57e3JxQQzIhlaf4mOjs2g31V92MHT+cESOJHJtLio6eDo
	 LrzMk0v8HqXqUSyugxfECkJHD7pQt9E3/FpHuFc4Hogxp8fNP3eng0JXoXEwajtjCC
	 W+NgNPUirmmOA==
Message-ID: <6855551f92648556b4079ea3755d2987.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240408-ep93xx-clk-v1-1-1d0f4c324647@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me> <20240408-ep93xx-clk-v1-1-1d0f4c324647@maquefel.me>
Subject: Re: [PATCH 1/4] ARM: ep93xx: add regmap aux_dev
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Rob Herring <robh@kernel.org>, nikita.shubin@maquefel.me
Date: Thu, 11 Apr 2024 02:32:36 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-04-08 01:09:53)
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> The following driver's should be instantiated by ep93xx syscon driver:
>=20
> - reboot
> - pinctrl
> - clock
>=20
> They all require access to DEVCFG register with a shared lock held, to
> avoid conflict writing to swlocked parts of DEVCFG.
>=20
> Provide common resources such as base, regmap and spinlock via auxiliary
> bus framework.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

