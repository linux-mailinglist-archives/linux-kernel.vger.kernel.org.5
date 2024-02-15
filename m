Return-Path: <linux-kernel+bounces-67398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EBF856AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C4D288695
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892013698B;
	Thu, 15 Feb 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zu2d0f7X"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8B136661;
	Thu, 15 Feb 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017821; cv=none; b=slUOm2KMpS1rDcOisyXnVwixlBLWKj8zTygXnWuF+oKRhfsRDwDo8cNEidWgwZ/GIGZK9q4y05AgVIEqtxWrEsaSZpSryVjNJmGQldZ0GredzMgy4YIKUo1bkLIEPC59dQrnb0lCkM/qJX8LkF/e2J3ofeEh5rC9D3ao/itGjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017821; c=relaxed/simple;
	bh=rRFd3YQp8MSUYdcnX7Jk6rBVAemU7SUryccg8S+OLiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDjtzEcvSZlBehtm7SYZsLBQQBwjIx+C9XWRKaegLa87dGX+xk5kuDfuSSFM1jQQ/Ua6NsQlq4MvCYde7m00vL/VjYBFH3ryHonItj696PkclP8UYkm9Kd9G8Wn63lSELGhsbAQgfuso6juOXLr6x9wva6IcgDNVZRpAM8WDNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zu2d0f7X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=La4s/vwj+gljO/UtWzPnryxXujz5t65E/dUslVMpOtI=; b=zu2d0f7Xkah1W7npzrqoHyfE1f
	Gm1FDdi/WZPmGzBjRcovWOqYam4m6HORn4gj62msKIooFLjF6oT/+JLOFNDVwWsWDy7RHV4y+a2Tw
	LpJ3KQ3fcm5HQ0aFrvdMLrm5NyccMYveiJkS9IfbcQXnSRcgkrKCqFfIOe0vu8op/I8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rafSZ-007uaA-KD; Thu, 15 Feb 2024 18:23:43 +0100
Date: Thu, 15 Feb 2024 18:23:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay
 from ICSSG nodes
Message-ID: <a0dc9fb7-2124-4f0d-a136-fc16a2301b0d@lunn.ch>
References: <20240215105407.2868266-1-danishanwar@ti.com>
 <71adaabd-bb24-4181-9fdf-f7191e93edb5@kernel.org>
 <4ef87f6c-caa8-45a8-8649-422806ec6eb2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef87f6c-caa8-45a8-8649-422806ec6eb2@ti.com>

On Thu, Feb 15, 2024 at 10:26:59PM +0530, Anwar, Md Danish wrote:
> 
> 
> On 2/15/2024 9:27 PM, Roger Quadros wrote:
> > 
> > 
> > On 15/02/2024 12:54, MD Danish Anwar wrote:
> >> Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
> >> property is no longer used by ICSSG driver.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
> >>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
> >>  2 files changed, 6 deletions(-)
> > 
> > What about the DT binding document?
> > 
> 
> Now I am only removing the property from device tree. Once this proprty
> is removed from all DTs, in the 6.9-rc-1 I will remove the binding as
> well so that net people can merge that without getting any errors /
> warnings.

Did the binding have the property as mandatory? If so you are probably
doing this the wrong way around. You should first modify the binding
to mark it as optional and deprecated. Then modify the .dts{i} files
to remove it.

   Andrew

