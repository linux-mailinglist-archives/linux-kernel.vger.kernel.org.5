Return-Path: <linux-kernel+bounces-121916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57C88EF60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6B1F2A10C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4F1514F7;
	Wed, 27 Mar 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st+1odux"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5E14E2EE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568296; cv=none; b=Gj8875IATarPvl7J2jRqrgXycPoKj6EJaund6jUwAdZ1+eYy1hb8VnfzuZxU8uDqmQtc843U4WUoQSi5MFexUqNi3NVXXJ5G5pIWuSwxOmyzZ4XDA1eEwW0yTh4jXR3w6pmlvxdScu/BzTQLi2oqDaei2Pk+fqIS0wsd/+4MAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568296; c=relaxed/simple;
	bh=zisQaeaGvkOWC9X2Vel/dognSj33myR5t5hDQWeBfys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jVTNv/ihOUcliRh5Ejgf/LDgDVAqDF/WGJcLF3/xxX7+AOfBGSu2XQzOI7NroxcnFet1VhEy9rOlUFk2HZ0AGHhdKNcLA8cZgEVzro7RGiXAC7gyeFXl/XaS6XCKjObmVxQS2lIkz6AejPbCc2elq1hsTUBwZqo/OtQ3aaPBNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=st+1odux; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c3260a714so240719a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568292; x=1712173092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=akaDXAIrRxfiXTC20v/6jAvRSqSRGmSUb7NNJN/u/r8=;
        b=st+1oduxcF+ETxU78CFOfDvoFj/U/IiG2HRx+zYSBYz85QiGNlmcHt1uWLVp7wmoxH
         g1b/MnNffJg0ZdT6HGhMQ4LZPGlpMswctnxodHcVgzu6yNdY39vZDbGQYhbdIvyWm/oX
         XAlFnGg3I6PrEhkSBxK7dULvDlD1IntHNGTqhCi7TiJ938fgdJZYrt2UgtUi/8A/EOCY
         iVQQbqd6tFhgBj7fRtJoi8hXxbuc1MWM0shGkricgIdl1IRIQMpk4Ppa04Zo2RxPVyc4
         lF8QEnsuZFg8PyekOBW6dYkbkK2gEBZsYsIUWJPkZgscn+7Io/9cKFSHCQLsbv7wqMRZ
         JCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568292; x=1712173092;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akaDXAIrRxfiXTC20v/6jAvRSqSRGmSUb7NNJN/u/r8=;
        b=SSb+KNGaotNeFTCpdU1yVCaVE/QQ9+YkjQ5ZSTyDMtodYC75HmILNHCu3gkCVMRvD5
         6fh/zZWp3i9Ou2r1NwoIxtWVkqj2sflrbrTlz3ynFffnDW0HvTUCDeWso85GID/Pgmgm
         SZ4E++uOlpIBxKcSX4gX84WxU2KHp0po4f1IJmPSOXCU+cP+p9kXDuxw7TGUqq6yzeQY
         tjIsbv9hQ9nnrl1RquO28avsqMibc1Rgv1hcdIni0FpHRwo94uB8RpQGVEPjo0c1juUt
         4quM3WAylcazF5kPhgJIUuNIU4unGiMhKsFrYEnGIf53xxLcJUNQCp9+k4PAzSXX5ITR
         pwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTMTrTyBKfSF8RheOwEDHQUnl27A6oAhHsklp4/dCjic3CzCXsWq7HbPo3E6GG2DgEXEI8XiO0Pv2zIxS4pBemYmlrZvXp/ABXyhBH
X-Gm-Message-State: AOJu0YzI8zn5zWik5B3b5GNzAnHUNPXS5aKpHS9v8VTKc4u1VvSEap9Z
	xi18epxXdouCnIyksa8zB0e0Rn5E6Ezu27QemZaD6fuieGFLdlk0E1ttwd5X20U=
X-Google-Smtp-Source: AGHT+IHygbZ7e2xIDjuQaMHBUNr5h40HzWBpsLIuw/vZPJxrtuB8Zmpa8YKlspyllfJr2T/tXROamA==
X-Received: by 2002:a17:906:4757:b0:a47:340b:df71 with SMTP id j23-20020a170906475700b00a47340bdf71mr322084ejs.2.1711568292671;
        Wed, 27 Mar 2024 12:38:12 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906504c00b00a46ab33f970sm5741119ejk.163.2024.03.27.12.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:38:12 -0700 (PDT)
Message-ID: <32c44e30-d94a-404c-8143-175bcc6de10f@linaro.org>
Date: Wed, 27 Mar 2024 20:38:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
 <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
 <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>
 <ZfR7uCcflCiFTvBh@hovoldconsulting.com>
 <11a193b1-7a3f-43ca-b885-cac8fdf2190b@linaro.org>
Content-Language: en-US
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <11a193b1-7a3f-43ca-b885-cac8fdf2190b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 8:37 PM, Konrad Dybcio wrote:
> On 15.03.2024 5:47 PM, Johan Hovold wrote:
>> On Fri, Mar 15, 2024 at 11:16:59AM +0100, Konrad Dybcio wrote:
>>> On 2/16/24 07:52, Johan Hovold wrote:
>>
>>>> This makes no sense. As Bjorn already said, you're just polling for the
>>>> link to come up (for a second). And unless you have something else that
>>>> depends on the write to have reached the device, there is no need to
>>>> read it back. It's not going to be cached indefinitely if that's what
>>>> you fear.
>>>
>>> The point is, if we know that the hardware is expected to return "done"
>>> within the polling timeout value of receiving the request to do so, we
>>> are actively taking away an unknown amount of time from that timeout.
>>
>> We're talking about microseconds, not milliseconds or seconds as you
>> seem to believe.
>>
>>> So, if the polling condition becomes true after 980ms, but due to write
>>> buffering the value reached the PCIe hardware after 21 ms, we're gonna
>>> hit a timeout. Or under truly extreme circumstances, the polling may
>>> time out before the write has even arrived at the PCIe hw.
>>
>> So the write latency is not an issue here.
> 
> Right, I'm willing to believe the CPU will kick the can down the road
> for this long. I'll drop this.

will not kick the can down the road for this long*

Konrad

