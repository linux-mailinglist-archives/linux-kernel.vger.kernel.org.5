Return-Path: <linux-kernel+bounces-20311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571F827D23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229AF1F22AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197FF33F6;
	Tue,  9 Jan 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+ak6Tt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC816D6CA;
	Tue,  9 Jan 2024 02:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32DAC433C7;
	Tue,  9 Jan 2024 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704769138;
	bh=8amxIQKYmOday6JZe0yAPbJIK5lyapq17OeQeMOSzvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+ak6Tt9iThu3wRNZuHVzFZTxiqpL2KxLNg0JN0Na9mETYZGIH7s6307mINx1am7b
	 h0TC+k/oZPUylITVu7jeROPhIJwgF55BVzlCPPddBADvVIIZVQQviGjUg+BNPJCPXX
	 IpzqoXrCCNSYSBwqO5BlvosHhisHIpa58mRAJODGz1e49gZFB6DxxX2uFMMSevYiYh
	 o3DDgv3nRNEfvV7arvYTxSNbSm4XSlnR6C+ykeakjvjiSmp4B883IzlZ/xHQe+bJ0X
	 pcOZIKHWjf15gPORZXirXemRJix4M1QYcnwSV8ItiYYw1jzem2MKaxzLoOHcQwJ0aQ
	 jFSZsSeZjcHiw==
Received: (nullmailer pid 2446730 invoked by uid 1000);
	Tue, 09 Jan 2024 02:58:56 -0000
Date: Mon, 8 Jan 2024 19:58:56 -0700
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linux-iio@vger.kernel.org, brgl@bgdev.pl, Ceclan Dumitru <dumitru.ceclan@analog.com>, linus.walleij@linaro.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, ChiaEn Wu <chiaen_wu@richtek.com>, linux-gpio@vger.kernel.org, Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Niklas Schnelle <schnelle@linux.ibm.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, andy@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Message-ID: <170476913621.2446678.11123586043221028423.robh@kernel.org>
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220104810.3179-1-mitrutzceclan@gmail.com>


On Wed, 20 Dec 2023 12:48:04 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> V10->V11
>  - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller'
>  - Add description to #gpio-cells property
> V9->V10
>  - Fix dt_binding_check type warning from adi,reference-select
> V8->v9
>  - Add gpio-controller and "#gpio-cells" properties
>  - Add missing avdd2 and iovdd supplies
>  - Add string type to reference-select
> V7->V8
>  - include missing fix from V6
> V6->V7 <no changes>
> V5->V6
>  - Moved global required property to proper placement
> V4 -> V5
>  - Use string enum instead of integers for "adi,reference-select"
>  - Fix conditional checking in regards to compatible
> V3 -> V4
>  - include supply attributes
>  - add channel attribute for selecting conversion reference
> V2 -> V3
>  - remove redundant descriptions
>  - use referenced 'bipolar' property
>  - remove newlines from example
> V1 -> V2 <no changes>
> 
>  .../bindings/iio/adc/adi,ad7173.yaml          | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


