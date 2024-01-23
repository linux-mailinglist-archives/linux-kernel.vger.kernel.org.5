Return-Path: <linux-kernel+bounces-35217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2929D838DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9651C20DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E655D900;
	Tue, 23 Jan 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0soKmaO"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B559B57
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010613; cv=none; b=bT07K/p+ua+j3wTsv3XaRFaL/OstvMFpLY+EZy0xvmrJ2SOz+r1JHsMdd4FpZ1GhfK7wU8yk6F9hoY68diWgFAP7t/2EHfHMGg0vRpCOqLlGrQ2oiMQ+MwrFLF+I1EIFc0WJ9KcK5I/Vh1HdP1xhIc9saezEdMZJmBD6yJ+V/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010613; c=relaxed/simple;
	bh=9555B2ryPbuiIQDf8ekp7mA6MOJBs0lVUPtThIkd8no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uw/XeELUVM/VOJ7vEUUG+zAZ74XmQHIDd5CyBGa90r2sv+t1tzn4pDQpSWzW2Pyt1bLsLbH2m4IG3mhod0E9MtbdCw7a6Bb0nqSoT9w4uQzDhQ7NoC0el1BtZUjrxukMrgQOzYen7OZxYujnCLx0Maaib+NZFoX4VOGzi9F8DOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0soKmaO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33922d2cb92so3764415f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706010610; x=1706615410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PmJ/o8ozNMBzFxt9ubcx7MPH2oFzFtnhKzW9CqW+CS4=;
        b=m0soKmaOQ95c0rYDVWnQU98fpt1lTlWL/udpBAKhiqYeyjAVknQs/ZnG8b8IdbqIRx
         UZeby6LGxQHkmRW5u0XO1U3/bmacXUJi8rc1xSf1yEhNzmjhTsU5xS1zbMquZ41M7Dbb
         jZJbF/OKFTSxYtq6Jm1x8MxZevo3O5iubt32NVtiUCGVSCgyjTFWaRKOJq/KkgFT4+2J
         XO4Kbc/L+Q3mA5lgdl76ZnWo1DWpM6iwP0CgSXEu+BfNX5O5gF5DZ1OcFqIHYI8eUtfX
         hP2EbCx3Vad8PXgNcf1m4tXGpXWEFeYJzTGcxOMWs22HV1HMGYjaQnS4VUbCdgrrRUEg
         eaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010610; x=1706615410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmJ/o8ozNMBzFxt9ubcx7MPH2oFzFtnhKzW9CqW+CS4=;
        b=bQRDr2DWXo0WpM2b6Ss0a4/cSAqDW1mARmoGKxM0yg+NB5rfMEgrMJEkp0RPDuuSPb
         HbQqWLJkW8p40W2HtvkMieLac9cTn6DEauZbyZGsOl74VMx9xYgsjKOP/KlErG1ln0yg
         xyGAlD8BeFvWeI6VTdnVSKBkt1pzxZptqX4HupWOGtEBJtEagPtWsVDw6WAlKU2ETTlX
         j/DkBZ6KAninZsDdh5VMNSMDsvDkH5Hc6g0P96WH3ubBOFgZW501WgW6zRq3zJA1piLT
         21U7XeOhp6G6faX1zDmYaiUtz4+WxpKsY936NGtfSSDJDAwk/lEcuzaGNIsVorE6b/1p
         8jqw==
X-Gm-Message-State: AOJu0YwTGsmv035YLBxU+Y8IbisdPAfirSIlGlkeCgfpIbyg6BKnq7en
	y5Gu+alGxCPnMYe9gthqmmqoAk2iUwTEII8jLNeBIKHbpNzTb3QWomKNWtFgBdk=
X-Google-Smtp-Source: AGHT+IH5mzkgfaXIZu/ClQ8zhEi3UlYUq0xV6dhMaTicnoagP3Jt9FhoFjXiAGLJLyvE8L571PiOyA==
X-Received: by 2002:a5d:64eb:0:b0:339:45f2:f418 with SMTP id g11-20020a5d64eb000000b0033945f2f418mr220231wri.118.1706010609961;
        Tue, 23 Jan 2024 03:50:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b00338a3325331sm11233113wrn.69.2024.01.23.03.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:50:09 -0800 (PST)
Message-ID: <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>
Date: Tue, 23 Jan 2024 12:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
To: Amrit Anand <quic_amrianan@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
 Elliot Berman <quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
 <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 11:10, Amrit Anand wrote:
> 
> On 1/21/2024 12:40 AM, Trilok Soni wrote:
>> On 1/20/2024 3:20 AM, Amrit Anand wrote:
>>> From: Elliot Berman <quic_eberman@quicinc.com>
>>>
>>> Device manufacturers frequently ship multiple boards or SKUs under a
>>> single software package. These software packages will ship multiple
>>> devicetree blobs and require some mechanism to pick the correct DTB for
>>> the board the software package was deployed. Introduce a common
>>> definition for adding board identifiers to device trees. board-id
>>> provides a mechanism for bootloaders to select the appropriate DTB which
>>> is vendor/OEM-agnostic.
>> Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
>> the proposal below is not specific to ARM but any architecture is using the
>> devicetree.
> Wouldn't devicetree@vger.kernel.org will have concern folks from all the 
> architectures?
> Please correct me.

No.

Best regards,
Krzysztof


