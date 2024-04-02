Return-Path: <linux-kernel+bounces-128480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F3895B65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86991F22E60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55C15AADB;
	Tue,  2 Apr 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1RPYV0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C015219E0;
	Tue,  2 Apr 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081241; cv=none; b=SlAk4G+uafxS2VFdfOjZ3ybX/3d/79RZcFk5vTFqcxQA4GS+gHF2OFFd1TGu2aMkyRqPtXljOzjGjrcTw4jSJakyTDiuYYR47qG/0MRYLmsqaXb/uHLJG24d4DRTXrw2akkHH7yaWnxeSrKBTi8/KHusujF3ltuzb4iYfbZ2P78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081241; c=relaxed/simple;
	bh=91aU9dbnR4oPxBkRhlJlak+TLyyFgxU3Lj4fxkKRr9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF4h4nl2rHtY+tvcuxRfdJwKOMwXxKSX7Q3S1DI4NjTYl7lO9nfcwmoilxtnjgzf17Z34On0AHeQO7PD84SPmDkVgKcu80YPZMwqe7FENfvJFER5GxcQ2YkxFJGpINrVqLC1/rL54Sh8KCIhZUcgOHyKStPSeKBnd5FEi98Pxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1RPYV0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5BCC43390;
	Tue,  2 Apr 2024 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081241;
	bh=91aU9dbnR4oPxBkRhlJlak+TLyyFgxU3Lj4fxkKRr9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1RPYV0snTHr8XNu7hM42QYJtoX68fM9iLvZliNyeCGev47mk1JODdjDlu5ar41B4
	 6pn0El/Lr6OJTo2/C18KeNC1wWP7RQNZF6umxfF5N2WVhdnViYKfw4RTxSn0dM29O1
	 hBlhBLjP+hKgzmrf8Ehq0apqRebcAwJl2qq0nh1hiZvdRsC6jYr73pdGpvae+hkZpT
	 qU/HA6X46Sa6qxdEKjYpYLdcgrwl5Ah3mQhAUgBED9ZEZ9J8PAxJhsJ1KNjN6AllvI
	 z31kvdLr/onRC4bBrpLy+1SM6bUh8rsF4dh8B3l9r9/kTV6jIFfiEmJytW0mD+DUXt
	 Wo5yCshpszXtw==
Date: Tue, 2 Apr 2024 13:07:18 -0500
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, zev@bewilderbeest.net,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
Message-ID: <20240402180718.GA358505-robh@kernel.org>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402120118.282035-1-andrew@codeconstruct.com.au>

On Tue, Apr 02, 2024 at 10:31:18PM +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
>  .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
>  2 files changed, 130 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> new file mode 100644
> index 000000000000..10fcb50c4051
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed watchdog timer controllers
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-wdt
> +      - aspeed,ast2500-wdt
> +      - aspeed,ast2600-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks: true

# and order/function if more than 1 must be defined.

Please note it was missing from the original binding in the commit 
message.

> +
> +  aspeed,reset-type:
> +    enum:
> +      - cpu
> +      - soc
> +      - system
> +      - none
> +    description: |
> +      Reset behaviour - The watchdog can be programmed to generate one of three
> +      different types of reset when a timeout occcurs.
> +
> +      Specifying 'cpu' will only reset the processor on a timeout event.
> +
> +      Specifying 'soc' will reset a configurable subset of the SoC's controllers
> +      on a timeout event. Controllers critical to the SoC's operation may remain untouched.
> +
> +      Specifying 'system' will reset all controllers on a timeout event, as if EXTRST had been asserted.
> +      Specifying "none" will cause the timeout event to have no reset effect.
> +      Another watchdog engine on the chip must be used for chip reset operations.
> +
> +      The default reset type is "system"

Express as schema:

default: system

> +
> +  aspeed,alt-boot:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Don't need '|' if no formatting to preserve.

> +      Direct the watchdog to configure the SoC to boot from the alternative boot
> +      region if a timeout occurs.
> +
> +  aspeed,external-signal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Assert the timeout event on an external signal pin associated with the
> +      watchdog controller instance. The pin must be muxed appropriately.
> +
> +  aspeed,ext-pulse-duration:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The duration, in microseconds, of the pulse emitted on the external signal pin

Wrap at <80. Period at end needed.

