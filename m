Return-Path: <linux-kernel+bounces-134614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0969F89B3A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BE1C20A79
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C83D38E;
	Sun,  7 Apr 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFxIWeQH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DF3C064
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516136; cv=none; b=AjH0IaqU9NB4cZ2dy8g406XldZsWa0F4tBix+56yXlbC8D4G9OzPvA5pd3raHoydUXNfWSlIFObu3EI+PwGjuzkpk6gIi1iz5tACeXaxJVg5hbtBQnUri3/jt11pGexH1fl0cjOikn2KJe6xYF2pHj26uy/8Kvc33PA2sD2LDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516136; c=relaxed/simple;
	bh=1jmoupeNeE1z1sOJ4olLhK9xvLFQA/pZjigBUutkg3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuSvqDtny/PqVvbDRDdvm2YJ5aqhqu1lFMSzs2fuydnr8/j3GGzly7GR2ROAMrXZnVk1eJeDg+hAC82/OvCyoqAOIbAyOzeTBjmzzePJkTG546l4ShXAy/24CUW+71g3lPrcI1vq+tiszXM3kXpW8Eku91sN8pxQrQU4wL416kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFxIWeQH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516c403cc46so6697166e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712516132; x=1713120932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OU07XWrH7QrRx8z6lpwbyNFVehByy6iiEfzZuuvlVDc=;
        b=uFxIWeQHuu1DnRmZCx4FShfk3LMX0EPN9ETDrz6mhAqyk+LxAHxwPcKCqnRyhneNYJ
         18e1IVgRyCBJ+XnWFCzYG9RQJYYLCqc2EH3y1O6099ixKju2xsPilJiglPIHWm9LYjEC
         L4/ezrJFMcOlkaib9McgXJEvx8oc8kAI6+qg1bZ5HU6uw9oZtqOU/DuQpUNykkhRTeuw
         5WNh2w8xsn6KIhAom1X8PzwGiNXD4wjaTMOejQGycqHRKKTs85tLjzZ7l5R3Hv6GWVfn
         4K1OnmNqPpLBE5SSKEA/XLrmAe9SXLTGcrXyMQ4kMZVek8A6NdWhdrdYdDC+Q1r33mYL
         X/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712516132; x=1713120932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU07XWrH7QrRx8z6lpwbyNFVehByy6iiEfzZuuvlVDc=;
        b=u33sHCagZYPWYLRWBgmAFT7RZ+bXYcBcpiIQarUovPZS7Od6XLfC3/zutfy/j9dx9l
         4e1d/S7m5yBNr9LKjszQPIb6R9IYaAFx0JNezzSuYEd9+akf4ktm1kFx+MFAydBhlnnf
         N4uwvdUcLHGNL3gd2TiptCtVO3rGo96oHOm6d7HtJmhgcdRDzEP4XI+E03B4H3+HX96o
         wATwR0qPoyB02l5MfjoqGEcZssaAJKjeJpRFC4ink8dTLmOoUt6cvFMsznhrOmRY5xQ2
         wl4DUG3vCNShhqb8/xzKO3EqYTT5YNpG1QSzrftl8Mmdqid0UzsxCsvN2bXX7Ljimeh8
         zCvA==
X-Forwarded-Encrypted: i=1; AJvYcCVZJJWa/Rgxmhy8cfWGr3abqPm7YWDDzrSad1CpThCAee9IFAktOcISEQFsvXZD9K9edIDrrk9+mUyoAKXaXmNhmoExSMnu5pSUmgaK
X-Gm-Message-State: AOJu0YxIwi3KfD2lMQqeVnhb55P4ddf4foPR6cQcIisDc9dAjksPF/C3
	NwT45p2HngChdFQWg71rxBmG7LV7i7M2EHzphaTselJ6DhQaI/rww1O3onQc/CQ=
X-Google-Smtp-Source: AGHT+IE1bcgFsTWpWkUF7p2n+cWGRC6JhLC677ZsCW3QO9jXpGb+GKMv8gNPyxkV1COnJrWbN+ubFg==
X-Received: by 2002:ac2:4c01:0:b0:516:d0c2:3ff9 with SMTP id t1-20020ac24c01000000b00516d0c23ff9mr5845387lfq.67.1712516132325;
        Sun, 07 Apr 2024 11:55:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jz13-20020a17090775ed00b00a51a1d1a3d4sm3457158ejc.47.2024.04.07.11.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 11:55:31 -0700 (PDT)
Message-ID: <46ee8ac3-b868-431e-b3cc-78fd33e9dfb1@linaro.org>
Date: Sun, 7 Apr 2024 20:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
To: "Alex G." <mr.nuke.me@gmail.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, andersson@kernel.org, konrad.dybcio@linaro.org,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 neil.armstrong@linaro.org, daniel@makrotopia.org, arnd@arndb.de,
 chris.packham@alliedtelesis.co.nz, christophe.kerello@foss.st.com,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
 <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
 <4f72048a-a764-43de-846c-3b4edc1232e3@gmail.com>
 <0c0487cb-c73d-42dd-94f8-499c29009730@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0c0487cb-c73d-42dd-94f8-499c29009730@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/04/2024 20:45, Alex G. wrote:
> 
> 
> On 4/7/24 13:40, Alex G. wrote:
>>
>>
>> On 4/7/24 12:48, Alex G. wrote:
>>> On 3/8/24 03:17, Md Sadre Alam wrote:
>>>> Add qpic spi nand driver support. The spi nand
>>>> driver currently supported the below commands.
>>>>
>>>> -- RESET
>>>> -- READ ID
>>>> -- SET FEATURE
>>>> -- GET FEATURE
>>>> -- READ PAGE
>>>> -- WRITE PAGE
>>>> -- ERASE PAGE
>>>>
>>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> ---
>>>
>>> For the entire series:
>>>
>>> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>
>>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>>> index bc7021da2fe9..63764e943d82 100644
>>>> --- a/drivers/spi/Kconfig
>>>> +++ b/drivers/spi/Kconfig
>>>> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>>>>       help
>>>>         QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>>>> +config SPI_QPIC_SNAND
>>>> +    tristate "QPIC SNAND controller"
>>
>> Also, don't tristate this. It can be set as CONFIG_QPIC_COMMON=m, which 
>> will cause the build to fail because you don't have a MODULE_LICENSE().
> 
> Please disregard my idiotic suggestion here. I meant to make this 
> comment on the previous patch.
> 

Also not. All of these must be allowed to be a module. If you need
dependency between modules, then use documented syntax in the kernel
(foo || !foo).

Best regards,
Krzysztof


