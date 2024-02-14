Return-Path: <linux-kernel+bounces-65708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03068550A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC47C2861F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09424126F3B;
	Wed, 14 Feb 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Gtv1Cmm+"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58B86623;
	Wed, 14 Feb 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932703; cv=none; b=CXUOsS8TtD4jgh1QlAe+qvkYhgNMYa0qFT3OydvvVpKa2FMuh+gkGlspWklu56wRON0qv18RQrPBQXmAImxhfLpwKKLvafzCqOu2muvAUHoEO+M++s8AGSjESZ85TRlbHnoAJ2g0QtRv8D1TxdsSaZN5X5arCajq/RMQGI6OTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932703; c=relaxed/simple;
	bh=x811CJqG41wjKajiBOXzidHjP15WACkqtAYCBEd1g5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXHwv544AfslcsRZ4KSH1CVaUepL4Sl2BsdAjCBMWpmCy5zfdoMnqEPnMMWGLVw0pFzXkObYlM/ohEfTTZRBnnCnTymZOYLBOe4+xNot0l5bVmGuQxQgG1D/mtkZsIHU5ywKTcKIxvQFJXRoTDQ/bU12+CD2/Wim95EHpI2xIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Gtv1Cmm+; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707932698; bh=x811CJqG41wjKajiBOXzidHjP15WACkqtAYCBEd1g5Q=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Gtv1Cmm+huqS6iDKNOn7DnjF/qUE3tXVD+P55tb3maKRm5XLnHull1KueN8xSq8t4
	 mVGNQbMAl5azsgJeq9eAbjetAZYabuG74Px9OOt1kckmeTKyB907s0e284ujEgCbc0
	 Ki7sMWC14TnAggJ3I8Cq13sgvx4a/Kv2VQ0U1Ibo=
Date: Wed, 14 Feb 2024 18:44:58 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <6hureabdusk6o4ksm7pxx7iwb6nyodqdx37fzqosqmmp33klqw@yopxzgjevddd>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-3-megi@xff.cz>
 <20240212114738.0000535b@Huawei.com>
 <i2q2vntbhilrpwppzl367ndoetbyd6guyti4t4n7vtg5pwq7bi@tjkio7zpwrfw>
 <20240214163116.000031b5@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214163116.000031b5@Huawei.com>

On Wed, Feb 14, 2024 at 04:31:16PM +0000, Jonathan Cameron wrote:
> 
> > > > +
> > > > +  dvdd-supply:
> > > > +    description: |
> > > > +      an optional regulator that needs to be on to provide DVDD power (Digital
> > > > +      IO power, 1.8V~AVDD) to the sensor.
> > > > +
> > > > +  mount-matrix:
> > > > +    description: an optional 3x3 mounting rotation matrix.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg  
> > > 
> > > Any power supply that is required for operation should be listed here (even though
> > > we can rely on the stub supplies if it isn't in the DT).
> > > I used to think this wasn't necessary, so lots of bindings upstream don't yet
> > > have it.  
> > 
> > By stub supply you mean dummy supply created when the *-supply property is not
> > specified in DT? Or something else?
> 
> Ah yes. I got the term wrong.
> > 
> > Because DTC_CHK prints a warning if I make the proerty required in bindings and
> > not specify it in DT
> > 
> > arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2b.dtb: magnetometer@1c: 'avdd-supply' is a required property
> > 	from schema $id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.yaml#
> 
> Provide one, or don't worry about that warning. 
> 
> Various discussions have taken place on this over time and end
> result is bindings should require them to differentiate from power
> supplies that are actually optional.

Ok. Good to know. :)

regards,
	o.

> Jonathan
> 
> 