> +
> +  aspeed,ext-push-pull:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If aspeed,external-signal is specified in the node, set the external
> +      signal pin's drive type to push-pull. If aspeed,ext-push-pull is not
> +      specified then the pin is configured as open-drain.
> +
> +  aspeed,ext-active-high:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If both aspeed,external-signal and aspeed,ext-push-pull are specified in
> +      the node, set the pulse polarity to active-high. If aspeed,ext-active-high
> +      is not specified then the pin is configured as active-low.
> +
> +  aspeed,reset-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      A bitmaks indicating which peripherals will be reset if the watchdog
> +      timer expires. On AST2500 SoCs this should be a single word defined using
> +      the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a two-word
> +      array with the first word defined using the AST2600_WDT_RESET1_* macros,
> +      and the second word defined using the AST2600_WDT_RESET2_* macros.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      anyOf:
> +        - required:
> +            - aspeed,ext-push-pull
> +        - required:
> +            - aspeed,ext-active-high
> +        - required:
> +            - aspeed,reset-mask
> +    then:
> +      properties:
> +        compatible:
> +          enum:
> +            - aspeed,ast2500-wdt
> +            - aspeed,ast2600-wdt
> +  - if:
> +      required:
> +        - aspeed,ext-active-high
> +    then:
> +      required:
> +        - aspeed,ext-push-pull
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    wdt1: watchdog@1e785000 {

Drop unused labels.

> +        compatible = "aspeed,ast2400-wdt";
> +        reg = <0x1e785000 0x1c>;
> +        aspeed,reset-type = "system";
> +        aspeed,external-signal;
> +    };
> +  - |
> +    #include <dt-bindings/watchdog/aspeed-wdt.h>
> +    wdt2: watchdog@1e785040 {
> +        compatible = "aspeed,ast2600-wdt";
> +        reg = <0x1e785040 0x40>;
> +        aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> +                            (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> deleted file mode 100644
> index 3208adb3e52e..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -Aspeed Watchdog Timer
> -
> -Required properties:
> - - compatible: must be one of:
> -	- "aspeed,ast2400-wdt"
> -	- "aspeed,ast2500-wdt"
> -	- "aspeed,ast2600-wdt"
> -
> - - reg: physical base address of the controller and length of memory mapped
> -   region
> -
> -Optional properties:
> -
> - - aspeed,reset-type = "cpu|soc|system|none"
> -
> -   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
> -   to generate one of three different, mutually exclusive, types of resets.
> -
> -   Type "none" can be specified to indicate that no resets are to be done.
> -   This is useful in situations where another watchdog engine on chip is
> -   to perform the reset.
> -
> -   If 'aspeed,reset-type=' is not specified the default is to enable system
> -   reset.
> -
> -   Reset types:
> -
> -        - cpu: Reset CPU on watchdog timeout
> -
> -        - soc: Reset 'System on Chip' on watchdog timeout
> -
> -        - system: Reset system on watchdog timeout
> -
> -        - none: No reset is performed on timeout. Assumes another watchdog
> -                engine is responsible for this.
> -
> - - aspeed,alt-boot:    If property is present then boot from alternate block.
> - - aspeed,external-signal: If property is present then signal is sent to
> -			external reset counter (only WDT1 and WDT2). If not
> -			specified no external signal is sent.
> - - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
> -
> -Optional properties for AST2500-compatible watchdogs:
> - - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
> -			 drive type to push-pull. The default is open-drain.
> - - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
> -			   is configured as push-pull, then set the pulse
> -			   polarity to active-high. The default is active-low.
> -
> -Optional properties for AST2500- and AST2600-compatible watchdogs:
> - - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
> -		      the watchdog timer expires.  On AST2500 this should be a
> -		      single word defined using the AST2500_WDT_RESET_* macros;
> -		      on AST2600 this should be a two-word array with the first
> -		      word defined using the AST2600_WDT_RESET1_* macros and the
> -		      second word defined using the AST2600_WDT_RESET2_* macros.
> -
> -Examples:
> -
> -	wdt1: watchdog@1e785000 {
> -		compatible = "aspeed,ast2400-wdt";
> -		reg = <0x1e785000 0x1c>;
> -		aspeed,reset-type = "system";
> -		aspeed,external-signal;
> -	};
> -
> -	#include <dt-bindings/watchdog/aspeed-wdt.h>
> -	wdt2: watchdog@1e785040 {
> -		compatible = "aspeed,ast2600-wdt";
> -		reg = <0x1e785040 0x40>;
> -		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> -				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> -	};
> -- 
> 2.39.2
> 

