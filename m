Return-Path: <linux-kernel+bounces-135294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0E89BE87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9E6B22849
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDB6A342;
	Mon,  8 Apr 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVF69sG2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86C6A323
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577559; cv=none; b=UhC/I9VZ/wjNXbOpNFYIcz2TrdFTr/31tEywoKBvLydkEiFav2V1qiQu90ZxiybKT5JXrLu4oWYTE9hvQ1syGZCJWhue/Q4X6bghDtkn/xMvmus8C3H8Xcd6lHW6TOSynR26RMvTBZO7nFergsPi9uAIguVN2+qvDmFV7k66AQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577559; c=relaxed/simple;
	bh=B0O16M3KvAjeKZmVSU6xbZE0TpBJfQ6Zdcy/+JglDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E59ziKsaxaypp6/z7i3wLl0syQpX2EJWzKfOfDvtnzV0Jm1Z/w5aXUiRlAOwz+4fjsKraea/ZLTsC1CWUPQvuRGAXBgW9auhFqLviBEukSejb9hP/CjM/wY69xBvHP94//yDVQlB44B1TUdf2CsSF5+VdL19KoBiEp7Qv5OO6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pVF69sG2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso5876041a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712577555; x=1713182355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bQfGWBS33oiPh11729J8cCB80loVN7z4yLpiLx3kmJk=;
        b=pVF69sG2qpWdUhdfDF3RTWJ4Bnk49mi0YeflS5+LYkR9eqtvhr/T5R/dHuxDc7NhYd
         7JSyOTB27HY1zkpYwFfSp8kklyU1OfaXlRBhcLgj+OF/peiEiA45lwSykNOAFmVxfud7
         Bfzv0ZvblzthR1HH1YSg7Yq2toBcYQKbC03WR5FN4a3XBJd/vD9OxQu20GcDasL38Zv4
         QGOQeMl8MywKW+BHEwF6w9qWr2G2YwcwWXrJ23q1DEhB7yi86dMm82HvwyaOWUES5TYe
         6cDbFbQfQNE+mrmieFVL3ZtQil7Tt+irWwYsp3ylu+TmesuEADW+OKjDQ2R6ngPXzlO7
         W6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712577555; x=1713182355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQfGWBS33oiPh11729J8cCB80loVN7z4yLpiLx3kmJk=;
        b=wjhhtonSB04xbUTxSzi69vbbdJZunYgGiiJDjTWzRnhOP8T+QJf6zq0XAbBAGWIQ68
         cnZZj0geu4ZC3GcVsO281BhkJrv4yjOtWfk9anOUdy9F+AmT2ChzVAs7pgaAwtq1RgKj
         xqmClOXoph0AATth5KDjc5fcjKygMjv906t9fV3qJTAtGXzbv7BVgS89j0DeDRFkhmnP
         hcuISRVOmvA3pbBh9A4mV7s/Cj1wGEDAPJ3hMkzL4AulFEJ+WalUBXiFmFO8g8Kkxkgn
         0ECLNxGfupWzdkrVjLG5/8vCuD7nWmmYDWZpvx/qHJe7wz3Cy/SkoV9LKirlWyQ/e943
         EOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ztFqrzk9IM98AiUBM478mKcT8iiqf/6+zo8vT2U3J3iTgEpnP7fukprY1qeoZ1kVG22EM3dqVEZTLHUbSa3IejzmLdaA4DBh1kvv
X-Gm-Message-State: AOJu0YwHzPCOJAhn90DlkcHcJLDKXHYnZ98tgwt89J74lctowiDlhv8/
	9z/pylzR+HdJj3X/fP5aHPMNIhAutiFzvNIGHrNsVGe9DQrbJDDQtljTTRA8UFo=
X-Google-Smtp-Source: AGHT+IEQcK7vBccU2yC/8y8lB9YO0dENrueP6GfrxXgQkes/uMS/RLAT+LYYJg8wMVSpDAF8nG5RVw==
X-Received: by 2002:a17:906:f584:b0:a51:dd18:bd21 with SMTP id cm4-20020a170906f58400b00a51dd18bd21mr1309952ejd.16.1712577555091;
        Mon, 08 Apr 2024 04:59:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906529600b00a51bbee7e55sm3008483ejm.53.2024.04.08.04.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:59:14 -0700 (PDT)
Message-ID: <7976e254-ed1e-406d-870b-1ecdc4b1e23c@linaro.org>
Date: Mon, 8 Apr 2024 13:59:12 +0200
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e6vvuttix5k5fioy7q44ick5wj6u5gleh7mht36s4zjjcym7vy@bziejyohtc4b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 13:52, Ondřej Jirman wrote:
> On Mon, Apr 08, 2024 at 01:24:03PM GMT, Krzysztof Kozlowski wrote:
>> On 08/04/2024 13:21, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
>>>>> but I did best I could.
>>>>>
>>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>>
>>>> ...
>>>>
>>>>> +  cabledet-gpios:
>>>>> +    maxItems: 1
>>>>> +    description: GPIO controlling CABLE_DET (C3) pin.
>>>>> +
>>>>> +  avdd10-supply:
>>>>> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
>>>>> +
>>>>> +  dvdd10-supply:
>>>>> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
>>>>> +
>>>>> +  avdd18-supply:
>>>>> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
>>>>> +
>>>>> +  dvdd18-supply:
>>>>> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
>>>>> +
>>>>> +  avdd33-supply:
>>>>> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
>>>>> +
>>>>> +  i2c-supply: true
>>>>> +  vconn-supply: true
>>>>
>>>> There are no such supplies like i2c and vconn on the schematics.
>>>>
>>>> I think this represents some other part of component which was added
>>>> here only for convenience.
>>>
>>> Can you give me pointer to documentation you are looking at?
>>
>> The schematics you linked in the document at the beginning. Page 13. Do
>> you see these pins there? I saw only VCONN1_EN, but that's not a supply.
> 
> The supply is U1308.

That's not a supply to anx7688.

Best regards,
Krzysztof


