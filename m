Return-Path: <linux-kernel+bounces-79706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94678625A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C01F21CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454243A8EE;
	Sat, 24 Feb 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ooLInn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01C1C13;
	Sat, 24 Feb 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708785503; cv=none; b=jbur0kuQ+7kSH36UwwdTdE9aGlALGlEa8qT1/yye9w/Go+KDWw/BErAWxRUnh0FczngJbHgcrMXqLJemq6T7MStrJQFFJLQHvq4unnl+uFOkIds+YqBk/5JFJtQlhGpA/r6k/ILEZxVdsH/qR9JNh1iIUoTpGpZ4H2NBg79KPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708785503; c=relaxed/simple;
	bh=LOIRRBcfX8qfYe4R2AJDus8SxcAc/GKkzU9VCLzg/80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKR93i2fSWfvIS3ev9bL3EWfdy2PgYdFWEOeR9HpD4evq9NeXFeWtwxy/au3ptcuKgqGCklid8LLs0YHwDsy7+rXW7q0rb6psU7//hJNAHiRIMqFLBzce36Kx1UI1cgOXyQViXmwNkgs5yMRG8TDc6yZvE9ZTby/vEpur3Iuqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ooLInn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1613DC433B2;
	Sat, 24 Feb 2024 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708785503;
	bh=LOIRRBcfX8qfYe4R2AJDus8SxcAc/GKkzU9VCLzg/80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+ooLInn5z6iQWZqErO2TrgTNTEIzxYdZOu/u8ZwxPlWYtE7ZH7c3OWqgrTfKoU0t
	 PM3/LfnlGamARgm8nK+k8t6CS27xETSFc6LTyxxUMNf34HIYIyTBDeqY5SnACg3zx/
	 f6dK9+U0mCUEfRTU6P8oKresYWthJXsAO4PN7n0lKWjudh+wQiIDYWJxGaReY/KfHA
	 g/nySzhwDrSuVAnIiE91D6jgpacwIZQFQfjeyUwh9n5NILlqzOXVINgYp0GC/F6Gd9
	 5E9SEa2bLnt0G/WZMFjH2sdbc6Ro42I5DCqbNr1MDy5MCTzp1oamBYKKiznhpSIReM
	 wRvFtWKa2bCqw==
Date: Sat, 24 Feb 2024 14:38:03 +0000
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
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20240224143803.27efa14f@jic23-huawei>
In-Reply-To: <20240218054826.2881-5-subhajit.ghosh@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
	<20240218054826.2881-5-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 16:18:25 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.

I deleted this first line of the patch description. Doesn't seem related
to the binding doc change.

> Extend avago,apds9300.yaml schema file to support apds9306 device.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
> v6 -> v7:
>  - Removed wrong patch dependency statement
>  - Added tag
>    https://lore.kernel.org/all/5089c549-505f-4342-b3fe-bed8a29b6ce1@linaro.org/
>    https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/
> 
> v5 -> v6:
>  - Write proper commit messages
>  - Add vdd-supply in a separate commit
>  - Add Interrupt macro in a separate commit
>    Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/
>    
> v2 -> v5:
>  - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
>    as per below reviews:
>    Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
>    Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
> ---
>  Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> index e07a074f6acf..b750096530bc 100644
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> @@ -12,11 +12,13 @@ maintainers:
>  description: |
>    Datasheet: https://www.avagotech.com/docs/AV02-1077EN
>    Datasheet: https://www.avagotech.com/docs/AV02-4191EN
> +  Datasheet: https://www.avagotech.com/docs/AV02-4755EN
>  
>  properties:
>    compatible:
>      enum:
>        - avago,apds9300
> +      - avago,apds9306
>        - avago,apds9960
>  
>    reg:


