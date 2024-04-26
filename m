Return-Path: <linux-kernel+bounces-160625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA78B403D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103581C21BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516911CD38;
	Fri, 26 Apr 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="09/7GHIC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5018C19;
	Fri, 26 Apr 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160635; cv=none; b=g3riy1gPEAqbOkFDDjLsxdCEJhEcjWgRHHdVzSg9ALY9I777wgMEsoaZWeVnnEOj4uEbt8Rrq75LhFJrBp8vPoWCuxcq2b00BfSSrmEtNOHoAdjgJcUZazgHtku3KYWLB6MrjQHOgqpssIGvj6pGKEg6jvTe0P+nkqb2ygk4ExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160635; c=relaxed/simple;
	bh=1m2KZnSkE8Z9rLOvusGPzukGeEbYzq7AQEGoOjvrcvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5UnbClfUb8oYoHTGxjAQI2kqS/ogeMaW8MDlCeHgxj5dCdx4D6O2YUl1CXfxrdyF9jXuFAWD5WDRqx8ZHKNx//lDgUOpwnlhTc2CfgadiVgYRAJF6dLZ868zOOsHOVfxWd3B9J1hMUKhNJsmq762uD0U9TixvNuI++uy1cwnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=09/7GHIC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o6y2LJ14txpTdXHbp38HomD5dRIYV/HuQPJ4h1ryQbI=; b=09/7GHICi894+Vn1EAB+6+3+A4
	tQBIFsrsvyf9k1FIR7QcIBJXkc3Gz3u6pitSWD94UQiGtqeY12M2u9AbwMgslV8VAlNw/OPqqN7kg
	oKOVYcTEFHay4kevOmcCxx0QGPhMT4zca1Z+b3eU+R3c6MBoUicpECCv/JVukM4Ey4tc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0RTy-00E6Pj-I9; Fri, 26 Apr 2024 21:43:42 +0200
Date: Fri, 26 Apr 2024 21:43:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Message-ID: <053fff95-4a7d-4d00-ad38-17ffe76a4525@lunn.ch>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
 <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
 <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
 <15b79794-41f4-43e0-888e-286ca1fc4321@solid-run.com>
 <d0426bb3-1f40-48ed-9032-6ffdce455cd4@lunn.ch>
 <32ec3ef4-0ecc-4ae2-bf76-c7b10f54a583@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ec3ef4-0ecc-4ae2-bf76-c7b10f54a583@solid-run.com>

On Fri, Apr 26, 2024 at 06:51:02PM +0000, Josua Mayer wrote:
> Am 26.04.24 um 20:18 schrieb Andrew Lunn:
> >>>> Colours are similar to RJ45 connectors (yellow, green),
> >>>> and are intended for the same purpose: link, activity.
> >>> For the switch LEDs you used label = "LED10"; Does the silk screen
> >>> have similar numbers for these LEDs?
> >> Correct, on CN9130 Clearfog Pro DSA switch, all LEDs are labeled
> >> individually on the silk screen.
> >>
> >> The SolidWAN SFP leds are dual-colour leds with 3 terminals:
> >> anode to 3.3V, 2x cathode to gpio-controlled transistors.
> >> They are labeled on the silk-screen as "LED9", "LED10".
> >>
> >> Duplicate labels are not great, is there a better way?
> >> old style "LED9:green" e.g. ...?
> > So you have copper LEDs and SFP LEDs, each with the same silk screen
> > label? Maybe put 'copper' and 'sfp' as a prefix into the label?
> 
> No, not quite.
> 
> We have 2x SFP Connectors.
> On the bottom side of PCB immediately below each connector is
> a single LED (as in physical component), each with a silk-screen label.
> 
> "J28"/"SFP 0": "LED10"
> "J42"/"SFP 1": "LED9"
> 
> The problem is that these leds are each two leds in single-package,

Ah! Sorry, you clearly said they were dual-colour.

> which is why I put 4 led nodes in dts, two labeled "sfp-0",
> other two "sfp-1".
> But I don't think this duplication of label in dts is a good idea.

Agreed. Then i would use the colour as a postfix.

	Andrew

