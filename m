Return-Path: <linux-kernel+bounces-33237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CC8366FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C671C22593
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357A3EA65;
	Mon, 22 Jan 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlN4ARmw"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBC4CB52;
	Mon, 22 Jan 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935457; cv=none; b=lkHedZo21EuzqWMgu3bhwq4LSry0lIMxB2w0erVmeVjb4LRQ4kobwWPmGxxUsAegzr3npfg1CK2JaeZW6cCMaQ8f1usCU0ZVVh6HYsut78eFULKc+EyxrUuXjNYuZkFgULjIm/0LYLqo/Y5d7JMegrraK/cEBjWzOYnPpnP0PF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935457; c=relaxed/simple;
	bh=spHEdjlAJz6awq3PIydFaK3ccnZgwJ1aPu6BJP9NIPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHNm8nkbs2DpagxbL/jHaPXXhMv31ZE0/X2DjEbHXcDOeeSeyvvug5VD0vTKT4z0F1n+NjllkxzrntCoJEsE+YdnXvNwxR94lzXXvZ6D8SkZZ9nXGiQiGLL8mCPS18Yxsg/m+zf/dgiorG02tlveVrUYZavdm/KP4Dl/C5jSxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlN4ARmw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2400433a12.3;
        Mon, 22 Jan 2024 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935455; x=1706540255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KmZWPYJBSOkWieoqR8/ANidiao8Ik7FDtETaXiuMJHY=;
        b=WlN4ARmw4x9a0w55nuZU8lcIfSSq+PTxSqvRQOuicO7dCvuiAcwrCiGbHo95zzjYaS
         VLRUk2n3AFEqQWcKtIysWfux4e+uExEcY2o1keoW9Zlrg+9gSiD9B3UmtJnH4bu8z/pd
         NnbJncRxqz6nHWw9kCbIS7qwfs5Q0qJK3zK0+YCEgMoOE1V1cto0FA4lbctWXBBx7Z/5
         +RyivQwckmkHdOcDOazrojxEugUeN+zHfZ6nJtnsfaXApbQGwkkNmk4by7eb9oanQTRL
         /ldLRUb/vCYYv8OCtyqeBS2h/PGYv7r1KllGc7f/2Hb7N9sIACssTlw6ggCO1WOMFxfF
         TxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935455; x=1706540255;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmZWPYJBSOkWieoqR8/ANidiao8Ik7FDtETaXiuMJHY=;
        b=diN/YKcNpQqXlzRikItTjFzAvDo7tIYoHH9PFO8tIWYjwgHIBy87TZNHs4bYTJSqzC
         +0esL6F+vHt5aGSf6y5f3v+wPVWwCkYarpqhGr4zEQl9nxj0gdrPgeaphfm3E2Vn+zzX
         4AZLW4sDHZL7EWEqBLP2SBt5E3ipAxLx4lenzn5LiuKZcHaCCgR4ZUVBBGtDPyihebkU
         8+a/zUYKWXOoQfrc6dNoObfyf9pTlHMeZpmRlrak49KPUY62tgrNJ+LOjtePeLDsAFKN
         Gqqc7E8uzKGTfvIWjn1rwekX7fx2HqCchrgJ5jsXxWPrILRae38EQJD358tXLMu8p2wd
         6Iqw==
X-Gm-Message-State: AOJu0Yw3b78nXf1aORQ30hPpItklRi6NhdsPpV4jpmXwzL3yPBPnmOlL
	e3S6sG02oNmqfITVNVTCsqepH9V2pkjfIJChvszW/UdZK5s7u+PRVNxoRFbA
X-Google-Smtp-Source: AGHT+IE4n7mW9RShOa0e76OB/+/OmswiUn3ZFEYmE59BNA3dsPajEXEommWuByO46cxNLBdaDQF8uA==
X-Received: by 2002:a17:90b:3782:b0:28f:f2b3:67a9 with SMTP id mz2-20020a17090b378200b0028ff2b367a9mr1825694pjb.77.1705935455266;
        Mon, 22 Jan 2024 06:57:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sn8-20020a17090b2e8800b0028afdb88d08sm9732358pjb.23.2024.01.22.06.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 06:57:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b7dbd5fa-b300-4d6d-b3fc-8cb8e90eefa3@roeck-us.net>
Date: Mon, 22 Jan 2024 06:57:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] adding support for Microchip PAC193X Power Monitor
Content-Language: en-US
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
 robh+dt@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122084712.11507-1-marius.cristea@microchip.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240122084712.11507-1-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 00:47, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> Adding support for Microchip PAC193X series of Power Monitor with
> Accumulator chip family. This driver covers the following part numbers:
>   - PAC1931, PAC1932, PAC1933 and PAC1934
> 
>    This device is at the boundary between IIO and HWMON (if you are
> looking just at the "shunt resistors, vsense, power, energy"). The
> device also has ADC internally that can measure voltages (up to 4
> channels) and also currents (up to 4 channels). The current is measured as
> voltage across the shunt_resistor.
> 
>    I have started with a simple driver (this one that is more appropriate to be
> a HWMON) and willing to add more functionality later (like data buffering that

Not sure I understand what you are trying to say here. This is obviously an iio
driver, not a hwmon driver. Any hwmon related concern is irrelevant.

Guenter


