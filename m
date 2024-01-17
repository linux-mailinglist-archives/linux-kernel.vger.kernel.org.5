Return-Path: <linux-kernel+bounces-29270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA20830BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D72842D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920D22630;
	Wed, 17 Jan 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS0NoPUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DE21A0E;
	Wed, 17 Jan 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512431; cv=none; b=ExG+0sIim9KNv3z3VT2SlYXz86H3PmR3xEvixJxLcQPoAHt0qf8kNyTtLc7EyIw0tw6BZ1J5JljpjxPTnMkAwpf2sh4lSQFT4LDD6r6+nU4KRxXQIXuyhxAwtsZ8n2G4+7TaUguy0Pr4QcaO8XPeADg/DhECgN9jszSotAWpvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512431; c=relaxed/simple;
	bh=5ln0JSCawXlnQqAUJkhfBzdwM60rMwxyLrmki/QtvDY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=CjKzbLBQDzc969BkM++7wJRUv7Z4ed8PIL7iOmw/lINCoGKdicTP/XgOl2h7l9PVSNIy0NbUR3dojOvbjlxAx88PcgedmJLo8OQ71hzcDLpRQV9Y6/PJ//lHBeTB5krNu13xstsoTZtIf6QlBaQ4pdts11dKGg5O/F0f6PxF5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS0NoPUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DADAC433F1;
	Wed, 17 Jan 2024 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512430;
	bh=5ln0JSCawXlnQqAUJkhfBzdwM60rMwxyLrmki/QtvDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VS0NoPUe5k3R2OET7/Gj/lnEIIFDv1nQlr34WWzXQsxDFAg9xYE2HTZKNBspRIVdf
	 CHW7KrM+uqKm1JKnxlm0O/pLYlWboQWu5aaZINqhC4Ux+BMavfjdcEqzd0FDBwkism
	 bMDnwfr/AzvW4Gb6mJmGK2moxSj5d4a++TpdbDjPCInT4Shq7sWWyx/KzefcdjxxDy
	 vllnrYT4XzjsTBx8U6+mv/MVLxw9fg2YF02mDlHdq4gDlemoVj9hidLh/w3mfe1qmi
	 RaOsTq8sAkZSy2CfOcBrtsVefspAjR3y3tw8FyiIyk3WcGD0ZGVrRqynV/VyTNRvKF
	 +zI6Z0Z56a6lQ==
Date: Wed, 17 Jan 2024 11:27:08 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml
 add sleep-mode
Message-ID: <20240117172708.GA2695411-robh@kernel.org>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
 <20240110172306.31273-3-petre.rodan@subdimension.ro>
 <bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>
 <ZaDqlmXJD6if1xK7@sunspire>
 <20240116173023.GA139792-robh@kernel.org>
 <20240117165001.00003046@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117165001.00003046@Huawei.com>

On Wed, Jan 17, 2024 at 04:50:01PM +0000, Jonathan Cameron wrote:
> On Tue, 16 Jan 2024 11:30:23 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Fri, Jan 12, 2024 at 09:30:30AM +0200, Petre Rodan wrote:
> > > 
> > > Hello Krzysztof,
> > > 
> > > On Wed, Jan 10, 2024 at 09:48:34PM +0100, Krzysztof Kozlowski wrote:  
> > > > On 10/01/2024 18:22, Petre Rodan wrote:  
> > > > > Add sleep-mode property present in some custom chips.
> > > > > 
> > > > > This flag activates a special wakeup sequence prior to conversion.
> > > > > 
> > > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > > ---
> > > > >  .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > > index 89977b9f01cf..350da1d6991b 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > > @@ -86,6 +86,15 @@ properties:
> > > > >        Maximum pressure value the sensor can measure in pascal.
> > > > >        To be specified only if honeywell,pressure-triplet is set to "NA".
> > > > > 
> > > > > +  honeywell,sleep-mode:  
> > > > 
> > > > "Sleep mode" naming suggests there are choices, like mode foo and mode
> > > > bar. Probably you want something like "sleep-between-measurements" or
> > > > something matching how does it work.  
> > > 
> > > "sleep mode" is the terminology used by Honeywell and it defines a chip capability.
> > > it is present in the HSC/SSC and ABP series of ICs.
> > > 
> > > other such options (capabilities) include temperature output in the ABP series.
> > > 
> > > the action the driver needs to perform if this option is present is to provide a
> > > wake-up sequence before reading out the conversions.
> > > 
> > > now regarding a rename of this property, I would vote to leave it as is - for the
> > > users to have a 1:1 equivalence of terms between the driver and the datasheet.
> > > 
> > > I say that because for instance in circuit design when a part symbol and
> > > footprint is drawn based on a datasheet it is recommended to keep the same pin
> > > notations and the same block diagram as in the datasheet, precisely for this 1:1
> > > equivalence, so there is no uncertainty for the end-user.  
> > 
> > At least add a '-en' suffix so it is clear this property enables the 
> > mode. We have both flavors (enables and disables). 
> > 
> > Low power modes between samples is pretty common on these devices. We 
> > should consider if this should be a common property. Jonathan?
> 
> Normally it's a controllable things so we make it dependent on userspace
> interaction (runtime-pm or whether buffered capture is enabled).
> Policy thing so not appropriate in DT.
> 
> Here it's different because it's a particular device variant that must work in this
> fashion. Other device variants don't support it at all.
> 
> If it weren't for the obscene number of variants this would normally be
> derived from the compatible rather than being in DT at all.
> 
> So it's odd and I don't think appropriate for a common property.

All good details missing from the description and commit msg. Given 
that, I retract my suggestion to use '-en' as it not a case of enabling 
the feature. Probably worth just keeping the name as-is than discussing 
further.

Rob

