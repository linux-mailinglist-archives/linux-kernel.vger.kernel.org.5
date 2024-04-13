Return-Path: <linux-kernel+bounces-143782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840658A3D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CBF282388
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0847A6F;
	Sat, 13 Apr 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF1OPY7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E245C0B;
	Sat, 13 Apr 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022017; cv=none; b=aZCdZ4g5g50ovnSrhx6RUQKkk+pvRqRaXiCb3F6WJoX3Xc3m6g8GB+/gKisFoNJRLIb7srtx8q++EU26RlZjJy2ix1mIcrtqJlhcBiRhX/6tXQPT7IoiKfTOA7OZTluvq5LfzSCq+sa0GEhf7fv4pe6fGMizUfVv+jicjaOstrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022017; c=relaxed/simple;
	bh=yjYE4O7v8bZRGxr3/fWFg7rBzUco5Yk1lqn4sxx6848=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxDuTZzl9vrtJrDj96Ybcl129vSHTs2tvx76wUIJIonYUn94Ezsg9fjVJP8iMwBSjNfEiqFWam9+EHuvkydPEOkzCXnIbYcxEOGqxb5rl3qrUeFAJEX/8GSB9iT+/qpwzQry3EyMMnFMvLSsRpu1RaxzhLlsMmB4EzVAx1xwmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF1OPY7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9040CC113CD;
	Sat, 13 Apr 2024 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713022016;
	bh=yjYE4O7v8bZRGxr3/fWFg7rBzUco5Yk1lqn4sxx6848=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SF1OPY7gtVfCVCF2OwCr+czoXz8yLNtPKWcUg5kkOV2l3krgyqVQEhlD5Q4B9WJG1
	 8EytEX09YOM47V76Q9p0u5QITIMmTF67MALEL8yX37kRym9qzJ4Z7PfuSP9ppCbIkC
	 I6WKSbV1aIAUW68BoZYaHhdF4smqFdV93fMQ7Ux0bsahCJnoSPC32OqpfhYqplE9j5
	 AnZ3pmIgt7d2eKk1wDWqVW2SwCJSi0cIMbu+hRXJlOZby4WBx+vHndxj0RH8BEIfNc
	 J+GXw9Rq7FhTleWkyZMx+Q2i8l14qfEiNxXvCRt1uXlQV8FhZZFIzxkE/LQzmnn3VI
	 qnv6TQ+ndV/iQ==
Date: Sat, 13 Apr 2024 16:26:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
Message-ID: <20240413162640.77c6fc56@jic23-huawei>
In-Reply-To: <20240412032102.136071-4-kimseer.paller@analog.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-4-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 11:21:01 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Define the sysfs interface for toggle capable channels.
> 
> Toggle enabled channels will have:
> 
>  * out_currentY_toggle_en
>  * out_currentY_raw0
>  * out_currentY_raw1
>  * out_currentY_symbol
> 
> The common interface present in all channels is:
> 
>  * out_currentY_raw (not present in toggle enabled channels)
>  * out_currentY_raw_available
>  * out_currentY_powerdown
>  * out_currentY_scale
>  * out_currentY_offset
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2672     | 30 +++++++++++++++++++

You can only have per device ABI defined if that is the only user
of the ABI.  That may actually be true here but given I've asked you to generalize
the voltage equivalent, I think we've shown this is general enough that the current
version should also be raised to sysfs-bus-iio-dac

>  MAINTAINERS                                   |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672
> new file mode 100644
> index 000000000..b984d92f7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672
> @@ -0,0 +1,30 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Toggle enable. Write 1 to enable toggle or 0 to disable it. This is
> +		useful when one wants to change the DAC output codes. The way it should
> +		be done is:
> +
> +		- disable toggle operation;
> +		- change out_currentY_raw0 and out_currentY_raw1;
> +		- enable toggle operation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw0
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw1
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		It has the same meaning as out_currentY_raw. This attribute is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in INPUT_A (_raw0) and INPUT_B (_raw1). The same scale and offset
> +		as in out_currentY_raw applies.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Performs a SW toggle. This attribute is specific to toggle
> +		enabled channels and allows to toggle between out_currentY_raw0
> +		and out_currentY_raw1 through software. Writing 0 will select
> +		out_currentY_raw0 while 1 selects out_currentY_raw1.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed00b364..fba8bacc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12843,6 +12843,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> +F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
>  
>  LTC2688 IIO DAC DRIVER


