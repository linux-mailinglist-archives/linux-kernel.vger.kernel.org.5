Return-Path: <linux-kernel+bounces-155331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB88AE8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C151F24F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B413B2BD;
	Tue, 23 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qww5zQ8M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06A13774F;
	Tue, 23 Apr 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880858; cv=none; b=AZUVozaGKgOakFSRTr5fi8FjCKi9gt9zzcD1dUsxpSXKxqLETwwnqDpg271GZcL73yi2veLdGfngQ062UJr4sV+iAOaoMLf4m+Y6U/bnLYoN5YTyBT0XVezW5GtGYOgfWX3luQEYGVubbH+CrKTpbP8+skFlPib3Z6dvg0LU9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880858; c=relaxed/simple;
	bh=U5ONziDaCttdPKhkIOEueLEAiyPNH0TnEDai6u5SLNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbcwtZUJ8q5ITGznhly7tkNSnCjuyNQ7lnJIdZIPKnKcMShW5QmJXnxE+ZRHkBL/H/sVoKU2udXWaNPp5BgDvlI6+O5SiiJOI5zkZ095/Pi3RJ6sA1XfJdRNh+BbnLKUQfXPTBSr+tCWeA7saoPYcaWLsIoXpF3CIaASzg1AnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qww5zQ8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD06C116B1;
	Tue, 23 Apr 2024 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880858;
	bh=U5ONziDaCttdPKhkIOEueLEAiyPNH0TnEDai6u5SLNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qww5zQ8MpvVgMCgYso0anl+IDVueBE7HE0bQqpm3UfHjVqss83se6mrRVVbmhnSHE
	 inP3GOhYCBMyamNWjEALHnoNBFHqIKFNY0eGZvvPLRAESMtEDuogW1BxCa7xLZR//B
	 lEkIek9mkZjg+oZA87gEtkkHpLJJMs88LE+HQXUgrOJMHd5wFo+h7+nc1DYjUCQzug
	 p44dEhTE+jCPUQo++URXAqwdnuqKuuRbD9up3rCYDyXhhOBiwi6gO4U0osXUJie4js
	 O2gNfADYS1CMg+R2tfeioc8PJMg4SuIKvDPEl4YABHYGeHmfkLU6r81gEo4Jw3cQbe
	 KyJHtIVfIG+Og==
Date: Tue, 23 Apr 2024 09:00:56 -0500
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, conor+dt@kernel.org, zev@bewilderbeest.net,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to
 DT schema
Message-ID: <171388085227.112740.4043099256538346209.robh@kernel.org>
References: <20240403020439.418788-1-andrew@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403020439.418788-1-andrew@codeconstruct.com.au>


On Wed, 03 Apr 2024 12:34:39 +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> ```
> 
> The schema binding additionally defines the clocks property over the
> prose binding to align with use of the node in the DTS files.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v2: Address feedback from Rob and Zev
> 
>     - Rob: https://lore.kernel.org/linux-watchdog/20240402180718.GA358505-robh@kernel.org/
>     - Zev: https://lore.kernel.org/linux-watchdog/65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net/
> 
> v1: https://lore.kernel.org/linux-watchdog/20240402120118.282035-1-andrew@codeconstruct.com.au/
> 
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 142 ++++++++++++++++++
>  .../bindings/watchdog/aspeed-wdt.txt          |  73 ---------
>  2 files changed, 142 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 

Applied, thanks!


