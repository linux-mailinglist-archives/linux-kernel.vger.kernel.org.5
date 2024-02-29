Return-Path: <linux-kernel+bounces-87423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1186D43B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AAD1F23249
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323A144021;
	Thu, 29 Feb 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OhCzDT6d"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CF1428E0;
	Thu, 29 Feb 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238576; cv=none; b=uB3Smj8D9aD5oaxwg77wbTEzugZ0ZJPA3yBt2plEFohG0BMi7qlyxIDhFYLM0ZSuxBb7irb5bzWAwTKc/dSg9ieuF+VodbM4Q4d1K1ozF3wNOtYvigesMzvQQJZAWuB1n0cZ0wNGRYkGn+w2UJv+Y3txlstCks+izfABdBMaNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238576; c=relaxed/simple;
	bh=L/s/b9tSVs9z239pdMRuvKxK6VQN+DzuuFGrb2AJ0Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmyT7Ll6Te7b6YU0msQpfHkEuZUfxbFgr5L0UwH1UI0IrMpDY52Je7vEjfGQ5W5CNVBxP430k/1e0U1NPX6YcMIqtU5mKldWK0sap+DXWCLQVL03AGwm7Ianhvsyp9DZhzn6ISYEC/1KWRvAeOATDttfsQs1EcgsTwQs/IDNsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OhCzDT6d; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF869FF802;
	Thu, 29 Feb 2024 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709238570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xsz9d2+yFSQZeecH2hOJtT+4TSF8kgLSBhGXKWhoDpQ=;
	b=OhCzDT6diyX9INg49zfgB6KwEWfdYjAzQMAaaMbxmHZ7yT1l6ewOG/X0HJ120MHMVo/Hw2
	ZfOIUYhTiqAVHadjdJMmkzkbxIP3hV0y5nyrK40vRfXJfV2lRtS/dIoK5oRs3TEFYQ+FrC
	pvDhHrPBDj6wx2nmTtjANKDIV1ovkCo5EWg+LU9ATvPEDVr6yDi19MIpYDmyBFTRIHJ2EF
	Wgg1Cd4id6LQdh51SlsqUDlRZIgIhUDb+nEtNMFj2XOI5FAw4iVyl4vBI8ZTpYVmr8F5ZO
	jFlEnUWaHt/p5RrZR8Mf47xH6KNbvdyJ3hb7TU0OFLOftZlrOlAXYAGlTMAKKg==
Date: Thu, 29 Feb 2024 21:29:28 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Conor Dooley <conor@kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v8 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <2024022920292837621a4f@mail.local>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-3-chris.packham@alliedtelesis.co.nz>
 <20240228-embark-rimmed-d81bab3d42b8@spud>
 <bd43a198-6287-40b2-be15-2734c5d2742d@alliedtelesis.co.nz>
 <20240229-skeletal-ultimatum-27cd91e8d8a8@spud>
 <b2ebc2a7-0347-40a0-8302-c84ba898fd16@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ebc2a7-0347-40a0-8302-c84ba898fd16@alliedtelesis.co.nz>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 29/02/2024 20:11:16+0000, Chris Packham wrote:
> 
> On 1/03/24 07:07, Conor Dooley wrote:
> > On Wed, Feb 28, 2024 at 08:21:35PM +0000, Chris Packham wrote:
> >> On 29/02/24 00:58, Conor Dooley wrote:
> >>> On Tue, Feb 27, 2024 at 02:03:10PM +1300, Chris Packham wrote:
> >>>
> >>>>      interrupts:
> >>>> +    description:
> >>>> +      Alarm1 interrupt line of the RTC. Some of the RTCs have two interrupt
> >>>> +      lines and alarm1 interrupt muxing depends on the clockin/clockout
> >>>> +      configuration.
> >>>>        maxItems: 1
> >>> The maxItems: 1 looks odd here when you state "some of the RTCs have two
> >>> interrupt lines", which makes it sound as if there are actually two
> >>> interrupts that should be exposed here. If those two interrupts get
> >>> muxed to the same pin for output I'd suggest that you clarify that here.
> >> This may end up changing if I can come up with something that Alexandre
> >> is happy with. Basically (some of) the chips have a configurable pin
> >> that can either be dedicated to the ALARM1 output (annoyingly labelled
> >> as INTB) or to a clock output. There is an INTA line that has other
> >> interrupts and if the clock output option is used then it also has
> >> ALARM1. The driver doesn't currently do anything with the other
> >> interrupt sources so as written this needs to correspond to whichever
> >> interrupt output is asserted for ALARM1.
> > So you're saying that depending on whether or not the clock output is
> > used, there could be two interrupts?
> Correct.
> > Without looking further, it sounds like you should be setting maxItems
> > to 1 if #clock-cells is present and to 2 if it is not.
> My idea was an explicit property about the function of the INTB/CLKOUT 
> pin. The current code does use #clock-cells as a proxy for this (and 
> Alexandre has some concerns with how this is handled).

#clock-cells must not be used for pinmuxing, I can't see how anyone
would allow this.

> >   Then if there are
> > two interrupts provided, the driver is free to configure whatever way it
> > wants. If there aren't, send everything to INTA.
> >
> > Am I missing something?
> 
> Right now the only interrupt that the RTC cares about is for ALARM1 
> (which moves between INTA and INTB depending on the clock config). There 
> are other hardware events and an ALARM2 that can generate an interrupt 
> but these are ignored. I don't think the rtc framework supports more 
> than one alarm.
> 
> Binding wise I think this should take 1 or 2 interrupts. For simplicity 
> the first interrupt should always correspond to ALARM1 (which could be 
> INTB or INTA depending on the hardware design). The 2nd interrupt (if 
> supplied) would be for the other events (which we don't currently do 
> anything with).

Not using an interrupt simply means the CPU doesn't care about it but
there are other components that may care for example a PMIC. If you
reason about what linux and the CPU it is running on can do, you will
cripple functionality and we will have to break the devicetree binding
later on to restore it.
We need to be able to express all the possible pin configurations with
the binding. I'm not sure why everyone is so resistant to use pinmuxing
to mux pins....


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

