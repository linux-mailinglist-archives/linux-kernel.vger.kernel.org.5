Return-Path: <linux-kernel+bounces-134617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15C89B3BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A101F21C51
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958383D3BA;
	Sun,  7 Apr 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV1SNUyp"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E3DDBD;
	Sun,  7 Apr 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516323; cv=none; b=BA5fTzsiEimGM00o8hZUbcMj17sd1tTh+q9u2DYgOVPAfmdVZRVke+bbLyPAEd60M/+hJsFo1GnK5gai/vbmAQb/eowD1FKn1BPSrrndytbCfA2O6ouQHGm9vmZcBLo4Nvxu77Q+07KEB9u3qGFGLvdz3CNFFiKAF0mkoJq4UU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516323; c=relaxed/simple;
	bh=Je+sdwn5hkeZEB38EPAxz0m1Ux0pBgOrJDpYMxeLrnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmAldlIRNnU1tFsw5sTbmm9jaKI7XL69wGoK8JOzdmzoZ2EdvSTkPPKv/LTfOUp/4FtEEguOOrkQfI+SxjatlckeyUq0RuE4v7++DJb4FyKa+CPdUHmWMfNF1YvccnkJg2QC0EUdt+11VUOzu9KlMW4ZmliHsnq56aLK30UE/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV1SNUyp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e68a30e6a1so1504472a34.1;
        Sun, 07 Apr 2024 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712516321; x=1713121121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scTTNj2woy/vxyldPj6pFMZnJWGeLMiGwUL3lFw6SWg=;
        b=MV1SNUyprIYZ5Qu8Hy2q0b76WHln4OliEJ2JYqPY5cCwBcXKgzy/g210RHMGLfeGXY
         0WW04W88ygvKpMMIRRxVLjxnY/P72wSvehb2HiINO1x7UXRY/oa3MBq++S4J0THSY0vQ
         TXgwcSZm2QpH8D7tQJc9GMkZcYhV6xBctTi7/Hj0SAlpDn1pEHmMSbya9v7Smi3FWOcZ
         wIA72Z00IhFwlRl5+D5c6ET8oeosWYQaYDAlO8RNHr71d8T+0Kg+3zhDb4JCc7JXrY9P
         ZMVjWUECx+sEPtRCLEvJM1nTWjAyJk7iY6FixRCHyAekl92KF9pnFBuHfGQ7MXz6GxGI
         1VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712516321; x=1713121121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scTTNj2woy/vxyldPj6pFMZnJWGeLMiGwUL3lFw6SWg=;
        b=F/GKZEDXtGg/pKK0RQMApPxzTUv3i0D7WH1iY/ssqZ0H9PcSjmeQQ2WhrpIg22X25V
         aiqRL0BuBYdX8iLmjvuUmKMxO7CV06XP4MprncYfIZcTao/ui7l1FPXlay+ZpgOkGgyD
         8MSG8AxPgciVbh3mFIFh5IGOJX7tByfHXk4ppe/VtvxX5LI6CRtK6CGU5qb474JOsLr8
         i4OpQjYqdnCFwMbnDhq4YgKNAYnK/y8Jrsh1nPGTTDX8DJ9dBAeBGGBfKXjZ177I/Vdu
         b9XOUsSht8slQt7T5+nP45RAB1spKnAGbFDmxP8zl+IlQ40G9sd01qw+VEtGhX5Wox1e
         Mu2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2MhHkytFy75COA9pKY5s4IpvC3DvXbOlVOfPeg69VfD6nFw0rhRBxvfIo9z+4UM++JH8nVOrI/clkQZTfvqmAYDv6T/ud3S9csSU8MZy59yrtp4pcQm9cp52vA9ceR64xPdqz3cy/cpM6e4OwhJmk4p6F34YVxY3psxRJPD3HH/BZxMaa/bE/BlOb32Nkiz+zozpbXwmiDhovu6py+8GEMiw=
X-Gm-Message-State: AOJu0Yw8NGqZekyNQsKLAuNai1pzJfDOJ4SAFft0vn+/mggfmvWVTv+u
	ItQDPHEwXQKVRuhK9x5JPWSkp6IbyJl55/BDcF5FJaRa9aEZgEjn
X-Google-Smtp-Source: AGHT+IFG8tDCVi2Hal8zENXLD8XK/N4pT4qILbW/+jIbZ5ynGBiQjUlYTNwzup3agDIiljYWM/Wa6w==
X-Received: by 2002:a9d:6b19:0:b0:6e6:8d2f:4013 with SMTP id g25-20020a9d6b19000000b006e68d2f4013mr3146432otp.8.1712516321474;
        Sun, 07 Apr 2024 11:58:41 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id e3-20020a0568301e4300b006e66e9ac835sm1156906otj.2.2024.04.07.11.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 11:58:40 -0700 (PDT)
Message-ID: <a0c7ab26-4eb7-42e8-a151-671a9222660f@gmail.com>
Date: Sun, 7 Apr 2024 13:58:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
 daniel@makrotopia.org, arnd@arndb.de, chris.packham@alliedtelesis.co.nz,
 christophe.kerello@foss.st.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
 <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
 <5fe5396e-c628-49e1-bec3-770847f061e5@linaro.org>
From: "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <5fe5396e-c628-49e1-bec3-770847f061e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/7/24 13:54, Krzysztof Kozlowski wrote:
> On 07/04/2024 19:48, Alex G. wrote:
>> On 3/8/24 03:17, Md Sadre Alam wrote:
>>> Add qpic spi nand driver support. The spi nand
>>> driver currently supported the below commands.
>>>
>>> -- RESET
>>> -- READ ID
>>> -- SET FEATURE
>>> -- GET FEATURE
>>> -- READ PAGE
>>> -- WRITE PAGE
>>> -- ERASE PAGE
>>>
>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---
>>
>> For the entire series:
>>
>> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>
>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>> index bc7021da2fe9..63764e943d82 100644
>>> --- a/drivers/spi/Kconfig
>>> +++ b/drivers/spi/Kconfig
>>> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>>>    	help
>>>    	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>>>    
>>> +config SPI_QPIC_SNAND
>>> +	tristate "QPIC SNAND controller"
>>> +	depends on ARCH_QCOM || COMPILE_TEST
>>
>> Here, it needs to 'select QPIC_COMMON`. Otherwise it can run into
>> unresolved symbols:
>>
>> : drivers/spi/spi-qpic-snand.o: in function `snandc_set_reg':
>>    drivers/spi/spi-qpic-snand.c:56:(.text+0x484): undefined reference to
>> `qcom_offset_to_nandc_reg'
> 
> No, do not select user-visible symbols. If you observe such issues then
> either stubs are missing or depends on.

I apologize for making a bad suggestion. Thank you for pointing it out.

Alex

