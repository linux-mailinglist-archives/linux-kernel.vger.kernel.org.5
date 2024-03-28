Return-Path: <linux-kernel+bounces-122819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EC88FDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D19A1F2742B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07B7D41D;
	Thu, 28 Mar 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwx0B4h/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B854665
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624465; cv=none; b=RmHDw1/WLQ5I2rxXfYfB117A8r7JAkLRhyrLhtGQrwIarkviA7VuENhXr+SAzPsLi+SqROD8LSZqhZN0yY/N0uHLjLe2/WPttA5Sj2PZJLxdLWDCukm4yXxEEI+Rt5ry4DVAWP/GtBKT5DCPyKtbLxBJw3u12kY1KzduDJVxLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624465; c=relaxed/simple;
	bh=8YPbYAdeFXJMdfqc/yEaJhJyvb96epmPZhyIDWzonCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJQZkFJj4NWWlTW0TGLZ+EncHzindoOcYKxYeUSJ+AzCl6BQe+4mZLxCd+3SmYFRHITKUyxwVxlt5w257m3ptrkP9CcjEz13DFNB9vLy8XXUMv7NkAMd6wXX6M9exgGr+kZUOUmfMTCA32jwapvIuDaoaigokjBBAu7vFp47PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwx0B4h/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bb22ff7baso907343a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711624461; x=1712229261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALYFsv0MuJ1c6KwsM480AASud0mpy25y/UnPkQ1lfXY=;
        b=jwx0B4h/K1Gww/9nWv+Ty/kmu/MyIWJkGdUZCLKM5qRx8BK6VnRCLkL0uCtjxDoVE4
         oX+6hVElwVajr6G4wC57wKWOoTdt5yKZzqXVqUHgQz9DOZ+4LPU2ZVR4kiyANkvKvC8c
         SXPn2ZbgQxAlgDLn7RFR1V1A+Ct2i2ELnPpDnEsqmdlsYE7C38UMrd/QCzHYVYZOK1uf
         khv2F5aJf1z3P+S4nGtZqlJxW3622TRAGY9/wFNarOZjVzZ6bK6321SlxXSOBgy/lKGV
         FMdH7yGWGd1LhQaJbbVjjAFkxTiGSWNtjn1U7RWEd/87BEmZM0l0OJ0sZYNs7j6FGF5p
         Sctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624461; x=1712229261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALYFsv0MuJ1c6KwsM480AASud0mpy25y/UnPkQ1lfXY=;
        b=Xz75uenGxwGQQCI9FRGVirhomyTs2wXjp+vOtHVQYFyqEAcGA+WEaScLlKKP8GbDry
         i5iHgeth0cBZqEcJHhOcp/eBIbU1WYrxdfh7A9oo708yACD0PlMklTfyKYv7jpIGi0iV
         kEpQnDiDwADjtHJlta4OCoIpkz5++M30+eDFyGreDJwo6NOaFaCyPi4ox3SdLGDeF/95
         ws8PxIFcle93EUCr933IC/a8lUhS1k3bEA/PEZWDnPuWFdnJHq4U6rhJP8dUQVszGoKb
         dRO3fBGzpepmU9laV9K+Eo8Cm4FVCug/YMY1FFpVp/mirdEvODDc6gI+p62W6zmsaFgk
         syJg==
X-Forwarded-Encrypted: i=1; AJvYcCUSPqtLMIqXWipm+43oRcR6aeNIS5myxlmR2iCIbHheuf1k5+GqCIeR8r/8eUaXlhC6yLb62aJDiYXMBgbIyypZ4A5OLOcrb/UrsT4t
X-Gm-Message-State: AOJu0YzXZsRmHF0cU+Ue1XkeMPWvRjpMB4nur/hmAorsWjoor9ikO+kY
	I2plYexbuq3NdUzm5jXAefeRwHVXeHxcT27ZzLbJ8vc84/FBjso2LZo1ea1An0Q=
