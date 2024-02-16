Return-Path: <linux-kernel+bounces-68512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD607857B79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691891F25CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA676041;
	Fri, 16 Feb 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxUdRPjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E9745FC;
	Fri, 16 Feb 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082494; cv=none; b=ubLdG2jy0jwgRSRCA66Q5mY50Czhk/aDLZhHHV+kurQE5nvIzCTFhyCfYMsP7gpH2JX+j+DJswI/qLxG3BGMQ26cHIvNyo/DQtRVyIWUueR6X5qvzwdqlpdKvFsT2mW10dNyRAcL6htzQ08TP0K2zWVkWDtheqtL6mzdcTcQJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082494; c=relaxed/simple;
	bh=aVpk1bSJsLIq7ztumwPZSfYOkIuBqVCeY6+wAlHv8tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvaztnETwBIWYNVinHHm+6vfFmo2n4FPy+4aUwX7cOoxsWyax59TRz/bO4KgfheMjf88ZROwLIFxcLSQQUDzchDrcIoFYl8WT7tYb1joNPzsBw9Pb1DHR7RwB5obnLd5WTMigDuH9OAQjOKC+01xolNzJOnq6sjp8fRRK84856w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxUdRPjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B72EC433C7;
	Fri, 16 Feb 2024 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082493;
	bh=aVpk1bSJsLIq7ztumwPZSfYOkIuBqVCeY6+wAlHv8tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dxUdRPjlGgS2WV0HpieRofNjFNwNkr5DCLeJJsV36UWRPPa1XH8SfdxP9PFx5sIno
	 7MqecM3bmaY1RVdJirWs3eZMlIDj8WhSO39xbdlo6garDVsKQQnCjtFagFnFnJ3qZx
	 Y81IdiZI2ER/H4uR7D0jjb/4OTFRk4qNmgE+3wMI1YoHmzvPVw3sM6WynQhgNUqPTu
	 RzpbXuinXPUUzq5HxANuhVbESpMSHxQ2tGcZ1NZW4yoXzbLOK16HJQSfPyFE+8w+2p
	 etxNVfxf4YDzcQIhrmnn9w6wwqqh2JWKhT8Q4ybG6Gb1kFf9lP/EUlv2dRb3WwEFdd
	 6NnaeAv24+S+g==
Date: Fri, 16 Feb 2024 11:21:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 thomas.haemmerle@leica-geosystems.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply
 binding
Message-ID: <20240216112120.76a0c0ca@jic23-huawei>
In-Reply-To: <20240216102820.1395815-1-m.felsch@pengutronix.de>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:28:19 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> 
> Add the binding to specify the vcc supply. We can't make it required
> since this would break the backward compatibility.

Given convention for supplies like this is to make them required in
the dt-binding to reflect that providing power is not optional (unlikely
some other supplies that might not be wired up) and not worry about the
fact that we happily provide dummy supplies for them if they aren't in a
particular dts, it should be fine to make it required here.

Jonathan

> 
> Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Resend since I forgot to add the DT maintainers
> 
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 8c6d7735e875..cf7799c9734f 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -24,6 +24,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vcc-supply:
> +    description: provide VCC power to the sensor.
> +
>  required:
>    - compatible
>    - reg
> @@ -39,5 +42,6 @@ examples:
>          tmp117@48 {
>               compatible = "ti,tmp117";
>               reg = <0x48>;
> +             vcc-supply = <&pmic_reg_3v3>;
>          };
>      };


