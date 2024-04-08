Return-Path: <linux-kernel+bounces-135900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B011789CCDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EB72851A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F9146A8D;
	Mon,  8 Apr 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ps5hVdF8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF31465BC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607157; cv=none; b=CcEDRgNr1fs4DCCoS+G+o+OJ2tK5sgi3mr21xfXTIZQhsJ8LN9iYc4Q+y8bhUjMQhgs3uCAMh+gLjEWrZrNzz0W31aoUKC2xqfIAcTgk0LBJcf1W6JPZeVlC3UkHdKabMiyJ1X4GGX/5I3FidWgRRxKaANxSqYOSTgefVFNe69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607157; c=relaxed/simple;
	bh=NVQtYSBEG2pxUndGJuSJkOztjdgw9ulw7xh2JSYD0pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s+eRnaXvNCHs+1F54QJXYfO+nSzGcYKXSQLA8Sv9tl3U04ys2X0ogtKy07Hk4bCd/j/XlQZBIujhoNnaccjRg29Z5+t22dzY3IcgcIXMME2A9zONYy2hiDe05C0gef1uZa+IE/gNxDYPxkb0wGAXkeeE/MhVdBFJ94G+JmOkis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ps5hVdF8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d6898bebso3565337e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712607153; x=1713211953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D3WZGoA5s1Cdk73nMnJCKpNMxCWu21VuKqBPTiSrXo4=;
        b=Ps5hVdF8YL6UnvMHMNVBaJYZR4tHhh/q51Fk92jJAZYUqA2Dm8h9Aa95oFleIZM/vV
         B49DXzYKL7Vhks468kNPZxQFVBLXtMXC5pBythHDQyFGJme6zi2KknPLaKfuf4hF2U6W
         ZyP/5MXEDhymltmM/vYSlA2TT05XsMzTTcCBRzjJFyK6Q1cI8JzMsZJ3VovIx8Jx3Bd6
         WiyTxhN9jenFl9O9jwOYl2MKCwzMLNMowQ0EV8kitXEoXaN1IJojNhpqOplnZk79uMQ9
         ubJkZnJoqQYbkJUfRzC3e/0FDZxG3a5U69lKF5bOb/wkMXphHnNrZIhPAtg5GkyN4mvU
         wBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712607153; x=1713211953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3WZGoA5s1Cdk73nMnJCKpNMxCWu21VuKqBPTiSrXo4=;
        b=ViUYX3mBoctaAwgUqBgGJbDwR/ab7xzb0mKTCpPFs/FaKsQZvn5nOMoI8EHDcXRd67
         Aka7wFVea36f6XSGi/Coy/hUqoZSvMlONR9MPRZ74MaS0SiBs6WYI6bn4kEtYk1R1hOd
         Hd8mOSxUybCwOmmjdo/lBTHNGzUWtacUUV0OKCkpFu2MOUwmKCJi2vxT5J5WWBvzw5RM
         i9LJIS2saBDkMLUvPmoxNo1K+fedX8k/bg//dNAqFHq7T7I9T6Xy2voqmQkdmVoBf5Qv
         jEKfYoTY5w7LuOuSkS0sRUoiyFk29onzpWl2QfqPulGpZAbqlq1GkloHUimskPl+sy6e
         G3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWj2V6Xor/03+rWxubSXJ8pDWOXa0QZnhHvpNXnoB+AtcghdS73MEXkMPrb5qzs0bUpTZyAC5TxxwNxITd+wy7E92YuhX4MUil+k0LJ
X-Gm-Message-State: AOJu0YwF4u9hQUmfbVYzI+XcsDpAK6goz3nO1eqgANLTvoMYDnvPwC8v
	OXsio/xh8uslfcXD/q9Z4zzig02xey9S0xtPJvabQsdwDqK1SAryaVuKXusQQO0=
X-Google-Smtp-Source: AGHT+IG2W2zaknbzAY47gOd5Azp1rY1fNswZewy/6JZJGK07p5lhNS0K5dfBr87ujo/gmLS3TlT9Bg==
X-Received: by 2002:ac2:46e9:0:b0:516:bfd7:de92 with SMTP id q9-20020ac246e9000000b00516bfd7de92mr6862950lfo.43.1712607152799;
        Mon, 08 Apr 2024 13:12:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170906e95400b00a51c5940247sm2834929ejb.213.2024.04.08.13.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:12:32 -0700 (PDT)
