Return-Path: <linux-kernel+bounces-68628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1E857D79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43F2281F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29212129A80;
	Fri, 16 Feb 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLh07+Qv"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCB129A6A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089341; cv=none; b=ROrAahb1ZF/+nZ7GLF4Yx74pSr914/IVgGOoH4xPD3Ux1m8oCxE8c1fGWbM+9/SuC/pB6VvZYj4wmQ619HPxJJfCqh5+rJZjGXXZH6/YB0jE/6EHRaPLJLYWIBbE2+DYLGVOiqY2kJBUaqCF5xv7TGcETdBGNKrE+ZjNrjtjvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089341; c=relaxed/simple;
	bh=KshJW+Af2TZqa/p/ikCF46YxCA1R2gN0qy3Ynw3oeAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJv50fFrNn2stCNpUj5icNOw8BH/r6+33hkKm0p0WDmxtn8z6zlcahBsDb+BashFFLfaKj8aBFP3bmOVDcC64XvFAZwsX/m0WZRX15yhZwuX3R1HcFkBkvAIqWI82NlplwVvcXe7FMuXf45Hwq1zNr3Fj96/ef7+kprfIAHeqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLh07+Qv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so259574066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708089337; x=1708694137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBSXdOntPeLAic2YSCGmE1hb9lcDpa7YnXt2WuP35RU=;
        b=yLh07+QvXUvfz5HwCuG/XW+4M3bctiuB41dspqytbspm5euFsfIHTMyuQwBcMDC23k
         46DHtM5ScrA+rHGX/pSJQi61RLYVlWth5DOfZwwAvdbCc5jT1Ed1c9rkmGsIRTmXiGmV
         2OLUc0xUXsuqcNDpGdxu2XY3czfssi2AHjGO/GdgF8G98XP5/dPCfMT7cMLgyy+WsmoJ
         ceyv7T2M060+tifdge2Ngjv0Liw2ZvWB75s2KOKo9QSm9ipPVva62scgYhkfHoqZIqiS
         wTsufVBP2owe8Nm3AoYWdeErYL5Y/ftBhp8q27MPNCnKhxxeQ99bfRIiCAw/8OmBP2OK
         83Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089337; x=1708694137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBSXdOntPeLAic2YSCGmE1hb9lcDpa7YnXt2WuP35RU=;
        b=rriC20oNz28u1A1j3Id03NfeXcp+2AZCSlN3j3ZSLCF7AmkNSEu//LQv+YGlQRg1wy
         lMdX50WggIsgD7a1902Q4za5Xq/DeSYA3B3EEEyD1hYR4/yeG6PrHZVqSnmKPkDrSIVP
         9E2NLSLkAcfq0RzpPsdXshhQd25MOErsR/ENJh+39HczDpCDWYnrF5f4tPYrxxC9T3d8
         R652f6wsGa0jdSwuH0UQ3N9XPTDHSg1xv8P1MVLkan8f4WI+yV6B/1SsD+Jq1fRwuGvx
         2RV87jstUXlMOeSzo1dxjwurN5s7Ecr/9T77R+pHNek08wJ4rdum7Emo0vPr+IS2ppYe
         G/4w==
X-Forwarded-Encrypted: i=1; AJvYcCUBC3ZYam0qfE1C7gHAiFh/OgkeD4gnQYphOGuRq+KoY9D4u1Z+2tSnPU3O/adM6w7o5PHlDavUcG0bJmPV2EMeSr9mRpwGIzUdpa9S
X-Gm-Message-State: AOJu0YwmglIMmYIWuKaUNHP20tbNht+CUTs6DQK3SoakXFKhMqiMi3nG
	PE8EJ4LSt/Qc+9ZYj2hrwoWLh2bsbCpTF34jZI1TbVgPqY5EZgxdBLx8qpTxHec=
X-Google-Smtp-Source: AGHT+IHN0T63GBIdlJqFXJYWH/wKCTSEx2gfTLEy2txVqfz2CGcrM5HbyOvRyjHKjO5dSTDnv5EuJw==
X-Received: by 2002:a17:906:a29a:b0:a3b:fd70:f9e6 with SMTP id i26-20020a170906a29a00b00a3bfd70f9e6mr3237189ejz.5.1708089337225;
        Fri, 16 Feb 2024 05:15:37 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a3ce36ce4f9sm1534655ejb.83.2024.02.16.05.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 05:15:36 -0800 (PST)
Message-ID: <ad827531-a470-451d-8f60-0fb82065cee5@linaro.org>
Date: Fri, 16 Feb 2024 14:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Add interconnect for MDSS
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216-sm6350-interconnect-v1-1-9d55667c06ca@fairphone.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240216-sm6350-interconnect-v1-1-9d55667c06ca@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.02.2024 14:11, Luca Weiss wrote:
> Add the definition for the interconnect used in the display subsystem.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

