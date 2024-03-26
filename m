Return-Path: <linux-kernel+bounces-118415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7788BA75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1221F3822B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB754BFF;
	Tue, 26 Mar 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0gJL7kr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343F5810F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434649; cv=none; b=Jf1gV7buKpTP5MJ0AVd1z3MSF7dWBWxHTEiw2crVEbpF8o2t/eI84+LdRCNTfI4PhEv0rkiLVXFppFd7dU5zSlFInBOzOcFhZ2d2o8AdZE0PuFJOHXem3qzipqhMAO6jNS9O/1N36+61Xl0WQsCzX7TbVFbeSRaKYzPxtvyuebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434649; c=relaxed/simple;
	bh=FUJcMJ5WIrNl21GXWnK0zrKAgnGK0z97IPHayeUpCn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2TF6Lg+flSMSI/xlHNlmw6+zI55qfXvp5oE4LFOH4alGcneu1LyMGObT29b63da4CU5ONLFoMBDbFJ+Ivn5yc8nfihtAtXNbnyS1yqZ77tPXq9nN+k/xXdaVoG0P4hSrWTi/paK4mqO/kHdMN6R3dSn83yiaInVKqh4WzLKfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0gJL7kr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so2041760a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711434646; x=1712039446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PyZLais0P0S7a3QnbwG1jwarGKeL/wfFUecKaJc8uoU=;
        b=T0gJL7krMhCekvkxG8hTTvmbOixkqdUUUDR+y0xOWkubJ7/9ccmD1JjVVdwkNw7nPJ
         r7/5DpM7SCV6z6NeBbZZtKC0kS5AqxcB6rVt47mtZMofuygctUKx+Edpaqj19bxke0mo
         dJsDkXUStbahSKwRfgPsSRxcKrOnPGDeSDDa7p+7cdb9m1XolxrfC+duzdLNTXzoLMVt
         +kFxcsXDc78caaMVKbaoj6RJ0nKEdW5dyckt1g8l/Cw0/Q7Imkk7cK6gZvxjp9un2VRW
         OgYk/RyO2YVxy+QubUvXbhwkc22M+O2d65AtlYRh9OaLdVvwBLawyrCsiA8h9ZGjZFvx
         bcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434646; x=1712039446;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZLais0P0S7a3QnbwG1jwarGKeL/wfFUecKaJc8uoU=;
        b=fBAVeQugXfMWCwLB04zI55DwVDUHySVhQ6Nchvr3B10bymp4GY/YXa6kOvyuoBY+CY
         lRN4CuRLWsX2LXsxhKpHG5iv77WfiayHfNPSqgcSp+Wy+AupddRsBiiYcJRnLZGc3cQH
         Uo0pM8Pn8M+/6zA+qXXNpzaDZS6nrIxkgMW3VIqGpMJvb8vgBK13tmTN/xy5r5r5Z47V
         WiqPz1jh19dCEZkR3QKeNcwHBiU2ZURClt4hMMpyUopreQ+s1sR4S8ZDN0/Jv0M9JH/A
         MzcOiQ7yO8CzpgR7CjksmbBDQ/gxokS3UdsCfjXmQZr29KhcZ1UcbZScz6pUrosfkRYS
         NOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtLqdfU5FOxqyRLLogFY8LOX+tLW8hIrpxw+34mR0C59BN3Q6WlD3fzEzMIuXlFh8o7o3venO0LTLywSN8H8Tn+v1J11gdyrRvTM/Z
X-Gm-Message-State: AOJu0YxY/+vbS7m/W8gaSEFfDPZv5wwyZ3XJZUpQ5QtNEHEkP/Vk2hSs
	c2fmQZg5ho6NlMPMcq4V3e1JzM1xvKBQdRnAn7etpL3bBLWnMSW3eiOplljDWjWf4lM4goS2EXm
	h
X-Google-Smtp-Source: AGHT+IGiqkEMIMCfN8VeIzkyEbhOlA27nha84CkBn6o6JgnYBGWGtiau3bW7PGsOVCa+1/5chE0HEQ==
X-Received: by 2002:a50:d5d5:0:b0:568:d74f:bb8e with SMTP id g21-20020a50d5d5000000b00568d74fbb8emr6274519edj.3.1711434645977;
        Mon, 25 Mar 2024 23:30:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7c98e000000b0056c2409ce15sm888733edt.49.2024.03.25.23.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:30:45 -0700 (PDT)
Message-ID: <b13ca51c-db57-4a09-b689-cf27265d348f@linaro.org>
Date: Tue, 26 Mar 2024 07:30:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240325153356.46112-1-l.rubusch@gmail.com>
 <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org>
 <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
 <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org>
 <CAFXKEHaEVwiAW9co0+=kZ5w5a8eWg3QL0dmg38bvrmLdnBEA7w@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFXKEHaEVwiAW9co0+=kZ5w5a8eWg3QL0dmg38bvrmLdnBEA7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 23:09, Lothar Rubusch wrote:
>>
>>
>>>
>>>> the tags. The upstream maintainer will do that for tags received on the
>>>> version they apply.
>>>>
>>>
>>> I'm pretty sure we will still see further iterations. So, I apply the
>>> tags in the next version, already scheduled. Ok?
>>>
>>>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>>
>>>
>>> Going over the books I feel it does not make sense to still mention
>>> feedback ("Reveiewed-by") for the v1 or v2 of the patch here in a v5,
>>> does it? Your link mentiones "However if the patch has changed
>>
>> I don't understand. When did you receive the tag? v3, right? So what do
>> you mean by v1 and v2?
>>
> 
> V1: The first version of the 3wire patch. I have split the single
> patch upon some feedback (yours?!) - V2... So, my current
> interpretation is, that every feedback I need to mention as
> Reviewed-by tag, no?

What? Feedback is not review. It's clearly explained in submitting
patches. Please read it.

Best regards,
Krzysztof


