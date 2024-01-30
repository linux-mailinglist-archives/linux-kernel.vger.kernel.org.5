Return-Path: <linux-kernel+bounces-44917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7E84290F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CFA1C25930
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110341272DA;
	Tue, 30 Jan 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtiDi4AM"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606986AF0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631944; cv=none; b=Y4O32t7+zi5kpXa0Uso8GdRe55MV04QgYuAPgkEjvJCovrqGhgq1fQsFBRe9N1kmGQMwUZHobpzXDO0MgykVvLwRx3W0fr7az45cAm05EjN5HSgFH5b17OJx/01ulJk/JV3fglLqydmJhYjBgkQuwJhHj9sGDLWA5ZBarYBdOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631944; c=relaxed/simple;
	bh=jjHoV2plujQcWWRAwaj2OpXn0x+glX/DFtpC9zjFYPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV37itVXX2Q5yzgS6lyAVZH7mZ9x7gVsiISkJqNZJw5Y8ns0D9RkuzyVYHTVe/PnAoB2/yi9Hmlwczemfxocie9F/IQarVvhkPUfdAeogoGrkL7hec1uJCluQyn618lg2Ncn9nNkWJ+pOPrQQsn/WqfCFvPYlZJkhLnGtzkCiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtiDi4AM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d05b06b5f9so10826341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706631940; x=1707236740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx5LK5cIWTZjcQaikGkUtTQL7dv+9ckkh97t67Efamk=;
        b=JtiDi4AM8fIdXt+7VlKry5tvyDOXoOxeM7KGTV/u1WA5l9P8TDg9+dAUdRTq0C6ad/
         DJfsiWxvEJ5JuxUOa8r6e0g7qwNaEL1Ues8BW8KAKxaNojS1uV8hJ37EVmdAGYhgBAMR
         D/KkaglftOsFQUJapODJb1FHgonGszp1MAHUn2j19LH7+b/awO4pm50Zmc2dt3lNBlUZ
         2Fv6AuhjrQ1YS+MoQvJ5RCMoihNzj/wcmof/lJ303ZyG1FaI8+HCgSOxlGJpz/yCFKLG
         DHqsdYXTdz24SMWsPN8P3ozmGoykUz9V4h/8fWvoSbDuqoEsjXnLuxC9mq1devOo+TSm
         aHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631940; x=1707236740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx5LK5cIWTZjcQaikGkUtTQL7dv+9ckkh97t67Efamk=;
        b=lKEzNuwzku05Lua78vZ6mSffsQq+LNGtfYmmvWQVrFeLqMNSFcIvFeZZyeA7TeqH0H
         6sxFVY7f6Ov1H3UZNtwy7RVmcMhfYFRMlcvax6n4oROc9m3/0pNLUm0lEduqZQHdUNXh
         KwAIxotKQjfN4I8IhhO7be21cwrKF0cvHaTWG5kDgPpXphffxPkuC4+blq01IWUQ4Ipb
         Od8zt59fGZE2QmlmkdmGa5PwMmUypC/Qw2iiGkPyjrW8AEO+GMRaaWK60n3flgP+NZ6I
         mlhV1qE/8rI8Xbn5wvz4fuLYF28hRI3p00L8obAVWNpLaUFKI9+jmxPThueJmqS7gWvZ
         IJuA==
X-Gm-Message-State: AOJu0YzIaiYc0AnqPnxIUmC9DAk9kW1cQpbDYe4nWvS3xAij/EuJp7Aj
	RcSvtajbVu4KDefvptNoHS11ImRegJ3pYpnp5PKowI4Po+JNCdIr0lbf8cR07cI=
