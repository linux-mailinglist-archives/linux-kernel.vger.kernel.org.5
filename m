Return-Path: <linux-kernel+bounces-125898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF338892D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6609E282A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FD4AEEB;
	Sat, 30 Mar 2024 21:40:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40822093;
	Sat, 30 Mar 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834844; cv=none; b=T16REM/JeJLpoXc7ElgL45TTWtiTMgynPrFBf46tlGF8vXCCm43+k5UkrSBfltzvdOj6XZjQGnnl38I8eOJmUER9LEmKMlrOcJ5UtCFoT2G2GqfSJEMd1AQnU2cmd+F/xgql5JQa5/FsWa14+2Xmv9mwG03Jta4Uudu6R246STw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834844; c=relaxed/simple;
	bh=Sfv61GuqN9EjrEx8j81lakykRn8nhWIo5beb5aUP+Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWiqO4Ji2EjrulhkN2iHrQdRuXu/yWIUA6mtsi+f+X6Ke/TUpqBVJ58ftB0LVu0Xd1QNYulCWla19cKKMW8iJ+xEhB3K/hdVeD0yV3Bd0Bhs+HPKulDrlxDl5gS5Yztast1Bs9ZVDRIUg8SD/Zahm92liwU2qYbZOMQJltrxgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D29106F;
	Sat, 30 Mar 2024 14:41:12 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114B33F64C;
	Sat, 30 Mar 2024 14:40:37 -0700 (PDT)
Date: Sat, 30 Mar 2024 21:40:22 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Ryan
 Walklin <ryan@testtoast.com>, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: add boost
 regulator
Message-ID: <20240330213331.68a2c145@minigeek.lan>
In-Reply-To: <0b53cf44-b5ca-4ccc-9912-777b85f1bcbd@linaro.org>
References: <20240329235033.25309-1-andre.przywara@arm.com>
	<20240329235033.25309-3-andre.przywara@arm.com>
	<0b53cf44-b5ca-4ccc-9912-777b85f1bcbd@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 10:30:05 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> On 30/03/2024 00:50, Andre Przywara wrote:
> > The X-Powers AXP717 contains a boost regulator, that it meant to provide
> > the 5V USB VBUS voltage when the devices operates on battery.
> > 
> > Add the name "boost" to the regexp describing the allowed node names,
> > to allow the regulator to be described in the devicetree.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index b8e8db0d58e9c..14ab367fc8871 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -274,7 +274,7 @@ properties:
> >            Defines the work frequency of DC-DC in kHz.
> >  
> >      patternProperties:
> > -      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
> > +      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo|boost)$":  
> 
> That's not an easy to read regex...

TBH regexps are the least of my problems when reading bindings ;-)

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!

> If driver does not depend on _, please consider dropping (_|-).

The drivers (checked both Linux and FreeBSD) do look for a specific
string, but it's the real old regulators that used ldo_io[01] and
rtc_ldo, all the "newer" ones use a dash. Since this binding covers all
of them, we can't drop this from this regexp, but rest assured we only
go with dashes for new and upcoming devices.

Thanks,
Andre

