Return-Path: <linux-kernel+bounces-44058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A6841CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70AE1C2587B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0953E3D;
	Tue, 30 Jan 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vk+NtIjN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F610524BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600434; cv=none; b=LjCTRPp7ySwkXuwVMO2Pvz+EerrhOMStytrC+MCoGZTd7urr9zlLYthxdmKOCwfLSwwLb3/c2VUJXYxgX7wEelNeudGWZKptmrimFQJg/v0vRfmw5lmHlNRMC2C7IwPYPGa7XqMCB+1meigHsJc2a9zx5fzTri0OkY3KwybHwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600434; c=relaxed/simple;
	bh=X8V9pvpV0JNRuDhoPRdTK4TGozcDMk3G0rZ4Q7XMqic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9v/8d1Ow9SgzLjrUuh8Thri/IsI030euNEB0Hd3RvEMiH6dEnnOnv/eQr3hdEhxcfUr6svMhTfnkZsq5+KxAg615xWnG6dLeENh3+sHcZznzqnqQpHboFCjOpI2MPgUZbU9z2gBTBtAFRMoiIbs7y1VmLiKlV7bXkd3R9wrixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vk+NtIjN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so672892166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706600431; x=1707205231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPe60IzTNRhQ8xdKXhrI1YkRrC86QmovGAq/H+j7848=;
        b=vk+NtIjN+424w+N92139h8KhT8HBQ/8yTi3vrGJwq01a/6Y7BpF8Q3R3229TSm2WLZ
         knwYwGosb+O4DvdHXuIMjt7qEkncwa6nuz9ZOGKGeNPOUKiVf1rYCgJjTWnW0u/8qzzb
         /jp04m99871RNPRZM1KRKEfY01Dt11bq0/f0G2TjG4doYfWEQWQSZd6aew6dEx6IUFw/
         vXelMLculQEeO6bvCf1i78UqRVE/2VmeUHE2K1UVXAPCRu1+vDPMmfBbZoBHeVtU1X0Q
         zb8+00+QfT448vrHapS+mqhnDeM6qcqJlumH4hgfKYYWbZff0XUfkNuxxxoY0CYEGW8/
         y+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600431; x=1707205231;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPe60IzTNRhQ8xdKXhrI1YkRrC86QmovGAq/H+j7848=;
        b=CgxupZ1ZJD2q5SeFeo/hJrcCyk6kQUvjQ5Appva9QeBiCihF0uC9IdDK4D+WlhhFeB
         tpuuA9U8/ziJ4Iu0iRSKMcFMdeOJXqSQlfSLeJ+Z5KIJPc7a7hT995ODJ1BO/NL/LmS9
         UIiwXRroswaUv4icD90n9o9sbfeZQINifwwiIlHzM3N8Fh4cYKE0EgnIK/ti33aS+eDE
         jy44ARIJcFnk3uRuxYQLvKuYZDM/Au+QyV5ggZ3jIFamC2/C3MEQE5hLA7KloZ4AzXtL
         /4bjw40MACaVc8Iw3te+z1e91Fq7ucnt0AiRxcyZwCQLHFBT5fVerKj7Fl8CjAtz2Ub7
         2KPw==
X-Gm-Message-State: AOJu0YwzdrcCx1zP3RULXPUhPZdGom8tWfRboRwTiZfeK81WtVQYi1da
	k8ughFVjNedl7scidV7Kk3CxyeBp44dJOLdIguWQXqfZUPy/Mcfy8xVOKOpfE7Q=
X-Google-Smtp-Source: AGHT+IFOW1yMVhj72oFmD37Hzaqe45ko6oyFddynA0fudFTsS0/WukBC5Pbd5ko3gKlDIwPzaYErdA==
X-Received: by 2002:a17:906:d110:b0:a35:991e:5085 with SMTP id b16-20020a170906d11000b00a35991e5085mr737177ejz.30.1706600431327;
        Mon, 29 Jan 2024 23:40:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a353bfdd411sm3690334ejc.59.2024.01.29.23.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:40:30 -0800 (PST)
