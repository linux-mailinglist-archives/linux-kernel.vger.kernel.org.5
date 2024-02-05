Return-Path: <linux-kernel+bounces-52608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B0849A63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5751F210D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343F1CAB1;
	Mon,  5 Feb 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6wp5TXr"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198D1CAA0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136465; cv=none; b=uSSl0Yd9q07gVIKrGu9zrFwseLPEAi0ZS2z0T1AmDU2trHQS3ec1iSZHsU6mzIIvpbvFZg8J3HboslU8BQXo5vOBywP3mPxnQXI50NWndWWt3kRCStwobtsPSfzcXmz9To8e63MjyrGcZFFlSXJbvCw6OjMam1jMeAd9ZMBQL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136465; c=relaxed/simple;
	bh=F/vGB7EZ2Y9uFglw/YzNsI/xFtKCTqw8ZdSpuKIUeW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWPSGntdcS1ySijA+trHS0MEHSR1Lk9886Nny53ufCjgUUH+axRmmbgA1L8kAsB0XBXu0i+7G61i+XxoLIdkpjfSwpLcERI+ny6yWR5hUFyerawNUWSbaUAKUxLSlK4EhIRjoxoid/A29rmMP+i3Tq/JFhj5Atn7YE2MU4RBChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6wp5TXr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b123f99d6so2863735f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707136461; x=1707741261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChB6SzaiHcknSRQOHnluoQPXimrJjUlp4J06xKAnalY=;
        b=M6wp5TXr3WisXgxcUDUK6cOzsUlScI3Gwb6D8VhFj/yzwTt9G3wOkTag4AY0pwzWa/
         Qgp3P+52NkZWH+QTNcJUwT8loIM2PVoQG+daYFYLoPCsVhwQa/sP8G3WVdaCHYJ+6twU
         zhcbGqb2DWafmP3SfKPaErykLcwsHKRZ0fzalUMGpXDHe5aH0RVIw6NKfKvVG9iHJfMg
         xjpNgQh7iqPLlC7igXXivwBpIo9a7IXECffHJGXhBOBMenFdCXa7uMsEV1DR260HoPBO
         LKbaCLUfG0uqs9NVcm+7z5A653l405GJRuEDFc6ZAwVdpWtBnGRUXH4BOruqW5yfBXmL
         3xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136461; x=1707741261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChB6SzaiHcknSRQOHnluoQPXimrJjUlp4J06xKAnalY=;
        b=L/1PEqRPQzm4kTNSp3KoX3KUbYn/ZbE7jfGc0GIzZaLzx/BF9ABEBhnxLnZT8YY37U
         p8Tgz/vMyiF67hcsem7DZK6/EOEl4ALz6kzzcvbILr1yeu0BZSVeS8CE3ERC+UXzledv
         lLOjJhiXbRC63pgBk2OmJExqcGM6FCehTYedQCk/O/Y1XVUmZgu1BjH5dTpbWYWVgKYg
         S46i6zWWEdwUB1bXV3HCWhOza33D3ElGEdW+REhPDbHOLZ0+Diiy/JlqvDwT9jQ9sZzy
         btXi1axBUrbts+fTz3PTM6v8RcAsV20J8ILFokJDomrPHqD8m+E/PiSEOOHSn0OOfacH
         4nxw==
X-Gm-Message-State: AOJu0Yzxn5vn9W0+NWxDMv1cSVt1MvGOCZ4H2VAOraSOQwTBrHqyWwzU
	FfAsvB8rSj0fPncep5XmdSWrSWkIkt4MrMxLnbmcHuKzE0qcbvaLVKzI6Lqxgks=
X-Google-Smtp-Source: AGHT+IEtVpVnuHIWAlTkOreO810d3a8J0TqUbaAD3kqdjtUIPG2SqimuenrEI3awqRirVAFtwtHwhA==
X-Received: by 2002:adf:d1c4:0:b0:33b:3d5c:86ab with SMTP id b4-20020adfd1c4000000b0033b3d5c86abmr1941952wrd.34.1707136461588;
        Mon, 05 Feb 2024 04:34:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJXapYyb8dHeMkGXbwKwexFr6zRMM3gsKrNQ4RZu8KnkrFKPXfpwctBjVS+Ai3/h8xBbWfS/Xa1qy5TKgm+DT3SvLCN5vB7DeFyXm70YO+mrnCrBfZYC1YMUIZ+nsLrc4UeL0x8qwB+QHuOEUaCewCzPaTYqBZsNXorwN4L4HcemCzsHHLp34dgawSS8hKbCrrLvxanWU09YIvo4BgqwllGIjs51SyBBi9qzwPX3AML6TitpgjEtaGTXyLngF4J2W7nEeLL3aF5CIXENlKiIqbLTTxE/GaCEzT6XuzbjI2mXwdJIpcAnNr5nQWzNEVC7nRk6KCrEQC/DnO3IaSzy+U
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b0033b3cdb9336sm2256202wri.57.2024.02.05.04.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:34:21 -0800 (PST)
Message-ID: <f964540b-5fa1-4cfc-8c61-438a0a7db71c@linaro.org>
Date: Mon, 5 Feb 2024 13:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] soc: qcom: socinfo: Add SM8650P SoC ID table
 entry
Content-Language: en-US
To: Jingyi Wang <quic_jingyw@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@quicinc.com
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-4-quic_jingyw@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205115721.1195336-4-quic_jingyw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:57, Jingyi Wang wrote:
> Add SoC Info support for the SM8650P platform.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  drivers/soc/qcom/socinfo.c | 1 +

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


