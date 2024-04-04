Return-Path: <linux-kernel+bounces-130965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67E898140
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247801C220DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85354AEE5;
	Thu,  4 Apr 2024 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOhQxYQl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA43FC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211143; cv=none; b=fALlJX5GBzvEI5nkD/yzQN/ueuSHwueopivv/yLIOf5Xtgz11ZSCOIffG4tuw8X6ki1PkspJmz3B9uA3kT8rGxkl7gNPzDUG2vpqpO0flY/Yu/+4tRvC2stJXILG3Hobfp91xDq2Pt7uXTexc+GOgYsDQMwOd7Vz8KzPT6HLx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211143; c=relaxed/simple;
	bh=Nz+GVvdYNt7j15z0S4gwY8j7t8Bi+495AqApM45teJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/nGeaJlPn+Q4UOv2P4CWub/aXzvFyHUt4W73XdlksYbJJWCw/tLDo5thtGbJpYBBcU0dEmOd8zQslnRgEN9m6glzU1RagqwLqglJRlr+MgE6BM25RL11z8I4izD5qsQs+37Crp2f0pIwYMUhTA9kGqeJ5ZZcRnlmbvaJ0t5WMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOhQxYQl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so408535a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712211140; x=1712815940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Jlsz6LxsqJXvoRYoB8EPQkaZhGyWROKtJ1IOS+vn8=;
        b=cOhQxYQlquuHLckGetZEUfMQrIfe1ZrZw22kEnv+uWFavtsse83zprPrBr4xOzsQFU
         pXHigfYmj7jWtyPhRglKIxJTnPblFh45bVXSiyXc3/aAyGwl9+0OUGl7TsELxXqeDuTG
         rgM/aCcQQPebbYMITfEZlGJY7dxF1HVDNUcK659H4ycnW+jTPgWSw+RZGXVRo+TUhLJF
         7bzUj64PwFbcmqF/guNvQLBfEOhK5LHCr+By30W15VTUVeKiO46WGpD66v0eW9FV1575
         5LgpgbVO9Hnj1MN8SG0HbKaHLvzcY3SNoyCWnt8ow7T6LKtPWRFji6Iy9SX9L8Y35kHJ
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712211140; x=1712815940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6Jlsz6LxsqJXvoRYoB8EPQkaZhGyWROKtJ1IOS+vn8=;
        b=xSSHkiXiH3cdY8eNSrlCzd+rSAH/4r0M2xS+/Wnbepj73VioGSmqcFrtiC5572hpza
         EoALqf+cR8hSWw7aIUATz8/4TSCKU1KVZOVUGJa2vbi2uaq5iSewKjjJvunqLJtlQ15l
         lON5WK9V0LuwLp1JeBbTvefCjwiwG8vNx/zSkL6p+IZTwlknh1FVprNyxyV4gDq5Tbcw
         a3fxmvC2QCee/85P263PSMAkFthbeNxmwpb4bhKWiWZMz6+4oL83VR8RRUk4csl9ymi9
         maKAnOefmS/eDINTc05nwUf5bWiunx77598TDMgHM2kYDb33O6qr8wS/5xZ5VnigSuQ9
         M47A==
X-Forwarded-Encrypted: i=1; AJvYcCW7bNXjeoyxHzZsc/STyJfpXA8hIzX+/pHgcWbihlbBEuLGAxo6bRA9z+FXhQUBdzDWi/UoWKM7ioLem0Uni3+C4Bxa9XbT4vBuBCMt
X-Gm-Message-State: AOJu0YxkfGDkgqm+AyHuJ3f574YAL9KPKc1wgoQmTGonDUixpVXASw1d
	S8iLKpdDNoEqMS6Z8FvdQFD0v371adoXkwVaNKHU6aYXtAfMqzP2+Lvc5ZJ7nZU=
X-Google-Smtp-Source: AGHT+IFmunps1EQCiMcWoc5T3Kdy549PJ5ZS+UHkfJMHVxrflDzob/XaPxmD0eHcAksWfbYZPEwcCg==
X-Received: by 2002:a17:907:e86:b0:a51:81e2:4200 with SMTP id ho6-20020a1709070e8600b00a5181e24200mr1013418ejc.72.1712211140448;
        Wed, 03 Apr 2024 23:12:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906125700b00a47522c193asm8619473eja.196.2024.04.03.23.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:12:19 -0700 (PDT)
Message-ID: <194aa24c-2763-47e2-8ccc-1637d299c1ba@linaro.org>
Date: Thu, 4 Apr 2024 08:12:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-amlogic@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204144429.45197-1-linux.amoon@gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org>
 <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org>
 <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org>
 <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
 <2e688f4e-11d7-4f8e-b8ec-58f4a97304a8@linaro.org>
 <CANAwSgQstkS-SDaV2hj0fimt7vgfEgOT_x4efshZ6sZQ0gWSEA@mail.gmail.com>
 <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org>
 <CANAwSgRLORHb6qiHWRBR0tMbYB=O=gwatuGhk72SwZyhYMopCw@mail.gmail.com>
 <d2962ffb-badd-44a6-bdcc-53e15d4a4379@linaro.org>
 <CANAwSgSpuh-+HFYg2UTgX27SHFyCBddV46MgKakiSCOtFX4+aw@mail.gmail.com>
 <436ed6a4-2ed9-47bc-bcc9-18a52b1a791b@linaro.org>
 <CANAwSgS8ip+FvuvgusjNwnVL5Z68PRmEdwfQxhst_ZoVZFoFNw@mail.gmail.com>
 <CANAwSgSftb3KkXvzNyGGixVtK8SWcOYjxO9WWpLt-B3mf_B6tg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CANAwSgSftb3KkXvzNyGGixVtK8SWcOYjxO9WWpLt-B3mf_B6tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 06:27, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Tue, 12 Dec 2023 at 18:47, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On Tue, 12 Dec 2023 at 18:39, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 12/12/2023 13:51, Anand Moon wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On Tue, 12 Dec 2023 at 17:22, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 12/12/2023 12:37, Anand Moon wrote:
>>>>>>
>>>>>> Here is the list of warnings I observed with this patch
>>>>>>
>>>>>>   DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
>>>>>> /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
>>>>>> hub@1: 'vdd-supply' is a required property
>>>>>
>>>>> You always require the property, but it is not valid for some devices.
>>>>> Just require it only where it is applicable (in if:then: clause).
>>>>>
>>>> I had already done this check many times before.
>>>
>>> I don't ask you to check. I ask you to change the code.
>>>
>> I have tried this and it's not working for me.
>>
>>>> my v6 original patch was doing the same and it passed all the tests
>>>> but since I updated the required field it not parsing correctly.
>>>
>>> Your original v6 patch was different. I don't understand what you are
>>> trying to achieve. Or rather: how is it different, that my simple advice
>>> above does not work for you  (as in the past you reply with some really
>>> unrelated sentence).
>>>
>> Ok, It's my poor English grammar, thanks for your review comments.
>>
>>> Best regards,
>>> Krzysztof
>>>
> 
> Any reason this device tree binding got removed,I cannot find this file
> Can not find the commit which removed this file.

Use git log.

Best regards,
Krzysztof


