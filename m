Return-Path: <linux-kernel+bounces-81984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12550867D52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434F11C24595
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A101386C9;
	Mon, 26 Feb 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2sBvFy2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387612EBE1;
	Mon, 26 Feb 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966467; cv=none; b=lzOgyYOuVNUhImG4zncjYKo/5gnSb70JiZx2krxIgpHbkM2BWxG4KL1JcZwwvWaGmQ0sKq92MHc3SbeFRPOw65xDMGp4lZQXEq9LWPWFcRQc9OIFJ32vz5vQOU4ZUPzO9XmHhspettgjYH0ex+jvGXCLOTVt8G6W1FdlQa5Boa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966467; c=relaxed/simple;
	bh=FdvcmEth3nWDGT8wTmWx6XZvqkMjHNWouvLS/wNZZ3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwU3kP1ALWLJZ08euri4dA4DTnSbQ8+ywVIYg76N4IFf00yKRL3vJInJpxfgRoikQ6o2IoRqG1Qt3GcCvfEiAMcJYsJl9JrU0HA2CGkXK+3jhg5rVr8IUR23roEE4K5mHBk+l8Bx6gdDMPZuyYsA7xl+n+GRqbl0f45ogSG9pO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2sBvFy2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a74ebdfbso6046535e9.3;
        Mon, 26 Feb 2024 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708966464; x=1709571264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnzV55OD4paSLHHWMOLT6h78Hihtp+PS6WGkHp75ykY=;
        b=S2sBvFy2/8gQK9+VVsjlCCqmxWbp14oAnd03rWTljcDgD8rf7wbXQAdt/TvcYxcyCA
         zqH2xgjZuogVISnKFldefkMWU+6ULw+4rnIiD9l5iVdUil/qu46+p5ve5S7ElhsZIfo2
         s+YtNl+EL88GD47Ic0cnlzVoV1/5pn5Ocw46lp32QqYrO9qJ5GHLNnN7aXRD7cPX/uxn
         VJ4a12iBGINbDLTFW4xtYOdeEwj5IdvVX3OUEyT/9+iqJkhVe1qaIDTJvStsn+DoIwua
         Z5CDJrRB959d0OyikaKezKronjnH2khuMmDGuONdkyJSEbh/Hm8scrJpuoAEmuj7V1Rx
         p2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966464; x=1709571264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnzV55OD4paSLHHWMOLT6h78Hihtp+PS6WGkHp75ykY=;
        b=XLTjTiMYcshQKsfTC5weYMnHh+66ENlJk39M9ZW3f95p0XQq9SH/Cz5WOYEqzf1m12
         Yz/bKmFyLyg//cDczq/UBRbUfSCj8EFDdgpF2v3NyBEgHZLwxjMU/Qn0SYu8vHtpxkbb
         S9o+Oj6j6fVxLkXrJQpv7T/IUkj1KQbLOADELPnh3voXxR17J1HD3MNlJaRQlPHNedWu
         VTamAVr3uXYYwlGax/b2zG8GlVo91goQV0SPSWIrrQkVZvAsb2cnsh6+Jt4qitdJoqr0
         F9I7M9JoGIbzoQKMYD9kZeq0tjRWTx03COZ4hFRwFNDFlkcjMRX3agsPCLsDYsSmR+I1
         gYcw==
X-Forwarded-Encrypted: i=1; AJvYcCVM4AJ6WZqWWrYOc5EizXCPjXNC04o09iWS0S2vcHk2juSFBtctc8c5pXqmuyfCyIS/NNkwbuWZnYZbeevyCYCx7b+TMZ/EJeU1C0VNGRnyc4Vh7iGSzxG4fhLondRJLc6RYceTEMfN
X-Gm-Message-State: AOJu0YyjNCG9a2bjfy/+rRKquzqoCLPNM6oNKrXoE7GiL5KWqXMbW6ap
	gTFh+RYdQZUlFW9J+vbt5XnwHn5O9SXx4pmkAqaSA1SXaVngJVL4
X-Google-Smtp-Source: AGHT+IGzq5hC0KDLf/FNzeWaLh0tteVE9l2o4QgF1GqBh/KpHyFLTLjqAHgT1Vn0+tr5wmuXT4GzTg==
X-Received: by 2002:a05:600c:5d3:b0:412:8e82:9a5c with SMTP id p19-20020a05600c05d300b004128e829a5cmr5815167wmd.38.1708966464121;
        Mon, 26 Feb 2024 08:54:24 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b0033cf60e268fsm8792121wrr.116.2024.02.26.08.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:54:23 -0800 (PST)
Message-ID: <01a93bfd-c1a0-4b1f-b941-6c0d3de316f9@gmail.com>
Date: Mon, 26 Feb 2024 17:54:22 +0100
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
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
 <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
 <1ba0fe63-1892-4042-9e5f-b1cd18e760b8@quicinc.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <1ba0fe63-1892-4042-9e5f-b1cd18e760b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 02. 26. 10:53 keltezéssel, Kathiravan Thirumoorthy írta:
> 
> 
> On 2/25/2024 11:02 PM, Gabor Juhos wrote:
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
>> 1.
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889
> 
> 
> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Thank you for the review!

Regards,
Gabor

