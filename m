Return-Path: <linux-kernel+bounces-3236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12A8169A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F00281EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FEA11714;
	Mon, 18 Dec 2023 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uabIJB/I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A31125A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2343c31c4bso117490466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702891037; x=1703495837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHPhLQNQAm+GiB2ZbhInDHh2iTZPzeOb81ASyh331/E=;
        b=uabIJB/I7w5b/9p/lHthcXUUrNxqE2n7KLjvB5Fijic/WVQ28NCSBLTVLKen6gQuW8
         kyDJpEFixsVPFbStQdH2ohnaCg6rCSYeGNoqa7iRs/AFKVdwvTndE/QQlhNDkpdSG1a2
         Z/KGB0MtEyi0kLBt74rbyuUKtHWPBsomD5Mz57R5cPfHjj1vj0bF/7t5xwuGl2nN6dwP
         Go9tKfULv0wPi71VcgCUArwEsR4BVmfImocSUCmvgvTnbjoCTWw+OZ87iwLLmpYcOUmO
         5MoVP05MoNGP4GMAwF+NFOehi1300pO4QQdHgxyz263nfMwTFfaaNoMkIIwKIoHlN4VL
         esgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702891037; x=1703495837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHPhLQNQAm+GiB2ZbhInDHh2iTZPzeOb81ASyh331/E=;
        b=mAX4Ezd7aSRx8K6/pZ+ePpM5hoVvrYSKuOJnei4+tkllk0yg2F//fAa8A9me20t9lj
         MurQ04XZTBNwZlubIXr3aHD/r5INOTbH07eliSk4lA3SE++nGyIWvCjqglENkrt+6tQp
         OPkMMWIh/cAaDNOWU6XlO2w/4BvM5k6ThDD8JwhsIk82NCfpVligeQDvclZcu9IeFPIq
         YhmwQkeNYotEIe4vczko3vK24WBzdHJL+pMR3NyYETj6aiu/o1VqPDe8ydoeQTT6nDBo
         bGJUHtE7aA8/qJC6kzSt2x3yKVXOIz257vsOb0eRg08H/BIqyYLgg0iV5WwYf3pvt6/C
         PXBg==
X-Gm-Message-State: AOJu0YwifaSLlUKlL4Ihacji5oWZUaAo9Bsa91/PCazermst9e4wA0ZG
	GLngMxzRPN9l0BH+CzrE+fPdFQ==
X-Google-Smtp-Source: AGHT+IH+LbJ2gkbeAgA69U667+1y/bGVZAJl9hgbsPQMYt+Cyz8ertbQURI3D8hR3M+VgHfq34mCHw==
X-Received: by 2002:a17:907:9251:b0:a23:526e:4425 with SMTP id kb17-20020a170907925100b00a23526e4425mr370307ejb.66.1702891037534;
        Mon, 18 Dec 2023 01:17:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a1d18c142eesm13905971ejc.59.2023.12.18.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 01:17:17 -0800 (PST)
Message-ID: <e3f62e46-16f8-4ca5-a8e6-67c116f6ede3@linaro.org>
Date: Mon, 18 Dec 2023 10:17:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
Content-Language: en-US
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Orson Zhai <orsonzhai@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
 <20231215085630.984892-5-chunyan.zhang@unisoc.com>
 <fd927698-6aa3-4a6b-988c-fc82663235ca@linaro.org>
 <CAAfSe-tTvxLCAdSCCgEw8HMFaVVfOytoowY_Fb2F0H-vo+cCmA@mail.gmail.com>
 <4faf78f5-5e57-44a1-8fdd-7b6a33b0bd19@linaro.org>
 <CAAfSe-teE0RnC9fNtEP4dW3d94ud7pxF4wAB71FLik65HjatNQ@mail.gmail.com>
 <7ea2e47a-59fe-43ff-89ae-4a870c754e2f@linaro.org>
 <CAAfSe-uAczP0AmQFF3=LmfhtZZ45h-BS1BJrPkNu0MgZkSGLBw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAAfSe-uAczP0AmQFF3=LmfhtZZ45h-BS1BJrPkNu0MgZkSGLBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 08:37, Chunyan Zhang wrote:
> On Mon, 18 Dec 2023 at 15:31, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/12/2023 08:18, Chunyan Zhang wrote:
>>> On Mon, 18 Dec 2023 at 15:00, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 18/12/2023 03:31, Chunyan Zhang wrote:
>>>>> On Fri, 15 Dec 2023 at 18:36, Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 15/12/2023 09:56, Chunyan Zhang wrote:
>>>>>>> Add basic support for Unisoc's UMS9620, with this patch,
>>>>>>> the board ums9620-2h10 can run into console.
>>>>>>>
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>> +
>>>>>>> +     soc: soc {
>>>>>>
>>>>>> Are you sure you do not have here W=1 warnings?
>>>>>
>>>>> Do you mean warnings generated by running "make W=1"? I tried just now
>>>>> and didn't see warnings on this dts.
>>>>
>>>> No, I meant `dtbs_check W=1` or W=1 coming from dtc (dtbs).
>>>
>>> Yes, I just run "make W=1 dtbs",  also have tried `dtbs_check W=1`,
>>> didn't see warnings on ums9620-2h10.dtb
>>
>> Ah, because it does not even compile!
> 
> The patch was generated from a middle commit (that was my mistake of course).
> 
> But I've fixed the issue. I ran the command just now according to your
> comments, and didn't see the warnings on this dtb.
> 
> If I'm missing something, please correct me.

You don't have unit address for soc node, but could be fine if
address/size cells match. Don't remember, but also cannot verify because
it does not build. :(

Best regards,
Krzysztof


