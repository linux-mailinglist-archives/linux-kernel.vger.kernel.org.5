Return-Path: <linux-kernel+bounces-81980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B8867D48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3398B2948B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8DC137C44;
	Mon, 26 Feb 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBj/g1qD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDB12DD89;
	Mon, 26 Feb 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966444; cv=none; b=Auh7ofS/97LeT03Qt45z6OqyhPke9YSLbkmk6eIwDg0sxnIaIViCy1rMBsJQQZB1CkcV6sGyiv8/0L5U6vpEUHk4TMV/QFV3BqeypfLi5I2ud54zW74HIgUhHCLc8NhfP4MXzzmRcM9uLRirIY9jiZ5mG+Z3NmQVmMGgPvlA5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966444; c=relaxed/simple;
	bh=ZNQwic6Q4fKlDucDcdzUqvIVEiifAuRRooU0/hV0Klk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIyMOF0614i5W4gpeR0W7ategiLTsMaxlG43vkWOyJDZMeWd1TFbuqKmbqnz0Yz6ORBBT4M5Ma3Zlt/vz2lzeD2MhsuhgTp4LDUnUAPI0IkgTP1UstReyzvAbyK1JC3UII2CpVkOzS6Blpn0Bx/AZhmJjklqhF4UPyS/krASodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBj/g1qD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9a61545so2540325e9.2;
        Mon, 26 Feb 2024 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708966441; x=1709571241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HPPIy1QnGtbZ8hqGOhoaCumwF0HMr9TMO/f05RDRGg=;
        b=nBj/g1qDw7tifEhwzI+NcaSEgwMBbwDTLJKhWSSh+ZfS13CLVpd0sjstsXE3qZ7hOv
         N/SNswmVjXsR7/dPQ1yzhQWsdM67MtASUApQzjEs1ih7tQy0caI21VyCe7VxnQXFCd/d
         g7lvHioLouZlazvMK6UV5/yVHvSogcBEhoocNS9txYmQscF2jfrfynR9cJICaZS+Ilqg
         6FAsKPVY0E44zhUm5Neyp7CSJecUCAbri/JfreUGeD6dZdQe3hjjQdS1Gsi5ozgD2fc3
         lgSxEIcbB1emG2gV7NVFCUdHoP+KV3wGrxCzyz6x7i7QX/NISRxYuD2RPKCCdHimZIiL
         JHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966441; x=1709571241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HPPIy1QnGtbZ8hqGOhoaCumwF0HMr9TMO/f05RDRGg=;
        b=cXwfZGJt2IbNQTIX4uAWgo2pic/zJ9b3ZMGsv6wpivhghnnIF2uQ24kGi4/Qf7IW5B
         RGQVf2H+tdVQy+BbesvBNgV+0H9XEUInZbOJTu2esC7uZ5W3EWq/x4e+vFw9FglFwPhT
         xZFp+noafUyYu3FUMCx5/V9tCEtYRazQNQqjot8NpraNRAH8O+ZY96SkMVyQua60b9eU
         1lcnRrnWV9Q5vZmACKNk6E13PfKjj2my59epU6fEsfoexdg0YlVPcKCOJMv/leSFC5Ey
         MeeBNRqzKGSSBUY6p6J4QUCJCkNA/tzhQm95h6bln46xcIiOFZm/CI4sx7sgKrU9zC38
         ZYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXukbY48VOMaeilyLDLiGdT1UJMscwbKRN491W+DXteaMNHHwAgdjD8k9ZHn3IIba1ZT8XXsGmRr0OPuiipk2Ivyr8B4eTY/cmmsPNuYhkR8P8029AfY8NKuLJmFa0kjT3g54eviwTUiH+3YrbYqSbAaxGRPAIZSxYwRhfSnuGv0AXPEBJ7Lg==
X-Gm-Message-State: AOJu0YzzT/HoiUD38vM3H9Gc0AAWSCrNP+jrw1TkwKwX5jNJ9XZGBRpK
	Zgk3JvkhBp7XG2yEUMH2JLD9+keAzhbP1Sn1ILM3edwe7R5BmLt0
X-Google-Smtp-Source: AGHT+IFULOO+jCUAYFp5qbKzSMcX16UMqfYHtTO/+6bq/fN0LtwyBaFdfm66ExHXFcWipMfETdlqoA==
X-Received: by 2002:adf:e4c1:0:b0:33d:409b:5738 with SMTP id v1-20020adfe4c1000000b0033d409b5738mr5420964wrm.26.1708966440976;
        Mon, 26 Feb 2024 08:54:00 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b0033cf60e268fsm8792121wrr.116.2024.02.26.08.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:54:00 -0800 (PST)
Message-ID: <dfa465bf-e0d5-461e-98cc-6c8d6558e8f0@gmail.com>
Date: Mon, 26 Feb 2024 17:53:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of
 'gcc_gmac0_sys_clk'
Content-Language: hu
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
 <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
 <CAA8EJpqX5kwiQdPsSbJM=-7hd6mqwOSw_=7zyWOWQOi4=QYFJw@mail.gmail.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAA8EJpqX5kwiQdPsSbJM=-7hd6mqwOSw_=7zyWOWQOi4=QYFJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 02. 25. 22:00 keltezéssel, Dmitry Baryshkov írta:
> On Sun, 25 Feb 2024 at 19:33, Gabor Juhos <j4g8y7@gmail.com> wrote:
>>
>> The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
>> clock definition seems wrong as it is greater than the
>> 'max_register' value defined in the regmap configuration.
>> Additionally, all other gmac specific branch clock definitions
>> within the driver uses the same value both for the 'enable_reg'
>> and for the 'halt_reg' fields.
>>
>> Due to the lack of documentation the correct value is not known.
>> Looking into the downstream driver does not help either, as that
>> uses the same (presumably wrong) value [1].
>>
>> Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
>> to use the value from the 'halt_reg' field so it follows the pattern
>> used in other gmac clock definitions. The change is based on the
>> assumption that the register layout of this clock is the same
>> as the other gmac clocks.
>>
>> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889
>>
>> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>>  drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thank you for the review!

Regards,
Gabor

