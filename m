Return-Path: <linux-kernel+bounces-45397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AA842FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0541F245B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDB7BAFA;
	Tue, 30 Jan 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBLqoJJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDD14F61;
	Tue, 30 Jan 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653727; cv=none; b=HXLHxD/Vbpa+jyImwWsGCUIvsieO/Ffs1iIHDlqcUGHy0q/WH1RGLzq6krkKUdbklXIQIuU/lu4Zjnx7nCfApbYjTBedLeLjNZZ8mGNQfebfyh2TNc+CzzefLm9CR5Ty1ZVDhVp7kljHIjxwmVTdV3zy3Okw5blIL5M7CDKafPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653727; c=relaxed/simple;
	bh=gdgAHXKpH/gBF814iZyrFoZFRlxxElbbmfZ1pVF2jng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lee4ja78ReY1ch2ZJWfUgH8vBbANvaSL0Wxm4W97ZinSI4Ce707JpTmaNy2sHS+67bkE0NE1eUkwe6GO6OLrK1GW2MMTaZo48aykoel2aU12eUa04OjI0T2/oW2oxflhHuzu20YjOFuh26XR7GlBR7p9OAOPaw7GDfBylzViuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBLqoJJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDFEC433C7;
	Tue, 30 Jan 2024 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653726;
	bh=gdgAHXKpH/gBF814iZyrFoZFRlxxElbbmfZ1pVF2jng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBLqoJJ2n5lA3yi7rrskf3Az4bDyF+HMkm0G2NfA+0hL+AFGrK9P3W0OSgM2R6V87
	 Yqh/Ud+PBcJXQdeJyIgcY7ZRy7cHFcqLTZ7qElwMYl4YdntfVLLbIpZI2DZ1mM9HxO
	 Jys2RIofNvCuzv06AbE/vmBek8q+feMjE+GDJ0J5GgX95Y0xSctjsD/2d01T+lOhZn
	 RVO0hSVa9xvzbNseSsAOu4NEd92yYrTMsvLDuuntv1hWjo2pvOef3uFVED4E2eta8/
	 uon9o/cZJUQsDr8Z3EwoSrtgFZkRQmty4HQT2YdYxmw8lua0icQdYSz/u2lWOj8TCI
	 18PDppuADvdkw==
Date: Tue, 30 Jan 2024 16:28:44 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
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
Message-ID: <20240130222844.GA2527859-robh@kernel.org>
References: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
 <20240125165823.996910-3-kamel.bouhara@bootlin.com>
 <2c8961ff-9fcc-402c-b048-744ae9473164@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8961ff-9fcc-402c-b048-744ae9473164@linaro.org>

On Fri, Jan 26, 2024 at 12:46:16PM +0100, Krzysztof Kozlowski wrote:
> On 25/01/2024 17:58, Kamel Bouhara wrote:
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  vdda-supply:
> > +    description: Analog power supply regulator on VDDA pin
> > +
> > +  vddi-supply:
> > +    description: I/O power supply regulator on VDDI pin
> > +
> > +  startup-time-ms:
> > +    description: delay after power supply regulator is applied in ms
> 
> That's a regulator property - ramp up time.

I'm sure there's an existing property name that could be used.

But why is it needed? Is it variable per board with the same device? If 
not, it should be implied by the compatible.

Rob

