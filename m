Return-Path: <linux-kernel+bounces-63158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20488852BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0012284BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1B1B598;
	Tue, 13 Feb 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="cWUxlPWk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC1224C6;
	Tue, 13 Feb 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814374; cv=none; b=JnRNeRHCXNRTodabcPOdwcwdMx4XxC4lYKooHflyOspenaabNV2bkNL7hUWQKnM142wJVGYTDWsJuik7qJo96xefr4qKjqNdFdajBwvlYeTfuj4BMFK404zmpabKF8jo5O88mff9MtNzaEqilOSHX5AGdGhGTb5/zyytRZjUwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814374; c=relaxed/simple;
	bh=hd1AvOuOlZBHBqTRp39Wkr6DhdcKty7DtCe8l8y2b3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCookVBTwGyUvAJBGQtUK6kJMBP6KWPDofPw+KgtTBIrcCMCjETnnS/rYuB5DIQDyTc4oNOqIYJTq6ZI3kEKDYaxfupqzXOoeDaXFdcWQb/kabKnxY6hx3J+M5VzEewNZ72wDVLxt0izJhf42gxkCIgFgw1MzvVRNPh3ITmsE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=cWUxlPWk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707814358; x=1708419158; i=wahrenst@gmx.net;
	bh=hd1AvOuOlZBHBqTRp39Wkr6DhdcKty7DtCe8l8y2b3Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=cWUxlPWkI0/9xTfruG+N6LCyJYghvtIrJuszr4L0CkNRE0TlJKdyt72j/f8MO/Jr
	 ca+q99WM9rAuL5yCd743rIli1ZvpnHGLxvYM3QXm2lGI0CYorQjRhHrQQpXaGfqQM
	 eGrpR3a9c/JWdOIzssiatbKFVMiEuQqeqsfTK3hNIUhIlsKFtg5QzOHIclepWhWV6
	 LO9wJWLDp8R3OpxNHGEOTpdmxposMU1Q4sUQeS0ir/8RZR0kyelWRRZq8xLF8rres
	 qnuSABq+9HgvwqKgmumi7uOr6KKQOgdj4LwgNwF3RebztPedRVoO6gy14w6PoR9ik
	 HXOy8rAqy2MMG9gNMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1rCXwB082X-00qDsP; Tue, 13
 Feb 2024 09:52:38 +0100
Message-ID: <bb7eccc2-a821-4326-b071-2f8a89038dd7@gmx.net>
Date: Tue, 13 Feb 2024 09:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/14] ARM: dts: imx6ull-uti260b: Add board
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-15-sre@kernel.org>
 <c38e7c68-e725-4174-aa0a-0594a55c8d56@gmx.net>
 <56eb2fnpmaya5rwfk5jvluvsidokzpoujeatihgrbxlytbzx5x@ozco7pbgkugp>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <56eb2fnpmaya5rwfk5jvluvsidokzpoujeatihgrbxlytbzx5x@ozco7pbgkugp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QwGYrtJOh2GSob57qG1BTL4524eNR06439bHtY0/90JfT5NIu84
 vxLrtONRTylt/pdpbEkXnOBuFv/qRTzSMEHmzzUQOpK+y5jNp8Jr2EnO0dnruk++dNsakfx
 SbLvrVbpLkrnM4PBLM1YtyFNDZrP5hHqkU/oiXIOCdmUFMiow74S0lHopY49FriUKY2+jrx
 aoR2ACHBxTPg+2nR4t5hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hzP5LxJpaj0=;JcejgMcwxeIaQkcltr7ilZz32QG
 UdjUQAkloUWOCgUaIJPXHfppTNiwOkbZtGjjy+3uz40QAv2KuFeKhANogM7kJXfwjqgSYTwX2
 yJ0OnmJdjc5o0koikbirLv0qUoPVbGNX9KI5sdC1WMw9fUba5+Vyy+rtzUJKw3FveMF1RSLVS
 JaniyBhGY0YJIjXdZa6fh4qlgM3pmolG8buFz9KIQ0fGLGmfcqtMFWoq9d3ZwzdXwrc6mCn8c
 vcXbhiwMIM50ZW0INa42ygxNJEMkzrUeiuYZnnRvW/AYBhEuheS8KHdknPjxUXLLoWO1a2iWc
 BmSqnpKiOg1UIWYQNtkspb1GaxF77s+xILaO3tm5E/YVIGeNM2+tsXdqzPU5uhuddOLoHIiUo
 KkRbIaTRhLWKj6y4+/4d7oamEKSGsFEEKOOk2JeOf7wJeb22JsYwlwfCxSxs7uCVDx+42FS7w
 bdMrMEDfb7kjesJWPW4I9HNL34BloUWYRLJER5UmMB4A5wy83zy3QBZ9U9wJRoh1xQD5EFDtg
 1UJrevt652XGZ2VNAalb+hxSccZPLQ6o7ylMWWtcEdHiVghu6KmeB+j+eh+lbT8s/9Q1bXbHG
 vXzU/u0Bk+BsoxID6zeNsWijsWzfRI3zjWD+b1J9k/2kYK6rkYyJVsi7hQLUM+JuJlsuNv2c6
 3rskaLXA0PRW/MiBPB79Bpa4a7Ku035md+jEyIhmyrcnqPj/pLoHCfiCYlAyNC3wjcHGEgoZ0
 9ln2+M84j8KiJYraAs21mDxZW3uHzNZt6cuatdnkfaLkHXBAjp7yJwu55ji18Hq+A8B8IqfdA
 0gNlYlglsPCgaO2jSNPxt5+AgYO3EUA5Pnsb7vNPWBVzE=

>>> +&ecspi3 {
>>> +	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mux_spi3>, <&mux_spi3_cs>;
>>> +	status = "okay";
>>> +
>>> +	panel@0 {
>>> +		compatible = "inanbo,t28cp45tn89-v17";
>>> +		reg = <0>;
>>> +		backlight = <&panel_backlight>;
>>> +		power-supply = <&reg_vsd>;
>>> +		spi-cpha;
>>> +		spi-cpol;
>>> +		spi-max-frequency = <100000>;
>> This seems slow to me. Is this a limitation of the display?
> I just used something slow, which should definitely work. I will try
> to increase to 1MHz. Note, that the display is not driven via SPI.
> SPI is just used for the configuration.
Thanks for clarification. Yes, 1 MHz would be better.
>
> Thanks for the review,
>
> -- Sebastian


