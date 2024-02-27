Return-Path: <linux-kernel+bounces-82582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C205F8686A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E291C22415
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724711096F;
	Tue, 27 Feb 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CywA2/DA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE21D53E;
	Tue, 27 Feb 2024 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000205; cv=none; b=WTjlMw8lvomLmyGeGQD41XvLgKzicweOWbQlQLm6vXS6O0yzR/ac9aR6cc2dqqVErZ6G2Shnf6GHx7I3scdJyOvT2GVk075sWnzt/1J0Too31n1dUqHbRGMVAtj32MzBTcQ02QtLNGNflt8mJ3qn7oSPthkesTUHQIkngPerN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000205; c=relaxed/simple;
	bh=mz/u9EkJffHeBU02kRBjhD8lvvMu6QEI/4vnSpJmJj0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=U99/dQzAg6XBuNDDyAJF04XLtKdXJKusJH3t5/uHYkhw0fWyDWEZCAHvxnNlb61RTab0HayImGjVhZZs5kuajwX482uicwhyti/rYXx//DNBjCRVR1+JiHs5yRVwwgwb9y2uhQW3h/kYw8QRHaHS5e+m1uSjRyTXayWwTiCjkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CywA2/DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C62C433C7;
	Tue, 27 Feb 2024 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709000204;
	bh=mz/u9EkJffHeBU02kRBjhD8lvvMu6QEI/4vnSpJmJj0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CywA2/DAZwzu+/tDJyr3guEOo4GnOwjqx+Ae1taXeq3By1uEqJwEsxOi3rZnpThOL
	 tEhbcdZ6G8LUDbw44Q23Oc0h8vThcqB8HB/qIDco6TYOEi5qm4URaz8XXjE8FJv+F0
	 W/mQi/oqZAkq6B5o09PJ9WT+KtlaWD1D1i0aIK9quwgANHto9aAVJ/uqjFGdceczrf
	 B7aNRP2gB48oEzRL18cX9HtW6kCTtMvGN/jPIr9T+oMk20B/xDlPIYEB92jFOHwX1k
	 WK82WXV7p2zgN15notE+FQhlaXpfD7MmRcQ9EWOxm8nX2qUXceaZzjnfQAri2CeVAs
	 FVlP6BySPBvWg==
Date: Mon, 26 Feb 2024 20:16:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
 linux-aspeed@lists.ozlabs.org, brgl@bgdev.pl, 
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, 
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20240227004414.841391-1-andrew@codeconstruct.com.au>
References: <20240227004414.841391-1-andrew@codeconstruct.com.au>
Message-Id: <170900020204.2360855.790404478830111761.robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema


