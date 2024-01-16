Return-Path: <linux-kernel+bounces-27627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0982F332
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2400CB23A11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F811CAB9;
	Tue, 16 Jan 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8mMRdRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD61CA87;
	Tue, 16 Jan 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426226; cv=none; b=VilWETcTcbsE5uCaUwqhh6YBULLUH9gMCBiBgQ/OGqZdACGix6IUsojpq8ZyKma+5YV8NWO65QaLjzwujtpECSHX/dyYQqzzsnRHqVV0KAOhbJnF22AbX4idIlEkis1oG2+KgRtZnAit5Izo7gp3QVCmJkLLz4ndIZRmc6w8a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426226; c=relaxed/simple;
	bh=MHbGCgDXoLO32ycO/d98J+MN0cEFtEnVDmEKDb8wMKM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=tZJJ/0rUXOdKz2Wm0ZgIznEHSIsG0iRZj0TEwz+gvLgVZ9q4U9aNfLjPSkp5Oa2ZnWfAtDNqOiR9tzjucr+AYGM3E4AkkQIGea1QiW6sFjATIs757y1fb7MQ2slMgDga+k4sLQOlLCjHFCmPjCQhfvifl+dCm5nE0arzCunl4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8mMRdRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429EFC43399;
	Tue, 16 Jan 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705426225;
	bh=MHbGCgDXoLO32ycO/d98J+MN0cEFtEnVDmEKDb8wMKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8mMRdRyuQK3x1YDlCIYh4rOrj4/+pme/Xl+Oz+G404d7dUqv++TTe9baz3z89B1p
	 m1jNEdf7miWbDQ2Jk1lqN2ebccMcFj+zptjgjwnpBfWz2uGLbhfYv1XmtdDvWHJKjJ
	 n2g3jyYfqTso8XYrVe9Gu67LtKhfyFncXfB1FgtawtMMOpFMIPYc+sW7WyZN4SrLy2
	 RwaXDubX4IFBdk/9r/aFqWPlGu0Yxtrm5mWm9j8/oMEJbgf72OpBEvudQAWMTlxiqV
	 eg5JFZr33fDOodbi9vaRudll9qep9HfEsiw2NeXtf5wZfiK93RlGoi/b0RmhDANJwj
	 5wWjTppvXIO+A==
Date: Tue, 16 Jan 2024 11:30:23 -0600
From: Rob Herring <robh@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml
 add sleep-mode
Message-ID: <20240116173023.GA139792-robh@kernel.org>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
 <20240110172306.31273-3-petre.rodan@subdimension.ro>
 <bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>
 <ZaDqlmXJD6if1xK7@sunspire>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaDqlmXJD6if1xK7@sunspire>

On Fri, Jan 12, 2024 at 09:30:30AM +0200, Petre Rodan wrote:
> 
> Hello Krzysztof,
> 
> On Wed, Jan 10, 2024 at 09:48:34PM +0100, Krzysztof Kozlowski wrote:
> > On 10/01/2024 18:22, Petre Rodan wrote:
> > > Add sleep-mode property present in some custom chips.
> > > 
> > > This flag activates a special wakeup sequence prior to conversion.
> > > 
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > ---
> > >  .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > index 89977b9f01cf..350da1d6991b 100644
> > > --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > @@ -86,6 +86,15 @@ properties:
> > >        Maximum pressure value the sensor can measure in pascal.
> > >        To be specified only if honeywell,pressure-triplet is set to "NA".
> > > 
> > > +  honeywell,sleep-mode:
> > 
> > "Sleep mode" naming suggests there are choices, like mode foo and mode
> > bar. Probably you want something like "sleep-between-measurements" or
> > something matching how does it work.
> 
> "sleep mode" is the terminology used by Honeywell and it defines a chip capability.
> it is present in the HSC/SSC and ABP series of ICs.
> 
> other such options (capabilities) include temperature output in the ABP series.
> 
> the action the driver needs to perform if this option is present is to provide a
> wake-up sequence before reading out the conversions.
> 
> now regarding a rename of this property, I would vote to leave it as is - for the
> users to have a 1:1 equivalence of terms between the driver and the datasheet.
> 
> I say that because for instance in circuit design when a part symbol and
> footprint is drawn based on a datasheet it is recommended to keep the same pin
> notations and the same block diagram as in the datasheet, precisely for this 1:1
> equivalence, so there is no uncertainty for the end-user.

At least add a '-en' suffix so it is clear this property enables the 
mode. We have both flavors (enables and disables). 

Low power modes between samples is pretty common on these devices. We 
should consider if this should be a common property. Jonathan?

Rob

