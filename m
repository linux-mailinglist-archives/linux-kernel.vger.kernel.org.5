Return-Path: <linux-kernel+bounces-59072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F584F0CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9657E290D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289165BAB;
	Fri,  9 Feb 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQmBEGTK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC9657CB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463908; cv=none; b=VWNIUeIUflUmG1RZPe7UdFwuqAADgpwSDVZSBdLjybLUXx1WbvbQVl4BQLqOObYmYWt3nZ0ZRqczvOYtIZD7gvzCiGohoJFlHUkgbxstf24C12RV0Iga71ysrBjjWe515d4ltC0h3SeOmJMuZ3u7C7L6Ez8T0hgmCG4WFlr/dUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463908; c=relaxed/simple;
	bh=xFmNZJS37ahgZTb4n847UyVexynqHYAijXk03hvaqSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0z9qTp/8Du3NDnrJ+9nxpQxPCn/P48MtSueCZwp5XM1Fw2bQAXj60omLz+6l5UeSliEZ6VYy4sQpMCcMD5eQivEEvM92cdWS63KaX9m/s0ZJfxqce1X05gJdeBw/vaGuPvDuQWnqrC1rpzbT/FtUve+Wke5E/poJ078ZI4Hd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQmBEGTK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso5003215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707463905; x=1708068705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=czGphICzS+JvFtvh9UqhTVKfL9+aki9x9lhTNwlN9yA=;
        b=aQmBEGTKchApd4zSo56unmE6wiGijvxdEbu9eMr2DuDmcAECTzkGNVOlqoxSgL1OZG
         uW/1vPDh3qQQC28RqDXpt81gf7/Ws+TMd9uYUlhszSmbakoPa3Buv+t4hID9n56d6IYT
         9yjIPpCMLmjCIDGil/Kp/CyHugtndog4PQY8dpxldMJyq1m3NLH9fykc3prrB7E2N1sy
         g9BQ1NGYYm/uJzAXUweSPqFXiEDxR3qbi5hJSbYnYnidqZKi9T09841ay/HrInPWIZrr
         MzTPF0x6q0T5uCbmWs+MLFz+/BnamG2dEdcofTlhhUcDIIfz5jGjF2Z8A2ia4UpSvNKg
         NwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707463905; x=1708068705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czGphICzS+JvFtvh9UqhTVKfL9+aki9x9lhTNwlN9yA=;
        b=wyGgqMQzx5jzipoZeyb4p15n44T0qJcDyNXpLvCNoEcC/b78OorCJBYeZ06+oAT0QU
         dQqaB06bGDrDo//ZVPpBdr4YZ++EafuDxUEP+f5BPRvIbXI1I+AwJJE8JGvNrOJiKPii
         nZHU1wbOBcTypeKGOQbgAbhGeJmEB87OyObnShaMcrezCyUVKhG8YSH4hiq1RT5S/tz9
         c6m2m/jQSIbVwQvAH5JPP4grvkxp3clvRNjjqEnA//Krk63VTXlnzGH1tuftOqtNbll+
         A89arf2v0tSzifdMr6pw75r6+4Ary0epI8Noa02ylKNzUUkq/YpW83aKyAJIx5Gmaqb2
         L9JA==
X-Forwarded-Encrypted: i=1; AJvYcCWe4Oaxv9qhCFCZ5RNa9uH+GKNtolvWTOqNYzSp+y8lst20LBI2fuH0hs7HUm3RcbF9G57nJifuPRp7bdop9JeiHsrK+o4kddb40dyh
X-Gm-Message-State: AOJu0Yzi/JZSQy3DBDci1sxPKYJIhFUtEUJzlgvWmnCrDixPZrICHmKw
	r41sjsqzlxG7TUmYNz2UktAFNOVt1TA2/KD6v0HehxjtmA1YBqQ9zHJhrW7X3Vg=
X-Google-Smtp-Source: AGHT+IF21UJMU+NhR40BDtgwZB2n++F2lik57iCGic0Zp+dyoR82suy8CBdyf5CO29MzoJwnGZq1JA==
X-Received: by 2002:a05:600c:3ac9:b0:40e:fbb3:f67c with SMTP id d9-20020a05600c3ac900b0040efbb3f67cmr506540wms.38.1707463904746;
        Thu, 08 Feb 2024 23:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoBgw94rOUHYSUFCtX3RXxcYDkM2MLAIzu1+et4Zr0eIQRwlqrzUpLl0+ZcoWHIEJJjOa0EfgLKFZZdMeVb02GCQhSh98ADzA2MF+Wy5IQ16yXQNOwo/YnmiJCbDB3j3AHuSmn/hg53wYwU1Lym6joVm0JDK3oRO4T0qELvIf9vkegm1nFE83q/Z4spBSpLhnS/qpS+t5j/lHRU0ejsDd/0X3Guj/U9jcPuq0sy5OtzFzRR2mLT7lpTvelifSlCwC7pIMHk1TLX+Oj01DQKqSUJPUvQPLnvvt67sABkXQGaXJLpTaF5LcltoOnQno32ad3xIPcA91exP/P7JYSf6Gn7GgZK9q9jOpa9iClJr+Vd7KKYM2/DA5ISAzVXwpZvqoQ2mfUlQ7NR/7XhS0cCcXK6YQa86nb4w/fM5GNZpnLYHdw2bgitwiDDiGw2zBkQVbIYNU7cQlGSMKavY7zSjulMSn0b5o6ObKN2fiv1u/XUPRClg1+PUXK+CpDSnld
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b0041039d20454sm1664309wmg.41.2024.02.08.23.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:31:44 -0800 (PST)
Message-ID: <973a15f2-4841-43ee-899b-d6f8ac57dde2@linaro.org>
Date: Fri, 9 Feb 2024 08:31:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, thinh.nguyen@synopsys.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 balbi@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mark.rutland@arm.com, mathias.nyman@intel.com,
 pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
