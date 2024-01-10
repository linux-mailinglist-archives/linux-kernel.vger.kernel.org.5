Return-Path: <linux-kernel+bounces-22228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0E829B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671611C2191C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF148CC8;
	Wed, 10 Jan 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlibfMCg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92703FB3A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so5179941a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704893069; x=1705497869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvHaK1RgalUg8ozCmF576A/qDpgZcPnqAvpVNUNT6sA=;
        b=GlibfMCg0ba+sOvFuTdb09zn4e+nODYnbJggcjwVtVcaLPDZS9mldog2DoUgodGyRy
         P6qSrywpHmHjsj5XGdNF/2eMIzZdxCRSi+znQj+Cpqk7RHupkejDynbOzfOUFh3AAlGe
         lFEvLtD4fPBYOYuMAMfc7cDY2PPXefz5Qdc+0JP4hW9Vu01YrCmL4jnOxOEYJ2GT3M3I
         EB0FcInGdORjulHJE3kC9j9f466Z/QdN4dN1wY0iII2lZYAqj0FYO8lZZhWpQH9FzTXy
         lpTWfFOsrmVHoPBC428PP1X9oHD8NF5eysdJw+Z3Ots9s/GR6IDKamxEhpryUQcRCe1N
         qxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893069; x=1705497869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvHaK1RgalUg8ozCmF576A/qDpgZcPnqAvpVNUNT6sA=;
        b=aVE+Zf0m4ze1QS0K/WKF/ygRupHDHO5NU1ZhFHZQ1gUDOvI/aHX/WyxBLO49RJ6jMA
         nNpqTPZt5STxupZ43D9qeH5NUujHOOpZ1fKzJ76M0Id7bU3+Gyc2DMmwd8wdORErzRea
         y4wyolV3CgW/I/UWz4FiC7WxSL3Lwhx+alpMyQyAxEksohTuW857JLYH6oJ07gd0pRA/
         kOpb1CcsKLOvUXeSlYQgndwj0wCR6/VibEaDsl43MqYYhKXVyq/8+s34vzulko7yc+EW
         ymUkLDdfEkMtTS6SeVfKyTGds2hgirXkWPhUe3ki5q8UkaCYPMZYK/Jan9x5WsmhyWNe
         5Amg==
X-Gm-Message-State: AOJu0YzacAYt4fD4j9Uv+ilA40YBBkDMFsBX12B/OmApLbwTAnnXoN0u
	3JCXPCVTXWX8C2iQXXN0IrS1N3B93JSsPg==
X-Google-Smtp-Source: AGHT+IHa+zH5OhZRd/yBx9txTf6yHZf8rdV0FDqWpqtvfPG2A3P72VGDePiXto43shC8jaREtpMtxA==
X-Received: by 2002:a17:906:1686:b0:a23:4faa:d4e9 with SMTP id s6-20020a170906168600b00a234faad4e9mr640831ejd.21.1704893068967;
        Wed, 10 Jan 2024 05:24:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906265900b00a27c463fbdesm2091211ejc.211.2024.01.10.05.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:24:28 -0800 (PST)
Message-ID: <445daac6-841a-4335-9b53-689e5bd2530c@linaro.org>
Date: Wed, 10 Jan 2024 14:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: dai-common: Narrow possible
 sound-dai-cells
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
 <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
 <7e312b05-857f-40a6-a1a1-a954dfea7044@sirena.org.uk>
 <f9f5df54-dbeb-4246-b30f-52f3db7d94b3@linaro.org>
 <3b1b956b-985c-45f2-bda3-018aaf897295@sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3b1b956b-985c-45f2-bda3-018aaf897295@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 13:57, Mark Brown wrote:
> On Wed, Jan 10, 2024 at 01:51:03PM +0100, Krzysztof Kozlowski wrote:
>> On 10/01/2024 12:37, Mark Brown wrote:
>>> On Wed, Jan 10, 2024 at 12:07:30PM +0100, Jerome Brunet wrote:
> 
>>>> If restricting things here is really important, defaulting to 0 (with a
>>>> comment explaining it) and letting actual devices then override the
>>>> value would feel less 'made up'
> 
>> Wait, what do you mean by "letting actual devices then override"? It's
>> already like this. Nothing changed. What do you refer to?
> 
> The suggestion is that instead of limiting to 1 and having one device

Nothing limits here to 0. I limit from all technically possible values
to reasonable subset.

> override limit to 0 and have all the devices that need 1 override as
> well.

I don't think that actual default value for this should be provided.
This should be conscious choice when writing bindings and driver.
Similarly we do already for some other #cells:
#io-channel-cells, address/size-cells (dtschema), #mux-control-cells and
others.

I agree we do not restrict all of them, though. However I do not see
single reason to allow developers use 3 as #sound-dai-cells.

Best regards,
Krzysztof


