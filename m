Return-Path: <linux-kernel+bounces-78570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D6486152E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5912867F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591A81AC6;
	Fri, 23 Feb 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ksxjEXF8"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913629AF;
	Fri, 23 Feb 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700837; cv=none; b=CsTCrdKUAHV+S330NpAbHRJRZaxO9+FAlTAu8NWa3nvqx/7lCBFpyAjEJFIb6KLpi6CsnIQbVXDEnVJPitYbvoON6JOlELRxHv4Iy2KQkDvom8fzegTu7WIwc8kpiTtC+LihkpnyDXTpeNyKKHBxi9BPnPT9BFtzOvETsWjcQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700837; c=relaxed/simple;
	bh=qwYvqnbUBgRmfcU5PY/qmaPSAuFYYxZn2Jkfy1nGQPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if0JdlbHamRgyI8oPID4AZGMbmX8dDsrdNvNyY1dzaWOUwkyhZdpNPZm8WUDFwKXex9YSJ2LIhXup8cxmxk5gnFYz/KLvm0c7sS2Q2J2iw5XN6JYVQZ4j7EJVMYLF7pHMEmtM3YPxSDifOuxZUvDWfafr0qRe7DLWLKM4vn2nGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ksxjEXF8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4107C1C0015;
	Fri, 23 Feb 2024 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708700826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FVN6qzrARPqd8slGB+ZGG+q4yGV1yFcxd8XyD/FaGY=;
	b=ksxjEXF8MtHctHNicBMz13UjkukmPWXphf8gXxKB6y5Uem1PJZrkDjzSlCUQQB5ENfq2bR
	s4QDePcCTPRohSRp2I7FIgq6sVvQl8Rqm5mcl3an9DBYOPzLrJ829BWPzlPr47WLu5F2SK
	kRkMa6hgUeMukEbhoUZzKvBiMhoagAAhl3Yumh5Nfx2gss/hD25R5pvP0GV9ibL5UiI2mD
	ENkfmO6ab3BWQPIoaJul7mbZg6tBM7D9UzVe50WZtWjI1jhIQSa4NFblhXR8YsLmG6+zZW
	thfqY4GS1gCWtZLP7CLf7AQl3g+aOQx30JSVfo2N5cQjDhUytE3YY5jEYO9fNA==
Date: Fri, 23 Feb 2024 16:07:04 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Bastien
 Curutchet <bastien.curutchet@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <20240223160704.4018cac2@device-28.home>
In-Reply-To: <a1e54836-51d2-4990-9444-56d9414eb28c@lunn.ch>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
	<20240130085935.33722-2-bastien.curutchet@bootlin.com>
	<20240130-impulsive-widow-9142a069b7fd@spud>
	<20240131210521.GA2289883-robh@kernel.org>
	<20240131-tummy-imperfect-e6d6f0e245e9@spud>
	<a1e54836-51d2-4990-9444-56d9414eb28c@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew, Bastien,

On Wed, 31 Jan 2024 23:40:45 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Jan 31, 2024 at 09:18:39PM +0000, Conor Dooley wrote:
> > On Wed, Jan 31, 2024 at 03:05:21PM -0600, Rob Herring wrote:  
> > > On Tue, Jan 30, 2024 at 05:56:37PM +0000, Conor Dooley wrote:  
> > > > On Tue, Jan 30, 2024 at 09:59:34AM +0100, Bastien Curutchet wrote:  
> >   
> > > > > +  ti,fiber-mode:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [0, 1]
> > > > > +    description: |
> > > > > +      If present, enables or disables the FX Fiber Mode.
> > > > > +      Fiber mode support can also be strapped. If the strap pin is not set
> > > > > +      correctly or not set at all then this can be used to configure it.
> > > > > +       - 0     = FX Fiber Mode disabled
> > > > > +       - 1     = FX Fiber Mode enabled
> > > > > +       - unset = Configured by straps  
> > > > 
> > > > I don't like these properties that map meanings onto numbers. We can
> > > > have enums of strings in bindings that allow you to use something more
> > > > meaningful than "0" or "1".  
> > > 
> > > Tristate properties are fairly common pattern where we need 
> > > on/off/default. I've thought about making it a type. I don't think we 
> > > need defines for it.  
> > 
> > I think a type would be a good idea. I am not at all a fan of any of the
> > properties people introduce along these lines.  
> 
> Before going too far with that, i'm not actually sure it is required
> here. I've not looked at the PHY driver itself, but i expect there is
> some indication somewhere that the network stack expects a fibre link
> is to be used. We probably can determine at runtime if fibre should be
> used.

I've missed that thread initially. I guess that if Fiber is to be used,
this would be done through sfp, then we have all the regular interfaces
to configure the phy_interface_mode, in that case that would be
100BaseX.

So, a sane behaviour could simply be to configure the PHY in copper
mode by default, without relying on any DT property ? If anyone wants to
use fiber mode, then they would have to implement the
sfp_upstreamp_ops, which would take care of reconfiguring the MDI
interface of the PHY in the correct mode.

Maxime

