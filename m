Return-Path: <linux-kernel+bounces-35505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1F83921C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9A71C21799
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27BF5FBB3;
	Tue, 23 Jan 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyeOlW59"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125A5FBA9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022460; cv=none; b=Mwhi1yvygCwbaskMQVHniUsrevILPLPQljp8Uo/sGtkNw3uec971JFsS4BO3oZyNrIxrM6CTpn8M1cDTQVfKtVg9xaoAjAhktTnhYqCzSM0atvQrQuOrHQSeBGY6udIcQsDxreLjY73F3qP93QBYY+uFA6vqpCWgM+LqttNRkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022460; c=relaxed/simple;
	bh=mHO6wOYkQ9uvvHrdU0hkocgK8bYDPoqCHtILZtWStNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tnt6hGL3p6lOlND58gZmImE+/lC6LZlWnEUr04CxSroGhrpl8oSDYq59RqJlo0dhroiwO54xARG7OOarBWmr1Ckgsa/x+/8ICevfkzZ1MjYahYdFd047vHgysABt/YYIzTRmHrzzT4R21j2oP6HdqWx9gNCmAkKM4lOmwlUAg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyeOlW59; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ec32453d5so2181415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706022457; x=1706627257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/UqkQBxw5JOuIjrIL6bmMCRMSSB1fyU93WfLZsklEs=;
        b=OyeOlW59OVYH7XC6u4j+Xz6m26bddntIRM97swbHxgdKEG4Kjk0wz5SIqhQ+1ocJEj
         v86NRXe8IPFjLKPBDA4HNi8Py4GxuCVJzkZsjsDaNk/sJF4yKXDtCVYx6OAIN+EoZ+vD
         AmvyNDfrOXWrzqr1px2ivH6pAimoP+raxZr2PTlSdri9rlRDF1d9OlL4bnsQW9QjQ+pD
         hRw38qBPfiOouPZ2ALEatv9YL3pPJKsIwKIMLQM1qVC6AJ8bykJOvKY7txUZoC5kCcPR
         3/upqNRwImPYMUqphc5yU/vYaij4Asj/4NY4bTDrX2/+Na3WVoWOj3066Nq1Kd2t5nLR
         t7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022457; x=1706627257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/UqkQBxw5JOuIjrIL6bmMCRMSSB1fyU93WfLZsklEs=;
        b=vCyFX9+vdSGfhoWgP/YH+e6aS4vUwFp0b5a3BzHh9zURk3CPfPzV/XCbwX97FtHLzK
         xEwMKbeaF7ZPef9cSFNd5H5tZl8u3rIbGb31DWhzqLOKmHwI1yZdsJ/wIEiqtSFrpzhD
         3loPAOXSi1yhmB2b/Vr5fl9TTi8eLH5azOQSMGWyvimdWA0zCXFrAwgWJqKi4Y1j9arr
         a30eIeX7AUgXk3trEfu858BGzbqwbbbBBAVH8ap6UBoceqONM39iZZIfI3qeluNsDsx4
         vhnWizHeiUiDv/VFn8tFataj1dBbAf32WaRjMWP4UBQH8f8/+qJZX2cbuVEcGjiMSQEF
         gEsA==
X-Gm-Message-State: AOJu0YyKJN5YPyzxOuyTMjJ+S1VKdP82yME6V6FV6UmigF6EUpjB7jsz
	XJzg3SOFBb8bhoJzYN2SKSsU6QOaFYtOqy08D3yMUgO4obOrmuvVIgptk1yUN3k=
X-Google-Smtp-Source: AGHT+IFRQW2M7Oh4ffeCnA1DMn8CRgZ5p8ScNdenBAz5pIAHDu5QDaUqqxrD3duP1+69q34z1wkjOQ==
X-Received: by 2002:a05:600c:2e42:b0:40e:52ce:f05 with SMTP id q2-20020a05600c2e4200b0040e52ce0f05mr558144wmf.70.1706022457525;
        Tue, 23 Jan 2024 07:07:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b003392be82b25sm8026083wrn.86.2024.01.23.07.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:07:37 -0800 (PST)
Message-ID: <7afbabca-e0bb-48a9-8c5a-7582f7ae3a6e@linaro.org>
Date: Tue, 23 Jan 2024 16:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: support NXP i.MX95
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "abelvesa@kernel.org" <abelvesa@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240121114623.1418597-1-peng.fan@oss.nxp.com>
 <273a80a7-2a60-4490-9c3c-c33dc14be9e7@linaro.org>
 <DU0PR04MB9417A8F4230D2C7C76D1550988742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <78e296fb-a3dc-4e00-94bc-91dab7294887@linaro.org>
 <DU0PR04MB94173B34D426181D285B995088742@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU0PR04MB94173B34D426181D285B995088742@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 14:59, Peng Fan wrote:
>> Subject: Re: [PATCH] dt-bindings: clock: support NXP i.MX95
>>
>> On 23/01/2024 14:08, Peng Fan wrote:
>>> Hi Conor, Krzysztof
>>>
>>> I replied you both here.
>>>
>>>> Subject: Re: [PATCH] dt-bindings: clock: support NXP i.MX95
>>>>
>>>> On 21/01/2024 12:46, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Add i.MX95 clock dt-binding header file
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> This should be squashed with respective binding patch.
>>>
>>> i.MX95 use SCMI firmware, the SCP processor handles
>>> clock/power/pinmux/reset/performance and etc.
>>>
>>> I just add the index that SCMI exports, and Linux/UBoot will use the
>>> index and go through SCMI to do real HW configuration.
>>>
>>> In such case, should I still add HW information in a yaml binding doc?
>>> I am not sure what should be added if yes.
>>
>> Then why do you need it in the binding? I don't see any use of this.
> 
> ok, should I just add the clk index header in same folder as soc dtsi?

I don't know yet. How are these being used, except SCMI firmware?

Best regards,
Krzysztof