On Tue, 27 Feb 2024 11:14:14 +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v4: Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
>     https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647@linaro.org/
> 
>     Add more examples to exercise constraints.
> 
> v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew@codeconstruct.com.au/
> 
>     Base on v6.8-rc6, fix yamllint warning
> 
>     Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
>     patch was based on v6.8-rc1, and going back over my shell history I missed
>     the following output from `make dt_binding_check`:
> 
>     ```
>     ...
>       LINT    Documentation/devicetree/bindings
>       usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
>       yamllint: error: one of the arguments FILE_OR_DIR - is required
>     ...
>     ```
> 
>     I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
>     of `yamllint`.
> 
> [1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh@kernel.org/
> 
> v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeconstruct.com.au/
> 
>     Address feedback from Krzysztof:
>     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/
> 
> v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/
> 
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 149 ++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
>  2 files changed, 149 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.example.dts:91:
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:14: warning: "ASPEED_CLK_GATE_LCLK" redefined
   14 | #define ASPEED_CLK_GATE_LCLK            6
      | 
In file included from Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.example.dts:56:
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:14: note: this is the location of the previous definition
   14 | #define ASPEED_CLK_GATE_LCLK            8
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:15: warning: "ASPEED_CLK_GATE_LHCCLK" redefined
   15 | #define ASPEED_CLK_GATE_LHCCLK          7
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:29: note: this is the location of the previous definition
   29 | #define ASPEED_CLK_GATE_LHCCLK          23
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:17: warning: "ASPEED_CLK_GATE_D1CLK" redefined
   17 | #define ASPEED_CLK_GATE_D1CLK           8
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:16: note: this is the location of the previous definition
   16 | #define ASPEED_CLK_GATE_D1CLK           10
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:18: warning: "ASPEED_CLK_GATE_YCLK" redefined
   18 | #define ASPEED_CLK_GATE_YCLK            9
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:17: note: this is the location of the previous definition
   17 | #define ASPEED_CLK_GATE_YCLK            11
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:23: warning: "ASPEED_CLK_GATE_ESPICLK" redefined
   23 | #define ASPEED_CLK_GATE_ESPICLK         12
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:22: note: this is the location of the previous definition
   22 | #define ASPEED_CLK_GATE_ESPICLK         16
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:25: warning: "ASPEED_CLK_GATE_USBUHCICLK" redefined
   25 | #define ASPEED_CLK_GATE_USBUHCICLK      13
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:15: note: this is the location of the previous definition
   15 | #define ASPEED_CLK_GATE_USBUHCICLK      9
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:26: warning: "ASPEED_CLK_GATE_USBPORT1CLK" redefined
   26 | #define ASPEED_CLK_GATE_USBPORT1CLK     14
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:18: note: this is the location of the previous definition
   18 | #define ASPEED_CLK_GATE_USBPORT1CLK     12
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:27: warning: "ASPEED_CLK_GATE_USBPORT2CLK" redefined
   27 | #define ASPEED_CLK_GATE_USBPORT2CLK     15
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:13: note: this is the location of the previous definition
   13 | #define ASPEED_CLK_GATE_USBPORT2CLK     7
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:29: warning: "ASPEED_CLK_GATE_RSACLK" redefined
   29 | #define ASPEED_CLK_GATE_RSACLK          16
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:25: note: this is the location of the previous definition
   25 | #define ASPEED_CLK_GATE_RSACLK          19
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:32: warning: "ASPEED_CLK_GATE_MAC1CLK" redefined
   32 | #define ASPEED_CLK_GATE_MAC1CLK         18
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:23: note: this is the location of the previous definition
   23 | #define ASPEED_CLK_GATE_MAC1CLK         17
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:33: warning: "ASPEED_CLK_GATE_MAC2CLK" redefined
   33 | #define ASPEED_CLK_GATE_MAC2CLK         19
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:24: note: this is the location of the previous definition
   24 | #define ASPEED_CLK_GATE_MAC2CLK         18
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:37: warning: "ASPEED_CLK_GATE_UART1CLK" redefined
   37 | #define ASPEED_CLK_GATE_UART1CLK        22
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:19: note: this is the location of the previous definition
   19 | #define ASPEED_CLK_GATE_UART1CLK        13
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:38: warning: "ASPEED_CLK_GATE_UART2CLK" redefined
   38 | #define ASPEED_CLK_GATE_UART2CLK        23
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:20: note: this is the location of the previous definition
   20 | #define ASPEED_CLK_GATE_UART2CLK        14
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:39: warning: "ASPEED_CLK_GATE_UART3CLK" redefined
   39 | #define ASPEED_CLK_GATE_UART3CLK        24
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:26: note: this is the location of the previous definition
   26 | #define ASPEED_CLK_GATE_UART3CLK        20
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:40: warning: "ASPEED_CLK_GATE_UART4CLK" redefined
   40 | #define ASPEED_CLK_GATE_UART4CLK        25
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:27: note: this is the location of the previous definition
   27 | #define ASPEED_CLK_GATE_UART4CLK        21
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:41: warning: "ASPEED_CLK_GATE_UART5CLK" redefined
   41 | #define ASPEED_CLK_GATE_UART5CLK        26
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:21: note: this is the location of the previous definition
   21 | #define ASPEED_CLK_GATE_UART5CLK        15
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:51: warning: "ASPEED_CLK_GATE_SDCLK" redefined
   51 | #define ASPEED_CLK_GATE_SDCLK           35
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:28: note: this is the location of the previous definition
   28 | #define ASPEED_CLK_GATE_SDCLK           22
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:63: warning: "ASPEED_CLK_HPLL" redefined
   63 | #define ASPEED_CLK_HPLL                 46
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:30: note: this is the location of the previous definition
   30 | #define ASPEED_CLK_HPLL                 24
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:64: warning: "ASPEED_CLK_MPLL" redefined
   64 | #define ASPEED_CLK_MPLL                 47
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:40: note: this is the location of the previous definition
   40 | #define ASPEED_CLK_MPLL                 34
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:68: warning: "ASPEED_CLK_AHB" redefined
   68 | #define ASPEED_CLK_AHB                  51
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:31: note: this is the location of the previous definition
   31 | #define ASPEED_CLK_AHB                  25
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:71: warning: "ASPEED_CLK_BCLK" redefined
   71 | #define ASPEED_CLK_BCLK                 54
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:39: note: this is the location of the previous definition
   39 | #define ASPEED_CLK_BCLK                 33
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:74: warning: "ASPEED_CLK_LHCLK" redefined
   74 | #define ASPEED_CLK_LHCLK                57
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:37: note: this is the location of the previous definition
   37 | #define ASPEED_CLK_LHCLK                31
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:75: warning: "ASPEED_CLK_UART" redefined
   75 | #define ASPEED_CLK_UART                 58
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:33: note: this is the location of the previous definition
   33 | #define ASPEED_CLK_UART                 27
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:77: warning: "ASPEED_CLK_SDIO" redefined
   77 | #define ASPEED_CLK_SDIO                 60
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:34: note: this is the location of the previous definition
   34 | #define ASPEED_CLK_SDIO                 28
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:79: warning: "ASPEED_CLK_ECLK" redefined
   79 | #define ASPEED_CLK_ECLK                 62
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:35: note: this is the location of the previous definition
   35 | #define ASPEED_CLK_ECLK                 29
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:80: warning: "ASPEED_CLK_ECLK_MUX" redefined
   80 | #define ASPEED_CLK_ECLK_MUX             63
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:36: note: this is the location of the previous definition
   36 | #define ASPEED_CLK_ECLK_MUX             30
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:84: warning: "ASPEED_CLK_MAC1RCLK" redefined
   84 | #define ASPEED_CLK_MAC1RCLK             67
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:42: note: this is the location of the previous definition
   42 | #define ASPEED_CLK_MAC1RCLK             36
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:85: warning: "ASPEED_CLK_MAC2RCLK" redefined
   85 | #define ASPEED_CLK_MAC2RCLK             68
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:43: note: this is the location of the previous definition
   43 | #define ASPEED_CLK_MAC2RCLK             37
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:91: warning: "ASPEED_RESET_ADC" redefined
   91 | #define ASPEED_RESET_ADC                55
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:47: note: this is the location of the previous definition
   47 | #define ASPEED_RESET_ADC                2
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:106: warning: "ASPEED_RESET_PWM" redefined
  106 | #define ASPEED_RESET_PWM                37
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:50: note: this is the location of the previous definition
   50 | #define ASPEED_RESET_PWM                5
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:107: warning: "ASPEED_RESET_PECI" redefined
  107 | #define ASPEED_RESET_PECI               36
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:51: note: this is the location of the previous definition
   51 | #define ASPEED_RESET_PECI               6
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:109: warning: "ASPEED_RESET_I2C" redefined
  109 | #define ASPEED_RESET_I2C                34
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:52: note: this is the location of the previous definition
   52 | #define ASPEED_RESET_I2C                7
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:119: warning: "ASPEED_RESET_JTAG_MASTER" redefined
  119 | #define ASPEED_RESET_JTAG_MASTER        22
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:48: note: this is the location of the previous definition
   48 | #define ASPEED_RESET_JTAG_MASTER        3
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:125: warning: "ASPEED_RESET_HACE" redefined
  125 | #define ASPEED_RESET_HACE               4
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:55: note: this is the location of the previous definition
   55 | #define ASPEED_RESET_HACE               10
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:126: warning: "ASPEED_RESET_AHB" redefined
  126 | #define ASPEED_RESET_AHB                1
      | 
/scripts/dtc/include-prefixes/dt-bindings/clock/aspeed-clock.h:53: note: this is the location of the previous definition
   53 | #define ASPEED_RESET_AHB                8
      | 

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240227004414.841391-1-andrew@codeconstruct.com.au

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


