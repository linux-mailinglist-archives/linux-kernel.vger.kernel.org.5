Return-Path: <linux-kernel+bounces-8534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB181B914
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1721C253CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8A768FE;
	Thu, 21 Dec 2023 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUtSiWXq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113306EB7D;
	Thu, 21 Dec 2023 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166614; x=1734702614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfxBOC7Ak9ofvXRWHBi0awUJZ/U0OS1qvUlw59nEa2Y=;
  b=iUtSiWXqX7kKPB0Y2FxI7UqMZjyb/4ughSZ1cEJ2yDffs5agP6dBrZmY
   HDyRXr2GvuAyR/cE3x48yCIFXlG8Ti0+n/7tAM0sIbdAREKNNRtVe603q
   R2O/W8adDPZC5gUFKXvjou9Y46/hqiPSYD3qZ2OD7qtNAOkamQfZ+HxGr
   J7joj1miX7PBwzJRmdrKURXVHLmxHAmkZPmVHfbmfbcqOChp6CAFpdsKe
   JevvAvLPEHJnGMwuRlk08KkcCHJP/EJ5psfy4meuzRjg5fjLtqtLpZfbU
   lMaVnT8WknOa0CeptJqPDtGflntY3ByRvi8Euc5hBBYMjaJsJi0p4AF6Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460311202"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="460311202"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108106685"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108106685"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:50:08 -0800
Date: Thu, 21 Dec 2023 21:47:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
	Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
	Rob Herring <robh+dt@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, devicetree@vger.kernel.org,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Fix versal-fpga node name
Message-ID: <ZYRB+Jkj0IMTphDo@yilunxu-OptiPlex-7050>
References: <6779af2f9cc21c912f10cf310388d99b980800b2.1702996281.git.michal.simek@amd.com>
 <7ac7db8e-f9b5-4394-af71-1a2b2548c485@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac7db8e-f9b5-4394-af71-1a2b2548c485@linaro.org>

On Wed, Dec 20, 2023 at 08:54:33AM +0100, Krzysztof Kozlowski wrote:
> On 19/12/2023 15:31, Michal Simek wrote:
> > Based on commit 83a368a3fc8a ("docs: dt-bindings: add DTS Coding Style
> > document") using underscore ('_') in node name is not recommended that's
> > why switch to dash ('-').
> > 
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> > 
> >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml        | 4 ++--
> >  Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml  | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> > index 8e584857ddd4..3d578f98ae2c 100644
> > --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> > @@ -41,7 +41,7 @@ properties:
> >    "#power-domain-cells":
> >      const: 1
> >  
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> Best regards,
> Krzysztof
> 
> 

