Return-Path: <linux-kernel+bounces-68904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63238581B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B821C2159E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2512F5BE;
	Fri, 16 Feb 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skpgds00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68961BDD8;
	Fri, 16 Feb 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098662; cv=none; b=oU4prlxkN639DHAAKuzD+u52EIrmHuLkMjyku8iMxUpwG+2/MfQNE4386v1MQmCo/gWg6R37XXT/OhS8iAMmoiVDjkg0zsiqG+2qpC9XF9j68ZE16EjI+unVHUYJ+f8coXi2UATDpmygftRuWoE6eea/XNZTAeF2ij1thPwNOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098662; c=relaxed/simple;
	bh=XqumZg0Xx6R1zZIUJu7IqknRri8yZSUgg2ag/nPL14I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUjF8PR996W9W1ElPZcx9omx7DCZcDIWKzMt7+snZAOUhW+SHvKMFbyzkOT/6wx8NclHToM55Bi+Da5Qn3mxt1VaGIHd144J6dOeRC+7rRMiVpQAhm5rw3TCxDKMby9/oQM3oBbcsGFWzLIX3QHu6XK0A91FvlZBVBpfQRRpA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skpgds00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB479C433C7;
	Fri, 16 Feb 2024 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098661;
	bh=XqumZg0Xx6R1zZIUJu7IqknRri8yZSUgg2ag/nPL14I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skpgds005HeZfnJM4/AXQU9lYuQcNubyIxR6+dlb+2BusjC/hA95dwI47l6nxndJc
	 A8xVVij9W9Df2+aA8VWSX5/KNEmJrJHcvn/btb1KumrK1hC10aF99YRnNJJ4vj0AIV
	 db224RP8P+p2sJs1diSnZp+o/Wp4UoWPOW0e/8tPApZA1/fA6imqjJDXWvzG8AU4Rr
	 5WyCCfCvn9fq32nUcJLCxeqqgQooWJoCLavMSxw8zIXmmTGQhcGeRfeiYssa/ChOix
	 XWZoLHW7+iZ/yNICznkPPbbOie8lVRseUJcPzNj1tEMTpugKvGLIZtFFduRFqlq26x
	 xjmUpoh2r5S8Q==
Date: Fri, 16 Feb 2024 15:50:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 thomas.haemmerle@leica-geosystems.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply
 binding
Message-ID: <20240216155048.29b806a1@jic23-huawei>
In-Reply-To: <20240216112348.pamc4c7yemuz3sjp@pengutronix.de>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
	<20240216112120.76a0c0ca@jic23-huawei>
	<20240216112348.pamc4c7yemuz3sjp@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 12:23:48 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 24-02-16, Jonathan Cameron wrote:
> > On Fri, 16 Feb 2024 11:28:19 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > > 
> > > Add the binding to specify the vcc supply. We can't make it required
> > > since this would break the backward compatibility.  
> > 
> > Given convention for supplies like this is to make them required in
> > the dt-binding to reflect that providing power is not optional (unlikely
> > some other supplies that might not be wired up) and not worry about the
> > fact that we happily provide dummy supplies for them if they aren't in a
> > particular dts, it should be fine to make it required here.  
> 
> Will this fact apply to all dt-bindings? I'm asking because, there are
> many bindings out there without having the -supply in place.

Yes in theory - in practice it's noise to do it unless we have a reason
to be touching the dt-binding anyway.  I don't plan to fix them up on
mass.

Jonathan

> 
> Regards,
>   Marco
> 
> > 
> > Jonathan
> >   
> > > 
> > > Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Resend since I forgot to add the DT maintainers
> > > 
> > >  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > index 8c6d7735e875..cf7799c9734f 100644
> > > --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> > > @@ -24,6 +24,9 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > >  
> > > +  vcc-supply:
> > > +    description: provide VCC power to the sensor.
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -39,5 +42,6 @@ examples:
> > >          tmp117@48 {
> > >               compatible = "ti,tmp117";
> > >               reg = <0x48>;
> > > +             vcc-supply = <&pmic_reg_3v3>;
> > >          };
> > >      };  
> > 
> >   


