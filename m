Return-Path: <linux-kernel+bounces-128023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15289550E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4800F2895B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5983CCF;
	Tue,  2 Apr 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhnrdBlQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93907FBBF;
	Tue,  2 Apr 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063763; cv=none; b=P6fMFUHQC5V8G/FNcmnrYJWigqvJOUrFpClsQOAbzusmoP8Y7wFwVLfcB2Tj3NPyhRoWixbnisxZQlWRKKH8ifzzbB/4RbDommr4PGbrmLRUbcbJiilAav+9fwmjZLkGNZRQUcqaYw6apPPrBToLb4Ev8oCC3C0zH0FbwSOSOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063763; c=relaxed/simple;
	bh=JGtn5SmVXrfAeCXFcY4ds7iC9X9Kw8dEpb6xMjrR9i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBXHOyiHlpwtz7TRRU9RaO/Umzue1sZtZYqsfVEOunq/0Ee4GmKZxxVlogJYc62uw7BhrWr6sleV8Cupku1eq3XdEAi/wSGsjmBM0sCIzdKo5i530NXSY5vVACXJ0UJ99VcYSiyP1skDsLC6nD8JKrSlsPBanDzfCEHsn99f46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhnrdBlQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d23be0b6so5632427e87.0;
        Tue, 02 Apr 2024 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063760; x=1712668560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gn8xWTJJGmsAJkVOyZ97/C/lX7XikjN5JjMJhiVZuvk=;
        b=JhnrdBlQUgMJfLIbhRmonX3Ju+RXYEERJ7eziLa0zdGwdQYzQxiPjDx5aDk0936t3P
         rtEo/v30NvVzQt9bKvAGgm1Eh8loAjZ7qJlZPMCfHLlWuLMbSVtcgW5PyEuT6W4rTBZ4
         ZB73DYWulDFYdceem35dM/3992K5GdD1uqzPv2YuZm1OkKegtR6d5FXI5gBKnFAVk9z1
         8eWzHgWmzi1sDm41lSTc6d2UfZQzni1rzHKQ6osBbXmVqouRf4p0JeYdqqSxgPEjmZSe
         FLKQNl0vMi0eZOJ04xSLdYDTmozfrouwellhJjjuTkkUIfrpCCOMmDMX8NeQ16ChbkH3
         kXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063760; x=1712668560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn8xWTJJGmsAJkVOyZ97/C/lX7XikjN5JjMJhiVZuvk=;
        b=PPu6MAxnYjImxEcmMZsFP7EP8Xi449pXUVYPMOIhWGbmsmLPypeWPYXvjrFwENdOdI
         B/iUFHlSjscXDy/cRY49hmdSdvhHh07sNbWoi2g66HweCRNGcZleISThsqSUxMivAsOe
         2tVNO+ycfD39NJbsCyjVMZLyw2/LDCBcaYDZLGQDpy4iP6GwhSNi42yc69LN/5XYDBcl
         /+0f91VA6yVMLPE5zKRIRZxUjUfTRqavIWYv2Ttngk/vsw0U/ISadNjbmSg6aQmqW2Ez
         Xu/v9WCLp7oyGjVzSdpGkOutDaLhJypTR+56CKcCQ3AwXw1wg5Ie7DXRoYZO9OJiNAWX
         g0SA==
X-Forwarded-Encrypted: i=1; AJvYcCUrT9HjdYIo4E9LsdhZZzZHcabE5b+rDsVXAFGIKXZvylUYTm8eLBBZecUHxDwPXUykqI7XRWTeRIpzRnFd1hFMk2xxo1//XO0zbj91g+7aNA7RWYS/WFFyHNk1tDqmj+/XYFSSozvCSw==
X-Gm-Message-State: AOJu0YzaA/X5/flULR6h+DfoKCPw53PyX0Hg0Sg2oH+DsG6zcnC46OuH
	RNo72uLhBA4QzxJ5AzF9bamH/NUvOM0JiD0/G+2ZI3U4UaffmCnW
X-Google-Smtp-Source: AGHT+IEiNyPSpS+I3gdpNA91ay19x/AAY6D2KAcqlZog4YX5tb4kY2Qp/S9fXwRCgSJpkqk4tHtAzw==
X-Received: by 2002:a05:6512:2145:b0:513:ec2a:8fd1 with SMTP id s5-20020a056512214500b00513ec2a8fd1mr10196082lfr.47.1712063758766;
        Tue, 02 Apr 2024 06:15:58 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25fc9000000b00513c86486b5sm1699383lfg.6.2024.04.02.06.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 06:15:58 -0700 (PDT)
Message-ID: <96250478-9b3c-4398-a60e-de5bd02ffbec@gmail.com>
Date: Tue, 2 Apr 2024 16:15:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: Add ROHM BD71828
 system-power-controller property
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240402111700.494004-1-andreas@kemnade.info>
 <20240402111700.494004-2-andreas@kemnade.info>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240402111700.494004-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 14:16, Andreas Kemnade wrote:
> As the PMIC can power off the system, add the corresponding property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

FWIW
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index 11089aa89ec6..0b62f854bf6b 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -73,6 +73,8 @@ properties:
>         used to mark the pins which should not be configured for GPIO. Please see
>         the ../gpio/gpio.txt for more information.
>   
> +  system-power-controller: true
> +
>   required:
>     - compatible
>     - reg

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


