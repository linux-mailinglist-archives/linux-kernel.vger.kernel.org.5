Return-Path: <linux-kernel+bounces-103321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F887BE07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B81F21839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A6FE0D;
	Thu, 14 Mar 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6wHILmi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813895D8F8;
	Thu, 14 Mar 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424228; cv=none; b=i7iJq6K5Vinkn3Pm1pNoDRsKDbPsF0v7pIqQcTEQZiVSYL7uZ90X+0DYK4sxE+jKQ32imTuOVjpc3yD+03ka+e9vHyPhhFlfP4h1xYQMkXjCtJebTCT0q+TlOkEGj7UY5LvM1pPIdfYE50FP9ye8ybKAeWsAixEpKe6cpH/TfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424228; c=relaxed/simple;
	bh=Tzh1vK/DGy6uJE/2aWSmjyxSpU/ZsuowcH3NnApV4aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pojwfWJ/+fFEZHohYCfYXVEBadJtptXR4lCcmUD4rziZUYWi9lH9aF1iRuTfpOjRNeuE9Xhh0vB78nFp5tV1MsbBse0bWneyqRgJcGdmCyXXv/XDGXF6zz/DwcD9+nKAXUXbnoHx+LFhpAz1HHDIHDaZcto5UqzZCfEmQQwk0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6wHILmi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so792413f8f.1;
        Thu, 14 Mar 2024 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424224; x=1711029024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgAo15gUFSM02p3Cs8MF4SXie/Dp2TjY+57amsz4rcs=;
        b=T6wHILmiYwuk/0AIiDGDjtAzetvZjZj3dD3XPeCAPmCPDwdpgeah0sFBcPlJuuKOYA
         gUBWRaQCEVheBDS3xkeKlFOyzolan290KPlctabnY79QxmooI1D91jrPKpGH2/npZk6l
         q9C7YeT0oQIS0SDqYeNwRPImBViOX/E5OFLLHTk89vLfOS2214kk1cBrqjTCkjbqLBUk
         jYQ1ezz2Zywpy1FnGvi7r5FGTAo9ge5+nU65JbQ3r4g+5FDqEkcCnVmjUBaO7jP7h8Iu
         lK3tJ5lRa8386cbuD06xcGUa75l0Z0F9w7VHgYBKkzP9eHO7weWVInOGAx/dSBPE7Rf8
         +6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424224; x=1711029024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgAo15gUFSM02p3Cs8MF4SXie/Dp2TjY+57amsz4rcs=;
        b=rYWbCj81V8YKaNDVceT5gc4WepLzK9GaLZE8YoxDgGYhplKWyPrbflJS/FKdl5bCL2
         MMLev1MwjX9IvzKQYjX3GmLerw7a5YXUbbNJoDBdnbNi0KVKra16MxRYV0gJU6o2SEdU
         w+KkIOs9x3sp4uyV1r5g71rK2TSX4lRmd7S/EOUQ2ppg1BNgqfpuMpm0fD+gWhXMhXOx
         Ev8RrFIrCCzij7RpPw0JpOkQ+yQJ80Wz85VQNvYyeemWV+9kBorsEUpoG24gNPoI3xgf
         4/VkMpSyPoUVPiSwcUxooJjOys38nq/3je7mj+8EKeB6xCWiyUISXZHYkzaJDk4cqbMI
         IBVg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ji6NXbypmrVa6s+/aAn0DN65xgmpH0a1ne5brD5fi8S0LmfnEvYCemC0dQDFbvQmlPSa13wum1viQdJib/02Bw8zpwXRGG4osvBAy6LfSCqG0tuJ5ZYW1v75DauBzVi2wbIxCMMN3YegMi0bB0aqVeSkiU1EvoB/cc3DZnKv
X-Gm-Message-State: AOJu0Ywwad3nN+PF3nBxJY1rONRnn/s9mlhppe/zjeXQIJpVHJ45OX0B
	bH64E8mv0+gKR6zZj7pVNYwLKEhdO1hYBgc+QcIDwwmaOe3CQJ/SAV4ZMaSTVrc=
