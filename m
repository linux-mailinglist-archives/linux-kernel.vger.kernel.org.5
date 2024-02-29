Return-Path: <linux-kernel+bounces-86791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27F86CADA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FFB217B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1677412E1E3;
	Thu, 29 Feb 2024 13:59:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F087E11C;
	Thu, 29 Feb 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215184; cv=none; b=XRlT8Sb5An3SnBGV1Cd4490rTKe3tXIBgmeVQbGqnwNUAgLKhu0nNqSz/h8JdQgcwFV21hiPFuxO3H6sX0KZvj/ZfFFICVcTMLPFyHVzhSc0Z8hj6HoakQSlUUhCshq4/rD+tVbHSgvZJwQKk9KeP/l2piXTkB81oo6nbWxPHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215184; c=relaxed/simple;
	bh=3n0JXgw9bpvzM7OgerM4GPLCp4fim2HgfxG1++56jIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsJfihy4AKsynVsX/NYyqD7fwTjyY63Zc7vJkHh/ZUmXLe4L4mOc1K0tKMl9D96evHIPzRcb7Y6HLIAJiQuPu2fdKjvTtnFOv0RNfucuX8SbnPXK04aqdk0TDhlMZ66JPcXx0s3CInr4pKUUv62pxn0nKfh1COlETe3L8Tk2oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F9D1FB;
	Thu, 29 Feb 2024 06:00:19 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69C9D3F6C4;
	Thu, 29 Feb 2024 05:59:39 -0800 (PST)
Date: Thu, 29 Feb 2024 13:59:36 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Message-ID: <ZeCNyLxQOIazc07h@bogus>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto>
 <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
> > protocol
> >
> > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
> > > >
> > > Hi,
> > >
> > > yes this is something I spotted in the past it was missing and I
> > > posted a similar patch but I was told that a protocol node without any
> > > specific additional properties is already being described by the
> > > general protocol node described above.
> 
> Without this patch, there is dtbs_check warning.
> 
> scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#
> 

Why are you adding protocol@12 to the device tree ? Does it have a
dedicated channel ? If not, you shouldn't need to add it.

-- 
Regards,
Sudeep

