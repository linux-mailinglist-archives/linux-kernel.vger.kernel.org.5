Return-Path: <linux-kernel+bounces-104873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B687D4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1358FB21C64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9865954737;
	Fri, 15 Mar 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCAq2gkp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FA5473D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533810; cv=none; b=J716Fcyv4jlSP/N61DkpzgpVsH3clndNPzncuMSDzEhHdj5ei/UMnvh1aD+Z6EgqzJE0GR7ueIELrRuoAH6iBJcDqbHDVLNzFuYCbZNgK4KiS27aTu0Oi5LVLmctaVAFCOCHga/fKgW1n6znumDycBnxS1LWzQQpdLEDXXyXBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533810; c=relaxed/simple;
	bh=9aTVDExRdXWvwN7G7Eo4D2nVBxrprfJWymNfNXN/Ci8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzZ+bBdmDFVrGjMxZ2KT6QGsAzqVsdQTVtdZO26c/uRTrTMctwSi+NRkcgcEVeCGBpVz56OiDfZuEcHNfzSgRDzJT9MI2NNRTtJ6Q0QRybpQ+i0EUja54NfPFYljefv92Id7I9LSuHeZMNpQBR64fFSWRHnpKlsRvonvv6rHulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCAq2gkp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d3e57518so2372103e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710533804; x=1711138604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBxlSXrDIUeEZ7iizn8awIR/ya/+nU5wVcONbsK/8zI=;
        b=NCAq2gkp9LiHzxSbgR7Fy9h3S/c6pBTBnLI+0/Z93VgwabRSNYvf0af5JOCLEdMG5k
         HaKB2Gd/fJ7Ak56GseCTQ0BAlleASn09aC1bu6wp5wzk19B28IaO9UyxlkD44z2KrVEp
         Zu80+qufLu4mBBs3k+NB29bn3VDvX71nJSk8s0gf07I4SWch+NjPDq4PZkkMeIReQWCH
         Lb82SQ/9bS7rCZK/2JlJ1sdPStG9wAhzXmYEaszc3GfEe9MrbOiBwRiuoG8aYCdqBXKV
         82fqPLxqPcIPBdoZleL/BO/CPYYeIiW2vxUJR54Wiou6h547mUkzKctHSVQifzr6Yg0m
         Slrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533804; x=1711138604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBxlSXrDIUeEZ7iizn8awIR/ya/+nU5wVcONbsK/8zI=;
        b=lhSXryQoKMYPqYTFj31Q2XwvOtKry94TlkJSUxxfkCNyVZjZCTV9tYiGktDj1XywjQ
         GfN7TlZombBOYC2pRoEpbtDvHixQMUeImhB5xlBOhEx0iRbFBOzzfq7VXNXMaKqVvXgK
         QwvPJdCUZwSJJVKkMnA8oODANUwpbCNwhjjpm6Te3RCpGEALGsNqNaoNRxC9mRoD/XOc
         Rn6uSYu272hpJvNHDiMfVS9FjMgwRMgD1cwzUfUn6zNSkcZrzRH3inzEgQfe1Krx8yPh
         2HzrBpsvUPwXzfRWrzkYhwpD/Axm4NS1YiJHn+lolUbZHYg0iKegjdoo+dQMKDlPKSBW
         uG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGAWIc30JlkpOBe0lzqPAnV/Zpuf271Yi57hQF2hJmCYmsgA7EZGjf4qU6sFyMq87ZUS0Wwa4R3xA5f3G6PPF/2h4bCeQG9/5sb2tZ
X-Gm-Message-State: AOJu0YxSUVeGbUTc1Nym6VRD6E3Ly8hbM1a26/7pcuVMOAqk5XG5oL0m
	F7LjIhy4Qcsxj3LAGbfWMGo+KgZcdGYSKJEjpNtDMikvosSqnE9y0+XyhpoXypw=
X-Google-Smtp-Source: AGHT+IGJVvNqj73VhU6LSycjUX1baoHaIGvPqGQeLn2j+8zYNxKplG8ui654YHm2M01GsWthY0n2dA==
X-Received: by 2002:ac2:4c38:0:b0:513:8a02:9e1b with SMTP id u24-20020ac24c38000000b005138a029e1bmr3213172lfq.35.1710533804439;
        Fri, 15 Mar 2024 13:16:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wr6-20020a170907700600b00a4623030893sm1976885ejb.126.2024.03.15.13.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:16:43 -0700 (PDT)
Message-ID: <105dd240-a9c5-4767-8f43-3a63be0b2a5a@linaro.org>
Date: Fri, 15 Mar 2024 21:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] serdev: add of_ helper to get serdev controller
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: Vaishnav M A <vaishnav@beagleboard.org>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-5-ayushdevel1325@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315184908.500352-5-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 19:49, Ayush Singh wrote:
> From: Vaishnav M A <vaishnav@beagleboard.org>
> 
> add of_find_serdev_controller_by_node to obtain a
> serdev_controller from the device_node, which
> can help if the serdev_device is not described
> over device tree and instantiation of the device
> happens from a different driver, for the same purpose
> an option to not delete an empty serdev controller
> is added.

Don't make it difficult for us to read your commit msgs.
Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 19 +++++++++++++++++++
>  include/linux/serdev.h    |  4 ++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 613cb356b918..5b5b3f2b2e42 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -555,6 +555,19 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> +
> +	if (!dev)
> +		return NULL;
> +
> +	return (dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  
>  #define SERDEV_ACPI_MAX_SCAN_DEPTH 32
> @@ -785,6 +798,12 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>  
>  	pm_runtime_enable(&ctrl->dev);
>  
> +	/* provide option to not delete a serdev controller without devices
> +	 * if property is present
> +	 */
> +	if (device_property_present(&ctrl->dev, "force-empty-serdev-controller"))

How is this related to topic of adding helper? Why are you adding some
undocumented properties?

No, it's the same in other patches - you combine unrelated goals into
one patch. Please read carefully submitting patches document how to
organize your patchset.


Best regards,
Krzysztof


