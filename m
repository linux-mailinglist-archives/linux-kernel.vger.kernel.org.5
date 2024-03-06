Return-Path: <linux-kernel+bounces-94234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F276873BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEB61F26FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9F133425;
	Wed,  6 Mar 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pb6FE6an"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00F135403
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741569; cv=none; b=QrE5YLOkm3TY6E8zX8ul6+bZXAEAxGivyRn7moUXR5A5KWFCx6FvSMWH+/4mdvCSMT0bqppV4NAUvHoQ2i29DDAWvSSJnHPgRUPOzoI3VIXOID+pA97cjA1nVszHV2zot/Z3ub1Gqa78hAFNEiVIb1+AzhhwNKMdRofuQj6z4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741569; c=relaxed/simple;
	bh=QAONO+XQBAc3jCOEFIruBrgj+J66EeIwpcirLURwslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYw1niywT7xpKAj0iVnsCXIzal6vTBwV0vHkwQ7UVK4nrhehTwOKVugppl4nqHtyyBBmiX74rPattCax8jr+US9wp5fQ1I/QoaX9RSjfMN4gLookbfrF44gRJI6GNcFUM631vCKE86bAVex9MHNocLeTqH0KHJaAblNKgkhZTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pb6FE6an; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d3ee1c9ea9so29715871fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709741565; x=1710346365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nK+Gs0FWIeojWQwQ2CF+QDqiBeMfY37a0667vq9G6k0=;
        b=pb6FE6anDOEXXVv0JZwx751zh7KsXWz9EkGx7ZZAkC3pKS36/8CrcxFpjrBIB8RBGV
         EjnfN8h5NOqfaLhbkfo2OHkmBC2zDNWGevs2GjvIIoqr9edD3MFnkSwv/V0ZPz+5oqmN
         enr6vmD8OjBo6cvzZ+C5aFnNcssQjg1l5B04SpwonQIKtfsonlW5SL3WZmn5Wj2ho8mI
         z6TcdCOJEVagiOyuSB1zcBb/9ST8qvRnt788ZKoQwiyhZ/JKjYm5fnkfC1HPHc+ZUvba
         Fwicn9sS326Zby5wIH1av9eXU1GRz8eUm64uV0Xo9Glr0COFcuV8WGpMbekC2vqh6tqW
         JCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709741565; x=1710346365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK+Gs0FWIeojWQwQ2CF+QDqiBeMfY37a0667vq9G6k0=;
        b=CUYDy9xMn7JBX6oXnYkVWK1A7vZV4o2BsGb8O0Yyq/Afm52SpVb43Dp1s14U8HjnYE
         MgKYZ57H23MOMy9KaiVv8PDQydza7EzRnunY7p++MBNR5LKeuEh//skGp+U0qYBrMqPR
         cXv3FbksjAw7d+Lf+D8028+2kcePlpdcilUlNRi8xe8Z6p5ByDShdwC9JVRadDR8AkWP
         aEKqSqPu4MOMCJQp4cdl1IlR0WT8XhrvtlDhVI6uHY0OpzB5BsghlTLkF4ky6+tFoU4S
         3de9HU/Q/4zn2BuAG1yZ5P+qTsQf4jIQg2vgbrMC3NooQPBc0aTQ0DndhsEeNiLV/sm0
         a5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVqd7g2Hn4scXcxeV8tRzgwG94eiOF0q2esZKAEiVnZHmh/Lg79jtcfHWhtj85hnU1DyxziUitWHsO+H5ohbpl2qprlFqk1XnigRNKa
X-Gm-Message-State: AOJu0YyIp90TDAdQMEOq6f1BaFzMVwRsjlHVLwfUduvSCyquvLQCuo56
	nj1BdBgTXJ7ftf/AMsnqH1QuCFixgnsc1rTqJqR47p+liYXLfJqW70PhDxe4oTM=
X-Google-Smtp-Source: AGHT+IFFcnqZEADza3R58lMEX7UfbEl9bDtG/46MctGLdXIjX2EZmsJSnh9HyMc6hI8F/VQs5+UT8w==
X-Received: by 2002:a05:6512:3a8a:b0:513:5adc:9061 with SMTP id q10-20020a0565123a8a00b005135adc9061mr2144075lfu.43.1709741564442;
        Wed, 06 Mar 2024 08:12:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906094c00b00a3e5adf11c7sm7244094ejd.157.2024.03.06.08.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:12:43 -0800 (PST)
Message-ID: <b1fdc1a4-21f8-471b-83c2-a09e94d93492@linaro.org>
Date: Wed, 6 Mar 2024 17:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP controller
 as cache coherent
Content-Language: en-US
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
 quic_schintav@quicinc.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
 <1709730673-6699-4-git-send-email-quic_msarkar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1709730673-6699-4-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 14:11, Mrinmay Sarkar wrote:
> The PCIe EP controller on SA8775P supports cache coherency, hence add
> the "dma-coherent" property to mark it as such.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


