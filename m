Return-Path: <linux-kernel+bounces-32959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD136836279
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7C11F27D78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64373BB37;
	Mon, 22 Jan 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWxKn8xx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EDE3B29A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923914; cv=none; b=BvICbuzdXaO7Ks52BwFpLhaRh4ImQ3g1a4WF+0y9o7Ise/tAyXah0zqfaLRRiJKNVQCa7g1zahLbV3EIQlwXcBMekoy/s3XPunVISHJK9xgnCD8mvU0d7LZCOIOUKkZa/TqrSfYJpeK4X1VE3AdpijrJsBGB7OcAxFnbjJ5VaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923914; c=relaxed/simple;
	bh=lNk8/+YTvlnfK1x79FWZ3OiIUBaRcAopuEESDKbbhg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhflCINudu5prm+wiVS2NZiLcgvRo4gfQ3mxrUDQAS+JqMdsuyimPNyoA6ozcehhkbuLnrvSTH/ERY05OT95qCZOu8Qr6gfs7AgWcYLqRCm6JGQRwxU0lQBwjEHDZhr6e0xm58/S40VbJn/yI18lvtEXvB0f5nUm3mi5yfS1VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWxKn8xx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7b273352so2858761e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705923911; x=1706528711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlootliIImGlh84z0DhVWuVBO4CkhtyLIhApMQlxbRw=;
        b=zWxKn8xx6xslFkxtM1K6EVdWCleVZuX9PAGJzJXVtPgKfUUiT+LB7ez1jk7UdTKuSt
         oza1+yTqFEdbB6GYXvUizKCccEXtJZIObhYY1smhfl2ZAHW7yPoT9Y5kyF+PKq+UGcVT
         C65YBoD/I3Ok2kRHbiO3T69nhpWWPrt+SN126ZJj/FRck3fwc2mIJqw3m6HaQEgOmesr
         lCtedSINutXtq9ajMvacoAFN9JrvrTDVaf1SQjS9sTYb8JG6hcxivdLCMrfx+D6qtqq0
         bDLnYHrZLpcvkKag2cqFuCWTZteWcJp/gLeo1XkENIBhH9OjPRCnX/kvQ0HQZHyM78+i
         ggiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923911; x=1706528711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlootliIImGlh84z0DhVWuVBO4CkhtyLIhApMQlxbRw=;
        b=gOvnmv56Vb0+eUw6JIjZEFkEvlFUxujVAJRb03b4uMVh02Sy1lfpYRVZ1SLryVO8Ot
         KORTVS0nI85fA4UDOGIqYMePLJ4keJmPUZwE8pQjntsm/VeVlbG0uiTMzE5tp9D2Q4Oi
         jGe645Od3pDpHJlsV1raLMky0+UgUTwQY+Gc1rSn5+fe7ZJk1RMYMT2DVYF2NDdjM0sN
         5qFRj+j7T2lJapoey0RhSgWEXX3HvM49levbSW16M30+EWqqnmQ5goxduiktoV/GLgtb
         1uwyYi/mo+sgT+BrMusiScNVmeWgIVvoKMo3+didD2BMfrFrqSYkt+gdA1YDBOlKabtL
         O7Ug==
X-Gm-Message-State: AOJu0YwuoeOrO8NxmHHs3Z17LStvTesrw78wuBwz3FDwiXQJwz14ykvL
	KR69HBJOfkh7vN7bjJCaoia05Tc6Nh/ZrguDBcOcoKAKU91/vtwzDzIngBOR3uc=
X-Google-Smtp-Source: AGHT+IH2FeXD6oQJdkJS5SvzUH5/K5ozG3MkC44wqGNtEOcPAyITe2L5mLRZdSkg2/vRi4OQQGWBLw==
X-Received: by 2002:a19:4f4c:0:b0:50e:9c17:24c8 with SMTP id a12-20020a194f4c000000b0050e9c1724c8mr1560705lfk.7.1705923910798;
        Mon, 22 Jan 2024 03:45:10 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id cw16-20020a170907161000b00a2ebd9e0de7sm6400402ejd.31.2024.01.22.03.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:45:10 -0800 (PST)
Message-ID: <657e013c-29c9-477d-bc01-381dd995e853@linaro.org>
Date: Mon, 22 Jan 2024 11:45:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] clk: samsung: gs101: add support for cmu_peric0
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 andre.draszik@linaro.org, semen.protsenko@linaro.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-4-tudor.ambarus@linaro.org>
 <0b825e9b-b921-4ad6-a4bd-a55645877e9c@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <0b825e9b-b921-4ad6-a4bd-a55645877e9c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 11:13, Krzysztof Kozlowski wrote:
> On 19/01/2024 12:11, Tudor Ambarus wrote:
>> CMU_PERIC0 is the clock management unit used for the peric0 block which
>> is used for USI and I3C. Add support for all cmu_peric0 clocks but
>> CLK_GOUT_PERIC0_IP (not enough info in the datasheet).
>>
>> Few clocks are marked as critical because when either of them is
>> disabled, the system hangs even if their clock parents are enabled.
>>
>> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/clk/samsung/clk-gs101.c | 583 ++++++++++++++++++++++++++++++++
>>  1 file changed, 583 insertions(+)
>>
> 
> This does not apply. Please rebase on my samsung for-next or next
> linux-next and resend.
> 

Oh, yes. I rebased, did a boot test and then sent v5 at:
https://lore.kernel.org/linux-arm-kernel/20240122114113.2582612-1-tudor.ambarus@linaro.org/T/#u

Thanks!
ta

