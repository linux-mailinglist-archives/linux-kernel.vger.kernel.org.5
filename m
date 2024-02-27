Return-Path: <linux-kernel+bounces-82657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DD8687D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEF31C210D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228B225D9;
	Tue, 27 Feb 2024 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcpnKLv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58A20DD3;
	Tue, 27 Feb 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005251; cv=none; b=DTtERpymvymxrQ+PrqzDZrTVxeGdUtdxUIgEs9zOm+sS6CzPNbYIz1sn4KbuHP1UrG3B1Sg7Gzjf+amGQPr6x2DDi4jfLKR95b/xQaaTfk9r7ndKEPsZ/d8MyLZMf+r5tyVB1B2q6jJQiqwrLBdBBYW0yTom1nm7Z71X3xhMsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005251; c=relaxed/simple;
	bh=F7EpFyKjl+IHhn75vKorY4OI7se0+dD77WgdblI6/x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcLg21tA9bWbM//FyKZ79X18NrWfTEQoQ3B3G4jN7ThBj6xJ5wyKM2QQCpXodseacP11UPCLgDqoj36HSH1YwHM+dUM7+7zFGYC1T79N2WI24E1VFAztJp/2CNkPeeXgNha5ABNqaNdwtaQmTrH8xYHn/hSokUQ8GuehDIxqTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcpnKLv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFDDC433C7;
	Tue, 27 Feb 2024 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709005250;
	bh=F7EpFyKjl+IHhn75vKorY4OI7se0+dD77WgdblI6/x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcpnKLv33h4/RDikiNfpNAwZoEGni5wy7RwuQuOUWYZ49SjyUiEHngtHF/Ie0byu3
	 zpsuIyUhjpkniZG2ThzQAmVfzuckmU25CMlnu07msCPm0xA5nxUqrzReC8yNd0vBld
	 huBTwoZQViD7rgdF2SEPq/mNYA/hNRvN10y8GM+M+etVEzSW0iA2W/1i9HQdFG2oI4
	 Q6xHXFfc+l5TTEYV6q1+uuKcbHLr89FQmlIVZn8+Va3Fb72zXHpAtWTIk6NseIFSLP
	 dY5fghMr+ashA33RN9xeGZNk6adadUcknmYMkKwXvbgtQTqPS4jGFq2UXtg0BaCJWq
	 Huol/qweALfYQ==
Date: Mon, 26 Feb 2024 21:40:47 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
	linux-aspeed@lists.ozlabs.org, brgl@bgdev.pl,
	linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT
 schema
Message-ID: <20240227034047.GA2644802-robh@kernel.org>
References: <20240227004414.841391-1-andrew@codeconstruct.com.au>
 <170900020204.2360855.790404478830111761.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170900020204.2360855.790404478830111761.robh@kernel.org>

On Mon, Feb 26, 2024 at 08:16:43PM -0600, Rob Herring wrote:
> 
> On Tue, 27 Feb 2024 11:14:14 +1030, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> > ```
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > v4: Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
> >     https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647@linaro.org/
> > 
> >     Add more examples to exercise constraints.
> > 
> > v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew@codeconstruct.com.au/
> > 
> >     Base on v6.8-rc6, fix yamllint warning
> > 
> >     Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
> >     patch was based on v6.8-rc1, and going back over my shell history I missed
> >     the following output from `make dt_binding_check`:
> > 
> >     ```
> >     ...
> >       LINT    Documentation/devicetree/bindings
> >       usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
> >       yamllint: error: one of the arguments FILE_OR_DIR - is required
> >     ...
> >     ```
> > 
> >     I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
> >     of `yamllint`.
> > 
> > [1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh@kernel.org/
> > 
> > v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeconstruct.com.au/
> > 
> >     Address feedback from Krzysztof:
> >     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/
> > 
> > v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/
> > 
> >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 149 ++++++++++++++++++
> >  .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
> >  2 files changed, 149 insertions(+), 39 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> In file included from Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.example.dts:91:
> ./scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:14: warning: "ASPEED_CLK_GATE_LCLK" redefined
>    14 | #define ASPEED_CLK_GATE_LCLK            6

The examples aren't isolated from each other, so you can't have 
conflicting includes. You'll have to drop some of the examples or drop 
their use of the conflicting include.

Rob

