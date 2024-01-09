Return-Path: <linux-kernel+bounces-20364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B92C827DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5C6285737
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773586103;
	Tue,  9 Jan 2024 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+sI214h"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409A5390;
	Tue,  9 Jan 2024 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704773278; x=1736309278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+YQIEcdRlkhUMeBkk5Nln3PeUMFfJKIkVceulsWxjSA=;
  b=k+sI214hDcy/K1b4yoZkYrFkDQ46kgfVJcRIF7cz/P+v6ln5zc5xoM/I
   7mcJF7LhDOsoSNnFy9gDi8BeYLCbdko4X7g65K0E2B4jVz/eK5tWyek8N
   QMge34a4JaRl6pIB8DfIKoAeCezrjs13Qar3S9sJHen/OkyJbiERCOkr1
   xE8Ye4ijuubsVg2mN0QlndZSONloVpRcczBJzGTX0p/b5Zjst7uymGIuX
   yd3M/lFXL7gnQgE2Y1t4NpFijDe5jRziXjxoucjM15lnPRHfG8OM8whd5
   hda81zQlUNY1IjyCKADTtrajQqN15gxSIZVq5aBnQT6JuKA4ym4fb+uEg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429263366"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="429263366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 20:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954868548"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="954868548"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2024 20:07:52 -0800
Date: Tue, 9 Jan 2024 12:04:56 +0800
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
Message-ID: <ZZzF6Fb8aRpde85Y@yilunxu-OptiPlex-7050>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
 <ZZuoTG2wdXQvLlAa@yilunxu-OptiPlex-7050>
 <485d0685-646c-44b8-823a-49870e109103@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485d0685-646c-44b8-823a-49870e109103@amd.com>

On Mon, Jan 08, 2024 at 09:12:21AM +0100, Michal Simek wrote:
> 
> 
> On 1/8/24 08:46, Xu Yilun wrote:
> > On Fri, Jan 05, 2024 at 05:04:31PM +0100, Michal Simek wrote:
> > > Convert Altera's bridges to yaml with using fpga-bridge.yaml.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > >   .../fpga/altera-fpga2sdram-bridge.txt         | 13 ----
> > >   .../fpga/altera-fpga2sdram-bridge.yaml        | 34 ++++++++++
> > >   .../bindings/fpga/altera-freeze-bridge.txt    | 20 ------
> > >   .../bindings/fpga/altera-freeze-bridge.yaml   | 41 ++++++++++++
> > >   .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 -----------
> > >   .../bindings/fpga/altera-hps2fpga-bridge.yaml | 63 +++++++++++++++++++
> > >   6 files changed, 138 insertions(+), 69 deletions(-)
> > >   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> > >   create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > >   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > >   create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
> > >   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> > >   create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> > > deleted file mode 100644
> > > index 5dd0ff0f7b4e..000000000000
> > > --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> > > +++ /dev/null
> > > @@ -1,13 +0,0 @@
> > > -Altera FPGA To SDRAM Bridge Driver
> > > -
> > > -Required properties:
> > > -- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
> > > -
> > > -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> > > -
> > > -Example:
> > > -	fpga_bridge3: fpga-bridge@ffc25080 {
> > > -		compatible = "altr,socfpga-fpga2sdram-bridge";
> > > -		reg = <0xffc25080 0x4>;
> > > -		bridge-enable = <0>;
> > > -	};
> > > diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > > new file mode 100644
> > > index 000000000000..a3f3fe2729f2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > > @@ -0,0 +1,34 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/fpga/altera-fpga2sdram-bridge.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Altera FPGA To SDRAM Bridge
> > > +
> > > +maintainers:
> > > +  - Xu Yilun <yilun.xu@intel.com>
> > > +
> > > +allOf:
> > > +  - $ref: fpga-bridge.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: altr,socfpga-fpga2sdram-bridge
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > 
> > Is the 'reg' required? I didn't see it in original txt.
> 
> you tell me. It was in example that's why I made it mandatory.

In original txt, 'reg' is not listed as required but in Example. I
searched the code but didn't see 'reg' useful. So lets delete it
from 'required:'

Thanks,
Yilun

