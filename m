Return-Path: <linux-kernel+bounces-31839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222883355A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465B21C21287
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590110A03;
	Sat, 20 Jan 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuWW2Qdo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA01078D;
	Sat, 20 Jan 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705767267; cv=none; b=gvHaOLfhrYXJbIsH7v9LJXtJLXgmWVnh6wK0i8XLhjkBSoeDpFtXPh2Qw8jforKipjlGUY0Q3B0wP6jCq9iT+lpodgnfE0jzCk6RqW6IMzRYIWMqjrFOhgA1i8QVVvaYk8HKdKffuCjUwsUaxk9b3YzlJlKDy44S0zuQj3QCWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705767267; c=relaxed/simple;
	bh=3j+/C4jBF5YM3bpknW9hCVPHcnBnTMWzqP9GyKMDxao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnFaDlgGj7SSYQ1dyEt5KV+KCDj2For156aIoJ1PpqtubhQ6v6DC92UWCLB3ThaSBlu5RKTB4pguH/A7UFLNy+BDAgGhmeayPkZlHugyPwE5Sdxt+ER5N1ZfEWhE/x6gy1kczRcLesPv+Yp2RpXUXRZG8YZbbAF3bniMblQPkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuWW2Qdo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ea948fe3fso927145e9.0;
        Sat, 20 Jan 2024 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705767264; x=1706372064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsRomkLitq2pOiV7IIgul49mE1iK5bxxrTr0pwfbKxo=;
        b=PuWW2QdoKoXU9RmJgZKMavIXhpndxiwBAbJmty6Fo5pFVU9jKqWUp34I0/330Z+2lW
         CHHdiS3OtKiN9Mv1OW+lnOVb79r0+pJCA/BRU+PKiHJWsuMyffZX9hnbEux0XRCfXZfJ
         Ab9Kw7hSzNgD97afwW/1itA8/8aLA07zhT0bRTe1tMC1rlybVHg0FB7KthF7Q8u0MPbs
         ZHv90/4lWkYcUzDSJvzi5zgwtP7Hb7pu5Zhy/tMtFDrwJh1r9vpfxloHZTFYahfmsCOv
         gRub3mccmH6uAzv5+1PrOKG0SNNRl88Lu+k+lhiBRTpNuARyBuk1rKMA8IbWoiwRV4J3
         CCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705767264; x=1706372064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsRomkLitq2pOiV7IIgul49mE1iK5bxxrTr0pwfbKxo=;
        b=V9CJ37xYCWXWcbUNfgQ46OQGEiVvYQbDZGxKItR5wGwArcIUAFYhlSl1gh40lBxidE
         SJ983Acn8FBp70BvQaEqaSF4mwHGcDN4F/oloHvWQWKFRUqvbbhWIQ6S1so71BrnA/Hi
         N/3uLYI0B/IY7u1mMGXIYSAsRQfNdogeXg1tEPaeC76yRbblxKELUNT9GxWfXB2CykI/
         5Vtc4MkY6GYKGipGAX4uzEsxEOzIfOdBSAVw0KvgCG+cfJc4tF9+cF3bNr+ZafzXkeyU
         BzGM0qi2f1RetFrf58My+UDfLIM1zsj7PvyQQR7RUeOLYMWvZKnG1Dh55VC6ccSEKSDG
         hccA==
X-Gm-Message-State: AOJu0YzOsk81Uss/aMZMHDTQ1njDYLknUHv9QTawBeN31TZvfhxGGz5R
	elU70gFM2ixHHoBrH/Uhic5181Pu/HugbcZ8c6Dic+tr/m3fLciu
X-Google-Smtp-Source: AGHT+IHh3ZkpT9C7+0YrlrpkRX5oWFsCSV7A3DdnMmABdmNlmh2CgGEZerc4uu3CXoVpxT3aRyFY4A==
X-Received: by 2002:a05:600c:a48:b0:40d:885a:55e with SMTP id c8-20020a05600c0a4800b0040d885a055emr817958wmq.143.1705767263484;
        Sat, 20 Jan 2024 08:14:23 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:f5df:1797:cf1:de92? (2a02-8389-41cf-e200-f5df-1797-0cf1-de92.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f5df:1797:cf1:de92])
        by smtp.gmail.com with ESMTPSA id b3-20020a0564021f0300b005545dffa0bdsm12081218edb.13.2024.01.20.08.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 08:14:23 -0800 (PST)
Message-ID: <b349fd4a-c7e3-44f8-9908-2abe24bbd69e@gmail.com>
Date: Sat, 20 Jan 2024 17:14:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: humidity: Add driver for ti HDC302x humidity
 sensors
To: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>,
 jic23@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231211122201.9598-1-579lpy@gmail.com>
 <20231211122940.9791-1-579lpy@gmail.com>
 <d9a84e5b-9e23-4aa9-8e58-0bb9f2b224d7@metafoo.de>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <d9a84e5b-9e23-4aa9-8e58-0bb9f2b224d7@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.01.24 05:17, Lars-Peter Clausen wrote:
> On 12/11/23 04:29, Li peiyu wrote:
>> Add support for HDC302x integrated capacitive based relative
>> humidity (RH) and temperature sensor.
>> This driver supports reading values, reading the maximum and
>> minimum of values and controlling the integrated heater of
>> the sensor.
>>
>> Co-developed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> Signed-off-by: Li peiyu <579lpy@gmail.com>
>> ---
>>   MAINTAINERS                    |   8 +
>>   drivers/iio/humidity/Kconfig   |  12 +
>>   drivers/iio/humidity/Makefile  |   1 +
>>   drivers/iio/humidity/hdc3020.c | 473 +++++++++++++++++++++++++++++++++
> I was just trying to use this driver. Somehow the Makefile and Kconfig
> changes were lost when the patch was applied to the IIO tree.
> 
> 
Apparently only the driver code was added. The new entry in the
MAINTAINERS file is also missing.

Best regards,
Javier Carrasco

