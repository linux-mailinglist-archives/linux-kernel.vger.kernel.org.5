Return-Path: <linux-kernel+bounces-79801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDAB8626F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338361C20A34
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86134C3D0;
	Sat, 24 Feb 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd+w5m7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002DEDE;
	Sat, 24 Feb 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802337; cv=none; b=SChAHgSfdHnUKggQ6qcS4/nCcYm7gP/GGtulMEffvIFKOXRghP30TT2zpddy8u5+ouwbmqp87FCUpROklkYXBJJtsVHPLBAjZNMbpx5BDmphFUgJYw9rpV+XRba5s1Cu6wcWEXH8WwPhM2TiI3DB93M+L7K/5IacrcLwaE2YFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802337; c=relaxed/simple;
	bh=15Z+svmWXnvuKAbgxBOoIfyNn9nC0bhPmQJ8VekgTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXMR6HiKz4hJvYWqopCPmP8b4cnXcZC16LArB1BJe6JowxxL6brU7v9Y8gk11aTESgux7gmbBohPpuxxcdpVbdnI6GU++YY4bu4DGpcyd4UE47T3WKUvOr+Yj8CU5PFH1yHSwvPUbAYv0eFVRqLxD9DwgKDEcZpPfsb4kTYJTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd+w5m7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79357C433F1;
	Sat, 24 Feb 2024 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802336;
	bh=15Z+svmWXnvuKAbgxBOoIfyNn9nC0bhPmQJ8VekgTSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pd+w5m7MGpgkfvereSA8w363L0+0XYyy4mxCGYK1kLPRXuIphk7iNf9fYjjs9zmFF
	 4Rh6RW/SyhidEjSAVYl0YYg9VsKRKQJJek5X7pp+2u5uoJmm+d3nL3ZwEn44GXRD+A
	 dgugZtqmOaP7YLbz55Zlil+KknYgufMCsfWBbdOAbFeEVAS0MfW3j9DwjoSdmtsPWG
	 bWt+66/72K3W5BLYndjd+QiVd6P186MSkHaMKsSiVyBn1dq8V11KLhWABaiGGNQ0/A
	 G7j2LIiUYPiq+ZCfC42cA7rQeoj09hHW/1h2c4GJE5rCnkfXTtzoND9vYgCirla/ZG
	 +9xQqjeoG2NaA==
Date: Sat, 24 Feb 2024 19:18:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: vishay,veml6075: make
 vdd-supply required
Message-ID: <20240224191843.61796617@jic23-huawei>
In-Reply-To: <20240223-niece-shakily-7e18b90f30e7@spud>
References: <20240223-veml6075_vdd-v1-1-ac76509b1998@gmail.com>
	<20240223-niece-shakily-7e18b90f30e7@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 18:34:39 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Feb 23, 2024 at 02:01:33PM +0100, Javier Carrasco wrote:
> > The VEML6075 requires a single supply to operate. The property already
> > exists in the bindings and it is used in the example, but it is still
> > not on the list of required properties.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> > The driver and bindings for the VEML6075 UV sensor were merged in the
> > merge window for v6.8 i.e. they have not been released yet beyond rc.
> > 
> > Applying this patch as a fix now would avoid an ABI break like the
> > recently discussed here:
> > 
> > https://lore.kernel.org/linux-iio/8409a5bc71b995e3b738b817a074cfb131c3b2b5.camel@gmail.com/
> > 
> > On the other hand, from the same discussion it can be concluded that the
> > major risk would be a potential warning with dtbs_check, in case this
> > patch is applied during the next merge window.  
> 
> I don't care if it introduces a dtbs_check problem, we can fix those.
> The device clearly needs power and at least for linux it being missing
> gets handled perfectly fine. I think it's pretty reasonable to do this.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

> Cheers,
> Conor.
> 
> > 
> > The VEML6075 driver already handles the power supply with
> > devm_regulator_get_enable().
> > ---
> >  Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> > index abee04cd126e..91c318746bf3 100644
> > --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> > @@ -21,6 +21,7 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > +  - vdd-supply
> >  
> >  additionalProperties: false
> >  
> > 
> > ---
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > change-id: 20240223-veml6075_vdd-e2220158ffda
> > 
> > Best regards,
> > -- 
> > Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >   


