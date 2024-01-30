Return-Path: <linux-kernel+bounces-44837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46115842801
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A02B2937D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C782D95;
	Tue, 30 Jan 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3c5jfZg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59A7E79A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628281; cv=none; b=g+UtNncHIGfGiakJx50w0IAT1eyopbBj+hGy5z7sl1nKQeD7dPGEcMS7v5meDduu1iF9EmdeN1a7LRx8h3hRtcG8RJdci9q41umZLBZ7+tBBhAOgNHguBYV4S1kH6Y2pakKrzqe+3XgM9nVGBy+fHNBHCbae0PqK9kIwx0/ST+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628281; c=relaxed/simple;
	bh=aLRLkFKEygSuNKnQf4vO02QwB1fYA8luQzkAZqptDUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aDPGM3QT9a9IsdXCNCz02XenVFfNRFsT7wihqURqV9OzoJW7WRRDaAkPxNqDWRoV0+XCQnwYNyE4e4yxUYhN1UWjPu41B6xkVH+8Kdb9c9zrGvMJWqg3UYe+9LmvpKNThD0RRKmwz9V1gWZTqgLSi82o/77q0cD7Xseak6QCcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3c5jfZg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so492978466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706628276; x=1707233076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upSyqDT91KZTzUgxrRwQ/EY2FPJ40Fp2ZgWf7H1/u3c=;
        b=U3c5jfZgmeKKPHLax67eJU21O3ViLlw6P6sNrQBkWEGoszlnoahEDuJ+vv6Wlo4W3l
         9NZqUPyQSGSS8HF1Ngisx3xLPhJ+ExQ4O6NJIMXNFwM05vIOwX8de9ZJ2UZDvsxmcwPV
         S20WNV/jWISLmzX470FUZq4XllGrPK57v/mRAwvqaRL9gofnn7zYrvnxbS95DPuUVKW6
         uLiBxlvwp68VO/canx+kBTS+f/g80ZN2OXaBdujbcjwWyI0jSUG/mJ41bfmmiZu4Bmtt
         rCZEoQelmWpEPUWQvsA0GmBacY+BqU79WkyRJdX5siDYAKkNGU9G58buRtVY3tB+SGUW
         Dj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628276; x=1707233076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upSyqDT91KZTzUgxrRwQ/EY2FPJ40Fp2ZgWf7H1/u3c=;
        b=a60ZY8TRe7ciAmoT1xmnlpb3Hl+xT+WGmvoU9PLAio9KFyrZSC1EwWb5+/wfpGHifF
         BV/7qDU+B9cfAyAujFeQDDYNIqNCEDeF3bLqNBNJyKph2Bhvh5+9vBtT55yLgt30vCdK
         53SXjZDOUbeyQ2tSyQ5bFNZS0V8oA4uz3Lj5TR4qD7X7jIiuBTVgXK7BJL6VF6H6pqgj
         7f5MtJpfCRRV7XTzg5LmGQmJdBTUSyGwNiK4S0u3hntgxUmslhbkGQ5iQc2Q7BELddkr
         zVEh0743BpoHMRn2Yx2Cl95WK44/R8pxDfjCKHZg+1o2kI26FzjMN7nOvt1QCEorHF6o
         m+Gw==
X-Gm-Message-State: AOJu0Yzf5vsaGF8OKH39g2wUw2UOaMsi9pefYsilzyOwRzGjPzaTvsxx
	yM2a3IhILuN7BmJKQjrHHbc9x9oCybEvawipuQst8OZDHjbcLrseSowygpe6Xe8=
