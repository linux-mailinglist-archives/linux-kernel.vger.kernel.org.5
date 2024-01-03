Return-Path: <linux-kernel+bounces-15607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9D822EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927181F24619
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6181B298;
	Wed,  3 Jan 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHMvbDq3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF41A720
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso11555945a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289148; x=1704893948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5yn09ffYZPc7aBLokf+bfH+Tett0Gy39mn9i+Z/bJZY=;
        b=FHMvbDq3l4FduL1U91gFrVrmirpdPi606A+9f9H0Yzj9Jq2MergD2QEFfk28XwOLKI
         cFQjTRvVFQS8qcmfRwoM2XD5SJ6e5ZttNxIvnZb+5jdW+0HPyXNRa9mzAMtCrLcCauwV
         J50X2O5dGWOKyGgxqe34/O3KbIqvM6Z47fC5suYQbZS5wLrrdDP7fIIc1O9wrQQQstnw
         MipOc7owJ8jzdckl8g7aKzF0ZoxUSN+1vOx4gijdAtk1M3UV53jRpTne6WVSXTSbk8Mk
         ZcfoCOii+8MKV16ZsJ67La71pQpZ3dk2OtAg9kD1PBDFIbwjMZCwY+d4GMjvxwHg/8zj
         yCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289148; x=1704893948;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yn09ffYZPc7aBLokf+bfH+Tett0Gy39mn9i+Z/bJZY=;
        b=Kr4FK3kOS0yxptbaSrKPPgGRvU9NIWPlKmlS0yxqQUr6fsVLeiNRcqUthwA9VZ+Dsl
         gjmDiy6DaZtUW9GlyS8P4iSM7DOUxvwjAouPOV44ymu2PaviJSKrJeuyB+u1777s9pe6
         vNdgGzheo9ZI++czSKxaRJIvTKWFavyR8x8kCQPM14u4FLkZXffqI6p3fQC0E6NhDi/X
         5aCjT25o405g/O8OlAN+KGA9URDWipR2X8cpp5M30grsDF5b8eo6SsdAdTzhf7Jtc9qF
         MN4+WKmIADncw2arrhRbEsNBffV71Dp0ZZ+K5W90jKgIp2IadM26tQBqGb1mfW+eDkzM
         i7hQ==
X-Gm-Message-State: AOJu0YzvM5k4HSgwoUfWRuEXmV6qoH/jBK832uE+ZL8halzUix4zBOAR
	F4UFR+Z8o3hVqyiaXDqIK2SFld0zETZFbA==
X-Google-Smtp-Source: AGHT+IGACRGMGX0Yf8cFK5MjN5WbNwSG9jrViLn6jwAsqsPJh2xixQVVpDljbKRh92Td3zAvTc9LMA==
X-Received: by 2002:a17:906:71ce:b0:a26:a49a:7d3a with SMTP id i14-20020a17090671ce00b00a26a49a7d3amr9198715ejk.67.1704289148551;
        Wed, 03 Jan 2024 05:39:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id gh13-20020a1709073c0d00b00a2797a545a3sm4926210ejc.193.2024.01.03.05.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:39:08 -0800 (PST)
Message-ID: <cbe43d1e-8de8-4f05-887c-a34b45ee327f@linaro.org>
Date: Wed, 3 Jan 2024 14:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: juno: align thermal zone names with bindings
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com>
 <b9943188-b3f9-472f-bc60-e8e6e043ddf4@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b9943188-b3f9-472f-bc60-e8e6e043ddf4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 11:13, Krzysztof Kozlowski wrote:
> 
>> 'pinctrl-[0-9]+'
>>       4  thermal-zones: gpu1-thermal: 'trips' is a required property
>>       4  thermal-zones: gpu0-thermal: 'trips' is a required property
>>       4  thermal-zones: big-cluster-thermal: 'trips' is a required property
>>
>> Last I checked this, it looked like the length of the child names was
>> limited because the thermal subsys uses the node names for its naming
>> which is limited to 20 chars (with null). Though the regex here allows
>> for 21 chars without nul. Looks like a double off by one error.
> 
> Yes, that's another issue.
> 
>>
>> The thought I had at the time was to make the kernel drop '-thermal'
>> from its names. Might be an (Linux) ABI issue if userspace cares (I
>> think it shouldn't). Also, I'm not sure how the kernel handles the
>> names overflowing. Maybe it is fine and we can just extend the length
>> in the schema from 12 to 18 (plus the 1 starting char).
> 
> The name is used in the "/sys/class/thermal/thermal_zone0/type" file, so
> actually some userspace could depend on it, but it would be affected
> anyway by my renaming of nodes.

Stripping "-thermal" prefix is a bit bigger task, because it is later
used to find the actual nodes. The thermal framework does not store
device_node pointer, but looks up by the name.

There is on-going work around this:
https://lore.kernel.org/all/20231012175836.3408077-2-thierry.reding@gmail.com/

https://lore.kernel.org/all/20231221124825.149141-27-angelogioacchino.delregno@collabora.com/

so I will just fix the DTS (shorten the name) and fix bindings for 11
characters.

Best regards,
Krzysztof