Message-ID: <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
Date: Tue, 30 Jan 2024 08:40:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Conor Dooley <conor@kernel.org>
Cc: thinh.nguyen@synopsys.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, balbi@kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
 sergei.shtylyov@cogentembedded.com
References: <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
 <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 18:41, Frank Li wrote:
> On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
>> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
>>> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
>>>> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 23/01/2024 20:22, Frank Li wrote:
>>>>>> On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
>>>>>>> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
>>>>>>>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
>>>>>>>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
>>>>>>>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
>>>>>>>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
>>>>>>>>>>>> GSBUSCFG0.
>>>>>>>>>>>
>>>>>>>>>>> Why might a platform actually want to do this? Why does this need to be
>>>>>>>>>>> set at the board level and being aware of which SoC is in use is not
>>>>>>>>>>> sufficient for the driver to set the correct values?
>>>>>>>>>>
>>>>>>>>>> In snps,dwc3.yaml, there are already similary proptery, such as
>>>>>>>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
>>>>>>>>>> driver keep consistent. And not all platform try enable hardware
>>>>>>>>>> dma_cohenrence. It is configable for difference platform.
>>>>>>>>>
>>>>>>>>> When you say "platform", what do you mean? I understand that term to
>>>>>>>>> mean a combination of board, soc and firmware.
>>>>>>>>
>>>>>>>> In my company's environment, "platform" is "board". I will use "board" in
>>>>>>>> future. Is it big difference here?
>>>>>>>
>>>>>>> Nah, that's close enough that it makes no difference here.
>>>>>>>
>>>>>>> I'd still like an explanation for why a platform would need to actually
>>>>>>> set these properties though, and why information about coherency cannot
>>>>>>> be determined from whether or not the boss the usb controller is on is
>>>>>>> communicated to be dma coherent via the existing devicetree properties
>>>>>>> for that purpose.
>>>>>>
>>>>>> Actually, I am not very clear about reason. I guest maybe treat off power
>>>>>> consumption and performance.
>>>>>>
>>>>>> What's your judgement about proptery, which should be in dts. Such as
>>>>>> reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
>>>>>> value for every SOC. The board dts never change these.
>>>>>
>>>>> Then it can be deduced from the compatible and there is no need for new
>>>>> properties.
>>>>
>>>> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
>>>> controller) appear regardless dma-cohorence or not, connect by AXI3 or
>>>> AXI4, needn't add new propterties. 
>>>
>>> Anyone have objection? I will prepare v2 to fix rob's bot error.
>>
>> I'm not sure what you want me to object to/not object to.
>> Your last message said "needn't add new propterties", seemingly in
>> agreement with Krzysztoff saying that it can be deduced from the
>> compatible. That seems like a good way forward for me.
> 
> Okay, let me clear it again. dwc usb is quite common IP. The below is
> what reason why need "*reginfo* instead of using compatible string.
> 
> 1. *reginfo* property is decscript hardware behevior, which will be changed
> at difference SOC.
> 2. it may change at board level according to if enable dma coherence.

dma coherence is not a board property. Anyway, you said it will never
change in the board.

> 3. dwc core part is quite common, all SOC using common "snps, dwc3" as
> core-part, all soc specific "nxp, dwc3 *", "qcom, dwc3*" is used for glue
> logic part.

And all should be having dedicated compatibles.

> 4. using *reginfo* can reduce add more strange compatible string such as
> "nxp, dwc3-core" ...
> 5. *reginfo* property likes "reg", "clk", and align what Kryzystoff said.
> "reg", "clk" is fixed for specfic SOC. These can help reduce "compatible"
> string number. "reginfo" do the same work as "reg", "clk" ..

So again, reginfo is fixed for specific SoC? So it can be deduced from
compatible.

I don't know what to say more here... so let's be clear that you
understood me:

NAK

Best regards,
Krzysztof


