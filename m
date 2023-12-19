Return-Path: <linux-kernel+bounces-5161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B869818763
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA9A1C23BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456F18627;
	Tue, 19 Dec 2023 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmR0JBNF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9711B270;
	Tue, 19 Dec 2023 12:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E20C433C8;
	Tue, 19 Dec 2023 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702988586;
	bh=0ZPp7C6xPL+E7Gl2PQUcf+FzC1fInLNKOXnsyZEshH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZmR0JBNFAiBZb0p1MEKAxT1zSWlnme9VmUwU98gE5BqXfMiJcEHOIbHnMcovCvBGj
	 rKYQda3cxg0fGzsxtly79HledAn2RilUONenAjv2Cuut4HI0v5+D7a6UEOjpEg7nDD
	 9RLlCXmF5Hki3UqANsMRELjG68+v1E8H/c0Uh4wV+5ubBzA60X/QqPcBWSyVzMC6bQ
	 XOHOt7ABZcNrTcFZG/0+IC5te7gUnNK9jLMytl96jOMB2cq0kA7CqcbYCEUA6fpzb3
	 NH98ZI377USSjEZwvNrTLZ+nFEI4l6O6cOT8g05HG1vH5zRhs5C/RTA0NsNXyHzGB2
	 BXLPNWBqoT6jA==
Received: (nullmailer pid 1608322 invoked by uid 1000);
	Tue, 19 Dec 2023 12:23:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-gpio@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Jonathan Cameron <jic23@kernel.org>, ChiaEn Wu <chiaen_wu@richtek.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Arnd Bergmann <arnd@arndb.de>, andy@kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, brgl@bgdev.pl, Ceclan Dumitru <dumitru.ceclan@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Conor Dooley <conor+dt@kernel.org>, linus.walleij@linaro.org, =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <20231219104631.28256-1-mitrutzceclan@gmail.com>
References: <20231219104631.28256-1-mitrutzceclan@gmail.com>
Message-Id: <170298858334.1608301.13113864256271673228.robh@kernel.org>
Subject: Re: [PATCH v10 1/2] dt-bindings: adc: add AD7173
Date: Tue, 19 Dec 2023 06:23:03 -0600


On Tue, 19 Dec 2023 12:46:12 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> 
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
>  .../bindings/iio/adc/adi,ad7173.yaml          | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.example.dtb: adc@0: '#gpio-cells' is a dependency of 'gpio-controller'
	from schema $id: http://devicetree.org/schemas/gpio/gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231219104631.28256-1-mitrutzceclan@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


