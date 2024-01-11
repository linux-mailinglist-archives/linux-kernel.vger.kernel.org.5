Return-Path: <linux-kernel+bounces-23949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F882B454
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98C828479C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0152F60;
	Thu, 11 Jan 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/+NHhug"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73751C27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e5521dab6so22868295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704995438; x=1705600238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r4fSN+Eb0Ah4b0v0uucoHS1kU8NuFfnog6M3eLAijo=;
        b=S/+NHhugPuPVns3CLMnIQSdyoffpEwPWhpy+W+esGZpeeVpYQyrPjHMITha7DsSGH9
         d6je6VdrbvNJfc9R6lMpsRMMbXBX+LuanCW/Uk2Dna4ZjbkmKAGw0qsxQBJRIPmBY5m5
         u4A5zgrEpsun1577VOl7mtPYZMdlz/3cafFvenD68+bya5AiTQwcv9B60ONk7orJHgQs
         gJpJ4iZByPFwt7YG6e0fsn8BRaY1pS4q+Ki8OFNKF/edGe1Gtf7OIqH6M18JBji8VHkm
         fYzLf9sWokGH0IS16Jydu+5stfmEjhijS+bmxyR8ufyULea4RVoRO6Hr9RBjQn+5b8eS
         Lqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995438; x=1705600238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r4fSN+Eb0Ah4b0v0uucoHS1kU8NuFfnog6M3eLAijo=;
        b=KIs2e35bh4gqEsq1FLWSrZnLzSK7AYCyfEEiKblvSCWsA7Vqw1etT5VyKs0gaQ/qm7
         N5CaNN0eAHCGu3JIQ76n0grX3ZZEVVS5hrl7wpmm6ZF+aDlX6AKHcxzMGQhYKjRvHrCq
         4Tpo2lx7pvFVsO7FpM8kFogYCNpkZi7Aj+G1Kf7ygq7TDbOi+YualgPedckeWTwLzcYl
         imL1KUR1IMjX1UgALh1hQctcHtcLN4UHZdMgACH3xmFFfAkezbsfHgn1EdaTx9hcuARd
         qHFdR0RysfMcA/tHYzG/FHei2m+0S74m6drE2+iVkXHA1CRplzs1s7nIUHYe9xdkBbx8
         mvag==
X-Gm-Message-State: AOJu0Yz3ah0hJTROzYB87sC1m3x1C6l97fC3QPTj2S4OaS8AlqeU7JSm
	/rLK1HUcOzF32z+etWYrGLg/gVAczhuG6A==
X-Google-Smtp-Source: AGHT+IESpGPeLpy16PzNwqOR3aMMajngTGW3vEjja7+S0PWCyfH1q2b8O1HGVXA96N3KrvlvBpNrcQ==
X-Received: by 2002:a05:600c:3595:b0:40e:3f9f:8f76 with SMTP id p21-20020a05600c359500b0040e3f9f8f76mr133227wmq.23.1704995438076;
        Thu, 11 Jan 2024 09:50:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c459300b0040e42391a12sm2767701wmo.13.2024.01.11.09.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:50:37 -0800 (PST)
Message-ID: <036823ce-9815-4884-aa3a-9c3831cea9bb@linaro.org>
Date: Thu, 11 Jan 2024 18:50:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal for QCOM PCIe switch power and configuration driver
Content-Language: en-US
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
 quic_skananth@quicinc.com, bartosz.golaszewski@linaro.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" <linux-arm-msm@vger.kernel.org>
References: <413d612f-0e31-6281-64e3-6484b85afe06@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <413d612f-0e31-6281-64e3-6484b85afe06@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 18:38, Krishna Chaitanya Chundru wrote:
> Hi DT maintainers,
> 
> We are trying to upstream the QCOM PCIe switch which has I2C interface
> to configure the switch.
> 
> In generic a PCIe switch is a device that allows expansion of PCI
> Express hierarchy, which allows more devices(PCIe endpoints) to be
> connected to a single PCIe port.
> 
> We need to configure the QCOM switch like L0s, L1ss entry times, Tx
> amplitudes etc.. through I2C interface before PCIe link is established
> as these settings can affect link stability if we don't configure them.
> 
> Once PCIe switch is configured, PCIe link between the PCIe switch and
> PCIe port connected should be established by the QCOM PCIe controller
> driver to enumerate the PCIe endpoints connected to the PCIe switch.
> 
> We had a QCOM switch driver which powers on the switch and do the I2C
> configurations.
> 
> This is how the flow goes.
> -->Power on the switch
>      -->Do Switch configuration (over i2c) with qcom switch driver
>          -->PCIe link training and enumeration.

And where is the PCI controller in this? Why isn't this represented like
I2C or GPIO expander? You need to describe what exactly the switch is doing.

Also, how about using existing solutions? Aren't there any? I am not
going to look for them for you...

Anyway, you should ask (means Cc) reset controller maintainers if they
are happy for such usage of reset framework for something not being a
reset. For similar reasons you should Cc PCI maintainers. If you ask me,
then no, PCI switch does not look like reset line so, you should not use
reset lines.

Best regards,
Krzysztof


