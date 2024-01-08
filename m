Return-Path: <linux-kernel+bounces-19155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCA8268E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F524B20DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686838F47;
	Mon,  8 Jan 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KITGLv8y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA08BF3;
	Mon,  8 Jan 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704700161; x=1736236161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3JUd2u6+WmcDLRkS6SGeD8yDlGeehHUpeG8fD2943NU=;
  b=KITGLv8yEpsIJKwrOUN9uzoHyomcAguat2ouHa+IA0iJFiM87hB3dfbd
   oDSUZa65N61GRRi0+l0esMGaJnEntwf+/rW2241H2htlDJ5vi78HQMFAZ
   8VMfEEKNtWgatc1MynZT81K2bSG7scqMTQe73lv3R0r6tMyhEgrqvjpet
   cKVx71LbjpHdtIVMSb/E+oBTssMIEI29785XE09h0o7SlMbcs/l4Y7fnr
   fWVhtUGwWs2YMtFQpjlHG9P0e3h+uYfMttuPL+8xamL4SDK5/OsGJ9cXp
   UG8ZTa3os9yOufz/S/oRCGvNR8RrMV3pOeJu5ywA/Vl4miZAlIX5/QcJP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4898552"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4898552"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="851709196"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="851709196"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jan 2024 23:49:16 -0800
Date: Mon, 8 Jan 2024 15:46:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: fpga: altera: Convert bridge bindings
 to yaml
Message-ID: <ZZuoTG2wdXQvLlAa@yilunxu-OptiPlex-7050>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>

On Fri, Jan 05, 2024 at 05:04:31PM +0100, Michal Simek wrote:
> Convert Altera's bridges to yaml with using fpga-bridge.yaml.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../fpga/altera-fpga2sdram-bridge.txt         | 13 ----
>  .../fpga/altera-fpga2sdram-bridge.yaml        | 34 ++++++++++
>  .../bindings/fpga/altera-freeze-bridge.txt    | 20 ------
>  .../bindings/fpga/altera-freeze-bridge.yaml   | 41 ++++++++++++
>  .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 -----------
>  .../bindings/fpga/altera-hps2fpga-bridge.yaml | 63 +++++++++++++++++++
>  6 files changed, 138 insertions(+), 69 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> deleted file mode 100644
> index 5dd0ff0f7b4e..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -Altera FPGA To SDRAM Bridge Driver
> -
> -Required properties:
> -- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -	fpga_bridge3: fpga-bridge@ffc25080 {
> -		compatible = "altr,socfpga-fpga2sdram-bridge";
> -		reg = <0xffc25080 0x4>;
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> new file mode 100644
> index 000000000000..a3f3fe2729f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-fpga2sdram-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera FPGA To SDRAM Bridge
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: altr,socfpga-fpga2sdram-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Is the 'reg' required? I didn't see it in original txt.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    fpga-bridge@ffc25080 {
> +        compatible = "altr,socfpga-fpga2sdram-bridge";
> +        reg = <0xffc25080 0x4>;
> +        bridge-enable = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> deleted file mode 100644
> index 8b26fbcff3c6..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Altera Freeze Bridge Controller Driver
> -
> -The Altera Freeze Bridge Controller manages one or more freeze bridges.
> -The controller can freeze/disable the bridges which prevents signal
> -changes from passing through the bridge.  The controller can also
> -unfreeze/enable the bridges which allows traffic to pass through the
> -bridge normally.
> -
> -Required properties:
> -- compatible		: Should contain "altr,freeze-bridge-controller"
> -- regs			: base address and size for freeze bridge module
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -	freeze-controller@100000450 {
> -		compatible = "altr,freeze-bridge-controller";
> -		regs = <0x1000 0x10>;
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
> new file mode 100644
> index 000000000000..4a89e3980669
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-freeze-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera Freeze Bridge Controller
> +
> +description: |
> +  The Altera Freeze Bridge Controller manages one or more freeze bridges.
> +  The controller can freeze/disable the bridges which prevents signal
> +  changes from passing through the bridge. The controller can also
> +  unfreeze/enable the bridges which allows traffic to pass through the bridge
> +  normally.
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: altr,freeze-bridge-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    fpga-bridge@100000450 {
> +        compatible = "altr,freeze-bridge-controller";
> +        reg = <0x1000 0x10>;
> +        bridge-enable = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> deleted file mode 100644
> index 68cce3945b10..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Altera FPGA/HPS Bridge Driver
> -
> -Required properties:
> -- regs		: base address and size for AXI bridge module
> -- compatible	: Should contain one of:
> -		  "altr,socfpga-lwhps2fpga-bridge",
> -		  "altr,socfpga-hps2fpga-bridge", or
> -		  "altr,socfpga-fpga2hps-bridge"
> -- resets	: Phandle and reset specifier for this bridge's reset
> -- clocks	: Clocks used by this module.
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -	fpga_bridge0: fpga-bridge@ff400000 {
> -		compatible = "altr,socfpga-lwhps2fpga-bridge";
> -		reg = <0xff400000 0x100000>;
> -		resets = <&rst LWHPS2FPGA_RESET>;
> -		clocks = <&l4_main_clk>;
> -		bridge-enable = <0>;
> -	};
> -
> -	fpga_bridge1: fpga-bridge@ff500000 {
> -		compatible = "altr,socfpga-hps2fpga-bridge";
> -		reg = <0xff500000 0x10000>;
> -		resets = <&rst HPS2FPGA_RESET>;
> -		clocks = <&l4_main_clk>;
> -		bridge-enable = <1>;
> -	};
> -
> -	fpga_bridge2: fpga-bridge@ff600000 {
> -		compatible = "altr,socfpga-fpga2hps-bridge";
> -		reg = <0xff600000 0x100000>;
> -		resets = <&rst FPGA2HPS_RESET>;
> -		clocks = <&l4_main_clk>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
> new file mode 100644
> index 000000000000..f8210449dfed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
> @@ -0,0 +1,63 @@

Is the License identifier also needed?


Otherwise, Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Thanks

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altera-hps2fpga-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera FPGA/HPS Bridge
> +
> +maintainers:
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - altr,socfpga-lwhps2fpga-bridge
> +      - altr,socfpga-hps2fpga-bridge
> +      - altr,socfpga-fpga2hps-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/altr,rst-mgr.h>
> +
> +    fpga-bridge@ff400000 {
> +      compatible = "altr,socfpga-lwhps2fpga-bridge";
> +      reg = <0xff400000 0x100000>;
> +      bridge-enable = <0>;
> +      clocks = <&l4_main_clk>;
> +      resets = <&rst LWHPS2FPGA_RESET>;
> +    };
> +
> +    fpga_bridge1: fpga-bridge@ff500000 {
> +      compatible = "altr,socfpga-hps2fpga-bridge";
> +      reg = <0xff500000 0x10000>;
> +      bridge-enable = <1>;
> +      clocks = <&l4_main_clk>;
> +      resets = <&rst HPS2FPGA_RESET>;
> +    };
> +
> +    fpga_bridge2: fpga-bridge@ff600000 {
> +      compatible = "altr,socfpga-fpga2hps-bridge";
> +      reg = <0xff600000 0x100000>;
> +      clocks = <&l4_main_clk>;
> +      resets = <&rst FPGA2HPS_RESET>;
> +    };
> -- 
> 2.36.1
> 
> 