X-Google-Smtp-Source: AGHT+IEqKJeR27FJtO7JNugr4TpMAFBBQOgL+/adDzqjA6u6o+ZWg0DvOoXMGlGVERyIxlMYoQ40JQ==
X-Received: by 2002:a5d:4bc1:0:b0:33e:c316:2a51 with SMTP id l1-20020a5d4bc1000000b0033ec3162a51mr1317287wrt.27.1710424223829;
        Thu, 14 Mar 2024 06:50:23 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id bq29-20020a5d5a1d000000b0033ec8b3b3e4sm868372wrb.79.2024.03.14.06.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:50:22 -0700 (PDT)
Message-ID: <2b95a593-225e-47b1-8bda-03240eb0f81e@gmail.com>
Date: Thu, 14 Mar 2024 14:50:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
 <58f07908-127a-438d-84e2-e059f269859b@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <58f07908-127a-438d-84e2-e059f269859b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 13. 19:36 keltezéssel, Konrad Dybcio írta:
> 
> 
> On 3/11/24 16:06, Gabor Juhos wrote:
>> Booting v6.8 results in a hang on various IPQ5018 based boards.
>> Investigating the problem showed that the hang happens when the
>> clk_alpha_pll_stromer_plus_set_rate() function tries to write
>> into the PLL_MODE register of the APSS PLL.
>>
>> Checking the downstream code revealed that it uses [1] stromer
>> specific operations for IPQ5018, whereas in the current code
>> the stromer plus specific operations are used.
>>
>> The ops in the 'ipq_pll_stromer_plus' clock definition can't be
>> changed since that is needed for IPQ5332, so add a new alpha pll
>> clock declaration which uses the correct stromer ops and use this
>> new clock for IPQ5018 to avoid the boot failure.
>>
>> 1.
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>> Based on v6.8.
>> ---
>>   drivers/clk/qcom/apss-ipq-pll.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index 678b805f13d45..11f1ae59438f7 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>>       },
>>   };
>>   +static struct clk_alpha_pll ipq_pll_stromer = {
>> +    .offset = 0x0,
>> +    .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> 
> CLK_ALPHA_PLL_TYPE_STROMER?

I admit that using CLK_ALPHA_PLL_TYPE_STROMER would be less confusing. However
'ipq_pll_offsets' array has no entry for that enum, and given the fact that the
CLK_ALPHA_PLL_TYPE_STROMER_PLUS entry uses the correct register offsets it makes
 little sense to add another entry with the same offsets.

Although the 'clk_alpha_pll_regs' in clk-alpha-pll.c has an entry for
CLK_ALPHA_PLL_TYPE_STROMER, but the offsets defined there are not 'exactly' the
same as the ones defined locally in 'ipq_pll_offsets'. They will be identical if
[1] gets accepted but we are not there yet.

> 
> [...]
> 
>>   static const struct apss_pll_data ipq5018_pll_data = {
>>       .pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
> 
> and here?

The value of the 'pll_type' field is used only in the probe function to decide
which configuration function should be called for the actual PLL. Changing this
means that the probe function must be changed as well.

Originally, I did not want to change this as it is not required for fixing the
bug, but it might worth to do it to avoid further confusion. I will modify that
in the next version.

I also have a small patch-set on top of the current one which reduces the mess
in the driver, but that still needs some testing. Will send it later.

> The L register differs, so the rattesetting done from Linux must
> have never worked anyway?

Probably not, although I did not test the original commit which added IPQ5018
support to the driver.

I have noticed the bug in next-20240130 first, but I had no time to find the
root cause that time. Later it turned out that cpufreq scaling was broken in
v6.8-rc1 on some platforms [2] which has been fixed with 98323e9d7017
("topology: Set capacity_freq_ref in all cases"). This was the change which made
the bug visible on IPQ5018.

1.
https://lore.kernel.org/lkml/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com/
2. https://lore.kernel.org/lkml/75f0bfc7-fb95-409a-a5d9-b00732e892f0@bp.renesas.com/

Regards,
Gabor