Message-ID: <97f2d38d-c863-4c76-91f1-52cd250759d7@linaro.org>
Date: Mon, 8 Apr 2024 22:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, Pavel Machek
 <pavel@ucw.cz>, phone-devel@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de,
 martijn@brixit.nl, samuel@sholland.org, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
 <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
 <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>
 <e6vvuttix5k5fioy7q44ick5wj6u5gleh7mht36s4zjjcym7vy@bziejyohtc4b>
 <7976e254-ed1e-406d-870b-1ecdc4b1e23c@linaro.org>
 <uoo7xltbfx7u6iai7urj3wez7cwotokxt6lwjhff57xbljusqn@fr2xejnrlak7>
 <1502383c-9caf-4362-8bd6-ed719a304f08@linaro.org>
 <vbo7bacecuagu4qzrr6tsdh4qlejrv7ia67yylf6ay4u7qnwge@kqj27bun2m7d>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <vbo7bacecuagu4qzrr6tsdh4qlejrv7ia67yylf6ay4u7qnwge@kqj27bun2m7d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 17:17, Ondřej Jirman wrote:
> On Mon, Apr 08, 2024 at 03:27:00PM GMT, Krzysztof Kozlowski wrote:
>> On 08/04/2024 14:48, Ondřej Jirman wrote:
>>> Yeah, I understand where the confusion is. The driver is not for anx7688 chip
>>> really. The driver is named anx7688, but that's mostly a historical accident at
>>> this point.
>>>
>>> I guess there can be a driver for anx7688 chip that can directly use the chip's
>>> resources from the host by directly manipulating its registers and implementing
>>> type-c functionality via eg. Linux's TCPM or TCPCI stack, etc. (eg. like
>>> fusb302 driver, or various tcpci subdrivers).
>>>
>>> But in this case the chip is driven by an optional on-chip microcontroller's
>>> firmware and *this driver* is specifically for *the Type-C port on Pinephone*
>>
>> We do not talk here about the driver, but bindings, so hardware.
> 
> Got it. Bindings should be the same regardless of what driver would be used,
> whether this OCM based one, or some future one based on the above mentioned
> TCPCI in-kernel implementation. Hardware is the same in both cases.
> 
> Just trying to imagine how to actually solve the issues...
> 
> Basic thing with the I2C regulator thing is that needs to be enabled as long
> as anx7688 needs to communicate over I2C. Other user of this power rail is
> touchscreen controller for its normal power supply, and it needs to be able
> to disable it during system suspend.

This does not look like anything specific to this particular device...
but even without this, please think how you want it to be solved. Same
supply which has to be on always, because your anx7688 can talk over
I2C, and in the same time sometimes off, so touchscreen can be shutdown.

If this is regulator for the I2C bus, then I think we already had this
discussion some time ago. I think it is not a property of the I2C
device, but the controller.

> 
> Now for things to not fail during suspend/resume based on PM callbacks
> invocation order, anx7688 driver needs to enable this regulator too, as long
> as it needs it.

No, the I2C bus driver needs to manage it. Not one individual I2C
device. Again, why anx7688 is specific? If you next phone has anx8867,
using different driver, you also add there i2c-supply? And if it is
nxp,ptn5100 as well?

> 
> I can put bus-supply to I2C controller node, and read it from the ANX7688 driver
> I guess, by going up a DT node. Whether that's going to be acceptable, I don't
> know. 
> 
> 
> VCONN regulator I don't know where else to put either. It doesn't seem to belong
> anywhere. It's not something directly connected to Type-C connector, so
> not part of connector bindings, and there's nothing else I can see, other
> than anx7688 device which needs it for core functionality.

That sounds like a GPIO, not regulator. anx7688 has GPIOs, right? On
Pinephone they go to regulator, but on FooPhone also using anx7688 they
go somewhere else, so why this anx7688 assumes this is a regulator?

You need to properly represent the hardware, not bend it to your one
use-case for one hardware.


> 
> ANX7688 chip desing doesn't have integrated VCONN mosfet switches so it always
> needs external supply + switches that are controlled by the chip itself. There's
> no sensible design where someone would not want this and the driver needs
> to get this regulator reference from somewhere. The switches are sort of an
> extension of the chip.


Best regards,
Krzysztof


