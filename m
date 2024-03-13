Return-Path: <linux-kernel+bounces-102276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3574587B0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F577B2994F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69612D202;
	Wed, 13 Mar 2024 17:35:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9B64AB3;
	Wed, 13 Mar 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351337; cv=none; b=HmQjR5mEynTxrXXwjtZVGTYwMI9bx1lIqknLpsNH3ALV6j40ZrX0I1+Obykr4EZ8iCyfNqlEocUonjwwJnUZJRom0UvtV8TGgXhjbetqkQnTBWvgcawofzebC2SStq9eLX3FUlmY/u7hJeyvZ5vY5QZHR17tWCpHuc5/2rcnZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351337; c=relaxed/simple;
	bh=MWwfH0Ds/guaynuWl2ku83J+KR2G68Bd0doIQxAEm0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6N6pmt/IGYuYvH3+9IWw9Iz+CzMAr2jOyJOde41c4WjRZNRhuTsTffawZFHzzRoBWKbiOKPorhqPbvf2Ci9FOv3G1YK+OJ2LsbY4OGh2jJ4Jb7PLpGoGkIrilBLoSpoRD/TsXR4WTjTwqmHPmo2sEepjMb0hZ+ub3XO3KegCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF58C1007;
	Wed, 13 Mar 2024 10:36:09 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 886BE3F73F;
	Wed, 13 Mar 2024 10:35:31 -0700 (PDT)
Date: Wed, 13 Mar 2024 17:35:29 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: document AXP717
Message-ID: <20240313173529.1f816404@donnerap.manchester.arm.com>
In-Reply-To: <f203a0a3-9107-4290-a934-0f6736fe218a@sholland.org>
References: <20240310010211.28653-1-andre.przywara@arm.com>
	<20240310010211.28653-3-andre.przywara@arm.com>
	<f203a0a3-9107-4290-a934-0f6736fe218a@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:20:50 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

thanks for having a look!

> On 3/9/24 19:02, Andre Przywara wrote:
> > The X-Powers AXP717 is a PMIC used on some newer Allwinner devices.
> > Among quite some regulators it features the usual ADC/IRQ/power key
> > parts, plus a battery charger circuit, and some newly introduced USB
> > type-C circuitry.  
> 
> Do you plan to put the Type-C logic under a subnode, or should the
> Type-C connector node go directly under the PMIC node? Either way, the
> binding probably needs to be updated for that.

I haven't looked into this yet, so cannot say which way to go. I
definitely consider this some non-trivial task, so indeed wanted to push
this off to later.
For now there is a device (Anbernic RG35XX) with that PMIC, so we need at
least the regulators to unblock this. USB support is not critical for now.

> > Like two other recent PMICs, it lacks the DC/DC converter PWM frequency
> > control register, that rate is fixed here as well.
> > 
> > Add the new compatible string, and add that to the list of PMICs without
> > the PWM frequency property.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index 06f1779835a1e..b8e8db0d58e9c 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -83,6 +83,7 @@ allOf:
> >              enum:
> >                - x-powers,axp313a
> >                - x-powers,axp15060
> > +              - x-powers,axp717
> >  
> >      then:
> >        properties:
> > @@ -99,6 +100,7 @@ properties:
> >            - x-powers,axp221
> >            - x-powers,axp223
> >            - x-powers,axp313a
> > +          - x-powers,axp717
> >            - x-powers,axp803
> >            - x-powers,axp806
> >            - x-powers,axp809  
> 
> The regulators patternProperties needs to be updated for the new boost
> regulator.

Ah, I indeed missed this one. I think the former PMICs had this
batter->VBUS boost regulator hidden, controlled entirely by the PMIC?
I will need to check if exposing this will present any surprises. I
guess this goes together with the USB-C support, to have role switching,
unless this appears on some device with just USB-A or micro-B.
I will check what it takes to add this one, the regulator itself looks
easy.

Thanks!
Andre. 

