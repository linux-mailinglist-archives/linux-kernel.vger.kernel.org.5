Return-Path: <linux-kernel+bounces-116926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F988A52E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02201F3B906
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873811BAC5E;
	Mon, 25 Mar 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nq+iUihF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A31BCFB5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365509; cv=none; b=OZ8wOB5oDBdGR6KUBUjEDeMdRmcWxGP7eevz2Or7WDTn2GfDH+UTJvGzIRRK0tPIjO0V68IpNY04+8V9HHUJZgdOtUOFh3y20UcOFjV7J92Z7YxzLPe0CfOKVKrttMBekUz6fOI8akP2G9ODZRmKngcmU3k2DbhwkZiDvBEzH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365509; c=relaxed/simple;
	bh=kfcSKsiNHTh7aM2utb6ONDctZpQO7DpatwSIZkd9iUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H1kwWjSZuQWBGbAszXZGWDa4GDQYOpGG5KZmPbl7/ss0YkYSjhjGkyRUEODbbervIEDIINp+f11CyBzOKjy/BciVxSIP/YwlBtRmjVIEtkqxiOz4U8I/MTN1sixrtp3dIx9X5QKhppGLoUxW0pl0xlTwQvH9/l3HulUr/O3aNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nq+iUihF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso525705666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711365506; x=1711970306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bH8fKZbOuc+ulViiBKFMs5wlGyaD3xI9s7KfEBDkhW0=;
        b=Nq+iUihFt5AgHBtlFB2JqMveBlm665GnN6gCX8XC3RzKDd+oRoWZWnCAVejkS25560
         x1ifo7sDtCTFWrrk/6ySKG/QuTaN1dgfl76WzAobVwdr5UiysHVLLEn5igyqXNJYzTgX
         6rX11MLAFEL35DD/HQ2jPGUv7TPsF/4Nf+JfWRrOzL53bDSZ88HIzWxg5lRhHFJS1H13
         70tBLHYhHNi7vRmc39QObzEWWrGqm+4uWB2EGRmq18BHNNMK2/nqX8Q2S8WcG+ejJAyJ
         aDmcCX3rzSBEbV04ufRsegnAQsF8FwPd7JTwAbVDz2WKyFtMMLIo7hEFwKBN4bK97vh+
         ewsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365506; x=1711970306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH8fKZbOuc+ulViiBKFMs5wlGyaD3xI9s7KfEBDkhW0=;
        b=j2gjptM1rXCGe+wqZUui2Qs+qIUniSPdKfa4A3Sog5jrsDnTDyo5F0Q2wCHLKHPVmd
         oKT870+fh8P7JY1RIlwddNo7OF1w6aUeacGg+8iwCu2GYhhHaBPcg8d5Swnr06eD7/3S
         bFh8emRVBh3xK4NCTz6wFXyK5X5LMPlRBPITeGAYgn0EDXA//GJ8jKMHJO2zuOrH7R6Q
         LUn2X6YkambMVO3EsTznMr+UVrX8WO6FORPAiIl9tYKYrTuYfmysZFagJdnsEt6FL9eg
         ehgotXz5PjXfWciYsKUE1ISseLM/20+9lJ/eZ8rMAiepoDoT0n7DIPH4NrPWvE7AW5DH
         VFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVkHO+HOguCgWVPWLR9jqJs4oUxKV1lGt9Dq8hvAKZiUwgnNfBX7ijt0gbfbbVhdq4ckhktKWcRWj/CCyIQqRfJyqO7bKQU82gifNTE
X-Gm-Message-State: AOJu0YzWcTeYD2fmA8gRUzHDvg6vADcBU5NeXA7stbAXHhOz5ujtqiML
	9QG22h3hwI8XZcz6eGNfvJU0rtsI+4U/+pUicrlk0k3yk0oRkp6Fuopii1EIb9A=
X-Google-Smtp-Source: AGHT+IEXkiZSwutlTqPA8bIbq2xfxvdoWK8kN3ol6WJDmD9JkYhFEs2a16HfG50Okm88n7y6CcUNmA==
X-Received: by 2002:a17:906:b015:b0:a47:3527:96d2 with SMTP id v21-20020a170906b01500b00a47352796d2mr4569133ejy.0.1711365506246;
        Mon, 25 Mar 2024 04:18:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id kq1-20020a170906abc100b00a46a04d7dc4sm2946795ejb.61.2024.03.25.04.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 04:18:25 -0700 (PDT)
Message-ID: <3fb87271-5d1e-465f-a7b5-06f9def0807d@linaro.org>
Date: Mon, 25 Mar 2024 12:18:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] dt-bindings: arm: qcom,coresight-tpda: drop
 redundant type from ports
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mao Jinlong <quic_jinlmao@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, linux-arm-msm@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325104007.30723-1-krzysztof.kozlowski@linaro.org>
 <f3a1325b-4126-42d7-b777-9b511279251f@arm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f3a1325b-4126-42d7-b777-9b511279251f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 12:07, Suzuki K Poulose wrote:
> Hi Krzysztof
> 
> On 25/03/2024 10:40, Krzysztof Kozlowski wrote:
>> "in-ports" and "out-ports" are defined by graph schema, so defining its
>> type is redundant.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Both patches look good to me. How would you like to pull this ? I could
> queue them for v6.10 via coresight tree.
> 
> If you would like to take them,
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Please take them via coresight.

Best regards,
Krzysztof