X-Google-Smtp-Source: AGHT+IGKmoGuj0MSsy/jyZO/UQZpGItSPG3/U4Kws6CIORIhy1+vliz1pR0tRfJaLsxxA8skGzJcqQ==
X-Received: by 2002:a2e:8552:0:b0:2cd:9f2a:1450 with SMTP id u18-20020a2e8552000000b002cd9f2a1450mr5579437ljj.17.1706631940254;
        Tue, 30 Jan 2024 08:25:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbt3+Bvs+rMDJrQfc4XovjpQSFvjOLVIDYT453/Fk87t14svX038oR2EttdIorcfJ3ZC+KXpajNm0Ln1Ptslbi7/6y1s5rew+bPKD84ODVNjOERPT1mX8BoWp+PBMHPGT9rNhMSO43orpcII3IBTQnBsn5R5h2r+D954t/SRDMUnTXrmpsE3ven9TfvFmFvZGZoeDKGX8Ze1pltFBYVj6ZQDQnaA7quAuYnssQ1Mv1eiac0Zviyql8BaXSBavqDJvd4OVotHGswsuGcY9dpYli3MGfIGmAQJieddCAcIHyEOgPyTV683RMedCmN+7PVnTTUCW5JmojHoeNnLLJzhMgZ9HsF+vmye91n2pmjipffUe9r6QhFyF7D1IWhxj5mtTaOUhq76jcTEuyia29cvKTan9+nCO7uPEBKGy3CZwh2iIRLiEraeQRYqHgOG5lAjwqKOb5/Tq5THKfXpcOlDv2goJwNYOiOzUJ0bZg80CEkZzjl/Wzl/oaj0jnjX7iNWAZ6EKwhEGB+8ak1Iz/GupL1fsbK5fSUGU/3qStMNAorAolyZNCHg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id c8-20020a509f88000000b0055f43384da2sm763543edf.56.2024.01.30.08.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:25:39 -0800 (PST)
Message-ID: <78241d63-3b9d-4c04-9ea5-11b45eac6f00@linaro.org>
Date: Tue, 30 Jan 2024 17:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
 <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org>
 <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
 <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org>
 <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 08:47, Chen-Yu Tsai wrote:
> On Tue, Jan 30, 2024 at 3:37 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
>>> On Mon, Jan 29, 2024 at 3:34 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
>>>>
>>>>>>> +allOf:
>>>>>>> +  - $ref: bluetooth-controller.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    enum:
>>>>>>> +      - mediatek,mt7921s-bluetooth
>>>>>>
>>>>>> Can it be also WiFi on separate bus? How many device nodes do you need
>>>>>> for this device?
>>>>>
>>>>> For the "S" variant, WiFi is also on SDIO. For the other two variants,
>>>>> "U" and "E", WiFi goes over USB and PCIe respectively. On both those
>>>>> variants, Bluetooth can either go over USB or UART. That is what I
>>>>> gathered from the pinouts. There are a dozen GPIO pins which don't
>>>>> have detailed descriptions though. If you want a comprehensive
>>>>> binding of the whole chip and all its variants, I suggest we ask
>>>>> MediaTek to provide it instead. My goal with the binding is to document
>>>>> existing usage and allow me to upstream new device trees.
>>>>>
>>>>> For now we only need the Bluetooth node. The WiFi part is perfectly
>>>>> detectable, and the driver doesn't seem to need the WiFi reset pin.
>>>>> The Bluetooth driver only uses its reset pin to reset a hung controller.
>>>>
>>>> Then suffix "bluetooth" seems redundant.
>>>
>>> I think keeping the suffix makes more sense though. The chip is a two
>>> function piece, and this only targets one of the functions. Also, the
>>
>> That's why I asked and you said there is only one interface: SDIO.
> 
> There's only one interface, SDIO, but two SDIO functions. The two
> functions, if both were to be described in the device tree, would
> be two separate nodes. We just don't have any use for the WiFi one
> right now. Does that make sense to keep the suffix?

Number of functions does not really matter. Number of interfaces on the
bus would matter. Why would you have two separate nodes for the same
SDIO interface? Or do you want to say there are two interfaces?



Best regards,
Krzysztof


