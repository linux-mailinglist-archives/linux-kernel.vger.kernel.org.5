Return-Path: <linux-kernel+bounces-76283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4385F52F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C913A1F25DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5839AD7;
	Thu, 22 Feb 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEEOZ8Mf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CA383BD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596146; cv=none; b=GR7GEQVVg1ErMJAhxneL+Ao3TikbM25p16487CJugtG5DDURyMp24CXj3hgRcT7xngtjmXSwozn6czh7YbLc5Cekxrenh4keONnXdSYj0aWvEwsS+SCiOSwbOfCLO04jTlHnEg5ZHl4KTv4Ur7wpnNIsySEb4eMg5GIt3nHHnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596146; c=relaxed/simple;
	bh=NCShy1u2YzpkuTfpCt1D73hQ11t0B995L8aKi10Lgs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxWRsM2vvN+bD+Ao3Ej/srNA0+nIcrMBXvm9FvyQeqCsppJF8JQ+HeVveHgkbEgFQHeRGdqDuwp4aZQPmmP9lTZUXAZZ7Fmz4caty0ZUifjtPmMyurt1zd/MYXnYf4KAMS4Vt8erdsbySB0vrwsnj/6mKuQLIw1UahI4EKrP4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEEOZ8Mf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4128cfb6c1aso975845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708596143; x=1709200943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFYHd6+4AFKoS9s0Ghxng7Vd4m1eqNVYafg51WuAAFY=;
        b=DEEOZ8MfyLXrtVkGfUoSMIGiyUvcb5ptuZfFEZNc4TBjNZmwyq0c2xNv/F0TwaC9KE
         ZZzyytWGJG6VJqU9Bys040AIfztevxWasv25vn7Q39hG6C7sSq3s0CKLbBUVJ/cEyDi/
         c5yRMWNVcql1fm6iU5r6YqOLD1+1Bcvp/pacysRfUOY4IKm+mddxTCKYuoHkOmwjJQrZ
         ZRV4y3W58MaJR7oD6eiMXtoiWEP9rg6Pp/IGsKi9zn6FvUdGlie1CBWo4ejp9+KPnFXY
         3OIzjLukL0YnITW0v7YXdokGBZH6pE4MR3xe76WTArtlDEWJ59uRge78p/8Lz8DjnDzH
         lQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596143; x=1709200943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFYHd6+4AFKoS9s0Ghxng7Vd4m1eqNVYafg51WuAAFY=;
        b=Pi7dnMe+s9BJRMHVtJHjCdu75jU5R+YZVEQFdsYSHLW/+FZqlxmlILlnzNYRMT43A2
         gD6J+iTNFncOR7GhgerjBfMudU3glLnowEzHlY4PYWcevnpWV8WCpZjUj8tGAR8ySTFi
         eVNfsyrXk/wtKDPTFLvEwKcSimuo0LRXvEE1QJ5QnrT4oaXJWdgzLruZM28WHn48q28P
         Uygmu7pQTU83adSp1glgWe0eoqZ1b5IEXUYt+jTe791ht4YMdrPQBzkM51ovmorDRvNj
         kvz/1qbFP5HgV7NtxA+LvBE3faZgPCSKbXCd2FJnIs7nUob0uFW22I90HQlV2bbpzGMx
         taKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+euwcBIYNrzRSeWqftwHojg4PY3obKOpV+20aZlyRu4797lvYDrk40uvZmhfgbC0nJ58RobdMS8F97Th7iaeGZQ7pcx0r+7C3Ph8L
X-Gm-Message-State: AOJu0YzABJbvRrx6HaYbI+kXtMPbgZjPqV9Xbj5F9a5GEi/KSJ6oLBGU
	iXr3tt3GeZ/KYtAjfeY+bzHrEx8vUyf8drghj0GX2JqOXaCPbRZNHJLtHQDZG9X1VrEmPfuTzip
	F
X-Google-Smtp-Source: AGHT+IF3t8KxDgoDIJivDdmBnVEfL+G0xlPoeOkFEyc7ma9OQbx/VZ8G5e7i3Xh2q0TvvIpR1dxcpQ==
X-Received: by 2002:a05:600c:3b16:b0:411:b2f4:16e9 with SMTP id m22-20020a05600c3b1600b00411b2f416e9mr1920979wms.14.1708596142728;
        Thu, 22 Feb 2024 02:02:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i8-20020a05600c354800b004127488c941sm5700224wmq.22.2024.02.22.02.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:02:22 -0800 (PST)
Message-ID: <a4f8fa60-7c03-4946-a135-a405d53f361b@linaro.org>
Date: Thu, 22 Feb 2024 11:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 patrice.chotard@foss.st.com, linux-amlogic@lists.infradead.org
References: <20240221214348.2299636-1-martin.blumenstingl@googlemail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240221214348.2299636-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Martin,

thank you for providing these cleanups.

One question below:


On 21/02/2024 22:43, Martin Blumenstingl wrote:

[ ... ]

>   		/* prescaler within legal range? */
> -		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> +		if (psv < 0 || psv > FIELD_GET(GT_CONTROL_PRESCALER_MASK, ~0))

		FIELD_MAX() ?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


