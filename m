Return-Path: <linux-kernel+bounces-46590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA88441BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98F31F22A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6E8287A;
	Wed, 31 Jan 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsV+tq69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6017F48F;
	Wed, 31 Jan 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711001; cv=none; b=IRa6EEBr+Le0U4wtTHfyW/8UwwS7fwMaYiLUl6YQyl8pCUIyh19d5+T60IYlrXjQaROyQm+e+eoy2YX8bqGBacSnhYW8SGei8Uvp49lszgr/LoljSCY6aIVWoqdkHu60qAP03FCq8zjMNXymxh+t9M09laOWOQpwsDWAcervR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711001; c=relaxed/simple;
	bh=r8Og+/DD3KNkZEqwH8xuXR2iH05bswrjdZXhOtKd4Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL5ytHjmdA0Fv/fMc1v7th6xaI37Ym8HTTV9LXUkcGDjC3cfWB0lAKnmB3R2/mnrLUuC7ma1BrMVlhicQeWOjkeOuZ4QlEUs/g6IVuJ0jDIqhWd2yNEtvoxOsIahQ5gyGzaCSqii0tS1McNgZ1FnVR/p3+aBL0iv+Ldc2el+/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsV+tq69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46730C433C7;
	Wed, 31 Jan 2024 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711000;
	bh=r8Og+/DD3KNkZEqwH8xuXR2iH05bswrjdZXhOtKd4Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsV+tq69DUehuRNgv5A4JPVD5aK3gK62Cy48n6gfWqHd6EiAhN7pmjv+b2wow2hxb
	 nZoYTTbe+cbBhz6NmKtSUqOwEqI897AJBSsoTAc5hssNSpCZZSbs8CSyrH7h+VyNz8
	 TkHum2dmjY8Ln1ozPjk6nhqgYvHg2u7R+2tzCs7+LUmxjr3AaahOXogASNkK5gv1IF
	 Kf0/CMO8m03BRdcl+d9IX7pU5CpdPzVlaVEiOdfnq2NtcEnh9ZbQ7t0HCAOEw3BxZZ
	 2BuRQ/5if5zFT+ECx6jbvX+d1SMR7N7gIw521oprGvzDgw4DM9LRrIN2sqBx5ApNM9
	 GdFu29aTu0fyA==
Date: Wed, 31 Jan 2024 08:23:18 -0600
From: Rob Herring <robh@kernel.org>
To: Dragan Cvetic <dragan.cvetic@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Simek <michal.simek@amd.com>,
	"Erim, Salih" <salih.erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Message-ID: <20240131142318.GA1091307-robh@kernel.org>
References: <20240130161259.4118510-1-dragan.cvetic@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130161259.4118510-1-dragan.cvetic@amd.com>

