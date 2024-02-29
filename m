Return-Path: <linux-kernel+bounces-86704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDAB86C949
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18C01C218D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CA76F05;
	Thu, 29 Feb 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="BrBwoz32"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A20185B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210054; cv=none; b=JgS5pN0Qhwlpana1RS9znrbF/etM6q2lGudOHyMFrbn+zGmOGiExk6qBfBCdooMYQhjYp8emHdEyQ3MZrx8JaIlgp7GM9bTczqIsE0kvnKBc73pG+8UfmAYDouUp/7IGjpjjBP78ZnsLq3dihdZyDuiMlyku+xa0IHXymfd3fzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210054; c=relaxed/simple;
	bh=xkEGfy7d8zBivZmihVMVtEwsaqjjjDrBXICHq66svsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkhK8LbAta16rDkbu8+7vVdJAxFIvQJ3mlpLv7FxUxxkKBdfaQDFFQF+0Y76jIDb7erpAk+5jXUwFu7gMAIlnQRdSkWoaBTe1fVsxfzDi1Mk3F13wjAqXTAOtiXPX0KJ7ZTTmAbM4Uy7CO6bjHqjqK+1b4JuJuwA2UHtV7HiG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=BrBwoz32; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1c51f2fb1so252450b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709210052; x=1709814852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCexcYQzx0d2SnUJdNnjgTSL8kpRco6diT5oBF7z1io=;
        b=BrBwoz328J+ZsWiE3qA9qQIEKJOeKHttw4cAX32uBSrRMaycp0l2djQqTHPtkMuqTu
         j4yo7o8AmTKXs2DO38cITIRtWB0mdNkiD200HqZGxCHE+23jSIBtPoje+/sBeKJWwgIn
         fkCHqsqOMfVzALnjKUPAtTPz5x+R3G0QVsqIp9rC3YaA6dnXriGB79ZJxrW8a0mk4HXW
         xDemdDqa8pdGQJ/lEgrQlLJ54V97wQW/7SKtnpI/Iq5adiosvdjwxE4uwxsb7QLFZykk
         A3txMMVm/7pRfxO9vXxBllBcX0EJM74A6M/R3G3Y8gs2BIX6q9WJ1ks4IA7EdnKsKaxQ
         XE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709210052; x=1709814852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCexcYQzx0d2SnUJdNnjgTSL8kpRco6diT5oBF7z1io=;
        b=XoIgjAnpFArnm5/CNgeusfXJv5xTRi8TEaoKYybNNUgiMh5A3SVYnF9Kijv6JvCQkn
         r65Symm++KtB0K62WDSkVSHSYQuhidTVmSsi6TlM7XAgVDvrUMmhYX8LvsMVAaIeiZ3t
         whLDLIWCDmwowWF7vMVNe58eXbe2TJmoWN4t7JIK+aaF9EU99banT0A0ZpyixINZ3kSB
         pjjKkKUrPjK47PPDwqdiyq2iJJhd/fjpO7E0wo93QKQNRMzUgA85oNKu1TdRcNizS7sG
         EMU90GJG7w4WMW0Wfx2BzpxC9X5UCOALvBXWLm1VfcSyOQxocIha3U5zOW5JeswgkgHj
         x4gg==
X-Forwarded-Encrypted: i=1; AJvYcCU9QGXF3MXJIukOTia8MastPfuau/M1pnPdU9k6cWwz+EsJBtcEItPDsYEGh/XQbBZ5ZcQdtGP43k4QiqQIZQ3YtEpGWoWsp4Hqtlw9
X-Gm-Message-State: AOJu0YwONQRA0Ou4a6/tEHGW9W98tpB0mE4J43UswAsvB4BVtIjEkvMY
	gOYYlfKDok+L8sURqWuolY5RvAtJer2Vhww8eNJ+XrNO5s6RBpJ1/ZrWeoMFLxE=
X-Google-Smtp-Source: AGHT+IHdvaW9rg2XSe3/zcZWIwQAeWvT3Che06ggyJnC3GQQMIyewfFXS0HnuDPtoErdRVpydOllaQ==
X-Received: by 2002:a05:6808:22a4:b0:3c1:c2cf:87e6 with SMTP id bo36-20020a05680822a400b003c1c2cf87e6mr2063771oib.6.1709210051821;
        Thu, 29 Feb 2024 04:34:11 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006e46047fe04sm1149383pfh.204.2024.02.29.04.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 04:34:11 -0800 (PST)
Message-ID: <45386f39-a034-4d70-a6d4-8804c27aadce@tweaklogic.com>
Date: Thu, 29 Feb 2024 23:04:04 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
 <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
 <Zd9tApJClX7Frq20@smile.fi.intel.com>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <Zd9tApJClX7Frq20@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/2/24 03:57, Andy Shevchenko wrote:
> On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote:
>> On 2/28/24 14:24, Subhajit Ghosh wrote:
> 
> ...
> 
>>> +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
>>> +						     intg_old, val2, &gain_new);
>>
>> You don't use the 'ret' here, so maybe for the clarity, not assign it.
>> Or, maybe you wan't to try to squeeze out few cycles for succesful case and
>> check the ret for '0' - in which case you should be able to omit the check
>> right below as well as the call to iio_find_closest_gain_low(). OTOH, this
>> is likely not a "hot path" so I don't care too much about the extra call if
>> you think code is clearer this way.
>>
>>> +	if (gain_new < 0) {
>>> +		dev_err_ratelimited(dev, "Unsupported gain with time\n");
>>> +		return gain_new;
>>> +	}
> 
> What is the difference between negative response from the function itself and
> similar in gain_new?
> 
-ve response form the function is an error condition.
-ve value in gain_new means - no valid gains could be computed.
In case of error conditions from the function, the gain_new is also set to -1.
My use case is valid hardware gain so I went for checking only gain_new.
Matti will be the best person to answer on this.

Regards,
Subhajit Ghosh

