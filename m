Return-Path: <linux-kernel+bounces-20351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF370827D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907E9B22427
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1AB53BE;
	Tue,  9 Jan 2024 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC78RgLA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FC5390;
	Tue,  9 Jan 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704772565; x=1736308565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+h4f9Zsp091Wb0KRNrIpykncxfV2hfUXF6oNuy3dNQ=;
  b=OC78RgLA8LJCRPwGVKmgwDWC45zXfcUfm52BX0FrwMZUXcpI3KcxHhwm
   QT3sdG9XDZyJTvExjzwLpHMzK9V5/u4NjnfAXoqqILFAusP/qZRTywnl5
   8XsmVhRq66SyMWTLz9vOfvdi6YKHODVgBuzgyRj/9zs5aznjzTZl03s8z
   bpzpaSZTr+RYJoUCc4//zZuFkmdNBASu5uHBZxPavZ3RqfxP8YDwC2hid
   GgaTCQv5ZVj6xZBgOTosmReMZBCzvynJ3g5h1oD7iQgnUoekO9jlpYYuM
   U5jlB+KBBmpLK8vzQEUtwxi/71Df5d/7MiSVu45BJ4nUAgsgQCyayy0QG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5421505"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5421505"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872101607"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="872101607"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2024 19:56:00 -0800
Date: Tue, 9 Jan 2024 11:53:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu,
	michal.simek@xilinx.com, git@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Message-ID: <ZZzDHxnMPTuraS4D@yilunxu-OptiPlex-7050>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
 <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>

On Mon, Jan 08, 2024 at 10:16:17AM +0100, Michal Simek wrote:
> 
> 
> On 1/8/24 10:09, Krzysztof Kozlowski wrote:
> > On 05/01/2024 17:04, Michal Simek wrote:
> > > Convert the generic fpga bridge DT binding to json-schema.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > 
> > > +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: FPGA Bridge
> > > +
> > > +maintainers:
> > > +  - Michal Simek <michal.simek@amd.com>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^fpga-bridge(@.*)?$"
> > 
> > Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
> > than one bridge on given system?
> 
> Yilun: Any comment on this?

We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
to identify them. So the expression is OK to me.

Thanks,
Yilun

> 
> > 
> > Anyway, looks fine:
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks,
> Michal
> 

