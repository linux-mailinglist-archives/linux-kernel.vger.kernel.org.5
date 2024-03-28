Return-Path: <linux-kernel+bounces-123628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD79890BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE181C31238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574513A875;
	Thu, 28 Mar 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTACBJGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB91C6BD;
	Thu, 28 Mar 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658924; cv=none; b=IEFuGgkgmVaQheXrPOkmkbcg7Piw8cJq8D40eVDUtmPwrTrZEochiHxSfeic+EDJOvEiJ0svJDLQXhS3XIhu3KWm+kkpYAb2Ih5Yj0ci+oes4xEaNDcqHde/ekh3oEnwym3MbLz48Nz7jAp1fjfZsSZ7ypfaY6ISkaid66odWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658924; c=relaxed/simple;
	bh=9tNr+tXXI2ik4cysZcYTVu5UqP8gxh751wRXV35uwxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX9kNg4fBHqCTYt5IraRh43L9yfKR8NuPS2+yDYr9uB53EAv9YksWCBkHf0q1O5DA6wzFdQsOobCO6tagQqDXbLhWVj10uA8RMbGKBY55wAc1PdBG3/2qd2H9ioLhFNnuNUJZ8l+04sA67vP1Sd6mkOlLUGGX+J45NlzGqv8XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTACBJGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1071C433F1;
	Thu, 28 Mar 2024 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658923;
	bh=9tNr+tXXI2ik4cysZcYTVu5UqP8gxh751wRXV35uwxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTACBJGaBX2UDIyTb4/FLQUHUm47twuspkQFKdMLS0BSC2FbS98Kf1Jz5j0i9ygmh
	 LAgaQRZ8w30D7TjuYLfCGkaGqW8TG0NCHvThBTwF0wLR2A5Jc46aXqh5Z+lxa+FYpT
	 a+jpyuYJsPRza6qio/5kzFYeFUGLN7/q/SdyygFEgaZhI1hTGa1lM/ZPSVBAga4Xh2
	 lQCAxxVRFaRMIlq2EDyR/nI/GqUnpw6SvM8UI6Fg0Vad0WeHk1/1PC9K22pd5ai6rp
	 y7vFtT2SeT6RFgCZzz7pcWetybe3S0mLu7rzxT03mSN3cnefVmtNNaXshDRJ5Sx6M5
	 Ag0IjbVaxkAjQ==
Date: Thu, 28 Mar 2024 15:48:41 -0500
From: Rob Herring <robh@kernel.org>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 22/23] drivers: media: i2c: imx258: Add support for
 powerdown gpio
Message-ID: <20240328204841.GA318468-robh@kernel.org>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-23-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327231710.53188-23-git@luigi311.com>

On Wed, Mar 27, 2024 at 05:17:08PM -0600, git@luigi311.com wrote:
> From: Luigi311 <git@luigi311.com>
> 
> On some boards powerdown signal needs to be deasserted for this
> sensor to be enabled.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  .../devicetree/bindings/media/i2c/sony,imx258.yaml  |  4 ++++

Bindings should be a separate patch.

>  drivers/media/i2c/imx258.c                          | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> index c7856de15ba3..0414085bf22f 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> @@ -35,6 +35,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  powerdown-gpios:
> +    description: |-

Don't need '|-' if no formatting.

> +      Reference to the GPIO connected to the PWDN pin, if any.
> +
>    reset-gpios:
>      description: |-
>        Reference to the GPIO connected to the XCLR pin, if any.