On Tue, Jan 30, 2024 at 04:12:58PM +0000, Dragan Cvetic wrote:
> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> dt-entries as well as any future additions to yaml.
> Change in clocks is due to IP is itself configurable and
> only the first two clocks are in all combinations. The last
> 6 clocks can be present in some of them. It means order is
> not really fixed and any combination is possible.
> Interrupt may or may not be present.
> The documentation for sd-fec bindings is now YAML, so update the
> MAINTAINERS file.
> Update the link to the new yaml file in xilinx_sdfec.rst.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
> ---
> Changes in v2:
> ---
> Drop clocks description.
> Use "contains:" with enum for optional clock-names and update
> comment explaining diference from the original DT binding file.
> Remove trailing full stops.
> Add more details in sdfec-code description.
> Set sdfec-code to "string" not "string-array"
> ---
> Changes in v3:
> Fix a mistake in example, set interrupt type to 0.
> ---
> Changes in v4:
> Set interrupt type to high level sensitive.
> Remove '|' from descriptions, no need to preserve format.
> Remove not needed empty line.
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 137 ++++++++++++++++++
>  Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
>  MAINTAINERS                                   |   2 +-
>  4 files changed, 139 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> deleted file mode 100644
> index e3289634fa30..000000000000
> --- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Xilinx SDFEC(16nm) IP *
> -
> -The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> -which provides high-throughput LDPC and Turbo Code implementations.
> -The LDPC decode & encode functionality is capable of covering a range of
> -customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> -principally covers codes used by LTE. The FEC Engine offers significant
> -power and area savings versus implementations done in the FPGA fabric.
> -
> -
> -Required properties:
> -- compatible: Must be "xlnx,sd-fec-1.1"
> -- clock-names : List of input clock names from the following:
> -    - "core_clk", Main processing clock for processing core (required)
> -    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
> -    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
> -    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
> -    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
> -    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
> -    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
> -    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
> -- clocks : Clock phandles (see clock_bindings.txt for details).
> -- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
> -  location and length.
> -- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
> -  being used.
> -- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
> -  driven with a fixed value and is not present on the device, a value of 1
> -  configures the DIN_WORDS to be block based, while a value of 2 configures the
> -  DIN_WORDS input to be supplied for each AXI transaction.
> -- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
> -  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> -  of "4x128b".
> -- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interface is
> -  driven with a fixed value and is not present on the device, a value of 1
> -  configures the DOUT_WORDS to be block based, while a value of 2 configures the
> -  DOUT_WORDS input to be supplied for each AXI transaction.
> -- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of 1
> -  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> -  of "4x128b".
> -Optional properties:
> -- interrupts: should contain SDFEC interrupt number
> -
> -Example
> ----------------------------------------
> -	sd_fec_0: sd-fec@a0040000 {
> -		compatible = "xlnx,sd-fec-1.1";
> -		clock-names = "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_status_aclk","m_axis_dout_aclk";
> -		clocks = <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>, <&misc_clk_1>;
> -		reg = <0x0 0xa0040000 0x0 0x40000>;
> -		interrupt-parent = <&axi_intc>;
> -		interrupts = <1 0>;
> -		xlnx,sdfec-code = "ldpc";
> -		xlnx,sdfec-din-words = <0>;
> -		xlnx,sdfec-din-width = <2>;
> -		xlnx,sdfec-dout-words = <0>;
> -		xlnx,sdfec-dout-width = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> new file mode 100644
> index 000000000000..7be8439861a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SDFEC(16nm) IP
> +
> +maintainers:
> +  - Cvetic, Dragan <dragan.cvetic@amd.com>
> +  - Erim, Salih <salih.erim@amd.com>
> +
> +description:
> +  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> +  which provides high-throughput LDPC and Turbo Code implementations.
> +  The LDPC decode & encode functionality is capable of covering a range of
> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +  principally covers codes used by LTE. The FEC Engine offers significant
> +  power and area savings versus implementations done in the FPGA fabric.
> +
> +properties:
> +  compatible:
> +    const: xlnx,sd-fec-1.1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 8
> +    additionalItems: true
> +    items:
> +      - description: Main processing clock for processing core
> +      - description: AXI4-Lite memory-mapped slave interface clock
> +      - description: Control input AXI4-Stream Slave interface clock
> +      - description: DIN AXI4-Stream Slave interface clock
> +      - description: Status output AXI4-Stream Master interface clock
> +      - description: DOUT AXI4-Stream Master interface clock
> +      - description: DIN_WORDS AXI4-Stream Slave interface clock
> +      - description: DOUT_WORDS AXI4-Stream Master interface clock
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 8
> +    additionalItems: true
> +    items:
> +      - const: core_clk
> +      - const: s_axi_aclk
> +    contains:
> +      enum:
> +        - s_axis_ctrl_aclk
> +        - s_axis_din_aclk
> +        - m_axis_status_aclk
> +        - m_axis_dout_aclk
> +        - s_axis_din_words_aclk
> +        - m_axis_dout_words_aclk

This doesn't do what you think. It requires at least one of these clocks 
be present, so then at least 3 clocks. It also allows anything else to 
be present. You need:

allOf:
  - minItems: 2
    maxItems: 8
    additionalItems: true
    items:
      - const: core_clk
      - const: s_axi_aclk
  - items:
      enum:
        - core_clk
        - s_axi_aclk
        - s_axis_ctrl_aclk
        - s_axis_din_aclk
        - m_axis_status_aclk   
        - m_axis_dout_aclk
        - s_axis_din_words_aclk
        - m_axis_dout_words_aclk


