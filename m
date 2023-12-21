Return-Path: <linux-kernel+bounces-7988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D743A81B034
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235B4B225C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6F16431;
	Thu, 21 Dec 2023 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhDPG6GN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05015AC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e55f97606so780089e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703146848; x=1703751648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4o29WQBzTF84xFF7dpFsFiRQpl9hdgHiI7WEKT6wg8=;
        b=MhDPG6GNbDyJnLNDq/Ke6mPPIztQBXU95wcCMWexpQxjJG+BKZxlE+w5pltQQH9oRC
         htlkViSW8q+Mo+abzUhRpCPhmW5EJydPB3pPozyNvD5Je8wviED2l/7yGg24L73QQQRv
         c4U3LDs5gH0MNJG7tb98XGluca1yjH5IiPvNQHfMg8Q+xCLwW3DvqSp9E+Dqq6Gpf1iL
         HPgQ+oeQZxe8CH99T1iCUoUchk6u1fX3PKamhu8Q/BLhsHcTQlVwg3wSybKzf/iZBR9r
         qGEYNF4I6eZwFTrRqk1oXMlkE9ERrMyQvAyq0Oz5v9Ja2bTQzfb/OrV4/HNZpaW+I3Je
         8duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703146848; x=1703751648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4o29WQBzTF84xFF7dpFsFiRQpl9hdgHiI7WEKT6wg8=;
        b=CJvM9T5Y3mOiSTAoAjXt2EtLwKTxexpz9HKfo2Xsz2k81L1r1hB6A5HRbLyKz/Hqwa
         iXlC1e/j62eT/RhwOrQUID/+IHQbka/OvuozYlFqXFCSU/thedlSQ4FEoNiIhQi24JEs
         24dTm7PRNzb6AD0nIYl5zU6DAMuaTAqf6HZH2V0GkuQwCahMlwduU6oUlh8EQLChQG2Y
         p0/uOnH4ZQ5Zgtxywsx1AahESgwDtI9dMjV4WmkSEqOm0BP3c7wJ6/ODvdrXZxyKPvQq
         YySWr7IF9OUw8oYnpJcN9QA95ZABHs4KeiMGuqx2olCEkb5/2K1iCB8n02AcvvgAndFU
         3DzA==
X-Gm-Message-State: AOJu0YyYNuts1/p4OOtMPlS+nVjtA9YTICYAfnJxEzWkHMvhWDLAy/Y+
	olAS2ljSZVICQAaGuKFDguem2w==
X-Google-Smtp-Source: AGHT+IF6j/xEo+V+emagAgbodcosd6j6iP+7qeDzepO7VvQ7VzZtmrS4tKh4dw+s39fElkjhleZRjA==
X-Received: by 2002:a05:6512:510:b0:50e:3221:e559 with SMTP id o16-20020a056512051000b0050e3221e559mr3614864lfb.31.1703146848408;
        Thu, 21 Dec 2023 00:20:48 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906689300b00a269597d17bsm686650ejr.147.2023.12.21.00.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:20:48 -0800 (PST)
Message-ID: <9035aff7-49e6-49cf-a8f8-619d3b53c4a5@linaro.org>
Date: Thu, 21 Dec 2023 09:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Content-Language: en-US
To: Ban Feng <baneric926@gmail.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, corbet@lwn.net, kwliu@nuvoton.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com,
 kcfeng0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
 linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
 Bonnie_Lo@wiwynn.com, conor+dt@kernel.org, DELPHINE_CHIU@wiwynn.com,
 linux@roeck-us.net
References: <20231219080021.2048889-1-kcfeng0@nuvoton.com>
 <20231219080021.2048889-2-kcfeng0@nuvoton.com>
 <170297774900.1297817.5593278746406765111.robh@kernel.org>
 <CALz278aJ08fOU2XZMZJJ2Ocp+XwovJ0+nHK-=0dWqbXf+522OA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CALz278aJ08fOU2XZMZJJ2Ocp+XwovJ0+nHK-=0dWqbXf+522OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/12/2023 01:44, Ban Feng wrote:
> Hi Rob,
> 
> On Tue, Dec 19, 2023 at 5:22 PM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Tue, 19 Dec 2023 16:00:20 +0800, baneric926@gmail.com wrote:
>>> From: Ban Feng <kcfeng0@nuvoton.com>
>>>
>>> Adding bindings for the Nuvoton NCT7363Y Fan Controller
>>>
>>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>>> ---
>>>  .../bindings/hwmon/nuvoton,nct7363.yaml       | 62 +++++++++++++++++++
>>>  MAINTAINERS                                   |  6 ++
>>>  2 files changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Our design is based on [1], and adds fan-common.yaml to

Nothing in the patch or cover letter described the dependency.

Best regards,
Krzysztof


