Return-Path: <linux-kernel+bounces-167491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8F8BAA5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A071C21AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAD14F9FC;
	Fri,  3 May 2024 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0eT+HGN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2D14F9F7
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730055; cv=none; b=Uo0lXKV48concbKdsRptoThG4tQttQor9PNTFxjubGXXZMnPD8e1yduJOr4yRF9gscqeJkdbqDHZXKPzfuxDcZ9GHNeSwb2lsSuHAPqhnLzL+tcJaVIeIAUrsGg7MBZm8epYDsq6qvMsWhqu9Yw+yyAXPD2YU4gQXa+RllUo84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730055; c=relaxed/simple;
	bh=iG60ECYOxrD3aXOMjctmBHv12V8OupZ4cn8B+jtbzBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7XsaQCeH4LywGaO3AyjtrzJO4tCfsACUxdMAVKvpCamh6e7VkscKTC4QL3vsRp02rzQWqgZFwl6XODJkE6WXhwXeanWLbiNwYzv7b+ZBamdja3zzzplYbjSRhEivxAsykkFaE1lDlBbjDFb6tT3/M5f65Q8IM9E76f00ZNy0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L0eT+HGN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so2882866f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714730052; x=1715334852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zfxIJiAlElThfMQHTOaj038sxuSgJSo+cnym6yLTtrY=;
        b=L0eT+HGNffr4PKdnPLgDWiRgb0CYAcWDdcKqK6vH0dqDyJ98BA/fIM4q08NUSmXzBD
         CWk16nLu82o1dLdKat0qdav4Mlwir8k+0rFCUclUBW6HuY914qIgjPXyO2TNDvrzUcAU
         J14SA71P+JLDWnhtubn15EVuHw4y8CPogDVh00NKs6EGyf66utsHVhp2oQm5UGb1QnpV
         0WCopydNWpqMtja3XZRUsHaqxp5SaX8063xtNTXJ7t9beFVxn+7raeTrDi0tMBP4w/No
         NlRzIpXcgNlFrSlHeQLf59Gs9jDomzq4UKeGY7cFIr0pdZJq9+ilOUBD9r21VA1omiWi
         sjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730052; x=1715334852;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfxIJiAlElThfMQHTOaj038sxuSgJSo+cnym6yLTtrY=;
        b=O4lvzl0ri+BYGuCor0M75W0FH1dhLvsMj2skTynFWQE9jDS4QyNs1vjCK0RB9eLW18
         6JdEBX+j+rZ25VAN/XlhB+0RmJc0azC/U+9Es+ZSJzBj6U2mwd1x/gumUgW1EETEx4iV
         3W8WXKRNBl9zu1KFcWhtLm9Q/l5mHS6AfZ/xV0aSRCyzgq8/W0vH4AkLmgmKLpbEagDK
         Y0zs1inm2QWtH2w2Ve2HXjPB4cXabiyJbEMZggNNbUoEWjIuEknwbd3wzi9Futzq+NLr
         LL+c4A235puzaWSu8BxeVWTbKRt3R9DwA0ecMxXfTEeR7Ia1LulA/Ix46l8s/DN5M1MH
         aVtA==
X-Forwarded-Encrypted: i=1; AJvYcCXBJEKuz6T5w9jPEs0FF3R/zo/aT/MUtvsrQ9qf93G+9tIwbCOa3ucGya1ct04x3MiSlbG9LKFzCO/4KuIyzPY3SMxdv38anPNx+Co4
X-Gm-Message-State: AOJu0YzCaT1xl3ldzDfwCUWagY1GBCblCUEAqCihranO2dvqyvmblDeF
	ZJFn3/z9r8yED1em5jfyNQtmZeGv2cboN2UMhxRDolAqR2KDKKZecPwmOqWNoYDacG/Fn4zyGFS
	2m4A=
X-Google-Smtp-Source: AGHT+IH8vCt7vS37/uSWaJNdRHj38YKceu1bjdWmDeQT8pxumVKXXmVnw5BxCBV3faqbLBl96L9lOQ==
X-Received: by 2002:adf:9b98:0:b0:34d:74cb:b048 with SMTP id d24-20020adf9b98000000b0034d74cbb048mr2305099wrc.34.1714730052418;
        Fri, 03 May 2024 02:54:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d420d000000b00346f9071405sm3356457wrq.21.2024.05.03.02.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 02:54:11 -0700 (PDT)
Message-ID: <9c57a066-d21e-4e54-b729-d61051191168@linaro.org>
Date: Fri, 3 May 2024 11:54:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/52] USB: serial: store owner from modules with
 usb_serial_register_drivers()
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
 <20240328-module-owner-usb-serial-v1-1-bc46c9ffbf56@linaro.org>
 <ZhzruFpJPfORWqYv@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhzruFpJPfORWqYv@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 10:56, Johan Hovold wrote:
> On Thu, Mar 28, 2024 at 11:05:39PM +0100, Krzysztof Kozlowski wrote:
>> Modules registering driver with usb_serial_register_drivers() might
>> forget to set .owner field.  The field is used by some of other kernel
>> parts for reference counting (try_module_get()), so it is expected that
>> drivers will set it.
>>
>> Solve the problem by moving this task away from the drivers to the core
>> amba bus code, just like we did for platform_driver in
> 
> "amba"
> 
>> commit 9447057eaff8 ("platform_device: use a macro instead of
>> platform_driver_register").
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/usb/serial/usb-serial.c | 12 +++++++-----
>>  include/linux/usb/serial.h      |  7 +++++--
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
>> index f1e91eb7f8a4..a659f2096a1a 100644
>> --- a/drivers/usb/serial/usb-serial.c
>> +++ b/drivers/usb/serial/usb-serial.c
>> @@ -1459,17 +1459,18 @@ static void usb_serial_deregister(struct usb_serial_driver *device)
>>  }
>>  
>>  /**
>> - * usb_serial_register_drivers - register drivers for a usb-serial module
>> + * __usb_serial_register_drivers - register drivers for a usb-serial module
>>   * @serial_drivers: NULL-terminated array of pointers to drivers to be registered
>> + * @owner: owning module/driver
> 
> Just "module"

Ack for both.

Best regards,
Krzysztof


