Return-Path: <linux-kernel+bounces-161981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB28B5426
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AE5B2207A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A422EF8;
	Mon, 29 Apr 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="RtJypCal"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB9225D9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382533; cv=none; b=jvSlJrm/8zZyqSzJcH0fUMRKSKK8bZJeSTdsb9bLRvCr9TPrAE2NowOQgfHLOdWPxTGsBTwdLeJorIfzZPJCzSvqhr+v/xHJsIlNLM+T3RQJqV2ytu8lmTYYLP+S7eBFoFQYQr+oCJilrSRy92mfiB5UuBAslSVVpulLKrqt4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382533; c=relaxed/simple;
	bh=v+9IardeQVHSNjpM0cCMrsumgfLobKVvrfyCwoM4r5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5c99LB8qD1BJM8axcpwK2iWRYAZ8TkgN4gbMD60KG5CbMvgjy11Vr1jydqiLjSYEk1oBYBgc6fvIZKpJTyZZRuCSDo4uGf0IpWn74NrAlK71/0MJDjzrDsfcJ6DIvo0rB100jLXqERCEU1r5/o1ydVAvQ7bduGv5ox40Pv451E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=RtJypCal; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.8.107])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1ND4sV3Dq8U421ND5sO3Gl; Mon, 29 Apr 2024 11:22:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714382527; bh=v+9IardeQVHSNjpM0cCMrsumgfLobKVvrfyCwoM4r5A=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=RtJypCal2HgNizvWD+OI4RGT1RAfQK4PMNc7BVnf2+MkPqf5xMeEVHTQXlvfUR5bm
	 rhe3HiZEYyE/THa/lggvICFtb7+ZbN3wAEmpyE9+e4d4xRmKE/Fvc69kSYo5dqPQ8A
	 8u2SS9hCoNMdlPkWlZkUnvFekPFQQ5JpNbOrXoOdCaSN4p4aAud2JAkIPKm7HHwu9z
	 iad4i0PLXUNGFQgfKooOhbf4RUgLH0jEN0jIN4gSbSmmuqerdva+izh5Xqd4YgTEtQ
	 /nloKzXl4qFiRs83bBR8pF3MxRFplTgVxNEVja4xV9TAWFOOE/dKihI4PLWIueBGKS
	 GE+951pfJSpKA==
Date: Mon, 29 Apr 2024 11:22:06 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93
 EDIMM 2.0 Starter Kit
Message-ID: <Zi9mvnx90mxnhv8j@engicam>
References: <20240429084422.8369-1-fabio.aiuto@engicam.com>
 <20240429084422.8369-2-fabio.aiuto@engicam.com>
 <07fa8910-da6e-49f3-a3d3-b7a55c48224a@kernel.org>
 <Zi9iAZjrq13X4K/C@engicam>
 <5858b5de-4083-4c46-b23c-14f5bec113f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5858b5de-4083-4c46-b23c-14f5bec113f0@kernel.org>
X-CMAE-Envelope: MS4xfEclqJNNWSx5Jl/gUw/lTjW5w2a5uNsh6ud23jxkPlVxDs5py/slyZcCBI+c9jxHVeScb29MJTtBYE4cUp8whME/QmgWnp/naj9Mdk/icw855VuWwciB
 7uWoQ7oXfsysyYbTKzNAGMEtPmOl7Sat4+HACGYPvgr2js6G7G/PLxDbdZ8gauI1AEvnuwA/NYGvoIf80ldAnLv5pyQ4/QtrNntv8R27iMTXioTNHrffew8k
 q+s2Mb/5um7W8arZTR4iANbj0Jfxd0iCcMMsujCppcRaDriW/kW2uSR3z9D+Z01Xr7Wmt1uP0h4xcBATIx4QAXWFveFm8IbX6YLkS89HfoqSMych54+iVgSL
 wEMJDUJEi49+Ybp3zvPD0nSaQns7GT+IfBanb+AkLEuti/Qy4IVW46/OHvBMGsqA+H8n7GQNWsDK5NW6e/vKgTw0JyjFd0TzjSAp0OJ/3Yn8Cp+Cx234XnkX
 +BI5vR+riCvat7Mwf/GfhR+Wn/G0iYDPqTdBJKWa04kFHFezaNFmfsm9ddpBEXulMEOgeqlFHvTxYq9u3YhgfeU7LCJUqjSZcMRpsLzEcwY+H/UDPEBhfosl
 iaL/ynxT70moFwYXPPrSUh2tX6DSM54Uti9V1AQSqHKHmg==

Dear Krzysztof,

Il Mon, Apr 29, 2024 at 11:04:03AM +0200, Krzysztof Kozlowski ha scritto:
> On 29/04/2024 11:01, Fabio Aiuto wrote:
> > Dear Krzysztof,
> > 
> > Il Mon, Apr 29, 2024 at 10:53:08AM +0200, Krzysztof Kozlowski ha scritto:
> >> On 29/04/2024 10:44, Fabio Aiuto wrote:
> >>> i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
> >>>
> >>> EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
> >>> Evaluation Board by Engicam.
> >>>
> >>> i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
> >>> to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.
> >>>
> >>> Add bindings for this board.
> >>>
> >>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >>> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> >>> Reviewed-by: Krzysztof Kozlowsky <krzk@kernel.org>
> >>
> >> What the hell? Why are you changing tags?
> > 
> > I fear I don't understand your comment. Did you gave me
> > your Reviewed-by: tag, didn't you?
> > 
> > When Conor gave me his Acked-by in v2 told me to pick up
> > yours too...
> 
> I *DID NOT* give such tag. Why do you manually type people names? You
> are ought to COPY the entire tag. Not amend it, not change it, not try
> to write by yourself.

I apologize for that, will send a v8

kr,

fabio

> 
> Best regards,
> Krzysztof
> 

