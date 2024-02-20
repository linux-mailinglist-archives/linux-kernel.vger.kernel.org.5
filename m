Return-Path: <linux-kernel+bounces-72440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1585B343
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0A0B21502
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED35A0E8;
	Tue, 20 Feb 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFYu/XWM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F765A0E4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412216; cv=none; b=DacAjjt77DWuXrI1Xu7bTq0LB5yYscEZ253kfSPcfy3p4hiJorFuGmnT0TM+fKn+/SRC1wymji9ALnBE61JC2GZojrxMofuzYHHkak8FbRnuwn3UhT4QH7dKqRiGniI+bKT3vl5XrzXw0nWh9cwep18QmkDrEflVy+xHwSCdTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412216; c=relaxed/simple;
	bh=Qnve8srr+d7k2IoQ8HZTR5t0IM8PBkOsm7uqSwQke1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF8AyWPysWhOENgfr8KidP7IZlPYi2hHyy9FRHYWmYN1BYww6WaEZvxNWJYzQPnttIfC8IiYS+kneCSBaDPXI6Q2kIf4WEvr3RvwI/UbPK23caXpCgS6BLUuG084nJ7AiUWiXGrJBkAAaagOoj7sYfJMYsdwGQcAbP6aSx1Vns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PFYu/XWM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4126f4863f9so1571485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708412213; x=1709017013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XaxgW75VyO9fScBpfnldWfP1qgRL3ra5DMemRw+uks4=;
        b=PFYu/XWMbxDXt3+ZanyOEwbLaKOUin0Y1Mr9XKQh+pNm2u0AwaZVPZnqd5UAl/a6VE
         HoQ5Fft2jI2TvCViU95DkO/C1/QmwlL0FtoNS/v5l9MEHMXab/GwkAXGeAzahnpGZKn4
         ZzyB/6o6zKBvmmq+LUXXXt5Lbb3oXfZW4ZqdznJPQb979lHDBOJd0el6rLLo67LA/Tg1
         hR49Y2tBFo8pWyWb5CFv+hd8aLqQ8pqrEQMXlVl+8oxD79hT6h2RvyRXFxSOX306OrHf
         l2VwyzERBXHiJIq+KSPnp62ox0HYPqiMtzazpFvEmZv4MM89fVaIutLLrMyzGp4Nxbay
         3DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708412213; x=1709017013;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaxgW75VyO9fScBpfnldWfP1qgRL3ra5DMemRw+uks4=;
        b=FslPQCaiumxCkbvSc7R66cFQ06cvLSxsnqmy/bwBJ3/Q2iL33DeLQd4ijzO4CNurU9
         mESk1e1zywLY7VI+vqd085zOBnWG6t2YWNLSKV5AuUFJ5bDz8J05QGBLVZ8CQ9fpAdAZ
         8xcTlqL1GEQlDymmMgIozHLri04sOd1RkTIbzmLpygeIThe7W4xu52x2FLtkf1GiGLqU
         13miCyiUOUdcDW6196GL2EHCN5s5/oLNKaytbBMXXR23WziddE7Gg7YGKVG8h/Kd2rkx
         zoSk9LQrhVJJRxqDA07Gp0xSe2NwbRcvCmmAUO51wrqr1KdPHqPxaBBBtw695BnB8vtX
         CLIw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Xai+JY7yYMWLKRPwjac5burtrPevxO9BMELsjxty5f/9hVFHLju8rnYvJz6WQhcX7azTZ4wzK9zW8U6R/t9xjVqCgmsaHih9IvYZ
X-Gm-Message-State: AOJu0YwtExl76OkfSUrSS4yn5L2cec1fy3ssG4HhNKdJiHwOpk882WzX
	1cenZfE8hvGfKiO3g+jGGP0BLvwHj10XiOhetrDAMg7wzScNfgozVXii377QTVU=
X-Google-Smtp-Source: AGHT+IElwXe8LVOVT8F9QEnILQOeYGjidjNYvcSXK2rPq1F5Ifc3AodFZNQAZNXmNg/vOgo3L51xNg==
X-Received: by 2002:a5d:4e92:0:b0:33b:187c:4ca0 with SMTP id e18-20020a5d4e92000000b0033b187c4ca0mr8190273wru.62.1708412213118;
        Mon, 19 Feb 2024 22:56:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0033cf5094fcesm12339789wrm.36.2024.02.19.22.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 22:56:51 -0800 (PST)
Message-ID: <d25a887e-801d-410b-9ccd-2ec10fb28f23@linaro.org>
Date: Tue, 20 Feb 2024 07:56:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
 semen.protsenko@linaro.org, alexey.klimov@linaro.org,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240208161700.268570-1-peter.griffin@linaro.org>
 <20240208161700.268570-2-peter.griffin@linaro.org>
 <ab1f9285-73ba-4b69-8882-0cf08c508e28@linaro.org>
 <CADrjBPqw9E5foNvZ-ETFZR3mb8=x8CYHz3UUhfJUbBpOi3iKYw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPqw9E5foNvZ-ETFZR3mb8=x8CYHz3UUhfJUbBpOi3iKYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 20:47, Peter Griffin wrote:
>>
>>> +
>>> +     if (property)
>>> +             pmu_np = of_parse_phandle(np, property, 0);
>>> +     else
>>> +             pmu_np = np;
>>> +
>>> +     if (!pmu_np)
>>> +             return ERR_PTR(-ENODEV);
>>> +
>>> +     /*
>>> +      * Determine if exynos-pmu device has probed and therefore regmap
>>> +      * has been created and can be returned to the caller. Otherwise we
>>> +      * return -EPROBE_DEFER.
>>> +      */
>>> +     dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
>>> +                                         (void *)pmu_np);
>>> +
>>> +     of_node_put(pmu_np);
>>
>> You are dropping now referencen from np when property==NULL. This does
>> no look right.
> 
> Good spot, will fix. It seems syscon.c and altera-sysmgr also have the
> same issue.
> 

Do you plan on fixing them as well in such case?

Best regards,
Krzysztof


