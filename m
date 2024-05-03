Return-Path: <linux-kernel+bounces-167487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803608BAA29
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A21F22131
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875214F9DF;
	Fri,  3 May 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8qKnF5M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4A13959C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729798; cv=none; b=PE9u7TgmtUBayofEIRtT+2MClRGepFacz8/gvZmYEQOfi3G12/VSbUm3ZFSQWpyI8g10EO2LXLb/Ks3i+fnaqt2wQsld/R7wotEQYyHWZzrI+An1IRIrt1NUewtSwYbpgum6dpszaU7BH9ktGYBdX5lxV1cAKfADlH+yR7cBOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729798; c=relaxed/simple;
	bh=3LrDmRQsKNnunMPXbC7EWhw7STX0WisSOg83GBg9AIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2xHX5XKpHMJxfqvkYyg/Vx/0e+DDfn18u838cti99YUOdjopWnq+OcAYduv8U10apgVlbnr1pp3gug3EVFz5odqoMvDsVmbBJVTWjqJxO8c5RG7vngMD/LE0Kx1JlHLvvT6oQ6gX18IkhMaG8vBZPErr090vvgs6ILDb4rGhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8qKnF5M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41adf155cffso61608085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714729795; x=1715334595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LKTWeNLujJDpv5WJYvNAC9ytQfUmNr0+EX2BojvW9Mw=;
        b=J8qKnF5M449SMejK6JV1jRsX7nSfjX9JFKFF/AmvVj7m8zavkTAW4BxYHJ2GMTMcAX
         oAgUncTcNeW6CCrldMWI3gJFF0LHiRaGT6izIPwDqDjhMrN/lJMUSaFRmbiOHfKmPvWU
         e4ELEyqU9jj+eAfiMoUu+4K8OcXzUEf11lX0+Gy/CGugdieJu0gddfFLRJgOTOVzDQ0V
         8fdenWebyjuSkptDEggV82O7Qy/o+SlOXtB4ezM/Qz8zUw6OhD1WnVA0m0JwmqqYUJ4U
         K9z8mEhmsm/aGqTDzj43noOktPK50bjsZANfOpe+bRkI9bCPIYVEG1oWJRcNPG1j5jEJ
         Qm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729795; x=1715334595;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKTWeNLujJDpv5WJYvNAC9ytQfUmNr0+EX2BojvW9Mw=;
        b=dlcVo9Aksu1jC5sGrD+U8DD746EnzaXoZ10D3/20EzgjCujMA8BjLqoHgh4o9IjyY/
         zQyPtN6rJxITYQ4if8yflnyRyaOp71niKVjS/xWPDIqSTL9nulR6nXwYoihyGjfllFcG
         0QAQ3jTZlmecrNHbxGW43df2UuApnORAwO0nXR4sEOWtCVuDbAX2ecJFEd58ron7xUKE
         VduHox7V8jniFlXWqQ3fGSMvKbfTkc/EQ6a0XPe2QSdg9hSlXcQ2LXjXgNisSfOLXpmD
         IAIFTILUlKzebCnFZiPbN5TQNPuYOfpHBp9V1gwOoo3XQ0u/RjIt6pUEABTtTCc9pWx2
         e6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSQlYcMa9d15l7Yz0itu5RCBFDxfvWrhYyDTditHiUzzN2PqHE89RtN3mgPYTyF5YhCL/wKWc36iBaM3bUXQ7HYnMxGu6f8dLb2NtK
X-Gm-Message-State: AOJu0YxjWBJ3haEfbe9kKmXYFUnzTg5RH76jh/9ymayg0aBfUS8xG5Ye
	LGJMHAgEeRdfylhf/b4hn3mwJNEPP+dIJn1AbxA9L/CWcvKkJZ6ord/mOyylSNcKY9O7Uk1zdIc
	xI+U=
X-Google-Smtp-Source: AGHT+IEfI40a6iSmYG8mIB0oqwq0TBDFtTKfIa/5JpmnC4jZ+ocIwVS0s47muTzX8eqzlquyaYfBTA==
X-Received: by 2002:a05:600c:3554:b0:41b:6dbb:52f9 with SMTP id i20-20020a05600c355400b0041b6dbb52f9mr1682526wmq.39.1714729795116;
        Fri, 03 May 2024 02:49:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b0041496734318sm8775845wmo.24.2024.05.03.02.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 02:49:54 -0700 (PDT)
Message-ID: <ee4daf22-8979-45f7-8e20-3cafd6c3e8f3@linaro.org>
Date: Fri, 3 May 2024 11:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/52] USB: store owner from modules with
 usb_serial_register_drivers()
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
 <ZhzrPA1wP7bER6Pi@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhzrPA1wP7bER6Pi@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 10:54, Johan Hovold wrote:
> On Thu, Mar 28, 2024 at 11:05:38PM +0100, Krzysztof Kozlowski wrote:
>> Merging
>> =======
>> All further patches depend on the first patch.
>>
>> Description
>> ===========
>> This is going to be a bit of a patch-bomb, but with trivial patches, so
>> I think it is still acceptable. If it is too much, apologies and I will
>> solve it.
> 
> No, sending 51 trivial one-line cleanup patches like this is not
> acceptable.
> 
> This is just one logical change so squash them all into one patch for
> the entire subsystem (i.e. this series should contain two patches).
> 

Sure. This is not exactly one logical change, but two, because the first
patch might fix some drivers which forgot to set the owner (even if I
did not identify them).

Best regards,
Krzysztof


