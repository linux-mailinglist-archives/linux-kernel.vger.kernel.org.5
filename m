Return-Path: <linux-kernel+bounces-112642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58459887C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CD71F214E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAD17732;
	Sun, 24 Mar 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+Gs6Z+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73317589;
	Sun, 24 Mar 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711278453; cv=none; b=glBTFPTcJOzv+Ia1/qVxiMTmD2pDP0shiJ0vj6Knzg1ZW1g3ENvPGGb5EXt8b+oGdIkWGvsmiQdPcMwM67t1qi77v+WsfwzZtUoiObYcAnGiZjZvHTz4203NBMWTGLkvZNaFYrVUKwDcQ76OmTZfiV7z5qaz/9inZNQlr7fqRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711278453; c=relaxed/simple;
	bh=c4DwOWppSfnfeU/csggpl62l/AoBhxYYo3PnytUAr6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olpnrykGYaBdUpDL3IxelmAEklFq3HW/9D0jJh/S3n0f3Zh4z1XPBz4foNI/nVfAI2MhO+sGRiYKgvdHDnvvlOIcTKyKeaOJHbRx4FQD0dfxZRiop8wFkOgeNOhKmhLjpZxUam/CrN2kWwCK9pd7PxvpTd92wOFarCHbWtKzunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+Gs6Z+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00201C433F1;
	Sun, 24 Mar 2024 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711278451;
	bh=c4DwOWppSfnfeU/csggpl62l/AoBhxYYo3PnytUAr6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+Gs6Z+chTKB0PynaDzxKDYVMmzLIQDib0BphLl9FOGvJ1foQe/nljTsYbLPD5in5
	 5JlcLQCVTLeuwQnmK7mWGH4MlqyA8g3syPivr/diQf7OQz/IYnKThR/iWh8u79fCku
	 /2mvNFaLqOkO+Ai7kE86b3sHbN7ZGk21udKOkzOTB7zaC6UA4cMlazn4yI9birZuHc
	 KLVFQ5ytzdb5J97FVMGouLyjYARbW6wRbA5PVbFKdFxjOPTEJQXvivDXbtAOKK5gFz
	 YdGoN/w5FVR0Pu2VfxaekhGeANIz2wlpj5Y/fG6EQJ5Pvkiv88AJ6RScBPAoV53WQ/
	 y0d2JqZdbh1+Q==
Date: Sun, 24 Mar 2024 11:07:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matt Ranostay <matt@ranostay.sg>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: health: maxim,max30102: fix
 compatible check
Message-ID: <20240324110715.0832e6d6@jic23-huawei>
In-Reply-To: <20240317-bakery-numeric-a34b928efa6d@spud>
References: <20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com>
	<20240317-bakery-numeric-a34b928efa6d@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 14:37:39 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Mar 16, 2024 at 11:56:57PM +0100, Javier Carrasco wrote:
> > The "maxim,green-led-current-microamp" property is only available for
> > the max30105 part (it provides an extra green LED), and must be set to
> > false for the max30102 part.
> > 
> > Instead, the max30100 part has been used for that, which is not
> > supported by this binding (it has its own binding).
> > 
> > This error was introduced during the txt to yaml conversion.
> > 
> > Fixes: 5a6a65b11e3a ("dt-bindings:iio:health:maxim,max30102: txt to yaml conversion")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied to the fixes-togreg branch of iio.git (which I'll rebase on rc1 once available)
and marked for stable.  Not really a critical thing to backport, but maybe it is worth
doing as risk is very low

Thanks,

Jonathan

> 
> > ---
> >  Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> > index c13c10c8d65d..eed0df9d3a23 100644
> > --- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> > @@ -42,7 +42,7 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: maxim,max30100
> > +            const: maxim,max30102
> >      then:
> >        properties:
> >          maxim,green-led-current-microamp: false
> > 
> > ---
> > base-commit: c1f10ac840caced7a9f717d4170dcc14b3fac076
> > change-id: 20240316-max30102_binding_fix-898e7c94cce9
> > 
> > Best regards,
> > -- 
> > Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >   


