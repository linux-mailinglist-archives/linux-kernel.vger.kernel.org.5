Return-Path: <linux-kernel+bounces-129509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F615896BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1700F1F21811
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449813957E;
	Wed,  3 Apr 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pz+5n47K"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA571386C5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139022; cv=none; b=Q+HIjoEAj3Q7PHiQK9x1A8qHv9obJFAPv4+sJgxkNsekcZt2g6tM8M9JmhlOhKCD8lVHLbATEqvlcwudt5lpvx6wZiEK7B+hd8P3IjlISxRTDFAl6jj0c1pJA4UV5C+VkL0eHof6m4rkGQl90w3LBGHZKUr5hG3IYSQ/noBrOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139022; c=relaxed/simple;
	bh=4uGMQrFPmMMy3ZJ9e8HYcL/S0PhoQSY/aYKBvnJjkog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5gqkeNXL0IZVfePuYPfx+7djB03MdlyF3M7aIzqt8/Xiuu8FX6SPsxrfYM4Ku5iQdDbCS/CRUIHhgVGvnUxZ459iwGssjq3kbCwnFJfqPLmV9CktLOn2BWPuaF7T9+bvOE9hSHNLMKZIYBUFyVYiQjxiiq1wi1NoRyngWW3GWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pz+5n47K; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso825038966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712139019; x=1712743819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=myCgdA0h68H3QUNWwYVoFe/9Mdd1M32UgiW7MLHEsoE=;
        b=pz+5n47KmXXjars6V7g/4QXvWsVionbi+LuqEUyBBPeOP5ptWUlhChrbcPnrIlD6F1
         lhARFvpjJjg3qZ8GiBxhBLz4n1NMUllO5+Kh62bjLq/TMovELJfOtj5WbKxAC26OUTLQ
         cFjI2PKFJ83BVYPiUxpJpV532a2SEswikOuv7WR/KbWZ7PBpYTOUDlDVP59HdFs06VH6
         ji5DifLh/OsydCRMRv3jSnvZxV61qx8ZdIkkqEG7pNozvvTv3scY4Rpw5a0EQUsIQgZR
         7t8UsvYCMqqLBbvdTRzjxpqJOBAuHCGOCyU/36MVGBG2gqQ1dx/4xGcpWCauDdP3EyLO
         oGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139019; x=1712743819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myCgdA0h68H3QUNWwYVoFe/9Mdd1M32UgiW7MLHEsoE=;
        b=hxeCK/P6VtOQzWiN1eXDF/pBz/Pq1u0UdfXlrFLaPRpmB8MfnvUbOYoFKzeU2o/E7s
         gMBQzE88OKSpVaRdESISCfKuvUlCHMLuj5NCZ10gRNMRepQJeM4jgwkNaeZrJ4bvLEq+
         CM3dU+eSjLQLaj29kI9Cjvpj5wQja4/4O+UCII+iJgrRE+lhc2rxGM0HLMZyi7ELa8Up
         uOTiDChnKE9BlKPwVvfz3HXR3g82gHVMEQzrUFYY7Xf9dd8oQ3iJGzRz0cE8iqE/iU6V
         eeh+GBH9Q3V3YD7DYoBdkJLVNad2oWOnSYK5QlSGElp6u/bX2gl6+NvOi56Ts0lY/2fQ
         Yinw==
X-Forwarded-Encrypted: i=1; AJvYcCV+0gVUWlfaeAVGovJwTWZSuD0WfBNqwjAY6B4OSHAQi1OebPbColHrN7YlT6z6YemIBBg7oSzvE8b9X+OFMnJUPY7RMPDFFT4fOxPp
X-Gm-Message-State: AOJu0YzJgaozMZrsM6darTfBBbEb1B/t3rTFiVQAg+6pXQBdiQ37zO90
	kf/et1PyXfYOaT+xqfTXRKcOntKXIVWPC8IfyOhxbfeSIHh58ytFLXweFksLnZo7KL0+xOp8uxE
	Z
X-Google-Smtp-Source: AGHT+IFhHhHI7xoYGNaPz0Ae1xelDIgCSGIAHERjeb4kNBN4c48x0Aukr3cvcs9kc7EZChEcXP9iAA==
X-Received: by 2002:a17:906:1914:b0:a47:4b39:ba1c with SMTP id a20-20020a170906191400b00a474b39ba1cmr1452990eje.39.1712139018628;
        Wed, 03 Apr 2024 03:10:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id xf6-20020a17090731c600b00a4e56e4e051sm4693217ejb.94.2024.04.03.03.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 03:10:18 -0700 (PDT)
Message-ID: <92c7ec52-a7a1-4639-aca7-ffeb643ae6b8@linaro.org>
Date: Wed, 3 Apr 2024 12:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe
 unused
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-8-arnd@kernel.org>
 <Zg0kC6uYFOi-UGXl@smile.fi.intel.com>
 <614fc80a-5d2a-43a1-b8d4-48bdb2cc7dc7@linaro.org>
 <Zg0pei7ut5lC9yVC@smile.fi.intel.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zg0pei7ut5lC9yVC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 12:03, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 11:52:12AM +0200, Krzysztof Kozlowski wrote:
>> On 03/04/2024 11:40, Andy Shevchenko wrote:
>>> On Wed, Apr 03, 2024 at 10:06:25AM +0200, Arnd Bergmann wrote:
> 
> ...
> 
>>>> -static const struct of_device_id stmpe_ts_ids[] = {
>>>> +static const struct of_device_id stmpe_ts_ids[] __maybe_unused = {
>>>
>>> __maybe_unused? 
>>>
>>> Why not adding it into .driver as you have done in another patch in this series?
>>
>> Because there is no benefit in this. This is instantiated by MFD, so the
>> only thing you need is entry for module loading.
> 
> Hmm... Seems to me rather a good candidate for MODULE_ALIAS in this case. No?

No, I do not think module alias is for that purpose. This is a valid
compatible, documented and provided by DT so it is expected to be in
of_device_id.

Best regards,
Krzysztof


