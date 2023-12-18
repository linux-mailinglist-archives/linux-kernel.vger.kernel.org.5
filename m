Return-Path: <linux-kernel+bounces-3098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFA816767
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B5DB217A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1A38473;
	Mon, 18 Dec 2023 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arhB13OT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95A9D269
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso2749403e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702884709; x=1703489509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBwdPWqcTKBElzhgdRRdv0i5FIzvRhmZEQbdFF/25NE=;
        b=arhB13OTfwfUrAAnRts4xISZQuhNoV5zNQ1kkgfS+aM6ybeQiHhjj+gZayxwTG65V/
         hXWlh3XcJM4Q1YYc7sn+zGfUnVN7KIAMoIcfz8h/oTPA5099AaTKMGQRR5Pmq22QLhdi
         BkSh6vA8aatcOr7R0lkA3OI/13pdBGGoKvX97ERev5Cw0OYo8iLb6OUc52+msV4JFuoo
         UV/8gnaqg6umW43cphLIsaCibLB98lC3I4OBhE6EL0s5MDapaW6GDCtWuG1I4qiwmF/M
         NnpcYetKig72iarvEQBwL78OzVmTLBP2VX5wbMZLjw6Ra8eSctlLChXmquLFN9pZ8Ds1
         lsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702884709; x=1703489509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBwdPWqcTKBElzhgdRRdv0i5FIzvRhmZEQbdFF/25NE=;
        b=Wd19UV5C//okcZ+f+3jYdbfuD0OBPlqiJnpmM6pstsU73kq7sO0PoEnuQCKzcF9oqc
         lci+BVoGhW1v96aWZ8GEo/y0GSAVwY9paYKzbD3yVPPbkmkH8ysVQMuC1jwaLQlJ6BX3
         biuGDxpflYM/7udKN+XmAaifv+eNXCezoy+ejEtN7lzn8Nv0kfP4Iiy3rTS1nt54WeY1
         k/Bacn+eVBk2xwQCSKPfnC4roU5BGLwe2nhbmXRTpnb6QqZPn8Wj0eQ6cLl9mEWnRfIf
         OvhabnIpisd3i3m8RnEkKcvjnt7vhFHF71Zsy3H25Sm+akky/lZkLWFsdDqqcFb0C7iP
         kMlg==
X-Gm-Message-State: AOJu0YwyvMEuv1lKtkHFODdyap02dWhfsMRNQ/4yyRiSYlASTx7I2vi5
	UTirD8nAp/+Cx2BVkJTc7vqAEQ==
X-Google-Smtp-Source: AGHT+IFwd0aBXMfS4tLFFGWWhRny9uOuy4K40Kg7MSMOK/R06V12KHQiJN7mfk2DL/NgMoOBme4+lA==
X-Received: by 2002:a2e:b80d:0:b0:2cc:3f53:c9cd with SMTP id u13-20020a2eb80d000000b002cc3f53c9cdmr1120892ljo.128.1702884708994;
        Sun, 17 Dec 2023 23:31:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402320600b00553463827a8sm911434eda.87.2023.12.17.23.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 23:31:48 -0800 (PST)
Message-ID: <7ea2e47a-59fe-43ff-89ae-4a870c754e2f@linaro.org>
Date: Mon, 18 Dec 2023 08:31:46 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAAfSe-teE0RnC9fNtEP4dW3d94ud7pxF4wAB71FLik65HjatNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 08:18, Chunyan Zhang wrote:
> On Mon, 18 Dec 2023 at 15:00, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/12/2023 03:31, Chunyan Zhang wrote:
>>> On Fri, 15 Dec 2023 at 18:36, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 15/12/2023 09:56, Chunyan Zhang wrote:
>>>>> Add basic support for Unisoc's UMS9620, with this patch,
>>>>> the board ums9620-2h10 can run into console.
>>>>>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +     soc: soc {
>>>>
>>>> Are you sure you do not have here W=1 warnings?
>>>
>>> Do you mean warnings generated by running "make W=1"? I tried just now
>>> and didn't see warnings on this dts.
>>
>> No, I meant `dtbs_check W=1` or W=1 coming from dtc (dtbs).
> 
> Yes, I just run "make W=1 dtbs",  also have tried `dtbs_check W=1`,
> didn't see warnings on ums9620-2h10.dtb

Ah, because it does not even compile!

ums9620.dtsi:8:10: fatal error: dt-bindings/clock/sprd,ums9620-clk.h: No
such file or directory


Best regards,
Krzysztof


