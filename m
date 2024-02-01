Return-Path: <linux-kernel+bounces-48912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF6846322
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD31C24ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5303FE23;
	Thu,  1 Feb 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arNLs2Vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF833F8D9;
	Thu,  1 Feb 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825288; cv=none; b=a3t3yCynnPFyFu1Hej/zbfs/UFWc/jeApu6QIUPke3Wu8OZRQuJ4F9tzXW9l0yqZuLWLiTJraDqnqg6t8LaDoTDZ8fd+5/j0VXMQV34vsSQfTEPkNuMGs8Lb9ftJfb0rb0Il1217tOzL+vu+iv20ymbrjml0QOUuTwPsGF9G7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825288; c=relaxed/simple;
	bh=hQhyDtZvF8uLG9TardzvTE09AI07Z4RnP2sRVzETQc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLpzj2XAh2XAFUogOi4oo8/ZU5CHG4g7rqnaZB350w1cv4KG1o9V0QI2oFx8AotulElo7IXKJKKtvqDXGKgVrvXjs6E7gj/bS65d7v1SwG5Ke/JCH7TlyBzs397kxWLvHSyaxCXLAW7MkKtddlLaqejiB/AaG1cVl0EUUSWxZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arNLs2Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8901C433C7;
	Thu,  1 Feb 2024 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825288;
	bh=hQhyDtZvF8uLG9TardzvTE09AI07Z4RnP2sRVzETQc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arNLs2Vi/LqVcmpe22RClErs4NOHdZtfpgtEu6tqLDJ6aBWXExjw+w5PSctCil97W
	 XalDQETiQW2gYN8Gk1iWByfzaaOblw7ZjJOUumjFX9qdx2fvzX4gytiqteGz2yd6nL
	 RTig1cXNadD8a4yrv24NqBy+X6vX0FFL1jJzcMYHq+k/hOHvbq6DMWTHFJ5rHhib/f
	 4Cr+AXp3iRpV5Ue8Z4jdsBcg5a7NPvRPDA1D7km08Kmh4rRzMIeOpNDmfE5Ww5Y3mg
	 40PVZjC1YGXrB2iipwfJil94w6KexlOZjChUFjgEvK37Rkjd8AEOQvMZ3Md0VdfXtm
	 nuFMZ1lBWrbYg==
Date: Thu, 1 Feb 2024 16:08:05 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>
Subject: Re: Re: [PATCH v4 1/3] dt-bindings: HID: i2c-hid: Document
 reset-related properties
Message-ID: <luzkdel2hshufku2gjgbsvfhxkmpg5eo6ekythuawaiz6kibvs@lsajkktmetkv>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
 <20240131-x13s-touchscreen-v4-1-39c0f9925d3c@quicinc.com>
 <Zbts-9tRDPcXbhYi@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbts-9tRDPcXbhYi@hovoldconsulting.com>

On Thu, Feb 01, 2024 at 11:05:47AM +0100, Johan Hovold wrote:
> On Wed, Jan 31, 2024 at 07:07:26PM -0800, Bjorn Andersson wrote:
> > Some I2C HID devices has a reset pin and requires that some specified
> > time elapses after this reset pin is deasserted, before communication
> > with the device is attempted.
> > 
> > The Linux implementation is looking for these in the "reset-gpios" and
> > "post-reset-deassert-delay-ms" properties already, so use these property
> > names.
> > 
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> > index 138caad96a29..f07ff4cb3d26 100644
> > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> > @@ -50,6 +50,12 @@ properties:
> >      description: Time required by the device after enabling its regulators
> >        or powering it on, before it is ready for communication.
> >  
> > +  post-reset-deassert-delay-ms:
> > +    description: Time required by the device after reset has been deasserted,
> > +      before it is ready for communication.
> 
> I know that Rob reluctantly acked this, but re-reading the commit
> message for the commit that added support for the reset gpio to the
> driver, and added a comment about this not having been added to the
> devicetree binding, it becomes obvious that the latter was done on
> purpose and that we probably should not be adding the
> 'post-reset-deassert-delay-ms' property after all:
> 
> 	For now the new "post-reset-deassert-delay-ms" property is only
> 	used on x86/ACPI (non devicetree) devs. IOW it is not used in
> 	actual devicetree files and the same goes for the reset GPIO.
> 	The devicetree-bindings maintainers have requested properties
> 	like these to not be added to the devicetree-bindings, so the
> 	new property + GPIO are deliberately not added to the existing
> 	devicetree-bindings.
> 
> 	2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")
> 
> So perhaps we should just do this properly and add a new compatible
> property for X13s touchscreen which can be used to determine these
> delays (e.g. for cases where some default values are insufficient).
> 

So we should add a new binding, with a device-specific compatible and
add a reset-gpios only for that (and not the generic hid-over-i2c
binding), and then in the i2c-hid driver encode the two delays?

I can try to rewrite these patches, if you can provide me with a
compatible.

Regards,
Bjorn

