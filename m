Return-Path: <linux-kernel+bounces-144964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC68A4D37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AA81F25F79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8A5D49F;
	Mon, 15 Apr 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hAsJDUnQ"
Received: from smtpcmd0871.aruba.it (smtpcmd0871.aruba.it [62.149.156.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEF5D47F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178974; cv=none; b=a6cMo6aAZ33k7MI1zJcL7ylVTFezIfAKImR+e+RkOn+4Jg/wtU+d7nqTHDwyQwFs7/fvLE86aogRHxlQAQ3gpRlMI0k8mN1zAfbqNcyScAO4W77lYd6D2ogdEQzB+iWb7kDCxc6OeOpl5QZzVXQkeJpJV3io0EC553m8Y9DwJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178974; c=relaxed/simple;
	bh=pxUIl7fu+ddmGZYHbXTMFc3Pa2Vv9xfOj4VnNTu17VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVd6WOKtH+xZEW2xVhzG4UlHfVV2lzi57uQcaoUMPwruCdmKrbIsz12Yy4Ws6FKr5xoqISgjYXYVKWO8iH+g0U9mF3PDGTZt034ewa+I1TSUS/5r6OJDnZR/gX5aLrFHE0sJmL0lZYimypAb6PnMJzqHsODmySvJ/2Y4ejrIYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hAsJDUnQ; arc=none smtp.client-ip=62.149.156.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.35.178])
	by Aruba Outgoing Smtp  with ESMTPSA
	id wK3orSBuzBZCLwK3provIw; Mon, 15 Apr 2024 12:59:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713178782; bh=pxUIl7fu+ddmGZYHbXTMFc3Pa2Vv9xfOj4VnNTu17VU=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=hAsJDUnQX4GPRNWeCM29c8VdbaE7MnJ5cE+46abmO04tlLAc2g1kS6FSIp7+5Az/g
	 nuXpUk/lMyVafehKgOKIIUHOs9WYAPrM8QWzxxtwqd2q8Ilj4KwUvJTf6J4pqpEC/w
	 6xoaUY5ELg83NUsJyp8qk+PsV9zTbwaujIiYVHBX8J/VMoYbUGerqjgab36yrEQrWm
	 ZvA93Kqf7QIaS0t+/ucbR3gYnV1iE/qL+0ar5ssbWrt9Bi5Yf/czf++jTYoC62sUbc
	 4wE4j58y2UXyKE3pvoBwQSVF8cifaZ0XiKYPm8kCrCeWPLERhCr55Z96vJrs9WaGfA
	 cadkNO40shrhg==
Date: Mon, 15 Apr 2024 12:59:39 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B
 warm reset property
Message-ID: <Zh0ImzJZrxw4Xia+@engicam>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org>
 <ZhjhCvVNezy9r7P4@engicam>
 <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org>
 <Zhq8ibYrZH05/AQt@engicam>
 <46fe43d0-28be-4acb-b0d4-dacd84fef8e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fe43d0-28be-4acb-b0d4-dacd84fef8e5@kernel.org>
X-CMAE-Envelope: MS4xfP/z+KuORGknNK6/gX9XtdpZ/tuKdch6lu03DLWqLvfsJNkRhpIeMxIcf2LaVjc/EJcG8uLHP4axebXN2r8breJCmVpl0DcFlHz154BJ57dqSpngd3Yi
 76lVgUXM4DOIXz7CAwgfFLvLbvlrme7mQxpanMhn3Kq0Twc7Jf7IcF5r47R1EAv/3Jk2BpY5g4JQh7N1vKqitqcNHJ6LQGxAzOPmvouQfFs+OyAkgrj4e/IK
 StJPHvjQdAlJdLmun9nr4gra9lEs6o/YGseFzdz7D7XaUjmMPdxxv8g0PUaDctANewz3yrRpjjqUjFoZFMtkHthBpZ3TLoGtAivC3ntZ8wIHI4MBIYcHC2L4
 K/cyB3siPna2mIOn+xHf7vjQH9r81wjGnxGQsMG6P2X/K9TbLNYln6UEiiIBgDSTYt2mVo8JoTqWQQ63Vtrv5vwJIs9mpQ==

Dear Krzysztof,

Il Sat, Apr 13, 2024 at 11:40:18PM +0200, Krzysztof Kozlowski ha scritto:
> On 13/04/2024 19:10, Fabio Aiuto wrote:
> > Dear Krzysztof,
> > 
> > Il Sat, Apr 13, 2024 at 12:58:35PM +0200, Krzysztof Kozlowski ha scritto:
> >> On 12/04/2024 09:21, Fabio Aiuto wrote:
> >>> Dear Krzysztof,
> >>>
> >>> Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
> >>>> On 11/04/2024 18:58, Fabio Aiuto wrote:
<snip> 
> I don't understand what is the use case. You wrote runtime does not
> solve your use case. What is the use case?

We experimented problems on some boards with SD card, if a cold reset
is done when the card is powered back on it completely freezes, the way
devices behave when unpowered for such short intervals is design specific,
not an OS policy.

kr,

fabio

> > 
> >>
> >> Sorry, you did not bring any further argument why this is board
> >> specific. And please don't explain how probing works, but address the
> >> problem here: why type of reset is specific to board design. To me it is
> >> OS policy.
> >>
> > 
> > Why reset type is specific to board design? I'm sorry but I don't know
> > what you mean, as said my intention was to enlarge the number of configurable
> > bits in pca9450 register space hoping this would be useful for someone.
> > 
> > All I can say is that is specific to board design for the same reason the
> > wdog_b- reset type was specific to board design.
> 
> Specific to board design means different boards have somehow different
> configuration/schematics/layout/hardware meaning they need this property
> to configure device differently.
> 
> I already said it implicitly, but let's reiterate: Devicetree is for
> hardware properties, not OS policies.
> 
> I also said, so repeating the same argument, the choice how you want to
> reboot the system based on button press, sounds like debugging choice
> thus runtime suits better.
> 
> Unless you want to say there are two signals and you want to configure
> them differently? But that's your job to explain it, not mine.

please see above,

kr,

fabio

> 
> Best regards,
> Krzysztof
> 

