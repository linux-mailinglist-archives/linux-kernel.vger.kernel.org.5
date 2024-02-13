Return-Path: <linux-kernel+bounces-63596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A924853201
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8E01C21D19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549685644D;
	Tue, 13 Feb 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kslz+AqL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0C55E6D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831198; cv=none; b=V958i1bObapRN86L8HC0/indL1z4MDcO7ENem5hyoqIy14ZkRyuVnsCBgGVaeupMbY63bYIAbAsoTHIiNMBhzGeluvSIeyFhtyhf36K12/ibw0qMl7x+PsKcfQoq/D8KuqHURxStu5ADlXeaBp6K7O92jb1M+SaD0nA0EFIj9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831198; c=relaxed/simple;
	bh=h01ngBOlSGw4F8wlO81TU9/G6JRx5OX8UHYwBeWAvMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVIeMA0AF1QYpn9uT7kZzQcD8lUfbGV7xIK6sjZwbVcavpxGML9qoHwU247Ywad6uXyl7M5aq6SnhrY6p9Y2GIumYoHOxwr0bQT1QOxz2lsFhn37H1R5Jpvsc3aaHGp4sfcpC7v+ekXxDAT2k8/I0WN4eMiT1sHiTUvIxpxGEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kslz+AqL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411d1fe61c2so1033325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707831195; x=1708435995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaD0B1TuLNeYNpMlA6iizr8UK6j9fkAx97a/7QghzcU=;
        b=kslz+AqLeIaRhtJM134sVP6omXFrWGHF+BtkDWF7pVjUBkBmNl2US66F5vc0orrTg8
         z8OVSKWyQcT3F6Nl5nKdK+bsrXL/OFcXSSPGY7QT/ES2nVVxl04wJc0ws1N3PRXFMdr3
         AoGbN3bfaUGHi0o30xUIGnamJdh5gWojbu4sOR48nF+0uOkST2UpAeeczRZHF0hycZ9o
         iqHBkDkOewgrU6Bgchq2s6CuL05//18LdlCiMG0n15Ap6fhDATt8ANLMExIDIia4LKDN
         Q3o0sYgRhYJjzxYNsFopdkvoWIvAf1Ler82aVFWIGO81yBzIUXVguPDb4MBfpvVyQpNF
         yPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831195; x=1708435995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaD0B1TuLNeYNpMlA6iizr8UK6j9fkAx97a/7QghzcU=;
        b=AyXoZ0YBSriHpPiw4fhETFm4Q2/MLXO//U1euJ60UiSGJfGTuQtHnlu2SLO/5sj4YP
         bW22nl00Ujogr7e5abcHyaYsk+AuzX3KBoAjc02TRgXfVOiSx+tCFyjStJl1XEJKGMY4
         7DEgZakkdfYO+3IoT/Ortg+qfz3wAZHctjqagA8BGUVH90fWCXlbBqY/C6K96SgCMbtA
         PB/EEXCZDTO3DmZHkeRMbR68T0ZLi5DMQBFbGJfVWfhhRbqKJb/h9Mi1otQWsAWzDh+h
         //yFxFyEiPn+BJoQhu9JFx20vLMp+Awp3u/5PlcGsv82Ys367+urVOpIgT6RLbA6An1U
         3Pcw==
X-Forwarded-Encrypted: i=1; AJvYcCXuRQcM2FCYeTDxuiPy9XrVXzvW6pXJHQyFVQ1wNAS2RVYHcoD0DowWDZgLc6kNmipSJejQ3Zi1/FVlKqaMCl9mRjVSQNU+9NSen9wu
X-Gm-Message-State: AOJu0Yy8jJV6mKKs7aEnQ1Vr7kAQ0lecmIU05vdrAOITQexQpGaz79Z3
	gc/GLlXEva3jeQfoFqpslH32AwaHgCxFmOSvgbPc81FPgm2DVyga2qCt2mA3dGs=
X-Google-Smtp-Source: AGHT+IHf84yuxchXNd+daOoZKvcoUdxbsSzE2sC1WIC2WiFbCPCP1Jc4oNFQ0WYs9GkQaBZ4ckhwKw==
X-Received: by 2002:a05:6000:1182:b0:33c:e2d0:a9a2 with SMTP id g2-20020a056000118200b0033ce2d0a9a2mr318308wrx.18.1707831195090;
        Tue, 13 Feb 2024 05:33:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWP0egO+6Qsein9lR2MZnxdm93iqghiryO5SosoaIxdRXjlBM+nu0fWgBvZq6SWht1fYQVyi/u8y8hYihS4+nOxVoPf1HcCFYHxlhcxYjzLYPzTi0pt+hpsYVIMKZ1YYLLn2GjzdriY/RDzPqfSUmcJD5151l+7bx79nrpjK6TZ8sl0HpdLmfLZkNpmJ9aD2p52o1MQVYdcj1Wnvn4Lfe5i/hnmNIY6UH1jduzv6LTiPwKOb5571pVxyeufSekwJbGFIcwnvyZlCfhz6bUnLNGK0YF3+hplPEbE8g5oF4wnjfBu0L4Tz3GO2aSFCkn9DImgl7ZwxIe7VQt/c7H3UUaQXTi3AZjyguK2FcHOuwPVtcaAW/ReBkuRE0=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bh2-20020a05600005c200b0033b7fb4d7dbsm6735150wrb.34.2024.02.13.05.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:33:14 -0800 (PST)
Message-ID: <681368b9-4c28-4611-a555-d7287a0eb209@linaro.org>
Date: Tue, 13 Feb 2024 14:33:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] memory: stm32-fmc2-ebi: add runtime PM support
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-8-christophe.kerello@foss.st.com>
 <7cb51fed-66fc-4ab1-be09-85a00d94514b@linaro.org>
 <ebd4b93a-80c5-4f22-974b-eb91e896e510@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ebd4b93a-80c5-4f22-974b-eb91e896e510@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 14:31, Christophe Kerello wrote:
>>>   
>>> @@ -1381,6 +1382,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
>>>   		return -ENOMEM;
>>>   
>>>   	ebi->dev = dev;
>>> +	platform_set_drvdata(pdev, ebi);
>>
>> Does not look related.
>>
> 
> With pm_runtime_resume_and_get API now called, 
> stm32_fmc2_ebi_runtime_resume needs ebi data to enable the clock. It
> means that the platform data has to be set before this call.
> 

Ah, OK.

Best regards,
Krzysztof


