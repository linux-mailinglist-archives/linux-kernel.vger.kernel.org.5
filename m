Return-Path: <linux-kernel+bounces-38085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D240483BAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F1AB23838
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882F134AF;
	Thu, 25 Jan 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fht7J5sm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A412B9C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168360; cv=none; b=EJV572yx1ePeyGV2T8kERD4CTlLthYyTGKXDJWArIn41JFBNNDXMAdIa/cVcxzlg1KbUqvuyWcsy4kBywqiJcTXu6xSYRlbJlYjpDllI84VyAZo+sihB5X8GDhw1WiJrOKnaRvfngTuvvsLwY94ICSVQ6TO8TUlUxRok1j9Pw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168360; c=relaxed/simple;
	bh=Mw5vEDQv7u4zVkX/DvrsT1kbpOxxCwaGJtvj/Ec3hEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT5tFDdr2iIhY6/K/wSj4UGAjPTeBGfvynQDSXqRdp6taS5Mb0FDzUOWv+aGzaFnDYV9zGG1BB6CNLeqSkn06ppwnTDlZbwU1ieBbvx6WnNTjIXazopj1hS//9W6VAh7DbEiGfWjjvZXIetcoRd9CoTVY/f2Xl9Y6u2rH6f8NTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fht7J5sm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so12860755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706168357; x=1706773157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hH0jMx6UHZTKBifmk34GWSzSdS+/3EcRnn013oRzjRk=;
        b=Fht7J5sm9m5XGId5hfOY9kb4IU4dwaNyODFNogIMxqx3jhYoLcH88Z0hUsYjTchQE8
         YbNVyFJfXXhtceqmsuVKgykTUl7mABoaL7e5vZSC0FoPAGpD3gXxi/CmNkChAovZYBjq
         kZKZS4OnKn7EKzLv2vPfAVlz+BfSmZiPXT48CR5EFGxJq4utO+WYw/Tv0tuoVozcHhpg
         m1xOkuSPUsyCJ6BRXhSVPvs1errala3rqKqTr0GZ4CcDnVPafE8h/0dh3bE54m0UTWiR
         A+WhuMmmXfBYmlwKUtwTCvkYQFgR3/QMXSXXnnmcJMQGrUPYVwmiKZD5jCCzNlU1OBTH
         nSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168357; x=1706773157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0jMx6UHZTKBifmk34GWSzSdS+/3EcRnn013oRzjRk=;
        b=c/4MtQjwUTXlldscO7jRTKWyTbOwlpckvKyUHCOr3+E5Fegl8dSBDeRA+Fu8PLSzQ5
         IdgOHAqDQqpjVtuuVwiGhlHLVmCdjhLvJ7F01+HQ1KBj2LrxMt59vJERWhqurcwLZ/PT
         czlYyb839s7WbnwCEU5Ijv9VX4bD2TdxUhPYaXjAAEp5VdttNkc/mRJ/AAdEsOYkgRTT
         9WW4+HJxLmWBqUIzkCijGbyHW5BrUsje6vJgmUuG9QlFhgJqOnD4riXc+74WgvZkqah3
         wd/swblC/0C2bW8Nvw8zI/EjFKfCvv5SnAep1/7xQJfzMc6AibDNCSzz5fr44Ume0KyE
         GD9Q==
X-Gm-Message-State: AOJu0YxY5HrAgxQQ+GW4+muitzAEhbkH2Oyew+mCJgs+fjcwaK0XosTB
	lssz9znTAaQqXLU053UdWk4Ij0BpOnDuVTBjmtscFLDhyWxorT8MVVLzMpSJP50=
X-Google-Smtp-Source: AGHT+IFOytjLNvmjiHVzdf4a427+lqnb2WeSj7VtriuX3UHr11rQpJFezm0gCR++NUoAsyLwbOJbIA==
X-Received: by 2002:a05:600c:1ca2:b0:40d:60ac:16f1 with SMTP id k34-20020a05600c1ca200b0040d60ac16f1mr244533wms.55.1706168356610;
        Wed, 24 Jan 2024 23:39:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b0040e9f7dadc6sm1539709wmb.25.2024.01.24.23.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:39:16 -0800 (PST)
Message-ID: <cc68112f-3863-4f82-b708-7787a4895a88@linaro.org>
Date: Thu, 25 Jan 2024 08:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
 <20240123-sa8295p-gpu-v3-1-d5b4474c8f33@quicinc.com>
 <f6844d28-c7c2-4afa-8520-2e62c608930d@linaro.org>
 <20240124212116.GH2936378@hu-bjorande-lv.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240124212116.GH2936378@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 22:21, Bjorn Andersson wrote:
> On Wed, Jan 24, 2024 at 07:31:34AM +0100, Krzysztof Kozlowski wrote:
>> On 24/01/2024 05:25, Bjorn Andersson wrote:
>>> +# Allow either power-domains or vdd-gfx-supply, not both
>>> +oneOf:
>>> +  - required:
>>> +      - power-domains
>>> +  - required:
>>> +      - vdd-gfx-supply
>>> +  - not:
>>> +      anyOf:
>>> +        - required:
>>> +            - power-domains
>>> +        - required:
>>> +            - vdd-gfx-supply
>>
>> I don't fully understand what you want to achieve here. If only "allow
>> either", so not a "require either", then simpler:
>>
>> https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/
>>
> 
> As discussed in v2, power-domains is currently an optional property in
> this binding and I'm adding vdd-gfx-supply as an alternative to that.
> 

Then go with Rob's syntax - not:required: Much easier code.

Best regards,
Krzysztof


