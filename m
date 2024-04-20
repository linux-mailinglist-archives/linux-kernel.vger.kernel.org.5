Return-Path: <linux-kernel+bounces-152267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79018ABBA4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926942819A2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2FB1CD3A;
	Sat, 20 Apr 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM+2gqJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC362563;
	Sat, 20 Apr 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618343; cv=none; b=HaE53CRUwSlv+wNXToJN+xAcf/AKTlqWMvhJEAaNWScSx8yDAnAJoGAmop04C/lCWkcoQ31fOVVy6jKUb1TcYGB7wqxAUzx6mVPHuykXOJodacHgrpcxYC8x6al6IebnUL3rS4tfeWzeSBOthJQcwTFFEVId/CFM1pNsEZZMRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618343; c=relaxed/simple;
	bh=tOZPG4x4K1aaVR7scN0+nqXpWbKsYpd4x0tbSOKNkhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPWEu2NgBWOSog+te4zvfsbmMNALQ6f8IBjiFehMHI/TzT5Fx7NRPPcdJORmw8mYEcZcP4YIuo9ky1yLx32WVyPHR64NAIF3SR5zywct3Q3DAGqWplWACxSAO59qd1CxVb99UY51fhOVYQ6HhIB6miGZqV7O9xeWD7iJjpq2kWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM+2gqJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E0FC072AA;
	Sat, 20 Apr 2024 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713618342;
	bh=tOZPG4x4K1aaVR7scN0+nqXpWbKsYpd4x0tbSOKNkhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HM+2gqJzP8IUVEbCaRE4niLBqKrbMxHoNWxLcVxUUWBjr5VRg+bq6YXOvEtGqUZLJ
	 pK0MXDTpgXT7xPg/7WkOpqUVuZx4d00BQ8q+UP4SG1oOrPs/9mlBLMQ9o1GW9jn+Oz
	 SjRc6d3HGlzj8xDlGltG4TCby03BtDIob+bYGxRFnMb4e2mOwPQJ/QDwodWIVzt9XG
	 oh+yfceomfpXCenZrwyTcfkBzOwG9Mf9vF64mG5EMYBKvzXqeOvY7l8RlyHMjwHwNm
	 m9iCbwzFjAkXWWzUF0l69J6QlW6+b2xTueTqUmrFgdlOWxmWAUu9bvM6mz7Im/MrVs
	 UbnmgDD9lLn3Q==
Date: Sat, 20 Apr 2024 14:05:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Andy
 Shevchenko <andy.shevchenko@gmail.com>, Ondrej Jirman <megi@xff.cz>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Willow
 Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add regulator for
 vdd supply
Message-ID: <20240420140529.4d969c6f@jic23-huawei>
In-Reply-To: <20240414175716.958831-1-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
	<20240414175716.958831-1-aren@peacevolution.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 13:57:13 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f6e22dc9814a..db35e239d4a8 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -29,6 +29,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply: true

As per review of patch 2, make it required and add one to the example.
That doesn't mean it will be in every dts file, just that we expect
it to exist given chips tend to work poorly without power.

>    proximity-near-level: true
>  
>  required:


