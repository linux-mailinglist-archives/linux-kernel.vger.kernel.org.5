Return-Path: <linux-kernel+bounces-41039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0983EA98
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86CB1C22D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3011707;
	Sat, 27 Jan 2024 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVQ1bDbh"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E354D2F7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706326023; cv=none; b=LVyozqqQ6e80wdyL9+NMZxbYr/8D1s3/INy8I7V7RfMnL58mGi2n0Hm5ZOUL2Py8i4jOI2Ff/lc/rWTioJX8fpqt9hNH2zgbDhTCWMwbwKsl3Dw/emKPElyIvmR+65aCesyyP5jEOUOvlSJTzri2MfkrlSeBJ9Uucz3kK+oNGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706326023; c=relaxed/simple;
	bh=vO3GB5SjiyyvyNItu6iQXmLSzIp9G8FHklYL5QikadE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZfCGKKFPM/Q5FO0xgHe7kbrqs8AsotE78OOPbFNQMHjVXZnmcK0798AJpawJ31Obzqhp6kVL8RrrwTUBHg2eSICRQ8MGPeR2oOOsxX0kauEUNmKgwwosd6XMe46nvwy7mjn3lobTJMpEAtfganQmj2hImWmYvO4MaPThpMV/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVQ1bDbh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so855975a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706326020; x=1706930820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vO3GB5SjiyyvyNItu6iQXmLSzIp9G8FHklYL5QikadE=;
        b=IVQ1bDbhvsBQrkbigakwR+pYjLv0yNk9EAYuEO8BQXSVFH1a85wEZWm6vB1awlThEx
         DTsOho+24gqPAJnQFS3T3WqrXWE8BsPqkMbQsggWvajq7fK6SEa4n+ox3YymTuSShLB5
         nJob1bEcj+CGeNHu2JPV5rBLKyKE1UWXM6VNhsd58N3ctPiqIOMtobeH+R3Z7mx4VrnE
         XfRA+9PJ6pFpilmNExk9rRxuRNc/gOPuQgNZDKgOhIbFX6LeqODg///4RxhDJaCIXYpp
         qd+e6jlqbqrlnp6Qcv+LdQctXdp3AaSeaIZzIduKFLzkxR4iLT5VvgVXVefuv8uDiH/f
         cWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706326020; x=1706930820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO3GB5SjiyyvyNItu6iQXmLSzIp9G8FHklYL5QikadE=;
        b=X+EkcxiMyvtDf6abuH/o9pf0+KHBdBhCWZUI9IsnLJofy96+/9lLO1RcT8BpHicTqx
         zbphnXVVToS8zTMCjju742IP3Wa9GXXqmC4WNseqKzf82/RocZXwouxrqDmJvFp+JjDK
         Pnm+kEzGdKWkWagGs/PICsXQzuNURndiVhTua6EOA1J5ncTc8LP00HtYyAIaZJJ1cgaO
         EKBoMXOJ5GcF+jP2BDKYg50vcuNVvbz95YLfPdvFmXDg16dunp37/TCJNdo6HTO3rFP9
         zFYC52ZajZQ9tIozZDQyiVqovX/jaRpnvI0jIv7t52gYmE4uiLUiNXC0TZxg+7JZbulh
         3I2g==
X-Gm-Message-State: AOJu0YwqbuUyADHGKvjaN8dPUz2vzd4RneXdTas9+WGXeqrw3YwNw2q4
	ozqa/SI0AhMBoSEaZC5/1r8EwGzSEw87vPMprbyiLqSTHcfxJW/P2N0IXVjYxZY=
X-Google-Smtp-Source: AGHT+IGFus+E14GBgTqTcE42ut/WxLI4Lq0UQnufk3YuYY6YRX1rXs3QqI/hX0WNtVTnPjQ0S5MfGg==
X-Received: by 2002:aa7:d80a:0:b0:55e:bc29:6fcb with SMTP id v10-20020aa7d80a000000b0055ebc296fcbmr15799edq.10.1706326020508;
        Fri, 26 Jan 2024 19:27:00 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0564022b8b00b0055c69e0751fsm1187275edb.3.2024.01.26.19.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 19:26:59 -0800 (PST)
Message-ID: <8d0b72e3-38fb-43c8-92be-ec96a9250f62@linaro.org>
Date: Sat, 27 Jan 2024 03:26:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] spi: s3c64xx: return ETIMEDOUT for
 wait_for_completion_timeout()
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 jassi.brar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-13-tudor.ambarus@linaro.org>
 <CAPLW+4nipUTRek7_=0uUt32kvN4QDSMAMAAzD5Nx_zv3seEgHw@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4nipUTRek7_=0uUt32kvN4QDSMAMAAzD5Nx_zv3seEgHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 20:13, Sam Protsenko wrote:
>> ETIMEDOUT is more specific than EIO, use it for
>> wait_for_completion_timeout().
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> Looks like you missed my R-b tag I added to this patch in your
> previous submission.

My apologies. Adding it here should do the trick, here it is:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

