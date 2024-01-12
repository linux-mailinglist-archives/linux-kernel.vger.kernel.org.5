Return-Path: <linux-kernel+bounces-24791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38382C29F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A62F1F246C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C06EB4E;
	Fri, 12 Jan 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCUb9eu4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBB6EB41
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso4363594f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705072650; x=1705677450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQNAWDXmxYQgA4LCYNmP7mT3vlvbfkNqLGD29l63sUA=;
        b=GCUb9eu4TaulOmoyhglouaCBEVoE057d9JYUGF8PwD4yNuxpkLpwo+NPfKMCZc80zZ
         4YzhDJl1Fx4EK47H7TRgqbGXrFmJdiCYYjruaKe7bH0bTwm0oIHBpdIvPBhhSEELueug
         J+ieGU65i5BytmVPgTc2GiE+HwZdDWv+3iDlz79w9ENsRY1RzUUHUwyLqqSSt08sjJZF
         GZ5+g/J3aoRlcvzeMnE6hRbjzna6fo9ZBEWNrbdKHdU7faVmXJxCL6KxRROg16rSwtJR
         uu4bFUNPHBzadKdgKBzylk1FrpGVPA4yBbCBC9rYiw44lbHTRf6NEWzEf/xzfZPh/eyR
         ZwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705072650; x=1705677450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQNAWDXmxYQgA4LCYNmP7mT3vlvbfkNqLGD29l63sUA=;
        b=EZO0Qof84Br4njz1cCQp52KhqL4BsFA2IWXdiml6zGhcjiMUm6XmcihYA7L94P3sl2
         vUdERUp8vqHXoqqtWtCgbSyXWBS/QV8KPOeRu9zgm6MsIx/Ed8VwrNHIk4o0f7Pr8FYx
         8sVjXdKOcr9LRAACEi2Ws7j/RjTYqLmLC8sX9kxNfy5lE/FQjJXYru3HPO1C/C9gNPmF
         6YnAfXest7nDwVLWISfgYai8Z4DpAGIp7v4VCdqEtwzCoV1Y9QIj5CROGzC4JYbF3f2j
         63CEEbz3+wpBwVODNyNvevtGcByKGxwHb+0ph3tbikQuA3mcgftdyL8ts97YvV1IW+BU
         +esg==
X-Gm-Message-State: AOJu0YxspsO1xsnMTuA+dD0z46upGi1t8O398raRA/nD4vcCPiWHKMK2
	xpjGcKanu7o/5V2CUCAnJfAz1bPbwPGnwQ==
X-Google-Smtp-Source: AGHT+IFSQRMTt3MRHiq8+omkYfNKh6C4s/p8ZGj089lXD4FOE2t74cG6vQoayvJt3ce81EKNlrpH0w==
X-Received: by 2002:adf:e64f:0:b0:336:ea02:ae93 with SMTP id b15-20020adfe64f000000b00336ea02ae93mr486332wrn.180.1705072650364;
        Fri, 12 Jan 2024 07:17:30 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id r1-20020adfce81000000b0033667867a66sm4147699wrn.101.2024.01.12.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 07:17:29 -0800 (PST)
Message-ID: <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
Date: Fri, 12 Jan 2024 15:17:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
 quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/01/2024 14:22, Krishna chaitanya chundru wrote:
> CPU-PCIe path consits for registers PCIe BAR space, config space.
> As there is less access on this path compared to pcie to mem path
> add minimum vote i.e GEN1x1 bandwidth always.
> 
> In suspend remove the cpu vote after register space access is done.
> 
> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")

If this patch is a Fixes then don't you need the accompanying dts change 
as a parallel Fixes too ?

i.e. without the dts update - you won't have the nodes in the dts to 
consume => applying this code to the stable kernel absent the dts will 
result in no functional change and therefore no bugfix.

I'm not sure if you are asked to put a Fixes here but it seems to be it 
should either be dropped or require a parallel Fixes: tag for the dts 
and yaml changes.

What is the bug this change fixes in the backport ?

> cc: stable@vger.kernel.org
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

---
bod

