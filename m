Return-Path: <linux-kernel+bounces-31707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09958332C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7478E1F22A13
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA417E3;
	Sat, 20 Jan 2024 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="aT4JiWn4"
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08736A;
	Sat, 20 Jan 2024 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705725431; cv=none; b=VR2qUn5M/9r5XsNjBSIMkz3r9BOT2MFc1YMb6+nD70A1MrfigQmgWmdRVMh6WJtVnadfzcE0s1e3szhU1chqjcji2Y1rJv5I8WEUoCNXiw+TZXfCmFL1th3hSnRqvORN/DT+BquFGp7DRcEEcZdbv4zHvtOLIVr+omi+Usu5XFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705725431; c=relaxed/simple;
	bh=XEw7823O5LqS2hF1lp1TtGteA/BryeDe3lF+BU05r5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdKHwpX+C4nvCibuStqvrklOq6Dc2Ctk4NdblkyudOVNUlaZx33a2jH2TklyeRXUHbQhxfyigvmwnjHD/0wkP4f04cmVljaU1/Cw1xvBeIRMBXMOzh65V0F9iiV1URxaqhpGwg5dwJ5cN9Ei3P2lwCgR0yK9DiMPfxl4SKDjgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=aT4JiWn4; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dX3n99dwnlf1UVqc9YuiAXdd48/uChXRpSPlAKrbBeI=; b=aT4JiWn4o5hoWke1g5urtgkZWH
	KX0r0UO+sij6S6Fh7g6sEXrHmEhl94BRjpqkqLyOCJBlhk6jn5+1UOfvbsc++OWtWCmmCstHEAbQy
	pVro1Irih3tyEmW8DenMZoc9dmOhTYgbYJwV3AP68yJIt3ebHXbd1VRWmgypk2Lli3We3uaOq9THw
	GhEozdfg0G2nGfVV9EkEJ8lc8xU223E8AFy3LNYI+0RYtInrAvDij/d9flJZD8Mf95urdjb0XAmI8
	P01eYis55Wm9jz7Mg1h9U1FPs+NfAQjaQGplGmGkNyVRtUHBagsdHFoEVK7rVrTb0FaJbty9JbufS
	a28f1iWg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1rR2nW-000Nax-9C; Sat, 20 Jan 2024 05:17:34 +0100
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lars@metafoo.de>)
	id 1rR2nV-000Jnb-QJ; Sat, 20 Jan 2024 05:17:33 +0100
Message-ID: <d9a84e5b-9e23-4aa9-8e58-0bb9f2b224d7@metafoo.de>
Date: Fri, 19 Jan 2024 20:17:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: humidity: Add driver for ti HDC302x humidity
 sensors
Content-Language: en-US
To: Li peiyu <579lpy@gmail.com>, jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231211122201.9598-1-579lpy@gmail.com>
 <20231211122940.9791-1-579lpy@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20231211122940.9791-1-579lpy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27159/Fri Jan 19 10:42:03 2024)

On 12/11/23 04:29, Li peiyu wrote:
> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
>
> Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Signed-off-by: Li peiyu <579lpy@gmail.com>
> ---
>   MAINTAINERS                    |   8 +
>   drivers/iio/humidity/Kconfig   |  12 +
>   drivers/iio/humidity/Makefile  |   1 +
>   drivers/iio/humidity/hdc3020.c | 473 +++++++++++++++++++++++++++++++++
I was just trying to use this driver. Somehow the Makefile and Kconfig 
changes were lost when the patch was applied to the IIO tree.