References: <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
 <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
 <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
 <ZbkTvu0Q85zyieXr@lizhi-Precision-Tower-5810>
 <0be231a2-0c3d-4f18-8de2-3e4f1fe1cd29@linaro.org>
 <ZcVFlRug4ATBcH9R@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcVFlRug4ATBcH9R@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 22:20, Frank Li wrote:
> On Tue, Jan 30, 2024 at 05:10:54PM +0100, Krzysztof Kozlowski wrote:
>> On 30/01/2024 16:20, Frank Li wrote:
>>> On Tue, Jan 30, 2024 at 08:40:29AM +0100, Krzysztof Kozlowski wrote:
>>>> On 29/01/2024 18:41, Frank Li wrote:
>>>>> On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
>>>>>> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
>>>>>>> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
>>>>>>>> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
>>>>>>>>> On 23/01/2024 20:22, Frank Li wrote:
>>>>>>>>>> On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
>>>>>>>>>>> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
>>>>>>>>>>>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
>>>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
>>>>>>>>>>>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
>>>>>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
>>>>>>>>>>>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
>>>>>>>>>>>>>>>> GSBUSCFG0.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Why might a platform actually want to do this? Why does this need to be
>>>>>>>>>>>>>>> set at the board level and being aware of which SoC is in use is not
>>>>>>>>>>>>>>> sufficient for the driver to set the correct values?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In snps,dwc3.yaml, there are already similary proptery, such as
>>>>>>>>>>>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
>>>>>>>>>>>>>> driver keep consistent. And not all platform try enable hardware
>>>>>>>>>>>>>> dma_cohenrence. It is configable for difference platform.
>>>>>>>>>>>>>
>>>>>>>>>>>>> When you say "platform", what do you mean? I understand that term to
>>>>>>>>>>>>> mean a combination of board, soc and firmware.
>>>>>>>>>>>>
>>>>>>>>>>>> In my company's environment, "platform" is "board". I will use "board" in
>>>>>>>>>>>> future. Is it big difference here?
>>>>>>>>>>>
>>>>>>>>>>> Nah, that's close enough that it makes no difference here.
>>>>>>>>>>>
>>>>>>>>>>> I'd still like an explanation for why a platform would need to actually
>>>>>>>>>>> set these properties though, and why information about coherency cannot
>>>>>>>>>>> be determined from whether or not the boss the usb controller is on is
>>>>>>>>>>> communicated to be dma coherent via the existing devicetree properties
>>>>>>>>>>> for that purpose.
>>>>>>>>>>
>>>>>>>>>> Actually, I am not very clear about reason. I guest maybe treat off power
>>>>>>>>>> consumption and performance.
>>>>>>>>>>
>>>>>>>>>> What's your judgement about proptery, which should be in dts. Such as
>>>>>>>>>> reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
>>>>>>>>>> value for every SOC. The board dts never change these.
>>>>>>>>>
>>>>>>>>> Then it can be deduced from the compatible and there is no need for new
>>>>>>>>> properties.
>>>>>>>>
>>>>>>>> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
>>>>>>>> controller) appear regardless dma-cohorence or not, connect by AXI3 or
>>>>>>>> AXI4, needn't add new propterties. 
>>>>>>>
>>>>>>> Anyone have objection? I will prepare v2 to fix rob's bot error.
>>>>>>
>>>>>> I'm not sure what you want me to object to/not object to.
>>>>>> Your last message said "needn't add new propterties", seemingly in
>>>>>> agreement with Krzysztoff saying that it can be deduced from the
>>>>>> compatible. That seems like a good way forward for me.
>>>>>
>>>>> Okay, let me clear it again. dwc usb is quite common IP. The below is
>>>>> what reason why need "*reginfo* instead of using compatible string.
>>>>>
>>>>> 1. *reginfo* property is decscript hardware behevior, which will be changed
>>>>> at difference SOC.
>>>>> 2. it may change at board level according to if enable dma coherence.
>>>>
>>>> dma coherence is not a board property. Anyway, you said it will never
>>>> change in the board.
>>>
>>> Sorry, let's correct what my previous said. There are two kinds bus in
>>> system, one is dma_coherence, the other is none dma_coherence. There are
>>> some dwc usb core ip, which is the exact the same. Some connect to
>>> dma_coherence bus, some connect to non-dma_coherence bus.
>>>
>>> So dma_coherence will be varible for this case. we need set *reginfo* for
>>> dwc usb core, which connnect to dma_coherence bus.  not set "reginfo* for
>>> the dwc usb core, which connect to none dma_coherence bus.
>>
>> OK, that makes sense. Please provide link to upstream DTS
>> (mainline/next/lore link/other upstream projects) showing this.
> 
> Look like I still have not found the real case yet. But I think it is
> existed (maybe not upstream yet). Can I forward using this method?

No, because downstream code does things wrong and does not follow basic
principles...


Best regards,
Krzysztof