X-Google-Smtp-Source: AGHT+IFDoU7C6TXJhg0CHW0lwJhkfKI5Q9o5dn4LDPIkxj0MNry/BzsX7aYOMOrmAR4h840drOZ3gg==
X-Received: by 2002:a17:906:b057:b0:a4d:b0e9:efb8 with SMTP id bj23-20020a170906b05700b00a4db0e9efb8mr1435796ejb.24.1711624461636;
        Thu, 28 Mar 2024 04:14:21 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.1])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b00a47459e7371sm632117ejc.79.2024.03.28.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 04:14:21 -0700 (PDT)
Message-ID: <5e790f4a-0c31-49f7-8e0d-b87d592f2835@linaro.org>
Date: Thu, 28 Mar 2024 11:14:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: samsung: introduce nMUX for MUX clks that can
 reparented
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 peter.griffin@linaro.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com,
 s.nawrocki@samsung.com, cw00.choi@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, semen.protsenko@linaro.org, linux-clk@vger.kernel.org,
 jaewon02.kim@samsung.com
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
 <20240326172813.801470-2-tudor.ambarus@linaro.org>
 <5af43398-70fc-4598-9453-6a52d758975e@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5af43398-70fc-4598-9453-6a52d758975e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/24 09:56, Krzysztof Kozlowski wrote:
> On 26/03/2024 18:28, Tudor Ambarus wrote:
>> All samsung MUX clocks that are defined with MUX() set the
>> CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
>> reparented during clk_set_rate().
>>
>> Introduce nMUX() for MUX clocks that can be reparented. One user of
>> nMUX() will be GS101. GS101 defines MUX clocks that are dedicated for
>> each instance of an IP (see MUX USI). The reparenting of these MUX clocks
>> will not affect other instances of the same IP or different IPs
>> altogether.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/clk/samsung/clk.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
>> index a70bd7cce39f..01f58b7686db 100644
>> --- a/drivers/clk/samsung/clk.h
>> +++ b/drivers/clk/samsung/clk.h
>> @@ -146,6 +146,26 @@ struct samsung_mux_clock {
>>  #define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
>>  	__MUX(_id, cname, pnames, o, s, w, f, mf)
>>  
>> +/* Used by MUX clocks where reparenting is allowed. */
> 
> ...where reparenting on clock rate change is allowed
> 
> Because otherwise this suggest muxes cannot change :)

Ok.
> 
> No need to resend just for this, I can fix it while applying. Still
> waiting for some review, till EOD.
> 

Andre' suggested I can avoid defining __nMUX() by removing the
CLK_SET_RATE_NO_REPARENT flag from __MUX() and instead add the flag in
the MUX() and MUX_F() definitions. Something like this:


diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index a70bd7cce39f..fb06caa71f0a 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -133,7 +133,7 @@ struct samsung_mux_clock {
                .name           = cname,                        \
                .parent_names   = pnames,                       \
                .num_parents    = ARRAY_SIZE(pnames),           \
-               .flags          = (f) | CLK_SET_RATE_NO_REPARENT, \
+               .flags          = f,                            \
                .offset         = o,                            \
                .shift          = s,                            \
                .width          = w,                            \
@@ -141,9 +141,16 @@ struct samsung_mux_clock {
        }

 #define MUX(_id, cname, pnames, o, s, w)                       \
-       __MUX(_id, cname, pnames, o, s, w, 0, 0)
+       __MUX(_id, cname, pnames, o, s, w, CLK_SET_RATE_NO_REPARENT, 0)

 #define MUX_F(_id, cname, pnames, o, s, w, f, mf)              \
+       __MUX(_id, cname, pnames, o, s, w, (f) |
CLK_SET_RATE_NO_REPARENT, mf)
+
+/* Used by MUX clocks where reparenting on clock rate change is allowed. */
+#define nMUX(_id, cname, pnames, o, s, w)                      \
+       __MUX(_id, cname, pnames, o, s, w, 0, 0)
+
+#define nMUX_F(_id, cname, pnames, o, s, w, f, mf)             \
        __MUX(_id, cname, pnames, o, s, w, f, mf)

I find the suggestion fine. Will submit v3 in a min, addressing all the
comments.

Thanks,
ta