X-Google-Smtp-Source: AGHT+IETvNmQMIHCQz27NuNXXXDADihf3p/sSp2mp29XrME0Bkd6glnFjdUcPFDntwwsK6JA8YF5uw==
X-Received: by 2002:a17:906:e57:b0:a35:da9c:ff80 with SMTP id q23-20020a1709060e5700b00a35da9cff80mr3469896eji.12.1706628276346;
        Tue, 30 Jan 2024 07:24:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbVG8bYLwqsPOydkSM5+VHguOM0m+2c/Ca1iL4H0oX79Ey7CfSflsz57RyTTis4cZoHFy2CmE/DsmlRqwmJDGJ6Inlj5wqjCx7kZ4M9a6/bAQX7VLau02ct1mk1gXmyIp0bLWabcdyDzAZ+SfyNUxyttw4KU6vnNesTOMjdFuh0ZQdN069zRcXaDW3XV8MjvS5xCbr/NZjv04s3qGOEH9N+G1VvxWvMkh6b0r8pSTpIu1yzUX2EJFiAw5FzMR9FcBKwwdRqRsRg9fL32NrmYaLdBeAeKPFBDIuek6nB+MzJDYficcmNW4+W5HpZOt/dahUYeb8BElRnfQKgAgr3/RE43O6+0zmEBldDNWOasSYoj8hmid+nfNeAF0+/JVfDbRUE/zcHBetNsegP0B1RFHvM1DMbtqQ893V0yRTxFJnXeSN8yfNFA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vo1-20020a170907a80100b00a35e4b460b1sm1762095ejc.222.2024.01.30.07.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 07:24:35 -0800 (PST)
Message-ID: <4792600b-4c08-45dc-a611-2cad4b2fede1@linaro.org>
Date: Tue, 30 Jan 2024 16:24:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Content-Language: en-US
To: "Cvetic, Dragan" <dragan.cvetic@amd.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 "Kiernan, Derek" <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 "Simek, Michal" <michal.simek@amd.com>, "Erim, Salih" <Salih.Erim@amd.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20240130125309.4019261-1-dragan.cvetic@amd.com>
 <8b01a23d-c5f1-474b-b69d-ef629d6d5f24@linaro.org>
 <BY5PR12MB424156FCFE0E76DBCCE80862E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BY5PR12MB424156FCFE0E76DBCCE80862E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 16:00, Cvetic, Dragan wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, January 30, 2024 2:31 PM
>> To: Cvetic, Dragan <dragan.cvetic@amd.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Kiernan, Derek <derek.kiernan@amd.com>; Jonathan Corbet
>> <corbet@lwn.net>; Simek, Michal <michal.simek@amd.com>; Erim, Salih
>> <Salih.Erim@amd.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE
>> TREE BINDINGS <devicetree@vger.kernel.org>; open list <linux-
>> kernel@vger.kernel.org>; open list:DOCUMENTATION <linux-
>> doc@vger.kernel.org>; moderated list:ARM/ZYNQ ARCHITECTURE <linux-arm-
>> kernel@lists.infradead.org>
>> Subject: Re: [PATCH v3] dt-bindings: misc: xlnx,sd-fec: convert bindings to
>> yaml
>>
>> On 30/01/2024 13:53, Dragan Cvetic wrote:
>>> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
>>> dt-entries as well as any future additions to yaml.
>>> Change in clocks is due to IP is itself configurable and
>>> only the first two clocks are in all combinations. The last
>>> 6 clocks can be present in some of them. It means order is
>>> not really fixed and any combination is possible.
>>> Interrupt may or may not be present.
>>> The documentation for sd-fec bindings is now YAML, so update the
>>> MAINTAINERS file.
>>> Update the link to the new yaml file in xilinx_sdfec.rst.
>>>
>>> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
>>> ---
>>> Changes in v2:
>>> ---
>>> Drop clocks description.
>>> Use "contains:" with enum for optional clock-names and update
>>> comment explaining diference from the original DT binding file.
>>> Remove trailing full stops.
>>> Add more details in sdfec-code description.
>>> Set sdfec-code to "string" not "string-array"
>>> ---
>>> Changes in v3:
>>> Fix a mistake in example, set interrupt type to 0.
>>
>> Why? That's not a correct interrupt type in most of the cases.
> 
> The interrupt type is set to active high in IP, cannot be changed with driver.
> I keep 0 to be aligned with the original document.
> What do you suggest?

Use proper type, so active high.


Best regards,
Krzysztof


