Return-Path: <linux-kernel+bounces-38741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CAF83C51B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A96B2512B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF86EB44;
	Thu, 25 Jan 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="henT+Gff"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA84F209
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194019; cv=none; b=flGFN8jVUUrciDnh9Wvdk4zdieLvZ6OmHrccU1Zv4F5nTw04C8tQuG2S/jsCy4iA7/3fVdII7WJu9xndIrImmYnXX5irLoUJR37RKz8WLuZiBIN8zddSMLbst5hn3ByLeykDinmcrNVWUL2Q6szQRlBpNf2oFbA0NjN3smHtmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194019; c=relaxed/simple;
	bh=GSabaqaJdXnU/qRSD1BuTU9GYupaRm2owUIzdswd99c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQQaPH7oziH15nFDwuItXI4GDYmtumwlT34InUEGdiB1pNfXMgoqG8jQaLbT73nC1LRH682VzTtG7ISjCdiO4Ikmwhpp46DX6MJ3GBvLsUgy2ftBvO7lJ/EBpHd60HXjYl1Y+XhIFOaHX3A572CV+7bKhK8Ag2yMrQoeewxMjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=henT+Gff; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so85490395e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194016; x=1706798816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c5TYYoSIS6DFr2+M25tAHJQD5shuiaKNFicKqBEZydQ=;
        b=henT+GfffYwVUw8HMHNJjOTsaJR6TuhdpU2v7KAHc/daxIZb4ra0VBxMhIfHfXcdR0
         D+MFExvRK6WtYGnt9JXn7+V5GXR1Mgx2s7SvxnsnO17ZTmbBly1JGujlKnUB5edDutI8
         KgRMVIhMTm9P5hTLYhBfJ7Ch7VxM/bpvwaeBQD3x9DoB6bRGsnH8h1btFrq6LFBu0voT
         aAScgJv8ZKDUxw1fVUevdz6D+3MZ6QujsK/ZrnB8m2A9CBN7Gtz+uIGycIay9FNTPIC8
         c89WMzANFf0rYtDKZGz+v7OaTSsPYjql2YNfz2K20QRWjIY55PD6z5Ji6kMxXv7+O+CJ
         99zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194016; x=1706798816;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5TYYoSIS6DFr2+M25tAHJQD5shuiaKNFicKqBEZydQ=;
        b=EeFSIInmskiyt3WVKCNdhgxUZyWH+YJfxBpC9gqHX2QYqkMEZeFp3c101VZgmGwvxO
         t9rQ1VxuRuOR+0haB4oLGGXhWfRuFbnJxUhuUgGwjd0aJD41zs+A+DBjgGu3IL+XF/ct
         /xyMXB0bCPc34AA9FMoocaZ0lMNtmIuKNJNWbKwEF85ijc3Dpq8+omweBdNrTRM8/SzL
         7lSzQG+mob6gpLcroVceUnil3V+dmMRSogyNkcLlSVc2LeIuo7D4CmEiVFwbZh9UcXwy
         GIHTXCmITPxmmjAbnyfzmNMdLmrHzemZF5N8OfewPk526gs6a6l7Gla0qqabk9eS/lZr
         CCdg==
X-Gm-Message-State: AOJu0YyyRh1rGZhGjj0mXFxc/FgNrPL+0fWd3hIVQ6PgNLw/YFD7orgM
	QlbeNYQUPyQRom4FwOjJjR17KNqoJmEzeFNAC65IPLP3i1gIoobGGmM5z19vBjg=
X-Google-Smtp-Source: AGHT+IHLEzrC0jE3m+aMfp4HdU7bsgKUkZeL0aBj6XPyWrx2MilZirtRPTy4/Zv3Xrq5v+g9JAEzPA==
X-Received: by 2002:a05:600c:6023:b0:40e:d24d:1448 with SMTP id az35-20020a05600c602300b0040ed24d1448mr542822wmb.121.1706194015963;
        Thu, 25 Jan 2024 06:46:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w11-20020adfec4b000000b003392bfcf508sm12538230wrn.29.2024.01.25.06.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 06:46:55 -0800 (PST)
Message-ID: <475b4eaf-bdf9-4f55-b6bd-4ba215e24144@linaro.org>
Date: Thu, 25 Jan 2024 15:46:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm8250: describe all PCI MSI
 interrupts
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org>
 <20240125130626.390850-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJprfhZ3m6aKcPsQMAUjDFPPeqN_L-E6Tz604pYJqgSvDZA@mail.gmail.com>
 <CAA8EJpoEMsrEp02pLpceMx7fr-j9=xVDiUYt1SKHsF4YCmfvAQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpoEMsrEp02pLpceMx7fr-j9=xVDiUYt1SKHsF4YCmfvAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 14:25, Dmitry Baryshkov wrote:
>>>                         interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>>> @@ -2349,8 +2357,16 @@ pcie2: pcie@1c10000 {
>>>                         ranges = <0x01000000 0x0 0x00000000 0x0 0x64200000 0x0 0x100000>,
>>>                                  <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
>>>
>>> -                       interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
>>> -                       interrupt-names = "msi";
>>> +                       interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                    <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       interrupt-names = "msi0", "msi1", "msi2", "msi3",
>>> +                                         "msi4", "msi5", "msi6", "msi7";
>>
>> This part looks a bit suspicious. All other platforms have these
>> interrupts in a continuous range.
> 
> Hmm, pcie1 interrupts are also not contiguous. Okay, fine then:
> 

Yeah, the other case has even two gaps.

Best regards,
Krzysztof


