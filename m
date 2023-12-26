Return-Path: <linux-kernel+bounces-11576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651F81E86D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ADD1C2202B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC54F615;
	Tue, 26 Dec 2023 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4V8YiHI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9F1E4B6;
	Tue, 26 Dec 2023 16:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC97C433C8;
	Tue, 26 Dec 2023 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703608296;
	bh=YwEGjY0TfNva5Qu9+ELcM3v8DLlN155ZNPZzPxqOLts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T4V8YiHIkemEOaWlTNQx+LEOydX29SS2YujpDP6mG9EJ3iFB7JZ0p1a5h4anrDwim
	 hVC17D8AWzOu9GGsi02dvzL2lZOoY9Wng6Ngv/L3OAZo16WU4yEMuZFAj+YjIiuMYJ
	 S59vNwJnxTUz8TLoktzjGnEeO5h9kX1IoortA92nXFw817pdjozy7Fd3Ax7q7B3Gey
	 E6GX5xqQzSJXGYHbi01yYmTjmxzNkqMaxJIlH+WD9RRpwfygVrEvhI5xWmYjVwHR7L
	 VdhSYgT6YVpPftA4oEipww60wRZCi2gwnDP+MbLXKLZ7reIznK/KiEEfm4S+w7tS5Q
	 vGVGgOfkeFfnQ==
Date: Tue, 26 Dec 2023 16:31:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml fix
Message-ID: <20231226163128.09bf0f4e@jic23-huawei>
In-Reply-To: <20231226162839.5ceddc9e@jic23-huawei>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-2-petre.rodan@subdimension.ro>
	<20231226162839.5ceddc9e@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 16:28:39 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 24 Dec 2023 16:34:46 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> > Define enum inside the honeywell,transfer-function property block.
> > 
> > Set the correct irq edge in the example block.
> > Based on the datasheet, in table 13 on page 11:
> > "End-of-conversion indicator: This pin is set high when a measurement
> > and calculation have been completed and the data is ready to be
> > clocked out"
> > 
> > Add description on End-of-conversion interrupt.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>  
> What's the relationship between Andreas and this patch?
> 
> Petre seems to have sent it so either Andreas should have a Co-authored-by or
Co-developed-by: that is.


> should be the author... Or not there at all
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/pressure/honeywell,mprls0025pa.yaml       | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> > index d9e903fbfd99..84ced4e5a7da 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> > @@ -42,6 +42,10 @@ properties:
> >      maxItems: 1
> > 
> >    interrupts:
> > +    description:
> > +      Optional interrupt for indicating End-of-conversion.
> > +      If not present, the driver loops for a while until the received status
> > +      byte indicates correct measurement.
> >      maxItems: 1
> > 
> >    reset-gpios:
> > @@ -65,6 +69,7 @@ properties:
> >        1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> >        2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> >        3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
> > +    enum: [1, 2, 3]
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > 
> >    vdd-supply:
> > @@ -93,7 +98,7 @@ examples:
> >              reg = <0x18>;
> >              reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> >              interrupt-parent = <&gpio3>;
> > -            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
> >              honeywell,pmin-pascal = <0>;
> >              honeywell,pmax-pascal = <172369>;
> >              honeywell,transfer-function = <1>;
> > --
> > 2.41.0
> >   
> 
> 


