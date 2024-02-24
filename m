Return-Path: <linux-kernel+bounces-79559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D0862425
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40221F233D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE4224CE;
	Sat, 24 Feb 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZc789RR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E45210E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708769974; cv=none; b=UZMqXDbnrOhSfLj+A5wdv7cW4r0jUoiS+w5HxFKRNq9FPuegQ0QJb1Dl9w7955SEw00r9ve+7EuaKN2l/qflLqN4OQU4BAQLM9IISL5y/b+1nzx79eOdNuqLg4LP6l7lbIsOEkWwGn0jTteQNQggU7K5Fu1vGwG+5a1PlLToP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708769974; c=relaxed/simple;
	bh=nx8yRAjYUkV1UZ3to0TYeKZurnRaHQvKgEb2DXQRKmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYRbrW1XpkwFRLMPqIQWOoqV93L5SqEQpxhr+6m/xPCf3iLrRjmhoPuxtnSDLrnK4BkML1+op/qB6GTmo6z66OTaN3jl/cxQKiXU7kai2nRaCxBvkrXbCN7MlK5XlvZxCp3+jc5+lb0fbUhtprTdLWGBVKat3w8ue7xpm6XHkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZc789RR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso151119966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708769970; x=1709374770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdhHm5cqQ2M3XxC2wYvGDy9jFBz/nbflm4Yxv8aZD/A=;
        b=aZc789RRUtGx1rQEzQHfn10iddRcBN9dgvU6fT0ZqF+0RZ2Bf5asPbcCSubi4TnsR9
         LYqYl0hEiNZ9gnb+nJRCjv2bIUNIXGw6mknKcs5FQ/AXd941JRKX81dlxN3FYusd1iQM
         pAbccqAQhKGD2T5QoqgLIFtP/zuNTkFmrywYNojFKaTh8TmQ3BsO71qbO+JweD0Pz/Iw
         5n2OY9zdV2pbk1DkfaxvnoME1hxvP5FTUtl/CKwXLOcizE97fK4vJxP3wDl7951MmeLk
         Dgx8FZvUWhdNsRjl7mShuYYOHVhPF05eaP4xFtA2WW68cQ17y+dd5BQHpciMj+HeRqr6
         yOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708769970; x=1709374770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdhHm5cqQ2M3XxC2wYvGDy9jFBz/nbflm4Yxv8aZD/A=;
        b=xDev39YPq+SRfFHqDAusjuVlPJXxGxHfjcFDmtkT6CST5ngWugyu8zoeWoDeIzfG8D
         TWLB9Gl3Gvc4GRyYt2cJ0e/3uNaRPEBLnHYYGI8qIsK0qJzgRYPGh5TuexHSfNpP1Y/Q
         LFMEdislaVN+C+4cbV0oI0WWjqWDRbGCVjYJ6mpmzhKi58YSrzGQXIAV7fzdaGWJ8yHZ
         z4zDGb4Cynfhm3Hf+bCLiThjCz6P6ZB3M3oeWIInm9jKvenYeYhJk+6tTiXdVMDgxBjK
         58gPn48SgQ3v9Su10FLo80zQqG9uTFQ3myZepRHYcWJfCB9gR3cCJYPUSGaOe/ILNRby
         7lBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLTN+QJ/1Myt9N64RTNoLZEAzUgfmDyJjQ/feIRcuxCI+pOweYJFjtETPif5oQIop7Z93tn3ZWFQRHItaGzF997/oqFqW2cJwAREFd
X-Gm-Message-State: AOJu0YypGIOp+vL1l6ofTnzJ9SPnnYMthtpVOu4U1ZV7OHlTL7dPsDM+
	4MJCw11vQmURDH/6arYxwbKGILNwQGwskbk0nvnR0JsVHeFfWsg5GZ4VJi76PTM=
X-Google-Smtp-Source: AGHT+IFHGOeyj988v7LWGRhKsMWoZCLaPxiReVLKlJCjuu7JCSd4JsaKXjCnXJm9/AeZGu7++i/G1g==
X-Received: by 2002:a17:906:318d:b0:a40:4711:da21 with SMTP id 13-20020a170906318d00b00a404711da21mr1257461ejy.37.1708769970445;
        Sat, 24 Feb 2024 02:19:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090646ca00b00a3d004237ebsm447339ejs.212.2024.02.24.02.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 02:19:29 -0800 (PST)
Message-ID: <866ea7ee-54c3-4a89-981e-64d6d3b46497@linaro.org>
Date: Sat, 24 Feb 2024 11:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Content-Language: en-US
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 15:03, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that there no cache coherency issues exit
> for the addressed memory on the host i.e., memory is not cached. But
> in reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 
> And worst case, if the memory is cached on the host, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> This series is to enable cache snooping logic in both RC and EP driver
> and add the "dma-coherent" property in dtsi to support cache coherency
> in SA8775P platform.

Please confirm that your patchset passes 100% dtbs_check.

Best regards,
Krzysztof


