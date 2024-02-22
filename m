Return-Path: <linux-kernel+bounces-76102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07585F2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C5A1C212CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDE22F19;
	Thu, 22 Feb 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnst1hBl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF622611
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590623; cv=none; b=OHELhuOCQhWt1AxIotAjfg09GbwgKtyRSI5xaI7U6MpJlbI2RI0ZfTN8XeGDlpMYB26m3a2Lfmz9NtObh3+zZ2qO7kScqfX8KiCDSru0NChDZeIW+MDzx4EMxOCkLEalNIYSu1U0Dd2i2ZmsU5CJuvdhtn+wQETnvE1dpdtpACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590623; c=relaxed/simple;
	bh=TDVHbHmjOOuwKIGXLipXVMrG/xOSgCHdDWJzigXFsD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuhE75uxTrhJBVzbhIZ5k0SXQw5UEXZum2s2svup0XThWzXHlK2oSf6Qmjjk+VmwaSMxOaqZpGck/VV/GKXfE792Ih1beYRfkRFt/ZReEIXb1LRhCoBqMQaSnzATQprIXIaMg7B/1nebGKV4eNc9e7XXFQftr6wxaqE7kBNwBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lnst1hBl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso177695166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708590620; x=1709195420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfFl6Nv53g+4pvBn47IPDnhewZ3IGGDlWpzdfZ97p5g=;
        b=Lnst1hBlLD79YokojBGfNqPw7HJcFf4vvVBdE+pIzLrxhHctNfj329ygaH3sIwgQvl
         vRKF53P/lMlNwVhSrHhT8NHh2OrkPphIbvkF64H/v11UgnQGYt0MrFSjTKFcFlIydKRw
         JnvMzzdu13lJpfs2PDot9fKjbkCHGj03RDkUb7Pyy4TOuceEbBC6kSbsx805xsBOt0+Y
         o1VVdEyZD+IbWsCvxnT6yZMNBUsVs8eKlJR1gHy3rFFaupC/T1fxehmeJO4w2l3H43Jd
         6UrJqI+V3WLNzetouS3T76Nsp5Go7eZz52i9s/OfFaP1E2qxjUNAPzPi3qecsy2gXnpX
         hwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590620; x=1709195420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfFl6Nv53g+4pvBn47IPDnhewZ3IGGDlWpzdfZ97p5g=;
        b=AR4VmLejsBeycIzyYgmR4ZOxP3gQ0NrVY2UOhzcKDMwjEEwUmwMIcH4mpVgYBTpZLw
         Bc63mrm4Vq4FDtioHRmzzT34KcM8fMbpPonObosfmD0d/pohbep8spSEb+aRr54OsjBa
         2CksSOlu0/MFHsLXbYBYuYu0k6KxmWkoaBNNlQyz5A1YXUy8q96bXQGOLkP4S/eeKQ8K
         2v4lXuHX+RJxeXmgOe7jyeeiQUtMSrXmqD7UeO2a+P1ZsoHiXNjk7D6pkg4qSTVbbGbW
         FGQwU2iynZxhUM1QwG1c2EjFxF9ku2UpnnQjuX1I/VOtofysCKvBT+6+4XStgNV989EO
         Gihg==
X-Forwarded-Encrypted: i=1; AJvYcCWjbdaFIMCl7fJexBrh2GkccijCar8UeKp8iiHT0X9Ta+vzqv+R5A1qdJuKXrB+JP+JT5Ymmxp85Ez2LVtLP7ZEclvcwl1jytKKPQTa
X-Gm-Message-State: AOJu0YydBLhhb+LNbJ51n2NlMBma4QaAA8niyZsMaEock8Qs9NHRMSeA
	zeAiNZGwafLiGQwTFruEHu139ZJbLhPFqXsm3+Y/W56aHTGV0LhUwEX7m7aCd+E=
X-Google-Smtp-Source: AGHT+IGImmTMlOFAe/o1JwcZ1T7azTD8kxUe9dHesVYTOfpnRc19tZTN5OeMe5epAEbcaB63z54uMw==
X-Received: by 2002:a17:906:d8a8:b0:a3f:4596:c3c8 with SMTP id qc8-20020a170906d8a800b00a3f4596c3c8mr2238058ejb.53.1708590620255;
        Thu, 22 Feb 2024 00:30:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id wg4-20020a17090705c400b00a3d99415705sm5698736ejb.73.2024.02.22.00.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:30:19 -0800 (PST)
Message-ID: <efee9c66-cb84-4f02-91b6-53f2db874b3b@linaro.org>
Date: Thu, 22 Feb 2024 09:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: media: Document bindings for HDMI RX
 Controller
Content-Language: en-US
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 jose.abreu@synopsys.com, nelson.costa@synopsys.com,
 dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com,
 shawn.wen@rock-chips.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-3-shreeya.patel@collabora.com>
 <fd3b7ab7-3702-412f-947a-95396dbe1f4c@linaro.org>
 <1048c3-65d66380-b-49a25c80@188726434>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1048c3-65d66380-b-49a25c80@188726434>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 21:55, Shreeya Patel wrote:
>>> +  - hdmirx-5v-detection-gpios
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/power/rk3588-power.h>
>>> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>>> +    hdmirx_ctrler: hdmirx-controller@fdee0000 {
>>
>> What is hdmirx-controller? Isn't this just hdmi@?
>>
> 
> Writing just hdmi would imply hdmi output I think so that name
> will not be appropriate here.
> 
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
> 
> This documentation doesn't have any generic name for HDMI INPUT
> but maybe we can use the name hdmi-receiver like some other existing
> binding has it here :-
> Documentation/devicetree/bindings/media/i2c/tda1997x.txt

Yes, it is fine. You did not respond to other comments, so I assume you
agree with them.

Best regards,
Krzysztof


