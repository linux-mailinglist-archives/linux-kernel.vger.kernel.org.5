Return-Path: <linux-kernel+bounces-32093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798CF835663
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CD4B22059
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AE38382;
	Sun, 21 Jan 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBvRefTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D6376F2;
	Sun, 21 Jan 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851430; cv=none; b=irg6hoi4KB+EvdOW+V+eqDXzKkU1awS5yKdiNrDQWzci8X0b/244YELK6W9lxyEGUcmQ9Y8TMn/3Q4zTtD9cu7ggyKp8bbTtFjBuVVFQoL15PfsVMkYAq3ni1f2KeC6KQg0BHDtH2KK9KkGK+4AJ6GqjmnKrHh2dB4tszWRq2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851430; c=relaxed/simple;
	bh=o9DRoMRGJgeYTuVP+aksfA+RBrVuOJIIhu/hq2XJfI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rl2NsICS5HETmikOb3+ci7jd6XFKidxn8arm+irxtWyk2mFarxkmM7f8H30/AYasKg12YXH6gbOtBRcTW5XLPL1AVsDX89k/7Bqtbil5sIBiIEwuQiEOLbYdyXU6qkkFlwA9XscTC3RjfSwMyeEAcqnqa/dQs3iyMQoNsqRB8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBvRefTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B25C43394;
	Sun, 21 Jan 2024 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705851430;
	bh=o9DRoMRGJgeYTuVP+aksfA+RBrVuOJIIhu/hq2XJfI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBvRefTYDQ7oSyrQ4357cr1D35GquD/G2yLcSCK8Xw3v6g7TQuAPDZGY9ORMNDMIm
	 oxdjBVMXp5F/Uzzg2TaCVupdsE1mjLsFY3sVNbuV0VnV5FPX1R/Jlm7qOn1+uOVVmE
	 PgW01O/ZIbcrZIK6yMW1uGddRfamFTjFTTNBKPBip5Z5sUBdK64wgpRmVFpBj5BWaD
	 iGg+bFW4HkhLj+17hIYQqtA1fDdatj33+TujNPYXnDAdA/Fu+yfnQ8DaINgtH40fUt
	 L/92GG/5UQnf5J0AVquGA6IJ2COnVgued/gd8CF5sEKmNtTh8Cye3Jki164J5eevum
	 zu9OFQ81DvoSQ==
Date: Sun, 21 Jan 2024 15:36:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20240121153655.5f734180@jic23-huawei>
In-Reply-To: <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
	<20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 15:47:33 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Adding device tree support for APDS9306 Ambient Light Sensor.
> Updating datasheet hyperlinks.
> Adding interrupt definition macro and header file.

This is an unrelated change, so should probably be in a separate patch.

> Adding vdd-supply property.

This one is reasonable to have in same patch as the new device addition
as, whilst I assume it's valid for the existing devices, you are adding it
to incorporate something that device also has.
Could also be a separate precursor patch.

> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
> v2 -> v5:
>  - Implemented changes as per previous reviews:
>    Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
>    Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
> ---
>  .../bindings/iio/light/avago,apds9300.yaml        | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> index c610780346e8..bee73a590424 100644
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> @@ -4,19 +4,21 @@
>  $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Avago Gesture/RGB/ALS/Proximity sensors
> +title: Avago (Broadcom) Gesture/RGB/ALS/Proximity sensors
>  
>  maintainers:
>    - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>  
>  description: |
> -  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
> -  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
> +  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
> +  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
> +  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN

Old links seem to still work, so why the change?

>  
>  properties:
>    compatible:
>      enum:
>        - avago,apds9300
> +      - avago,apds9306
>        - avago,apds9960
>  
>    reg:
> @@ -25,6 +27,8 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply: true
> +
>  additionalProperties: false
>  
>  required:
> @@ -33,6 +37,8 @@ required:
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -41,7 +47,8 @@ examples:
>              compatible = "avago,apds9300";
>              reg = <0x39>;
>              interrupt-parent = <&gpio2>;
> -            interrupts = <29 8>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> +            vdd-supply = <&regulator_3v3>;
>          };
>      };
>  ...


