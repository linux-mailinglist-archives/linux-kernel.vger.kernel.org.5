Return-Path: <linux-kernel+bounces-74436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03285D433
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E614B23E05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED13C493;
	Wed, 21 Feb 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB8uQNK6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1803D0B4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508699; cv=none; b=IOaCGbJK9k1zPOP2E/5IrKY1EOFUdtPEdv50tNmju9ea4WzHiHBEZZuuptKPSQn/mIMg7MG5kD0JzImgzM1P4PGaSTmnq+tZ3XJ6aL9F7/pHo6xuJiqrC2WkMUZgncYVw7bu97Gw24FmrA3wBoIU1dtayC2zRCt1mE2OUSdSC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508699; c=relaxed/simple;
	bh=/opIB55MMYKYaC78niYQAuyhzp2B1CswjFKDPDdn5Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URXQrxrfSwmzornpD3BbaeGCvpm+vIxvSTX2AbrhWs8tvTuEVfd//DnUyEcNcmz3ShBMHTb7xYPVTR7vSQTLCprx/TJ+nuT3LTFgLZ7FF64G+mMAtq4KERgDEoPwpyqTp6bZgABUYr4vq15NFjOYxSb2LmyxloMF+EC0VtFVzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EB8uQNK6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a34c5ca2537so46448566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708508696; x=1709113496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyBaoVH2N/0Qpdr6Z5VWnZpm4sf6QgnERUX3ACGj03I=;
        b=EB8uQNK6VFZNe3WYq8CHMy4J44WMAAaiHCqGROumV+EWVQhMQNGZsULAifrsSRUwgE
         faG/Ze5n6vqAY/giFyBf3/1l9DFRjDtf1B4n87QO40x62e434qQShJKL9QZm9q98gRWd
         5qfx3QlONdPD6P3pwX9QNCdZlPRsWtzQMJCdNlX0tsv4vRdDioLBc+JnqYjb70fZdos4
         31IPELlOJMY1b36lVmx1HlFmYjxb3ywkH9xKjJjbZUCW8Db1cIVFTHEBfXfcomOYrUPy
         Tci+yPSbVQikHaaygoLR9mtYJxxdK/SZb6ADkhYdDfttj5rLcHM503OdN9jsHDysBgQT
         DeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508696; x=1709113496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyBaoVH2N/0Qpdr6Z5VWnZpm4sf6QgnERUX3ACGj03I=;
        b=QLNEvPkSXRA3p37bZKlzxbU/nA5LpRc6FV3JJaCKAnGBg5eRY8cKzxvON7XfH9Gs0p
         LqQmUOfqXFgcAN2xz6JkqR658jKBufC3mMfiB1HD7BvmH75/itdapuRjGTn/ybP9/wzG
         y+jbZodVXwl85MKjoH+7DxX/H0H0f0prIoH3m+7OnoanHRXNtQIUkbVAuY9QEr0WBCMA
         6qhuh9QQVSy8QnQz2ldBab9i8NR+bLqiRziMLO8e844kH/YMy/x0oHiAUKYFcHkNwMz/
         attUgEGNxh3AbdoTQ7vaQtOqYao5nsZIy14AOpKzx6J+gK157B9/IbTnVr3MwHYiyKxm
         V+kg==
X-Forwarded-Encrypted: i=1; AJvYcCUflPplSFa1Z4OejjmHB0HUiSAqIR/oIfchHbapM1xeod7THnRgXLagvz7xE5dDKKl84kHQVcHz+9eaDSfWT/3Gg3RuYIkGLGOQBoNu
X-Gm-Message-State: AOJu0YxboxhQvegyfwxH1aDNUDNMxhHJXhY8VpRUwdoK/rz6XVpiOgIm
	H3VuCqrmikWngGnYN73j4REAKdHkDaQYiIFvqNRa1sm6+LCx/67rAC85wPi9JTQ=
X-Google-Smtp-Source: AGHT+IHKAvnXAoTx45vIQ/qJlrbVDVZ7kPxLCVw3sTsnFfwKS3/tPeqcsbS4/Vw6sYV6b+JfjsNYeA==
X-Received: by 2002:a17:906:2b97:b0:a3f:50ae:52d with SMTP id m23-20020a1709062b9700b00a3f50ae052dmr418708ejg.10.1708508696477;
        Wed, 21 Feb 2024 01:44:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a3e1939b23bsm4464478ejc.127.2024.02.21.01.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:44:55 -0800 (PST)
Message-ID: <7ae0567d-e5d3-4e00-98f7-5139d5879f75@linaro.org>
Date: Wed, 21 Feb 2024 10:44:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
Content-Language: en-US
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson <sean.anderson@seco.com>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 12:52, Krzysztof Kozlowski wrote:
> Hi,
> 
> Dependencies / Merging
> ======================
> 1. Depends on !GPIOLIB stub:
>    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowski@linaro.org/
> 
> 2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch #4
>    (reset: Instantiate reset GPIO controller for shared reset-gpios) depend on OF
>    change (patch #1).


Hi Philipp,

I got acks from GPIO folks. The also provided stable tag with dependency:
https://lore.kernel.org/all/20240213101000.16700-1-brgl@bgdev.pl/
(which BTW already is in mainline, so you could just merge Linus' tree
into your next branch)

Can you take entire patchset?

Best regards,
Krzysztof


