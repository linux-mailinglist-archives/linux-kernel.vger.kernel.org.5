Return-Path: <linux-kernel+bounces-119430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF3D88C8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C658B23664
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3313C9B9;
	Tue, 26 Mar 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRUmGKiv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37E13C90A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469463; cv=none; b=D//F64z6ZpFKGaTR+RxpgxXI9KI5KtGgTch1eFRmxwu5FBEKXezNcMIHwby4nn9l5id+C9QLniFJBAZ0lhV3P3UL94iQTIMmLuD46jVQDHwJwNWpEA/RolbDzx4as56IxA6jpzKx9lqLVfkPmhTc5KwZicI4moAq3DhbNM9uowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469463; c=relaxed/simple;
	bh=KwMXp5AYs6WOVQjryYiZ7EdeG0cvYrV+oZuxAXVaIsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiuASvTGLkN1V1N1Bpg8OksrHV02vjgYNcWyfz63VGGMXweeVxb59t/zAAPj4UP5yOHoC3K9pameA/WXDm5e0K5O+w5H4PGl/WYnlU0ubnzsZ6UEfQRvk68pkkC9o2Si30wJUbx+fVQyDywMAdJoPMX7JLub12vmr0ETsfQWP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oRUmGKiv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso279416766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711469460; x=1712074260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CJEINb2e91P4WW8EGz190gc8mkLNheJ7gLR8cYMnru4=;
        b=oRUmGKivNLUoj6m/eOzQb91DeiVGGgfa+jK2/bWFyh0etETC0Mh1BDuL6UrIQI9/aT
         s2rr828QE//GI7BwvKsB3ypFcFg5Wpunq4xKXwEsz1LthLCjkqu4G5A9zjFA7PGEKyD7
         ru+FDDLujuSFGhidMSKLwL+yDyRgXmQWZJbPo4mpUALUL/cL9cFZdJB1VIcG89aEtOQi
         xDe+AzmG6QQYDpo3RuC33ZbbwxsgCfd6rnfGlj2OybH9JSleoxBBzjgenlLstMLhoUpV
         S+yqfiFiu+FpnEzrjtEUR4FqWE5HVb75vo7OtNnQKs7cQkvCfjHivz8I6syV6JUCasGP
         exfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469460; x=1712074260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJEINb2e91P4WW8EGz190gc8mkLNheJ7gLR8cYMnru4=;
        b=ESM9Zvy0Z49f1Zc71ZM6u01TAMfzxIR/jQ7L2ZpSd6qJ7T8vj2uj+HWtIoWj8WLXru
         /0LyUQlZgpAi4IgPbgR+wtADMJhKQHSIAQiAYspNUPkk+sXdmeQTbhxIfzRCsTcM1uF4
         g+2lQoSk+8aqdGS/LmiqAu3WMu6x4rpL+RPtt01PzdtLAVVcODS6n2rElhKso0BL0S5F
         FifgD3+hDYttwtsr+zLczzLMp1aM7inYlbm4h3FzqsJMXOFLBONBKwe/z/GYYySqyVQ5
         2TzirXc0aOUG+Sfix8ewiBHZw0P4FVDGD9d9zKqDRZpiJqxM0bAQEL6vlKzs65YoRVLX
         S8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWdOkZB/MEc+OFqn2f6P5TDsepB8VIpjCFcLxNAC+iH7pad6HizTDmluz1vcoM28KSMIlL+zHFr3SmZtbseUU2Xipv5OvlVKr4QAJzT
X-Gm-Message-State: AOJu0Yyt2LUMqHJwDDloIqkL13r1V3xoUjtTS4W1G0R0jGzJB4j7Kpon
	aPBL/hRZh8jb0CgMN8mHtFqrGXkxHy1bDIiTixhNM/2afED/J7tGr3p8b4eyCZI=
X-Google-Smtp-Source: AGHT+IEnfovCI/8gs5MyW507wofKNOAGHRO601c++5j8l3aXUe7AMIkTh7rSqBNUzYwqWbwHKTogNw==
X-Received: by 2002:a17:907:8687:b0:a4d:f900:fada with SMTP id qa7-20020a170907868700b00a4df900fadamr1554040ejc.56.1711469459875;
        Tue, 26 Mar 2024 09:10:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id le13-20020a170906ae0d00b00a47464a6ee4sm4006323ejb.173.2024.03.26.09.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:10:59 -0700 (PDT)
Message-ID: <e91bed22-31d0-45b0-8d2a-69bfd361b125@linaro.org>
Date: Tue, 26 Mar 2024 17:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: vmgenid: drop redundant .owner
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20240326075337.55377-1-krzysztof.kozlowski@linaro.org>
 <461a8c3d-460b-4ca4-aa90-b70685958f6f@linaro.org>
 <ZgLY6i7zZDh5uDb0@zx2c4.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgLY6i7zZDh5uDb0@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:17, Jason A. Donenfeld wrote:
> On Tue, Mar 26, 2024 at 09:07:52AM +0100, Krzysztof Kozlowski wrote:
>> On 26/03/2024 08:53, Krzysztof Kozlowski wrote:
>>> Core already sets .owner in acpi_bus_register_driver().
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/virt/vmgenid.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
>>> index b67a28da4702..8f6880c3a87f 100644
>>> --- a/drivers/virt/vmgenid.c
>>> +++ b/drivers/virt/vmgenid.c
>>> @@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
>>>  static struct acpi_driver vmgenid_driver = {
>>>  	.name = "vmgenid",
>>>  	.ids = vmgenid_ids,
>>> -	.owner = THIS_MODULE,
>>
>> This does not make sense and is not correct.  I need to fix
>> acpi_bus_register_driver first(). Please ignore.
> 
> Oh, okay. Does that mean this will resurface as part of a series that is
> core fix + individual driver cleanups subsequently?

Yes.

> 
> You made some comment on the other thread indicating that this
> meant the driver is "clearly abandoned" because of "all this owner
> crap". Wondering if this driver here hits some weird edge case that
> isn't covered by changes made "many years ago" or if something else is
> up.

No, it was just my mistake. Driver is fine, sorry for too fast judging.
It turns out only some xxx_driver set .owner field. Which I think leads
to actual problems, but that's a bit bigger patchset I need to prepare.

Best regards,
Krzysztof


