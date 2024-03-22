Return-Path: <linux-kernel+bounces-111230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C481188696C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F740283CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498120DCC;
	Fri, 22 Mar 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVy5mMyf"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92605224ED
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100376; cv=none; b=g/yF+An0ltJKDC+K/Atq4NKcXABRDcT2wx/efWuACTIzK/6IO4/E1LSwOobOz9JjYTSurcdh0LJG2hU8lcFxHIgwwZ4mMRyjdn0fsipjkNvS2tF1t1s1q4JMhaWBk7NlHMgoW0iZS1pZPMPGh6uhINm+T/eoloNkK6IB7bXgMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100376; c=relaxed/simple;
	bh=iKaGHu7VFDCljo+X/R+DU525M8eOtDFvQLYVkXGWhqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuGUp4WUgYFD+gJZYsfKQBgLC7PUVJdUQ106FX1ZGCAH2QXy4sByFiGcOGA4O01Z7jCWfuzeL/8zhYM/ObHBZ8siX+g/DquNEJOFN3MrvTu28A/6vf23G6CE+CzwWRrkZbBLX6SBS46S7aiBTSCxAmM34+cakR6RkWRVHAphWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVy5mMyf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46cca2a979so116031666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100373; x=1711705173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKaGHu7VFDCljo+X/R+DU525M8eOtDFvQLYVkXGWhqI=;
        b=jVy5mMyf03ong1J59SH6krVcSb9h2IDh706zO7jaRQORnVimOxcg2bbPqGh4POyFVj
         0oDtd+KQaM/Zr3RnTWCjV8KFdid1jr4+P1jL4GNowY7RH/0gsnQ/mNQIl9wQ7fDOMkuj
         vH/A6mr3Jnyb+46eJFe6J49/McvQ02cpx1QK5uU/T8RKIKQ3IZ/Wfe2F0E+q+yq0kO5s
         yWZXfRykVD/Kc7n3dGYZW5UNQa7rUA94OuE/vhbJLQKu0wVSClXL4tBtzJHimKD0/KHM
         fPe19xoRrpBS02EqbahTFBDLK4il7QBBdVwgjGmIvJQoIGIMfG+N/g3VW1nZw5UGKm4z
         VwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100373; x=1711705173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKaGHu7VFDCljo+X/R+DU525M8eOtDFvQLYVkXGWhqI=;
        b=THQh7/tE5dCpiugEnPwMYsnqnS8rWIAcF27e02wvjxQcdOKaCK4Pdhh4wRBTU9ai2s
         K21PreNIc0eqcsA2asjZhpKrvmNT7biwFE6zv6yhL6zoYx8VQ5Z9ke9T8aBHzRcS0EeD
         uh5zf79qVtsJNbQyK727k0w1/odtmcml4s8eDaUstb/BSm1IksdCOEsraGohFpO15Ol8
         9NXIH5d0+Lwea3pn4Pea1ilw6Y4kV/1p3FpkL8+sFefcGc92xKf/m8OG5F8HMJcGDPGE
         Rw8cqIZlsRo9hUjzMA6lAijpeuuwPzFu9Lc5GKfZP5Ejoux96SfhIkCN+FqdF9dXtA5q
         yI+g==
X-Forwarded-Encrypted: i=1; AJvYcCW5uA9ScXeNRaDaX5ApnPwBmKcoM1ehYjZN6TKrtHgv1N0l1qVWEXGaS7c6SLLWlyPS0/C63VKJBtHGiplkSKcV69f06MzYB6IDJQG/
X-Gm-Message-State: AOJu0Ywt1BxOS01KcqxSQEa2rwnUsP4Nurn0k4nuiEwQZAyhsk2bPymm
	jRYHgmS24HbrwyenBOg2kTLRAqzdKW9VBzvyf1wKV+KjpfH7eHz5MVjBiep1gl8=
X-Google-Smtp-Source: AGHT+IFdS/wNfVkgLAzNBLe3/39onavyj4PwvV6BXzaBahe1ih49oGZqJ0APqPhqlZak3M8FXBrluA==
X-Received: by 2002:a50:8a84:0:b0:565:6e34:da30 with SMTP id j4-20020a508a84000000b005656e34da30mr1483570edj.21.1711100372846;
        Fri, 22 Mar 2024 02:39:32 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.108.187])
        by smtp.gmail.com with ESMTPSA id ek14-20020a056402370e00b00562d908daf4sm817450edb.84.2024.03.22.02.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:39:32 -0700 (PDT)
Message-ID: <867158d7-0d98-4058-9c2e-6b573ec68516@linaro.org>
Date: Fri, 22 Mar 2024 09:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: samsung: exynos850: fix propagation of SPI IPCLK
 rate
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?B?6rmA7J6s7JuQL0pBRVdPTiBLSU0=?= <jaewon02.kim@samsung.com>
Cc: krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com, alim.akhtar@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, peter.griffin@linaro.org, andre.draszik@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20240229122021.1901785-1-tudor.ambarus@linaro.org>
 <20240229122021.1901785-5-tudor.ambarus@linaro.org>
 <CAPLW+4=jSr6ZsB7XekXsiUBm0SmVpVFnqpgjViuF3=HpT4gRAg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=jSr6ZsB7XekXsiUBm0SmVpVFnqpgjViuF3=HpT4gRAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sam!

On 3/1/24 00:13, Sam Protsenko wrote:
> I fail to see how this patch fixes anything. Instead it looks to me it
> replaces the (already) correctly implemented logic with incorrect one.

I opened another thread asking for feedback on whether it's safe to
re-parent the USI MUX to OSCCLK at run-time, find it here:
https://lore.kernel.org/linux-samsung-soc/71df1d6b-f40b-4896-a672-c5f0f526fb1f@linaro.org/T/#m588abb87eb5fd8817d71d06b94c91eb84928e06b

Jaewon came up with the idea on verifying what the downstream clock
driver does. I added some prints in the driver, and indeed the USI MUX
re-parents to OSCCLK on low SPI clock rates in the GS101 case.

Thus I'll respin this patch set fixing GS101 on low USI clock rates by
re-parenting the USI MUX to OSCCLK. I'll leave exynos850 out if I don't
hear back from you, but I think it deserves the same fix. Allowing SPI
to modify the clock rate of HSI2C/I3C at run-time is bad IMO.
Re-parenting the USI MUX to OSCCLK fixes this problem, HSI2C/I3C will no
longer be affected on low SPI clock rates.

Cheers,
ta

