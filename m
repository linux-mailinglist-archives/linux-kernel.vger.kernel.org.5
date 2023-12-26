Return-Path: <linux-kernel+bounces-11517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ED81E794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03253282C23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CA4EB5B;
	Tue, 26 Dec 2023 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeRVujRn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76D4EB25
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so5207293a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703596778; x=1704201578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65H5yRn6ppDlyOF5SbMYBjLvbO45G2k1XGu1rV4uUQs=;
        b=jeRVujRngHA/+TukEPB0Xn3CzfPorlvD7wiI8Q47xEDVgjQWzR1txiDHpGBRn74MUL
         1jVgdshAzwd9lfU89F/+M7NbNbhaya03idvl/fBkwRPwbQiQhQKT+e0A40v5Gs8pod7K
         mBcE5ofPKwsQJ3XHc68E/rpTIWFO/yVLuDNU6rr23hETetteefWHKpmR1YeYUISPGRov
         ctsNHxinBMvJHFzaN12HF6AJHG2ELcvUD7JbeOmSWony98ONZin+Yu9QZaPd9MslPldd
         VXtt1yi17WWhXnZ6Lj/YkK31OuP8SUg3us1slg/VnK6yzVvm93v2YeJfMdyu3PbEvGZM
         /0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703596778; x=1704201578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65H5yRn6ppDlyOF5SbMYBjLvbO45G2k1XGu1rV4uUQs=;
        b=tlfI67lIk59Sdvo83Y/OT3TWkmek3yuhz1GQ/LrElbrvbbz4nc5Cwle3fPxn9XVs3B
         Z349FxUmbP1teIBzci3zZ6b/AGMilqOubVRzeEqNatw4PCI5ly0EjQuKZreeQ9KraiLl
         xaQQDIoFPq8Prnv37+4FFJid6H2PPHKoLludzua9fEYUWxaesjCgWrjqkfSVM7bGqmMe
         pYGW0hW99iHJ820NEeHZRbmL7FMs7SLq2ey0hKwwEdSJQRjASgbifHsRP1nzf8Fv8m+Q
         atRKWFrOA19QcAhPt1Xwq48oEkC7yAPxz6Nid0eDMEY25XIoot5LczJaap8Y8r9ZKUrG
         6VFg==
X-Gm-Message-State: AOJu0Yy6EY8bRaFFtHT6nIy8UNpi7IV1p8kLp2KSiF8ItXjnxJrJ7zxe
	SPcgkGvMFF1lsdWzscgF47yhsnw/eF2iPw==
X-Google-Smtp-Source: AGHT+IEcU9Xo370hyXvB7QF8wvkNeSo1X3a5qALqBUIce4wMlDS7lRQTgnObjOK6ztJYAu53e5kzEA==
X-Received: by 2002:a50:8753:0:b0:553:453e:5531 with SMTP id 19-20020a508753000000b00553453e5531mr3643124edv.106.1703596778171;
        Tue, 26 Dec 2023 05:19:38 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b00552d03a17acsm7331459edb.61.2023.12.26.05.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 05:19:37 -0800 (PST)
Message-ID: <2e58c0f6-08c0-4042-84da-f9b7a6020506@linaro.org>
Date: Tue, 26 Dec 2023 14:19:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, Conor Dooley <conor@kernel.org>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <20231226-twine-smolder-713cb81fa411@spud>
 <7ad0a344-4f24-4319-8f60-ed2521c21815@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7ad0a344-4f24-4319-8f60-ed2521c21815@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 14:14, Jie Luo wrote:
> 
>>>>>
>>>>> This does not resolve mine and Conor's concerns from previous version.
>>>>> External clocks are defined as clock inputs.
>>>>
>>>> No matter the external or internal reference clock, they are the clock
>>>> source selection for CMN, there are only 48MHZ can be external or
>>>> internal, other clocks have the different clock rate, so the internal
>>>> 48MHZ reference clock can be implied when the
>>>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>>>> Conor in the previous
>>>> comments.
>>>
>>> I don't think he proposed it, but maybe I missed some message (care to
>>> point me to his message where he agreed on usage of
>>> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
>>> same page, that the presence of clocks defines choice of internal clock.
>>> This property should go away.
>>
>> Exactly, I wanted this property to be removed. My suggestion was about
>> defaulting to the internal clock when the "clocks" property did not
>> contain the cmn ref clock.
> 
> There are two internal reference clock sources 48MHZ and 96MHZ.

On which devices? Paste entire picture, not half-baked descriptions.

> The 96MHZ is used on ipq5018 currently as i said in the previous
> message, but it is also possible to used on ipq9574 per double checked,
> since the possible reference clock source should be kept as configurable
> and the clock source should not be limited on the specific IPQ platform,
> since the clock source is configurable, the different clock source maybe
> required by the different board design.

I don't see how this answers anything about our suggestions.

Best regards,
Krzysztof


