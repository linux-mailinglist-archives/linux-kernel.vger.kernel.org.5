Return-Path: <linux-kernel+bounces-66973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A372085643D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E070284411
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF3130AC9;
	Thu, 15 Feb 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBdxRXDT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E312BF3D;
	Thu, 15 Feb 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003418; cv=none; b=qBKdMNHOMz9iDF+L0GNuoq1q1LBUcvCG+UKqps4acwzXP2wyjABmJ6FhMse79/Z02p6tNTBz2Y+zZxyPyhW2Qu6wEDTfYDIeV6NU9UvnHsr12Og4zBixUJtr75/G+a0uy3XPamQfe2e4E30zy/guPgGoed82bM7iRmVz+vi/m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003418; c=relaxed/simple;
	bh=6jdrHUpTR12o6zcCwnI0EmRbmFBouErFnPWURWeH5q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fneh0CQjDvZdcymO1jQTaXK5wl8sTG+SqE2QlCB64FS7F5G3Cvf7lYIt4uMVNDtVk7VzBEuCTkeNAd+QYY3Cw3WU9rb3wc0uEQjTmxwLdi2S9zh7C8B7AY4PyBG4El7+OTryu/QiIURLhEA9m6BHXPck/PsChv12W87D0DbksEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBdxRXDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6DCC433F1;
	Thu, 15 Feb 2024 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708003417;
	bh=6jdrHUpTR12o6zcCwnI0EmRbmFBouErFnPWURWeH5q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBdxRXDTAvoqW/fU3000WkufRKm4HgTzTbRMB9KZVHVslbwbCiMmQj2PvQ5UWm50K
	 uHnYwR9E1kAXMJkmg8Y4nlpS/Voxsh6SUgf1IlW4Kvvgp3rTkXuLOD5TxVyHhWA4FN
	 xBUjGasB1POqXSzw8b2cmITWSFF7A78YYwnZMAKcJGuuYdVSWJpOUWR5rVKarK85zv
	 ay6bdoFOEDzv13ivhw89tM7wB+pgdAbsBzVZ2lml6497xvT8xdE1DZ3CooTA2ZaZZc
	 ipSskdjzmZWNk1OsBwbaWE5VamNLojk283MHuYPe2ikQjPFMJL76dFMd27f3poZLnn
	 LT5H2q2BFovJA==
Date: Thu, 15 Feb 2024 07:23:34 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240215132334.GA3847183-robh@kernel.org>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
 <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>

On Tue, Feb 06, 2024 at 11:34:13AM -0600, David Lechner wrote:
> On Tue, Feb 6, 2024 at 11:26 AM David Lechner <dlechner@baylibre.com> wrote:
> >
> > This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> > AD7986 ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++++++++++
> >  MAINTAINERS                                        |   8 +
> >  2 files changed, 239 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > new file mode 100644
> > index 000000000000..a023adbeba42
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> 
> ...
> 
> 
> +  adi,reference:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, internal-buffer, external ]
> +    default: internal
> 
> ...
> 
> > +allOf:
> > +  # ref-supply is only used for external reference voltage
> > +  - if:
> > +      not:
> > +        required:
> > +          - adi,reference
> > +    then:
> > +      properties:
> > +        ref-supply: false
> > +    else:
> > +      if:
> > +        properties:
> > +          adi,reference:
> > +            const: external
> > +      then:
> > +        required:
> > +          - ref-supply
> > +      else:
> > +        properties:
> > +          ref-supply: false
> 
> This seems like something that could potentially be improved in the
> dtschema tooling. Since adi,reference has a default of "internal", I
> would expect:
> 
>      if:
>        properties:
>          adi,reference:
>            const: external

         required:
           - adi,reference

>      then:
>        required:
>          - ref-supply
>      else:
>        properties:
>          ref-supply: false
> 
> to be sufficient here. However, currently, if the adi,reference
> property is omitted from the dts/dtb, the condition here evaluates to
> true and unexpectedly (incorrectly?) the validator requires the
> ref-supply property.

That's just how json-schema works. With the above, it should work for 
you.

However, redesigning the binding would make things simpler. Just make 
'ref-supply' being present mean external ref. No 'ref-supply' is then 
internal. Then you just need a boolean for 'internal-buffer' mode and:

dependentSchemas:
  ref-supply:
    not:
      required: ['adi,internal-buffer-ref']

Rob

