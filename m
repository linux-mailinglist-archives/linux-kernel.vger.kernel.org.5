Return-Path: <linux-kernel+bounces-140161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FA8A0C36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07202B24B29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530E14431D;
	Thu, 11 Apr 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2uEOJk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B613D258;
	Thu, 11 Apr 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827306; cv=none; b=ufzKbIH5CPiEC4geN2EgoAqQcgJRj6wmogvw5J3oDevgSuPwckN6YcgwK6iHqyuDqVQ06sXHo2nCQnaVu60hXhaQq4nuKR9i0PKlPI2zAliEUDXXlaFVnWxRlcV9Ip5Kxgd/oxSlRaXr+yrNQCTwCBmeC2ky9thI4PnY3/usniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827306; c=relaxed/simple;
	bh=gYO1mF5/U4kkBcBtg406va8gcS8Zo2X98br7HyIJpQM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dlZTOaoqbxk4SbPkuvNjwZ6nVuQ/lMz6CmSEgflrzUO/Xi2WSvZ1X+JxF2Svh+0HXidY1q92BUc9Nqm4qcIaOF218EIjR3I8NALg9vT+fnZr16ITiyvWSz9Bwt3phH8qLd9KslkcUqXaj7hVXBAwjD6kLWJsQEvIOreUhAtbnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2uEOJk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C9BC433F1;
	Thu, 11 Apr 2024 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827305;
	bh=gYO1mF5/U4kkBcBtg406va8gcS8Zo2X98br7HyIJpQM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=i2uEOJk9xxSn8TelZjbW3knSDIm6inhNY294w+pHywO850L2y6ZVwZlKtR0150QHj
	 s9JeS6hm2ViaVkFYHDLrsQMAfUKy9rP8XqzpLINvjjPVdwA+CgqbSHu2CfQyObL/Xe
	 O8zb7cMNr9v9T801jYGbo053QtKrOTK12HsrQoUCkJ82QCey0IerkMsA0V5TDBUn31
	 kjqPWwmJcqBRiyLVhcwu5PtNwgdrgds2Jlms4mbg4T6y+7XPfKH0pDvv9FtXvvl7CG
	 g6HgeVt+CTIgkl6jt6sPMImjxSVk8kb8rRcz6/kZoFbW2SK0Ug455w/w7L6tGLR8KZ
	 Je2a3sYFFU3Kg==
Message-ID: <ec649aacc50aef2ce1fe9ec87ef033c1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240408-ep93xx-clk-v1-3-1d0f4c324647@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me> <20240408-ep93xx-clk-v1-3-1d0f4c324647@maquefel.me>
Subject: Re: [PATCH 3/4] dt-bindings: soc: Add Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Rob Herring <robh@kernel.org>, nikita.shubin@maquefel.me
Date: Thu, 11 Apr 2024 02:21:43 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-04-08 01:09:55)
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add device tree bindings for the Cirrus Logic EP93xx SoC.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

