Return-Path: <linux-kernel+bounces-19156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1528268E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90F5B20F43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3273C8F55;
	Mon,  8 Jan 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcFCNq0G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0E8BF9;
	Mon,  8 Jan 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704700227; x=1736236227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gx/BXclvQkv/na5zLAkpV7uWoaXir7Ur5I5u9CS57A=;
  b=YcFCNq0GjxPEXo8xii2c5MQxGfJDZ38/YXUCrlpoKyka7Qu0JbTCpGWj
   sN5wg/7gq1LsLTFfri1ggieUR/lkhs9zdpof84bxjKPqnK3rYH7GWAQka
   Xb4MQ9vYTJCuq++TkkSKraLIhtzE2BYZtTncfeTvwjmZ238l+Qllq/Nge
   dVD5LzmaYf5ixaUkfNlyO+oeo2/yPfvzmVfXDINfva6Lrp1C+NeF/MjMs
   2LdbydQbyxoREGxhA9LEvR+1H/xOLD13dp3Zf5gmW5UB3WLacBXhRG0UJ
   2pQMQv8WK29pZw50OlAx4HApt6PkVnzkpUwwKvWTD/CZ+GmArYfbuIxEc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4898736"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4898736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:50:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="851709859"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="851709859"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jan 2024 23:50:22 -0800
Date: Mon, 8 Jan 2024 15:47:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Message-ID: <ZZuojgPfXZ5Bq6Kl@yilunxu-OptiPlex-7050>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>

On Fri, Jan 05, 2024 at 05:04:30PM +0100, Michal Simek wrote:
> Convert the generic fpga bridge DT binding to json-schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Thanks

> ---
> 
>  .../devicetree/bindings/fpga/fpga-bridge.txt  | 13 --------
>  .../devicetree/bindings/fpga/fpga-bridge.yaml | 30 +++++++++++++++++++
>  .../bindings/fpga/xlnx,pr-decoupler.yaml      |  5 +++-
>  3 files changed, 34 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> deleted file mode 100644
> index 72e06917288a..000000000000
> --- a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -FPGA Bridge Device Tree Binding
> -
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> -
> -Example:
> -	fpga_bridge3: fpga-bridge@ffc25080 {
> -		compatible = "altr,socfpga-fpga2sdram-bridge";
> -		reg = <0xffc25080 0x4>;
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
> new file mode 100644
> index 000000000000..248639c6b560
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FPGA Bridge
> +
> +maintainers:
> +  - Michal Simek <michal.simek@amd.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^fpga-bridge(@.*)?$"
> +
> +  bridge-enable:
> +    description: |
> +      0 if driver should disable bridge at startup
> +      1 if driver should enable bridge at startup
> +      Default is to leave bridge in current state.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    fpga-bridge {
> +        bridge-enable = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> index a7d4b8e59e19..5bf731f9d99a 100644
> --- a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> @@ -9,6 +9,9 @@ title: Xilinx LogiCORE Partial Reconfig Decoupler/AXI shutdown manager Softcore
>  maintainers:
>    - Nava kishore Manne <nava.kishore.manne@amd.com>
>  
> +allOf:
> +  - $ref: fpga-bridge.yaml#
> +
>  description: |
>    The Xilinx LogiCORE Partial Reconfig(PR) Decoupler manages one or more
>    decouplers/fpga bridges. The controller can decouple/disable the bridges
> @@ -51,7 +54,7 @@ required:
>    - clocks
>    - clock-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.36.1
> 
> 

