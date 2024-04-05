Return-Path: <linux-kernel+bounces-132756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B18999C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59678282575
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1B1607B0;
	Fri,  5 Apr 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gj59kXFi"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57115FD0C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310080; cv=none; b=eC48pectbN01C2V/2QCPWh2kSOtPVoj3YvnXzRHBEkmgtEboYbIqVmvlbTlahzXXmurWMaXeca/6PSclvfaLfHNgOGlzaJnrmJO9EXqccee+HF7jm35UXHPeAfxt3IFEyvFtgrF4oxxx7WKimMJjUBaLAPedytMa7DC/FZhcIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310080; c=relaxed/simple;
	bh=UyVyV2JYszopSsJckWNwyJEeMsYFqNu/AzrIaxXoUyE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iufrHmHhRFeD5lNnF+ZXmienrVo6Q5EP4FTVHeuPdJKXJfN0oWI6qbio9/dnl39J9TykCGMJinVDy0pwuqNHpaWaZXTq7eFDEMGiSMNiRsbHtk+bc1KcoBbGYWVZS3O9b7CynoLqBqEaa7oSa1es9cKppnbv7UN6fbEMC36YmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gj59kXFi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0162fa1so1908171e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712310076; x=1712914876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nT1SV3hX5JvG9SEIJKw9S2FaHccnPXvv5uODCQgaeAY=;
        b=gj59kXFi1MvIvh8GibGLCdwkGa/kJooVggxINM78/42vS8KFMjZCfNWiv65DTfReTw
         XbhLJytZTCKrfhmErOJF/RG6v0LAk1qv2Z8mjDAXB4e+2UQjagsZeJiCPasBaiOl1QRV
         shON5fWes3P8AyNbPp8AyCW+n+QWF7+WwsSiywl+JIgA97VINpkKC8p/HFYn+P0Ie1Kd
         Ry8ZCDwTiLCmqLKzTH7uP83IoLjhXrOUIUbQE5mvWZheSssPJJby6nxV7ZoRk2JFgOda
         VmYaxx3DMQFLVJ0ihp3kAFfjGMgQY7338Zs0zvH5czRz6Ba7OROygA0hyTZm6utzdRfj
         +SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712310076; x=1712914876;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT1SV3hX5JvG9SEIJKw9S2FaHccnPXvv5uODCQgaeAY=;
        b=ZuuamtZD98V4XWBAG0plwCbw6ZMx+m/kJ3BP9BFJQZDqN6Agz57yIZM0o/l8Ff19RT
         RH3IvzarHU0fOZCZ3NnktLFl89VRrAVcKpUNcNSVfCd0lqJBWFhrHBPO6KIOAAK5VSi7
         /zZUxgn6lbshVRABPwbsv/nfjJmosIywR1NzxkupXdUtyZHJAIwpvzCY/WkIr8D8AHyp
         pHoYrCquQXe6paXvs7V69NNcnXnc5JDzV2aeYlgyt0Xe40aomL6vA/QMed4/lDqMdj9E
         4jhSo3TLRY2dWBGK4f19mZFupZ6sb/VU0dfDQUzDjOYhprRrBIYe81KTTX3kUv4DUROV
         +eiw==
X-Forwarded-Encrypted: i=1; AJvYcCULzjo+0BbYERGE6LWPaDlX33nWphufGHVAyKXh4v7ZR+HZExYUtW/FN3eAauql8FibRUvrtQWWMMa1f1GKU8YlBVlmuD1AUzu0FpuW
X-Gm-Message-State: AOJu0YyP/xUnB5h4H3zEk+sOkU2qsFmEVnDLRwYIVWVXTRliWWj3+toW
	0erXeGuRaNtsL2UUXhROAYAhryZHgEjPnscWhVBaIyLJie89akZTRFL1MGOgnbc=
X-Google-Smtp-Source: AGHT+IGX/aGyAFYg1g4cxu3TvZXYBcFZq59NLojqzdtrtBQHMqRPOnHJQBjyRrkcwBsOLU07NXsu+g==
X-Received: by 2002:ac2:5636:0:b0:516:d1f0:600f with SMTP id b22-20020ac25636000000b00516d1f0600fmr766011lff.16.1712310076280;
        Fri, 05 Apr 2024 02:41:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c48f000000b0056b0af78d80sm613125edq.34.2024.04.05.02.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:41:15 -0700 (PDT)
Message-ID: <b1fd85b2-8bee-4c99-a0bf-4ffcc243647b@linaro.org>
Date: Fri, 5 Apr 2024 11:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the ath12k
 PCI module
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-6-brgl@bgdev.pl> <87msqm8l6q.fsf@kernel.org>
 <CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
 <87cyr440hr.fsf@kernel.org> <83dccd7e-e690-4803-adb9-aaedcee7dc94@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <83dccd7e-e690-4803-adb9-aaedcee7dc94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 11:37, Krzysztof Kozlowski wrote:
> On 05/04/2024 11:33, Kalle Valo wrote:
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>>> On Mon, Mar 25, 2024 at 3:01 PM Kalle Valo <kvalo@kernel.org> wrote:
>>>>
>>>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>>>
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> +
>>>>> +maintainers:
>>>>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> IMHO it would be better to have just driver maintainers listed here.
>>>>
>>>
>>> Why? What's wrong with having the author of the bindings in the Cc list?
>>
>> If you want follow the ath12k development and review patches then you
>> can join the ath12k list. I'm not fond of having too many maintainers,
>> it's not really helping anything and just extra work to periodically
>> cleanup the silent maintainers.
>>
>> I would ask the opposite question: why add you as the maintainer?
>> There's not even a single ath12k patch from you, nor I haven't seen you
>> doing any patch review or otherwise helping others related to ath12k.
>> Don't get me wrong, I value the work you do with this important powerseq
>> feature and hopefully we get it into the tree soon. But I don't see
>> adding you as a maintainer at this point.
> 
> This is not a maintainer of driver. This is maintainer of bindings, so
> someone who has hardware, datasheets, knowledge and/or interest in
> keeping the bindings accurate.
> 
> All your arguments above suggest you talk about the driver. This is not
> the point here.
> 

And to clarify: I do not have opinion whether Bartosz is a suitable
person here and whether driver maintainers should be instead or not. I
only want to clarify the purpose of the binding maintainer.

Best regards,
Krzysztof


