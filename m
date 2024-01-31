Return-Path: <linux-kernel+bounces-46102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77423843A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C269293DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539469941;
	Wed, 31 Jan 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yd0FUfzL"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1F679E2;
	Wed, 31 Jan 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692021; cv=none; b=O9dnGu917fc8B1FrRMakbT03g6bgE3LVWnq5RL74jpmIYogX49vHkAHJTRL/M5tgUqV0XFmtEEr59Eb3Jenfk1PmXYek9t1tJ7VRfS/S+2JY386FS0bfZz2bIz7Yc3+59BCTk7YltUMAVPX2DYBLqZeCij8tP8UrbFwXjAg3zQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692021; c=relaxed/simple;
	bh=RWLHpSv1FQJdPrzkOEajwCMgnQC47rNEwuP9ENggOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro1eaqy7I6gNl+TSGETHzpTHrXuAJaOVd/vnU7P1DGWpUKv5p3vUOc4ZNRXQZK6Q387w/nCs75lJeAkjJ8yPPoe5BEq4DRx7iDY7BwD2+r3zMq+/5BGjYl1M9GFF8l5K66XVAoiX8pLz51v16T3gI8tBZpwifSJM5WjETKrSAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yd0FUfzL; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 937664000C;
	Wed, 31 Jan 2024 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706692015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCQ7iioHvXhcFjs8lJt1ySXi0LfrvZkBLBYBR0HOxcc=;
	b=Yd0FUfzL588YJmPfZGOtpZyUG+QXIYGBErcTugTw1W9jyC+bXvG668VN6Ct+q5iECbzOxU
	WJASwnSCisjn1I1TWTE+uAQtmFKQAnmGMIVwRtxpTds0DKrl8wVCdxufCHTN/eNa+OeP/4
	5vymZklBbi4IbMxVgG92je1GAmtiORl2w/IGpG10GjU81PyYylcBbDeQDRx3XUDZcjXtru
	G20lQxIbcvW14XHCRO9fMEf5anT3Jivi0LswQBw4eKWnL3lluAt9z8KDKnWt/jISlyR244
	r/K+P1KpzC7m1SCl9wz1gyF8+KZlg2r5BLld0XrWxoYfcAdV7OVfgrqXFyVImw==
Date: Wed, 31 Jan 2024 10:06:52 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v6 2/3] dt-bindings: input: Add TouchNetix axiom
 touchscreen
Message-ID: <20240131090652.GB3004909@kb-xps>
References: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
 <20240125165823.996910-3-kamel.bouhara@bootlin.com>
 <2c8961ff-9fcc-402c-b048-744ae9473164@linaro.org>
 <20240130222844.GA2527859-robh@kernel.org>
 <f07d7557-c190-4154-8fc7-6a3850b1d162@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07d7557-c190-4154-8fc7-6a3850b1d162@linaro.org>
X-GND-Sasl: kamel.bouhara@bootlin.com

Hello,

On Wed, Jan 31, 2024 at 08:28:43AM +0100, Krzysztof Kozlowski wrote:
> On 30/01/2024 23:28, Rob Herring wrote:
> > On Fri, Jan 26, 2024 at 12:46:16PM +0100, Krzysztof Kozlowski wrote:
> >> On 25/01/2024 17:58, Kamel Bouhara wrote:
> >>> +  reset-gpios:
> >>> +    maxItems: 1
> >>> +
> >>> +  vdda-supply:
> >>> +    description: Analog power supply regulator on VDDA pin
> >>> +
> >>> +  vddi-supply:
> >>> +    description: I/O power supply regulator on VDDI pin
> >>> +
> >>> +  startup-time-ms:
> >>> +    description: delay after power supply regulator is applied in ms
> >>
> >> That's a regulator property - ramp up time.
> >
> > I'm sure there's an existing property name that could be used.
> >
> > But why is it needed? Is it variable per board with the same device? If
> > not, it should be implied by the compatible.
>
> I meant, that regulators have such property. Unless this is coming from
> the device needs, not from the regulator?
>

After looking again into the device's datasheet [1], the delay (startup
time) is not really optional and it shouldn't be set through devicetree.

IIUC, it have to be set unconditionally after a device reset or
a vdda assertion.

[1]: https://www.touchnetix.com/media/dgnjohor/tnxd00394-a3-axiom_ax54a_2d_touch_controller_datasheet.pdf
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


