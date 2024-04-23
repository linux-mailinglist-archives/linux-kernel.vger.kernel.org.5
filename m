Return-Path: <linux-kernel+bounces-155505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD88AF2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0586D285C46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1113C9DA;
	Tue, 23 Apr 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEkUoE9y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79155FDA6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887737; cv=none; b=J6lTLTtxsMsuOnZq2hIEoPZG+y7ITURqfoDZxPRt/6kqo9Hl7Hb128tud9//dAMzYH2dr5VbeJsKXA0X4Km194+II78sxnMeRqKPlL8PnDSCqqhcwy+H2yMXzB9CejUfetgOueArUfkqj9WjIoD5XrQE626MsCqKwU8SmoXqtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887737; c=relaxed/simple;
	bh=Ej8/m7SdFnqgrwQhjVcEPBmt81QzHjxp6CjbBxx+vI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOMCnshCCncNlNCpy2GzPR8KQCcxgqyC7LUnJPYc8eUOZavBUmZjZ0s8lnHpnosUw7ZcX8j2M+2CPU2A/PlqGC/U4mbjBM0Tz9tSVIX2TryFQkRgKw5rF0ZSdB3QIcxEMgoNfkz0DnyRzNMCKDPbrhUGKXTiWF8y594X/3O2tVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEkUoE9y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343d7ff2350so4384807f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713887734; x=1714492534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IW7ZL4jAlMLz9cl+B/4SKCxX48cMreRrpQi5eMp0DZg=;
        b=tEkUoE9y3DVtC7F4tWLgm7Zp2XU7lDrqABiC0DIkBdfU/ElB9BYX4H0gqyF3SfzOdr
         wxzGh861JFoFHkSREsajzT8VPhnGTVC3ZWeba4xdK6YgGT/R1OPr2xA6O7K48LmBaJ2V
         nrB5azA+as0e1nBQzE4ThSMGZCxg+QNRaFFnHGSuZFd2yF+rl+gUT4GxC7SWM0m0573B
         X5Z8J9NkAfJBi+cIVpPfRMiObG3FfBg70a069gVywLIxZWt0Y4JXqHwuQgdV8W01wQUy
         YoovHUrozb5UJ1/mngwIgiXR33GYb+5flzNFEVwzi07OsIG931cvSjupbvAd8EqZOiFz
         fOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887734; x=1714492534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IW7ZL4jAlMLz9cl+B/4SKCxX48cMreRrpQi5eMp0DZg=;
        b=nOizdgpYFKCYWdEUZ/qK3CRCEUpVVeEytPLg4wXxUgHwBFr6Zd401XDOEOrg3gl4gy
         gS7XHLJZv5A9qnpwS8Wl0jkNpX2t8Df52AMhU1A64qYjWOroElJkIYLiAu/TzNAxxirI
         Z9OhKQ8iO0jm68muiqTc/IAq+HFNRMnXucOjJKcQjfSHfPkN4DfVI1eETgapTFM9YjMn
         iwzqHNUehMiyFQA7OOtKiGcZzmQmb57qabiTY0nWbLH9zfdBeUIExEImVgFrLDmt7H0y
         UtFhRtSVxcHSxyOL74RhiLAOO1+I7lz/iKomtDzv4Ft1Y4J44u/ImTKhim757H+GdAej
         ADMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEnyQhGdoN8dvYemUOTSgs8+8TYvKaUvysm1B7xKIFaFpe/VSgMEPF1+xyTuapcmmtXUTzYjBdyrAj0bRvN3+Ywj6pkGXqtWGrNINl
X-Gm-Message-State: AOJu0YzX6J6+AWxh8a7bKxafHiu2kUh+KyKdCAQnppTHSMyulhqw805b
	DiRtReDGROGQrQLXAfIo/Ng7j2zi2LbOB4HEFyDtxgJRNCxtx+wycNOMkyZ40Lado1cp5bqu781
	Q
X-Google-Smtp-Source: AGHT+IE8hjf2SDJhBCEz7Eup94Cqf+emuhCs+kF2rRPWSjs9aeWo2uin89OSuJPdxvp0W8z6jY9zNw==
X-Received: by 2002:a5d:69c1:0:b0:343:ef1b:9f69 with SMTP id s1-20020a5d69c1000000b00343ef1b9f69mr11023947wrw.43.1713887733821;
        Tue, 23 Apr 2024 08:55:33 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a6-20020a05600c348600b0041ab78cb237sm2690632wmq.31.2024.04.23.08.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:55:33 -0700 (PDT)
Message-ID: <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>
Date: Tue, 23 Apr 2024 16:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
 <ZiejT5yddioQ8upR@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZiejT5yddioQ8upR@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/04/2024 13:02, Johan Hovold wrote:
> On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
>   
>>   static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
>>   	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>>   	SND_SOC_DAPM_MIC("Mic Jack", NULL),
>> +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
>> +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
>> +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
> 
> Shouldn't these be split in dedicated HDMI and DP jacks too? What if you
> have a machine with HDMI and DP jacks which would otherwise both claim
> "HDMI/DP0"?

These map to the Jack's added as part of qcom_snd_dp_jack_setup and 
belong to DISPLAY_PORT_RX_0, DISPLAY_PORT_RX_1, DISPLAY_PORT_RX_2.

If its going via USB-C DP controller it will be either DP or an HDMI ?

This is the most common naming for the USB-C DP/HDMI jack events.

Qualcomm LPASS in some older SoCs had a dedicated HDMI interface which 
is different to this one.

Usual Other ways to connect HDMI is via external HDMI Bridge using I2S 
interface which totally different to this DP interface.

So none of these will conflict.


hope this clarifies.

thanks,
Srini
> 
> Johan

