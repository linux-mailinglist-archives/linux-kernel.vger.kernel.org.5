Return-Path: <linux-kernel+bounces-135296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C789BE90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47A1283891
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C46A8D8;
	Mon,  8 Apr 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2lVjeFS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC66A325
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577676; cv=none; b=FhvwKESvS5JvkCWNRuOKXCf0vzOrz8UzyfUFnqzJg20CaUNrLRfe5P5mRNzRxSL7BrGQ05PLORDKhTYV0w3ekgzv0LTkSzw3GJS/f39rJKfmkYZ0KgfmBRacRFEVuNJnhmQDqOzBP7KkfBQQZRHionEwwdxikJMJhakVsjwoAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577676; c=relaxed/simple;
	bh=Jp1lqU+Ps4+pwsRUu4Ay0uXR+ZlujK7vY3phzerhDlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aDa8mhsIAbIscaz9xKR2DlgkiiSN0AvVdbuKGhVzk8kKrgi/a8RzOD7+qXwSS1FFkNMtlwufddhgvNqm9viDKYC8d3lpBw0RFCh14cyF5LfnDAYbjvF6teqNt7xZfrl8Smq1lCS/sQo6ykIzjuGeQ/VKfqkOF0GFxN+DvrbosTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2lVjeFS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51c37a5025so195966966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712577673; x=1713182473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=deF3TVXhftcnwVqJvcDn53aPCb4xZ8Uu1FNRBk9s6Cc=;
        b=q2lVjeFSFBY5e86JEJ8RbGAgjjbXFeKF2gkYeT30O+oqroovQuF0JmFkhaXxVDTfQZ
         LLTzspWgV3LjJJkRDf5E8IIE4Ns/6xqOSjdkH+Dm2ib30WgDny4OeW1Ydu4kHfNVorxX
         LvNFRaFDB+a+R6KTBffgdaC8VFMRBZmH8yk+CS5sdaP1wBLE6rV1LPwzHPcfgcBs/gBc
         8nkYccUpFdLcsAaiuR8dmlP0RfDxCvWSCUI1ElDVaqKtbmxgG+xuEZf65AeedMD5dHfo
         szAdDcMFq28LuZ1jjBW1Ix/0Zbfy6pjDGEWlLNUBLvf8zHh6sr1oCjN25T8JdoJs0nTC
         jc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712577673; x=1713182473;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deF3TVXhftcnwVqJvcDn53aPCb4xZ8Uu1FNRBk9s6Cc=;
        b=oG1fg2v32xVOKwaNyaTVbD75W2e2Kt8a9a/ud48e458xDPpRgxcl4U43AA7VcVJHIU
         ly6RN6ZaB4DYRH/WJFng59/0T1uG/Jda/ZVEqT0ynoHu/effOfXUBsgy9Tvw0rqHC2U3
         xCUVd2KXTC4DynrRjztXE4Y60HBiWPVq+16jIldao81QAww/7EI7n6F8KB3K/nwiA/wN
         2YIQUnmWeTa4PvmhRLWbyEPdoEAKAk81/wBoPRzyX7DOs7oqe0Y5Dde44KbSea/vVcPf
         cjTtkRVJviEeIrbunj+nArKigptUrpkgNKMiTWQScfHbWj72zU1fOSH0an+RAoVrDrqM
         MvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7+XwSolhoFChj/mnK7/41OWqlsBQZDKxPbLw2OOU6MpZ/BjkegqqGhXkDE2zCE6BK2dsf+isEGnIkbOkDPMMRzkELIPM7M2CSA6s
X-Gm-Message-State: AOJu0YxlELi/0RNUL6RpCp3RiYRixeyePjvhxEyyohT7NRTpwBdjz9CW
	VrmexPT1JU/43FYJ3jIbuWUf87E5s5P8B6zvQ50HayqzkN10/Pmo9o42rdikl28=
X-Google-Smtp-Source: AGHT+IHyhxp5xxrUMAsHrBGLaoPNqXCnKRkGYBpRJOGi20ZJoFezwFTy3W2h0vLDKdQ5ImJ2Q2oXcA==
X-Received: by 2002:a17:906:bf47:b0:a51:cc20:9116 with SMTP id ps7-20020a170906bf4700b00a51cc209116mr2774047ejb.68.1712577672724;
        Mon, 08 Apr 2024 05:01:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a51def4861bsm564112ejb.91.2024.04.08.05.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 05:01:12 -0700 (PDT)
Message-ID: <0dd237e4-70e7-4dd4-8173-2e7290ddfbac@linaro.org>
Date: Mon, 8 Apr 2024 14:01:10 +0200
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
 <35tqaktf533qtpaquvzb7p5juupjyakktstlqgr2hqretnt7lv@chubnabkyqjz>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <35tqaktf533qtpaquvzb7p5juupjyakktstlqgr2hqretnt7lv@chubnabkyqjz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 13:51, Ondřej Jirman wrote:
> Hi Krzysztof,
> 
> On Mon, Apr 08, 2024 at 01:17:32PM GMT, Krzysztof Kozlowski wrote:
>> On 08/04/2024 12:51, Pavel Machek wrote:
>>> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
>>> but I did best I could.
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> ...
>>
>>> +  cabledet-gpios:
>>> +    maxItems: 1
>>> +    description: GPIO controlling CABLE_DET (C3) pin.
>>> +
>>> +  avdd10-supply:
>>> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
>>> +
>>> +  dvdd10-supply:
>>> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
>>> +
>>> +  avdd18-supply:
>>> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
>>> +
>>> +  dvdd18-supply:
>>> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
>>> +
>>> +  avdd33-supply:
>>> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
>>> +
>>> +  i2c-supply: true
>>> +  vconn-supply: true
>>
>> There are no such supplies like i2c and vconn on the schematics.
> 
> Which schematics?
> 
> ANX7688 has VCONN1/2_EN GPIOs that control a switching of VCONN power supply
> to resective CCx pins. That's just a switch signal. Power for VCONN needs
> to come from somewhere and the driver needs to enable the regulator at
> the appropriate time only.
> 
> On Pinephone it can't be an always on power supply and needs to be enabled
> only when used due to HW design of the circuit. (default without ANX driver
> initialized would be to shove 5V to both CC pins, which breaks Type-C spec)
> 
> I2C supply is needed for I2C bus to work, apparently. There's nothing
> that says that I2C pull-ups supply has to come from supplies powering the
> chip. I2C I/O is open drain and the device needs to enable a bus supply
> in order to communicate.

No, that's misunderstanding of DT. These are not supplies to anx7688.

Bus supply is not related to anx7688.

> 
> You can say that bus master should be managing the bus supply, but you'd still
> have a problem that each device may be behind a voltage translator, and
> logically, bus master driver should care only about its side of the bus then.
> Both side of level shifter need the pull-up power enabled.

Again, that's nothing related to anx7688. If you want to add it here,
why not to every device everywhere?

> 
> You can also make an argument that bus supply can be always on, but that
> causes several other issues on Pinephone due to shared nature of most
> resources like these. There are other devices on shared power rails, that
> need to be turned off during sleep, etc.
> 

No, do not add non-existing properties on this device as workaround for
other issues.

Please drop these two supplies *and all other which do not exist* on
anx7688.

Best regards,
Krzysztof


