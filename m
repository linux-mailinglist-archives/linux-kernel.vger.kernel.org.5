Return-Path: <linux-kernel+bounces-143809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF18A3DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2C1F21A62
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5B51010;
	Sat, 13 Apr 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="n8vacIt7"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE04C637
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025526; cv=none; b=hM8lNCJ2ioH1/6wdd93xxu47cNCYbCxJHZ6Q0xOQOAQOU8MlRWyLovO3jkr66OFJBd+rGonfIc/wwGhE0w6Lly1sW/UBzrWT7C3LDPlduzo3ZMdfPhHQL3QTf8vUQLV05UDBgo6FCEoMy90eL2FR++4zFnGym+JJlibYBCQopUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025526; c=relaxed/simple;
	bh=n+iS7LyrTTkIi7xi6ucaibUFWn4QdelkPkr5JeYy8d4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0jcqtjImGJPKdrchybWGy0wE3OIM0qJ3r+gWG/7jQu5kZ2Ftz9d1V2WFPX47QcDRsMOzhQGbj0UXu4NrgzXMOKp/p30D0x8c+crK9SD2OcIuoOEC96ExMeja16BlS3MlCdksh3YFCCjnr0XOdU75sxsx1o4V+hW34UVfyj398Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=n8vacIt7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1713025521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+iS7LyrTTkIi7xi6ucaibUFWn4QdelkPkr5JeYy8d4=;
	b=n8vacIt7yfrQWFV7QBr4XWB0MCZzNkkwvAvjAaZI3WnrTW/b3zQGRAdKCbe29it5WgSvNV
	VLFeZCXFYtim2Q+WV6h70wdahJ/e69+9yRGgg5DO3cod+Y7F0q70BH+52OxNwSuWM4BNtY
	Y7+RYjNWMhWNZ3s84Wcmr6FJPTUumKkebR9aGJoLJjsDhQEWn3BzVMld4v6M69fy9y5g4V
	UNzo7ZvPD3kKkBYvAM5tIuGBApvMsv3OP+CLVclBLMmDVxrE0xwZrC/efABRLQbOVJeYvA
	DfrSdq3T7OkM4MECmhHw4s+TafCtGRx0WfwT59uSAeMAuSX8WLTc1nPPZQ1Naw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Johan Jonker <jbx6244@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 shironeko <shironeko@tesaguri.club>, Etienne Buira <etienne.buira@free.fr>,
 Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid error message on rk3328 use
Date: Sat, 13 Apr 2024 18:25:08 +0200
Message-ID: <2858084.SxWNgMZFd1@bagend>
Organization: Connecting Knowledge
In-Reply-To: <Zhqjhvq38oNH5-sR@Z926fQmE5jqhFMgp6>
References:
 <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
 <f245966c-267f-4159-a9ca-2561693d24d9@linaro.org>
 <Zhqjhvq38oNH5-sR@Z926fQmE5jqhFMgp6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1947452.T9h9lEBQeK";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1947452.T9h9lEBQeK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] Avoid error message on rk3328 use
Date: Sat, 13 Apr 2024 18:25:08 +0200
Message-ID: <2858084.SxWNgMZFd1@bagend>
Organization: Connecting Knowledge
In-Reply-To: <Zhqjhvq38oNH5-sR@Z926fQmE5jqhFMgp6>
MIME-Version: 1.0

On Saturday, 13 April 2024 17:23:50 CEST Etienne Buira wrote:
> Current tree displays a spurious "can't read the data register offset"
> message.

Sounds useful to mention that (specific) error message as that did rang a bell.
--nextPart1947452.T9h9lEBQeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZhqx5AAKCRDXblvOeH7b
buzoAP9IvFP5YDXQPi1B4ZffLVaTiAAgMhjgunSAtOX0B6Nh+AD/X/yn6HLFcrnw
guI7nfh53NS5sflYMoh5EorcImZvkwk=
=+8l6
-----END PGP SIGNATURE-----

--nextPart1947452.T9h9lEBQeK--




