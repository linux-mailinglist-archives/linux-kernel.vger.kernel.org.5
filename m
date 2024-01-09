Return-Path: <linux-kernel+bounces-20713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F48283EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA101F21FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955E360B9;
	Tue,  9 Jan 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhZ+LEgq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9C36084;
	Tue,  9 Jan 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704795916; x=1736331916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qybVg1yF1U6mARID1UkppiGKiT8bQ1f8SyBzaQJjJGQ=;
  b=dhZ+LEgqwvh/4f41E1YdCJQYzL+Wc3d2NQuvmfErICY+ck4kyIbIuvQr
   5T9nu7H3lmC1yP7h/VuhTrBiG90A9xDSM3HjKQOT7DwZ8+vjMbEaEGdGy
   ZawRH8mOPdHr61VhbwkavAxkG7UHl6N1lgEssw+i79rROTkqxkQVtcX2d
   w3F2kbn3Za+TQaXCuwx9jua4t04NiXci95l0+9hU7PplJjheZiOzhq01i
   a3lANB7I7m9fzsp1rL6RZVSxhP1UIW/H4vAzrkAaqoUPBON8sW6HfhTIZ
   7bWeoLB1EgpVnnuFPT4aTIFHSGvGxNAgY5k4jVbrs7O/y4UE6oBVs56yq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5238297"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="5238297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 02:25:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="30134895"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 09 Jan 2024 02:25:11 -0800
Date: Tue, 9 Jan 2024 18:22:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Message-ID: <ZZ0eVZGcYJ0sFxh2@yilunxu-OptiPlex-7050>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
 <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>
 <ZZzDHxnMPTuraS4D@yilunxu-OptiPlex-7050>
 <bd356c60-7681-47e4-b45f-d25e70068b65@linaro.org>
 <3bfaab38-6831-41f8-8a7b-9f1f434e0f9c@amd.com>
 <e88205a2-f8b6-42c7-82cc-bfc08a680f3d@linaro.org>
 <f3aeff02-2560-46e7-a712-1f8d323f43a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3aeff02-2560-46e7-a712-1f8d323f43a4@linaro.org>

On Tue, Jan 09, 2024 at 09:16:33AM +0100, Krzysztof Kozlowski wrote:
> On 09/01/2024 09:15, Krzysztof Kozlowski wrote:
> >>>>>>> +properties:
> >>>>>>> +  $nodename:
> >>>>>>> +    pattern: "^fpga-bridge(@.*)?$"
> >>>>>>
> >>>>>> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
> >>>>>> than one bridge on given system?
> >>>>>
> >>>>> Yilun: Any comment on this?
> >>>>
> >>>> We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
> >>>> to identify them. So the expression is OK to me.
> >>>
> >>> So you claim unit address thus reg with some sort of bus address is a
> >>> requirement? Then "?" is not correct in that pattern.
> >>
> >> I expect it is about that people are using fpga-bridge@0 but bridge is not on 
> >> the bus. Yilun said that reg property in altr,socfpga-fpga2sdram-bridge.yaml is 
> >> optional which means no reg property no @XXX in node name.
> >> That's why I think that expression is correct. If there are more bridges without 
> >> reg property then I expect we need to get more examples to align expression.
> > 
> > If we allow node name without unit address, thus not being part of any

This is valid usecase.

> > bus, then the only question is whether it is possible to have system
> > with more than two FPGA bridges. If the answer is "yes", which I think

The answer is yes.

> > is the case, then the pattern should already allow it:
> > 
> > (@[0-9a-f]+|-[0-9]+)?
> 
> Or better go with what I used recently for narrowed choices:
> 
> (@.*|-([0-9]|[1-9][0-9]+))?

It is good to me.

I actually didn't know much about DTS & its Schema, thanks for all your
input.

> 
> Best regards,
> Krzysztof
> 
> 

