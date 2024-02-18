Return-Path: <linux-kernel+bounces-70576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE785995F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A21C20BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4B7317B;
	Sun, 18 Feb 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boLrqGdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E68C1A;
	Sun, 18 Feb 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289864; cv=none; b=Mk872mxhgg0nVzx5M24qpNXfhHrkfeA0BD9Ho+fbzdssZl1Rd4kTmZtz2H4KJovPAWLbb6aqS1SxwCLl40pgfqhPfKkMGM41jpIghzKTZH4SJ36ZcYqvBZXaCM03HBC9gnQIYuk1nHUXCbsRdR7cZ8P19cIcg3ovK9L7nF5H/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289864; c=relaxed/simple;
	bh=XyVBAYojIXNfiY2h5khy0cciLOneIIfR/qnxl+XbJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4yxas7ZQRSeog6L2oX4gfrDQVZRj7/yucbBL56jYYKDZi6R9a+++OKGRv4C5dGJft/P08VHu4eEdpCaIHLwLvAKTs1uRuzM0zDkF3Ny7F+mHjgtotSCJTfhZ42SS+nUtucXRwSx3HG3ysaMfsSKqoySCVqO7+6idYPejWH0yOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boLrqGdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CE2C433C7;
	Sun, 18 Feb 2024 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708289863;
	bh=XyVBAYojIXNfiY2h5khy0cciLOneIIfR/qnxl+XbJoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boLrqGdBCCwHGrRftYmqxJcR0wK5yt4RCIfbW1668yL3eLRFO2vBkLCt9uYOuXf1Y
	 zaqU5kWIWkJOXwmrXXzn11QDtuoR2M4msb7nwyoTu23dpXbAiGs50L/XLtkHN99f+W
	 BXMxXO34FImMWejvGZnhvuFbMJoCWZnV26YkPalCzWs1rt/7r9a2jzsAF4FrAP7Ewl
	 zMsi1splTyPQWKCc3OiPFj7b+JNp5gBP8JXpiTTVMatIAW3gdKjj3fI9I1+jeuCso2
	 JTxfnHVGkMnI2lRXz8Nje3mRL04oVzCVQwndSeVDzKoh6y7DXjfHJobxGliJOtpWLy
	 tdyTSu6DKFVFA==
Date: Sun, 18 Feb 2024 14:57:41 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] dt-binding: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support
Message-ID: <20240218205741.GA1561527-robh@kernel.org>
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
 <20240216-clk-mv200-v1-4-a29ace29e636@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-clk-mv200-v1-4-a29ace29e636@outlook.com>

On Fri, Feb 16, 2024 at 07:37:54PM +0800, Yang Xiwen wrote:
> This SoC is similar to Hi3798CV200.
> 
> Also document the specific DLL regs and add an example for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../clock/hisilicon,clock-reset-generator.yaml     | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> index d37cd892473e..8ee844574eda 100644
> --- a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> @@ -44,12 +44,17 @@ properties:
>            - hisilicon,hi3519-crg
>            - hisilicon,hi3798cv200-crg
>            - hisilicon,hi3798cv200-sysctrl
> +          - hisilicon,hi3798mv200-crg
> +          - hisilicon,hi3798mv200-sysctrl
>        - const: syscon
>        - const: simple-mfd
>  
>    reg:
>      maxItems: 1
>  
> +  ranges:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
>  
> @@ -87,6 +92,12 @@ properties:
>      description: |
>        Reset controller for Hi3798CV200 GMAC module
>  
> +patternProperties:
> +  '.*-dll@[0-9a-f]+':
> +    type: object
> +    description: |
> +      eMMC/SD delay-locked-loop (DLL) register subnode
> +
>  required:
>    - compatible
>    - '#clock-cells'
> @@ -137,3 +148,28 @@ examples:
>              #clock-cells = <1>;
>          };
>      };
> +  - |
> +    crg: clock-reset-controller@8a22000 {
> +        compatible = "hisilicon,hi3798mv200-crg", "syscon", "simple-mfd";
> +        reg = <0x8a22000 0x1000>;
> +        ranges = <0x0 0x8a22000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        #clock-cells = <1>;
> +        #reset-cells = <2>;
> +
> +        emmc_sap_dll: sap-dll@39c {
> +            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";

No child nodes, not a simple-mfd.

> +            reg = <0x39c 0x8>;

I imagine you are linking to this node from the SD host controller node 
with some custom property. Instead of defining the register address 
here, link to the parent node (&crg) instead and make the offset the 2nd 
cell.

> +        };
> +
> +        sdio0_sap_dll: sap-dll@3a4 {
> +            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";
> +            reg = <0x3a4 0x8>;
> +        };
> +
> +        sdio1_sap_dll: sap-dll@3ac {
> +            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";
> +            reg = <0x3ac 0x8>;
> +        };
> +    };
> 
> -- 
> 2.43.0
> 

