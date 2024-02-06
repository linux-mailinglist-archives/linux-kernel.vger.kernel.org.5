Return-Path: <linux-kernel+bounces-55149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C174B84B87D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB391C24335
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7149C13398D;
	Tue,  6 Feb 2024 14:53:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658421332A7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231196; cv=none; b=qg5NQhu+6a742zYq30osX9ggFHBMcSMCvFroQz/W5XI/+jPiz7wIkHGLQWdShYzEcz17m8+q/FZeqTgrxE0+PFnPjmJk7lwrE11hsxav1QaOOpeQw72frwDhsvyRwA2TOi6exI1wQB0tiFcFIj8WnVul5sjHDWs+lwSbPyGb1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231196; c=relaxed/simple;
	bh=DJ78Ay1OdNqn9uu5KBT+Cad3akqY44X3HXQr9ywyub4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsp6qYkFO8PQ04rO5ojHjBcV1YminZ1wynKWPFT5pff1XmR71wuJ7ynhRnTodR5V6aDJzeoBLlXEAt89hHCpvwbwSnqugVmEIx7RMYiEvKTIJEa+Wa2VR/62UYU/UHOk1uSGmFzaHIqp+8h8BFvQRUMiaEXd98fHLOXvU9OufgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXMog-0005Na-Dy; Tue, 06 Feb 2024 15:52:54 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXMof-004qT5-8Q; Tue, 06 Feb 2024 15:52:53 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXMof-00EFwL-0R;
	Tue, 06 Feb 2024 15:52:53 +0100
Date: Tue, 6 Feb 2024 15:52:53 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec-tcpci: add tcpci compatible
 binding
Message-ID: <20240206145253.u555h3rvtetv3qaf@pengutronix.de>
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-2-m.felsch@pengutronix.de>
 <004dbeb3-f863-416c-a4e4-18739302ae58@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004dbeb3-f863-416c-a4e4-18739302ae58@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-02-06, Krzysztof Kozlowski wrote:
> On 05/02/2024 17:43, Marco Felsch wrote:
> > This binding descripes the generic TCPCI specification [1]. So add the
> 
> Typo: describes.

Argh.

> No, this binding describes PTN5110, not generic TCPCI. This is not
> accurate commit description.

This binding is currently missued if another TCPCI conform chip is used
which requires no special handling. I could have dropped this commit
since the 'tcpci' is already present at i2c-device-id level.

> 
> > generic binding support since which can be used if an different TCPC is
> > used compatible which is compatible to [1].
> 
> Sorry, cannot parse it. Please run it through native speaker, Google
> grammar check, ChatGPT or some other way.

Argh.. you're right, sorry. I will rephrase it.

> > [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
> > index eaedb4cc6b6c..7bd7bbbac9e0 100644
> > --- a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
> > +++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
> > @@ -11,7 +11,9 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: nxp,ptn5110
> > +    enum:
> > +      - nxp,ptn5110
> > +      - tcpci
> 
> I don't think this is correct. First, this is binding for NXP chip, so
> why generic implementation should be here? I would expect it in its own
> dedicated binding.

The nxp,ptn5110 device was the first driver which implements an TCPCI
conform driver. The driver already support the tcpci binding for i2c-id
devices as I mentioned above. IMHO this whole binding (file) should be
converted and the nxp,ptn5110 compatible should be marked as deprecated.

> Second, we rarely want generic compatibles. Care to share more details?

As said above this particular NXP chip is an TCPCI conform chip. There
is nothing special about it. There are other vendors like OnSemi (in my
case) which implement also an TCPCI conform chip. The (Linux) driver
already binds to the generic tcpci compatible if the i2c-core falls back
to the i2c-device id. It's even more confusing that the i2c-id supports
only the generic binding the of-compatible support only the specifc one.

> Are all details expected to follow spec, without need of quirks?

Please see above, I hope this helps.

Regards,
  Marco

> 
> Best regards,
> Krzysztof
> 
> 

