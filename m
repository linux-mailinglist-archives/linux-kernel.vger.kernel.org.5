Return-Path: <linux-kernel+bounces-32108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A6835698
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD014282003
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582637713;
	Sun, 21 Jan 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAqYLZtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDB37704;
	Sun, 21 Jan 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853852; cv=none; b=ENSmXFRQbOsvdPQH1+FrT7Qa1/MZE8pbyNG7E7XVGU404JHYEwo6A4ps2o3bjtkq+2PxgwPK2Q1ed0atc3NXodqNozTTAg3zPoaDqvHSIsYKqbmKtzIlgQMuS+opIkUTrTW9FhBB/zWeA8wMK66+yCX4xV0diZQyFl3tR8oGPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853852; c=relaxed/simple;
	bh=iUfq0MblOYTJ4Xg1o/EOPCx1dTOon9m9lKdqAKdduVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lV4/BiWoHo0kEm+kTnxWqTAxCD7EBo7RsqxiLQsmKnHWSVEjtM6t39aYreYZ5qb/vMI9xfVtjy+3mk9JjSmbCsg8z+YRVziGntRlxAYDY9GVUEI4P6V02B4J4Cvzp8MBbpRze65cQXFMFPRZv1znDOCbUUQ5LGSR6Q9mrdwjwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAqYLZtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312F2C433F1;
	Sun, 21 Jan 2024 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705853851;
	bh=iUfq0MblOYTJ4Xg1o/EOPCx1dTOon9m9lKdqAKdduVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uAqYLZtP8sR2EZcaOV2Dt7xxVatLrvMCG0HC4OHUWVU5mlAHcCvFPs8GOAova8sme
	 B4ko53SEDdVychlpJkRSm6MfFgf8ngJfSZOD9R3hcAhBnFVwWSb+iydLOYAw5gGzco
	 GuBcM3FW82lN2rW+a/a5E9LKq7PVeNdALdNq0D5jIv4hDcJgewtPSGyUp92LZ5g5df
	 jS8ED/N7LWBui4a4YQcGP5Z0ALIffPVimE96niYaBBrdq03a2M7UmxxTKTmyII53AU
	 9j7zQCb8zR3U4pK8Bsv009Y1VMGXKX7ccg4dk3E0DDrCmXcgIJixVrEkFcxtAWpW40
	 V7VIkq3sOPxqw==
Date: Sun, 21 Jan 2024 16:17:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Petar Stoykov
 <pd.pstoykov@gmail.com>, <linux-iio@vger.kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240121161718.32ffcb38@jic23-huawei>
In-Reply-To: <20240116163713.00006bf3@Huawei.com>
References: <CADFWO8EomrhEgtC+i9ikkcDU1c05kx-8kjrS4usAv-TRKxif+w@mail.gmail.com>
	<4eab426b-f654-4e10-9ffa-5b34016565fb@linaro.org>
	<20240116163713.00006bf3@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 16:37:13 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 16 Jan 2024 16:31:55 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 16/01/2024 16:24, Petar Stoykov wrote:  
> > > Sensirion SDP500 is a digital differential pressure sensor. It provides
> > > a digital I2C output. Add devicetree bindings requiring the compatible
> > > string and I2C slave address (reg).
> > > 
> > > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > > ---
> > >  .../bindings/iio/pressure/sdp500.yaml         | 38 +++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sdp500.yaml    
> > 
> > Filename like compatible.
> >   
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > > b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > > new file mode 100644
> > > index 000000000000..af01ec7e3802
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > > @@ -0,0 +1,38 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: sdp500/sdp510 pressure sensor with I2C bus interface
> > > +
> > > +maintainers:
> > > +  - Petar Stoykov <pd.pstoykov@gmail.com>
> > > +
> > > +description: |    
> > 
> > Do not need '|' unless you need to preserve formatting.
> >   
> > > +  Pressure sensor from Sensirion with I2C bus interface.
> > > +  There is no software difference between sdp500 and sdp510.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sensirion,sdp500
> > > +    
> > 
> > No resources? No interrupts? No power supply or any pins? No even
> > iio-cells? This looks incomplete.  
> 
> For a pressure sensors, io-channel-cells (which I guess you me you
Gah. Gibberish.

which I guess you mean...

thanks,

J
> mean) would be a new thing. We've never yet had a consumer of this
> data type...  Not necessarily a bad thing to have as one can
> conceive of one, but none of the current pressure sensor bindings
> have that.
> 
> vdd-supply though definitely wants to be in here and required
> given device is unlikely to work without power!
> 
> Jonathan
> 
> 
> >   
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c3 {    
> > 
> > i2c {
> >   
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +      sdp500@40 {    
> > 
> > Node names should be generic. See also an explanation and list of
> > examples (not exhaustive) in DT specification:
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> > 
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> >   
> 


