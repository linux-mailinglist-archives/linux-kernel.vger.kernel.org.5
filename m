Return-Path: <linux-kernel+bounces-12016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AA81EEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1541C22662
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD744C6D;
	Wed, 27 Dec 2023 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN9iDgia"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB601446C5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso11145595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703680655; x=1704285455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wesJmWNaOnVZJZpdhuoOdG9dT7HD2sjCO/NjwB5ss78=;
        b=aN9iDgialq29+oBwXFdUYOKDo5tync3/WPOVMH2fDzzG/owVPcp3QZauQZizIX7YlT
         uKLkfrmBF5fhbypspC5jjSPFekS9jTJy2MCuyOWSkX9HlEII68qs7U+SVi9V0Sx7Dswd
         uiN40UvAUpwUkWKfKL2SPD4XMpVJqdvfsw2UilAiz4lRIF0HBI0PPS5QvHy6VO9E6Tlp
         ZxfiY3egfERURYqsSWkF88k/FiczmPDhzioT9ckJyiLAKM1lUgUxFJd7nfc82lVY94C5
         tn7snY4Fb4HBE/vjtEyPzhNdHN0ceKcyWkrYgcIEGXmDWDHSYYA31Tx1bqX7EZaR9AtO
         F3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680655; x=1704285455;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wesJmWNaOnVZJZpdhuoOdG9dT7HD2sjCO/NjwB5ss78=;
        b=H4gWL8TSxRzhomM62+YwNNCD5yN65qUri1XHucCNC5+BUy1eMs/x5AuZEnxMO6JYLS
         0hGEwvOtFX4/iHFPzBxgHyKzqRJt422fJ5MNifob8CW5M4gBLgxA9MtTMVmWYZabGV+f
         0nxLM1KZnkWnigXBZBwqqqOO19ATGS+QE6lt/3FMKhQWyMiAvmDyEI720bwUykU0fkcW
         iP3DOtUYU1FNdqFTSCTFY7k8njWoLDwsfwtIP+f5g6nG/wuK1utW5AbhfgZaW3pNpfDw
         EMx6JDeGd9uUrR3hQMdJGh6Harnwo5wyX+T/m1FTY7PTEp3JlvoUq1kMe9kXZviMsg0l
         zVng==
X-Gm-Message-State: AOJu0YxRXPRW/fSauODr4LyrE/3rC0lyKJx4L9bfmWco4ZljNEk1lFMS
	WfJkX0qJxcZvV9Bk9PPMB/MV4k+dlNeW1A==
X-Google-Smtp-Source: AGHT+IE3D1vGO58uuT1LVhCfsPPlEHD9+fJL3ET72PDrtNP2HNEw7GvowoIy/QUsnurCcZv4kKfSaQ==
X-Received: by 2002:a05:600c:2b0e:b0:40c:31f1:145c with SMTP id y14-20020a05600c2b0e00b0040c31f1145cmr4841175wme.169.1703680654916;
        Wed, 27 Dec 2023 04:37:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm3569893wmq.24.2023.12.27.04.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 04:37:34 -0800 (PST)
Message-ID: <2bf1c818-4a7e-4fe7-9441-471de4a8c469@linaro.org>
Date: Wed, 27 Dec 2023 13:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
 <20231226-support-clearfog-gtr-l8-sfp-v3-1-fd1ac2d6bf2e@solid-run.com>
 <d105c2c5-4d36-4489-b7ac-ae8da74fa9d3@linaro.org>
 <202e7469-60a4-4d8f-87e6-8932c593a877@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <202e7469-60a4-4d8f-87e6-8932c593a877@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2023 13:05, Josua Mayer wrote:
>>> +      - description: Armada 380 SoC
>>> +        items:
>>> +          - const: marvell,armada380
>>> +
>> Thanks for the conversion. I think this is still not what we want. The
>> main problem is of course in the original binding, not your conversion.
>> Compatible armada380 above alone is not correct. This is SoC and SoC
>> compatible cannot be used alone, because it is not specific enough to
>> differentiate boards. Same applies for further lists, which I removed
>> from the quote, for the same reasons.
>>
>> What we could do here is to fix this instead of pure conversion:
>> 1. Add this binding file with new compatibles for existing boards and
>> drop the TXT file, with explanation that you actually document properly
>> all existing board compatibles.
> So - we could add a boilerplate yaml with zero boards in conversion commit,
> and then add new or existing boards through separate commits?

boilerplate YAML file is kind of useless. It's like writing new driver
with adding empty C file and Makefile entry. I understand you want to
split logical items, but there is no logical action as "empty binding file".

> 
> I feel that collecting / fixing the compatibles for all a38x based 
> boards might be a lot of effort.
> Would it be acceptable to start with the few that I know / use myself?
> In addition to those already submitted I could include 
> armada-388-helios4.dts.

Yes, it's fine.

> 
>> 2. Add compatibles to existing DTS.
> For boards I do not know / using codenames - is there a template / 
> generic description string?
>> 3. Add your new board compatibles.
>>
>> At least this is what I would do for typical cases, but as I said
>> before, Marvell here is in some surprising limbo state.
> 
Best regards,
Krzysztof


