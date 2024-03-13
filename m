Return-Path: <linux-kernel+bounces-101421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7231987A6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279971F23A58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584C41202;
	Wed, 13 Mar 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTJhJShC"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B440879
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328303; cv=none; b=fpZabxBdSKAzKUpDkjgZH7LEsS2RzFUysEzppEW6aoP5IGxfMJpXyIWvLv9VWHYcWsDMqY/2O0TO0tiJCMA4mttPEgsm1wYFbyiNIcD1t1XJFCzKIS+c7qEICjg/G99u59O4Gzlu5rVGDthCyDMtAlmrQmH4P0UolsnctSPU4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328303; c=relaxed/simple;
	bh=rtHbVnZI/W6fBvspmtIKRsDzeKbatS6a8EbiYUIrurM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idsJ/qG03diUh0aJcqRX6bKDYJ4J/YRNFXDkQKiKVtedQoWqmlRl9Ec6HzJo4lXxtN5K0jgooMlJYQYEaZxFiLe2sZ4PeOIUj13h4vvXc4Wk65Y/auXckKLwGdsVLEctOkdwzk0TlghYaDi3wtObSK5LBv2qzXXa+FKOkIE6Qeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTJhJShC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e17342ea7so3032949f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710328300; x=1710933100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGu108ok/BlzqaUsJF63tRhDYVja7ZGknjz9bScPQ20=;
        b=QTJhJShCiAeU0pcnuYpLvtr9VQpsI6wDx/bxPyhT8dJFwiUK1zbkvriAzTs39NIHVS
         XwYZq2uWEq38eOy6F3WmMbESIX2QqOE0txX/juNYLtyg2h4dcpweoG1jWZN1CgU81g9U
         5tQ9IezJWPX2AjjV90t7lgN+a5dK4cTn1TXglma4B2fX61vUOigPfO9YAmnUpDa+Vq+M
         E8BDI3Pvc9aEfY51sIcrMEXwRpZjD+LzXP91z+MtoTsehfdWFbAPVck1rhvahPAUzdkd
         zrM1bAdsIPletVtmNaXEK0b26mbJKLxBcYF8fpuksE8+JEe6fL3h3sOhtys+n6ETjD8r
         3Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328300; x=1710933100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGu108ok/BlzqaUsJF63tRhDYVja7ZGknjz9bScPQ20=;
        b=F4FILVmKfzaQdpX4P61cfxssNPK5x3eN0rANWdZhjL79C96fAbTGKyN2AphyFxGVL6
         7RHx+kKVJc3tjZ3VHF6ZSwCk14iq9VOUI4GPkI457d6hNXFpuKRomt/TM1IPfIIAK5am
         IR41+Iiw8quwtYrHp8QBEeyqQo16ukyLwn64Zq589sQvxS9I0r0QEJ8UnXLw21Xguso6
         a5VfGa7jRTylg3aSc4QSjWrwsIv9i1Hmvka1m9Fh7QyM+ktaDBG3sjFKZ6Bm9bnWXPwp
         NzgsxMsLa6f2m8r8umEuSlm/ATYYsW+FFKLpxIpzUazcR8anjQWjsmeecEVxLT9TuBmN
         Wdew==
X-Forwarded-Encrypted: i=1; AJvYcCUVYgTF4Uh7GdFTAQQOy/z67Zp7Bt/dIt4zNXbexgVpxOysSJvf3mHddc55BeuOW6F7V4qsMY2RwUSddFZkoq2+zKYV07hrJvsale0I
X-Gm-Message-State: AOJu0YxsUsDrXRUnwDpn9SijiRpa8Dg+vdp/mVLSv9U/yzpOLVzAzp+W
	D5ofmZRR3nkCKiN9ZyRzad4P+0RP2uBj8TdlWcSMpAlzkhaEMSjZ4hon0PPcQp0=
X-Google-Smtp-Source: AGHT+IF4G9WZUEvlQlxg4UeXBzioTEl5qAud9Gps6pFQCLKtagQAg4Fwxva6RxmsZhVomOPQZ0+pUg==
X-Received: by 2002:a5d:408a:0:b0:33e:9311:5fda with SMTP id o10-20020a5d408a000000b0033e93115fdamr1338958wrp.29.1710328300192;
        Wed, 13 Mar 2024 04:11:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q11-20020adff94b000000b0033e95bf4796sm7905988wrr.27.2024.03.13.04.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 04:11:39 -0700 (PDT)
Message-ID: <932168cb-b1a5-43f7-a138-90ec8552c577@linaro.org>
Date: Wed, 13 Mar 2024 12:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-sun4i: Partially convert to a
 platform driver
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240312192519.1602493-1-samuel.holland@sifive.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240312192519.1602493-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2024 20:25, Samuel Holland wrote:
> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
> platform driver") broke the MMIO timer on the Allwinner D1 SoC because
> the IRQ domain is no longer available when timer_probe() is called:
> 
>    [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
>    [    0.000000] Failed to map interrupt for /soc/timer@2050000
>    [    0.000000] Failed to initialize '/soc/timer@2050000': -22
> 
> Fix this by wrapping the timer initialization in a platform driver.
> builtin_platform_driver_probe() must be used because the driver uses
> timer_of_init(), which is marked as __init. Only convert the sun8i
> variants of the hardware, because some older SoCs still need the timer
> probed early for sched_clock().
> 
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


