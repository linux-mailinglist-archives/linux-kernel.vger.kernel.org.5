Return-Path: <linux-kernel+bounces-71953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D022F85AD00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE11C219C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806B5339E;
	Mon, 19 Feb 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZJJBiWbb"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C09524C0;
	Mon, 19 Feb 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373968; cv=none; b=CyM55jKjV2lXGT+7+GokUtGaJaEi5d37dhIpVN+KJey9rSC+6DNs3nA1QaFAeutMSICkfN/TCIXE2BhbG+4Y2Ub1l2Rtj+hP0xiHW20WCIVbCRDz/txGISFhvjmzW1VrFKEbS/QptRludGnLLdTWa61nj8fUhkPwCAXI+MhyH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373968; c=relaxed/simple;
	bh=EwTBXOokFY4P9ANdyfQvACUoGgEpku28/zv8Debf6KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERRnDhHYB+4R1fXE9uNMbj/UmuOznIHYbRcwocpzAC9t5M8/FX4lZs2G6exC/cPsD06FxP7ZIG2k0gEzaYKK0aQsjdt3zsebJ+YeDGDfyisIwFOelLKWtKI8ekjzjZaTLx4k5cJ/lYb6jRHe5mUAsRimiSNQCUNG/IPOWiqUXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZJJBiWbb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FC0F240003;
	Mon, 19 Feb 2024 20:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708373957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eFa1OZ6RfBH4efn1I84fs1ja49iC4gp/bJRJKYHyLY=;
	b=ZJJBiWbbQlaBB2D6VpMjxy7mi1VJFKuuQHHbAVy2+IbVDdQ6zzJNgzwpTrdZy3I7Z5Xl81
	lmZ/fVm4w9xg7xsGvRp47527tcWFUhfrz6mGGNeQ2uzs4msTJbniB8ZKQq2pYnxwH/SsdX
	YRVfyuatTfzV0WAY6i2dJyzxDEdEuCm41W+B9LzOpSscxlaSNYOphuOgHlO1O+bcljUUxz
	Qem3xafhQyRKvcG+A57yYeIjrYlz8WMWqMjfJY7Oa3blsQV6klPHBz1RRKl0XokY2ILVQh
	FD3Sc4jN8ItbrLxZXE5SKqG+N5MFkgsNQwDZ7xEAfIttA/j6f33s5t1RtpgUMA==
Date: Mon, 19 Feb 2024 21:19:16 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu,
	michal.simek@xilinx.com, git@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Message-ID: <202402192019160b9c4120@mail.local>
References: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
 <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
 <ed59671f-6e0b-45a2-bae7-38f7b4b7e625@amd.com>
 <ebcfd49d-f810-4d9b-8cba-b55071fc7fa6@linaro.org>
 <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 19/02/2024 14:11:50+0100, Michal Simek wrote:
> 
> 
> On 2/17/24 09:26, Krzysztof Kozlowski wrote:
> > On 16/02/2024 10:42, Michal Simek wrote:
> > > 
> > > 
> > > On 2/16/24 10:19, Krzysztof Kozlowski wrote:
> > > > On 16/02/2024 09:51, Michal Simek wrote:
> > > > > RTC has its own power domain on Xilinx Versal SOC that's why describe it as
> > > > > optional property.
> > > > > 
> > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > ---
> > > > > 
> > > > >    Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > 
> > > > But Versal is not described in this binding, is it? I see only one
> > > > compatible.
> > > 
> > > It is the same IP only as is on zynqmp with own power rail.
> > 
> > Then you should have separate compatible, because they are not
> > identical. It would also allow you to narrow the domains to versal and
> > also require it (on versal).
> 
> I can double check with HW guys but I am quite sure IP itself is exactly the
> same. What it is different is that there is own power domain to it (not
> shared one as is in zynqmp case).
> 
> Also Linux is non secure sw and if secure firmware won't allow to change
> setting of it it can't be required. I am just saying that Linux doesn't need
> to be owner of any power domain that's why it shouldn't be required
> property.

I guess because the integration is different, you still need a
differente compatible so you can forbid the property on non-Versal.

> 
> Thanks,
> Michal

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

