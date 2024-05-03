Return-Path: <linux-kernel+bounces-167485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F798BAA24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4855F2832C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2814F9DD;
	Fri,  3 May 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSPeEykV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A814F10C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729720; cv=none; b=TOYBDUicwAIfaHNkiVYrEFJxy2eJbMMJyUHjfRy02NniHZUgRC2WJqQHwwBBD5tLTxyP8U/OzXqOO2KTNFo7SBFZWpGq3nIK4NiGdbEXRW02b4cvI0reBxZ/rGYjr9ff+gUG66LTDH24VClP5oa0XendNFiuT+NS3LwDa9SSv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729720; c=relaxed/simple;
	bh=kI+AdC3cA0a0L7SzFHzr3IKTrFVT6gC3wTDkaA5IXO0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gNbMJi1Ir1BQHg3K+wGNpUUGFuLGuaEEh4pZ99rkqvstMtx2DJpmxxKl74gtpcotn5T+ppswWnR+EnEYTTsn+fqerDxwWlVIkpMKWIheSFe/3rkbIuc0Kl5ixpwxuP9vQ3kdOv5tf5igBqv4RelH82b6WTen8gW3aq8f+cfU5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSPeEykV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so70616055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714729717; x=1715334517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSy/53HBsXrM6K3XBe0PPBtBhqSMQv9ta3VtVgt0D6o=;
        b=zSPeEykVdi5sHPePmxtvKaXrv1ET0SrZIVKQ+PM24yxe+faDKFdLX7/AOBWGC2yY9Y
         V5oEOAlFoGsh/OjH3XkC3ZYVwI1KDqI2zPxjyEKAlsEfkZY9JyXk+bTOXbKiMLNHLjsQ
         EcMUDHWRHc8N/6jdgMeZJ1tYf+YBSe8CCzBCTGZWAT964qACjXs+cFCkeOF7/ErwBolV
         OX5mwdSkw5ol5bFIcR7002G7geQ/f6j5vXVlbAj9fmI9LJp9eQndtC/GmuuAvrPPolu5
         WybDQA+cR7nyAgjEUrLTMVbjInuXhbTss6mWZ6GURRV6A1b1kLwRWICwaqwJehXO+mTT
         Ag+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729717; x=1715334517;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSy/53HBsXrM6K3XBe0PPBtBhqSMQv9ta3VtVgt0D6o=;
        b=dQAIexYwb3vbdEm7X6vmCYT7g1NrFiIR3BsWwFuDcrLUyCQ5CWuM5l3nf/33zp3vjZ
         P1bAqvv9thWIlEuk4yivsw14QimEDeQs44A64LqOXIvq5i26Dj/PeoZDIGhPJVR3eWoP
         uHtEanxLmE2nDud0i5dk/rLLJkUTWIRSgw/f1JIGenOixZclzUXq/nnCRMLaZ+zlK4DT
         9yxM6+OLZELnSCnvitKvE345iDAu51hpGRHY34fzMcP4XrmH+SO3jx6q4w3mFjQyXwJP
         q9G8SmCdT6gAGxL02mFoxz/CNAqLNKRn0UHPDwm/f+zMuuZLofp47dw1a14Fu/hEHZI1
         WsLw==
X-Forwarded-Encrypted: i=1; AJvYcCXsSxlAF/Rvv5WySwNV88E5f7Wbe9x5TcKCItcAoqEbpXelu05nva8g5VatqptLSeWzy9A2biTZNKOedtO5PIvKHFG2BpT0d5z3U2QG
X-Gm-Message-State: AOJu0YwHqBhQClsCAZNS3x5DZJOGgRg9OUX8ilMpcM5eQeJ58QfdvPGE
	JWEJcFo5jtE+mSTxBlg0KX50vbZAfKF8CrGNQgxulgn22egYhG93igkj8y4Ayt4=
X-Google-Smtp-Source: AGHT+IEYJhrE6g1L9j8QSQ6A2OUsPgPnGS4Avt0n9K5EXPd+OKVb0Vje4r2MYnmJXr/G6vG3FDgYjw==
X-Received: by 2002:a05:600c:1e09:b0:418:a706:3209 with SMTP id ay9-20020a05600c1e0900b00418a7063209mr2186907wmb.31.1714729716931;
        Fri, 03 May 2024 02:48:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d3-20020a5d6443000000b0034da4e80885sm3317064wrw.59.2024.05.03.02.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 02:48:36 -0700 (PDT)
Message-ID: <ef21450c-9ae6-4515-9b68-32c04369247a@linaro.org>
Date: Fri, 3 May 2024 11:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/52] USB: store owner from modules with
 usb_serial_register_drivers()
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
 <0b771439-ef12-407d-bcf7-7f50466726a6@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0b771439-ef12-407d-bcf7-7f50466726a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 11:46, Krzysztof Kozlowski wrote:
> On 28/03/2024 23:05, Krzysztof Kozlowski wrote:
>> Merging
>> =======
>> All further patches depend on the first patch.
>>
>> Description
>> ===========
>> This is going to be a bit of a patch-bomb, but with trivial patches, so
>> I think it is still acceptable. If it is too much, apologies and I will
>> solve it.
>>
>> Modules registering driver with usb_serial_register_drivers() might
>> forget to set .owner field.
>>
>> Solve the problem by moving this task away from the drivers to the core
>> amba bus code, just like we did for platform_driver in commit
>> 9447057eaff8 ("platform_device: use a macro instead of
>> platform_driver_register").
> 
> Hi Greg,
> 
> Any comments on this patchset? I know your patchqueue is usually busy,
> that's why I did not ping for some time. I just want to know it did not
> end up in some spam folder.

Never mind, I missed Johan's response.

Best regards,
Krzysztof


