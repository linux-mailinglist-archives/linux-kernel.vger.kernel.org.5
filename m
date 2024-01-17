Return-Path: <linux-kernel+bounces-29238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1C830B74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A991C21A21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E35224EE;
	Wed, 17 Jan 2024 16:50:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED551E863;
	Wed, 17 Jan 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510210; cv=none; b=DkST+sKnK8eeIIqVB9iqT9mi9M/l/7NHk5y2Ciufe6AGX5KUOxjfBNHPNWJuR9MGq6EIiYbAtzjx2nhaQi7b90nuOvA366N4uvokRBDdkoWaZ1iuih18SklzS7IjOhMKQy9VbJDfWMu+z5k7l/bOfHtPXpJFHOZppiaxPbShheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510210; c=relaxed/simple;
	bh=9UwbAjBITZpX2+JqWcLCFrn2uFADUodbLwB5n/JYW1c=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=tC1hx9hsS9z/EmYoqZ0dHHgW5FA4h7PNHyDRg62ulsyobWfjLforeBC0PFAZ/pKC/Sq1sjmyzBNdfat7kJ2jgeSEmnksQHsWWHcuFx0G7ZLJsN9TxGm3jbdgEcOHllVPu16Mb/zkx2E+RRcuMUWPN8UPRMiqsyHKwS5NPMdDILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFWyc0RKnz6K6M1;
	Thu, 18 Jan 2024 00:47:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 833D8140AA7;
	Thu, 18 Jan 2024 00:50:04 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 16:50:04 +0000
Date: Wed, 17 Jan 2024 16:50:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Petre Rodan <petre.rodan@subdimension.ro>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml
 add sleep-mode
Message-ID: <20240117165001.00003046@Huawei.com>
In-Reply-To: <20240116173023.GA139792-robh@kernel.org>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
	<20240110172306.31273-3-petre.rodan@subdimension.ro>
	<bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>
	<ZaDqlmXJD6if1xK7@sunspire>
	<20240116173023.GA139792-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jan 2024 11:30:23 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Jan 12, 2024 at 09:30:30AM +0200, Petre Rodan wrote:
> > 
> > Hello Krzysztof,
> > 
> > On Wed, Jan 10, 2024 at 09:48:34PM +0100, Krzysztof Kozlowski wrote:  
> > > On 10/01/2024 18:22, Petre Rodan wrote:  
> > > > Add sleep-mode property present in some custom chips.
> > > > 
> > > > This flag activates a special wakeup sequence prior to conversion.
> > > > 
> > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > ---
> > > >  .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > index 89977b9f01cf..350da1d6991b 100644
> > > > --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> > > > @@ -86,6 +86,15 @@ properties:
> > > >        Maximum pressure value the sensor can measure in pascal.
> > > >        To be specified only if honeywell,pressure-triplet is set to "NA".
> > > > 
> > > > +  honeywell,sleep-mode:  
> > > 
> > > "Sleep mode" naming suggests there are choices, like mode foo and mode
> > > bar. Probably you want something like "sleep-between-measurements" or
> > > something matching how does it work.  
> > 
> > "sleep mode" is the terminology used by Honeywell and it defines a chip capability.
> > it is present in the HSC/SSC and ABP series of ICs.
> > 
> > other such options (capabilities) include temperature output in the ABP series.
> > 
> > the action the driver needs to perform if this option is present is to provide a
> > wake-up sequence before reading out the conversions.
> > 
> > now regarding a rename of this property, I would vote to leave it as is - for the
> > users to have a 1:1 equivalence of terms between the driver and the datasheet.
> > 
> > I say that because for instance in circuit design when a part symbol and
> > footprint is drawn based on a datasheet it is recommended to keep the same pin
> > notations and the same block diagram as in the datasheet, precisely for this 1:1
> > equivalence, so there is no uncertainty for the end-user.  
> 
> At least add a '-en' suffix so it is clear this property enables the 
> mode. We have both flavors (enables and disables). 
> 
> Low power modes between samples is pretty common on these devices. We 
> should consider if this should be a common property. Jonathan?

Normally it's a controllable things so we make it dependent on userspace
interaction (runtime-pm or whether buffered capture is enabled).
Policy thing so not appropriate in DT.

Here it's different because it's a particular device variant that must work in this
fashion. Other device variants don't support it at all.

If it weren't for the obscene number of variants this would normally be
derived from the compatible rather than being in DT at all.

So it's odd and I don't think appropriate for a common property.

Jonathan

> 
> Rob
> 


