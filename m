Return-Path: <linux-kernel+bounces-75973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6385F15E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BD31C21354
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A917BB2;
	Thu, 22 Feb 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQcS4EBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599617995;
	Thu, 22 Feb 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582477; cv=none; b=k5+VLvtH6IbDPzbZMZCeRTVLWtc4tmdpn9AFTQ8sxi8U+dBW1Nrrl2rLWfH6Fql4Rglil6wGupObCr2lBsHpVozrZnz6meEbAV19uOYVmb3gsZJXtVg23YyI7AWrxBPmQI7FCJKGvwxu/ZDuykL+grq0gCrfa/zR43ENHbPU37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582477; c=relaxed/simple;
	bh=pgg5WKeYR4QbYp1ZZYjlrBPumfK+qOrTGW2v0uXP17k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NLGnBcJpoVBLevT04LUJvOBVNyrlM7XO/5hnTbiWKv0qOI7S5gDBOGKo9JRHshEIcA518gSersJMv/1a4S2h9cv1g6VHh6IwG6D40VsEPShMEbTw+pQoYu22Ab0PBUclOYsjLUUYK2PHp4r/8CJMnQSRelGO8reH5CsMwbtmHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQcS4EBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6487CC433C7;
	Thu, 22 Feb 2024 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708582477;
	bh=pgg5WKeYR4QbYp1ZZYjlrBPumfK+qOrTGW2v0uXP17k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HQcS4EBXCG4zKnYIz8MSHjaxIUQGvHVl1xacBMeKjbYhpsLOqxH/en6rt3pCWsg49
	 1pqJvLoYPA6B8pqSKwfo/+uIUZ0paW4B5o63XZLpRYkJMVvWAWRSUj7ddUUPChAdyS
	 j3oKVYc93wQIKxdLhkN4/WrQJt1jxZj/ZLvpZ/DCg99q7SvElIyD07pQELEufodm7g
	 pcuNH4DAyWYCMeNqhjgKOmpX1yoOKf7YMA/WAqo5kwYJ74yL8x286DYiW6tHr0b3CF
	 ZFLD5mrp9Fm1v+Y0Bq5CdGAzitAhYotfsUAGVzERfHKWFlmz9wUHgizCDn7k6M8oso
	 Sp3Q9jC4jurwQ==
Message-ID: <e0ef5616466b7dc9a5c7ede84fb234ad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240221-mbly-clk-v7-3-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com> <20240221-mbly-clk-v7-3-31d4ce3630c3@bootlin.com>
Subject: Re: [PATCH v7 03/14] dt-bindings: clock: mobileye,eyeq5-clk: add bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 22:14:35 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-02-21 10:22:11)
> Add DT schema bindings for the EyeQ5 clock controller driver.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

