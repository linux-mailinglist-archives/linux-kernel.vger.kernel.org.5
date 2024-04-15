Return-Path: <linux-kernel+bounces-145801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E798A5B09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE401F2158A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09415FCE8;
	Mon, 15 Apr 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBSZdj0i"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8E15F322
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209693; cv=none; b=ciNa8Md5+Syqoc8mbRKN+45wGsNQ+MvrLlavo5IR0xPhZN25vW4GTeLIKWTVvAv11C/R6EpHxETgvhklLeQeKbGXY7TYcrhWyVQW7GKFJchENXepeXgtFpIf1RalxvqGhF0u7ZXuw75vsHqrr6Rw1E9KENeqx3WPkY9pkoV+SO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209693; c=relaxed/simple;
	bh=RQH/xq79Dx1ojuJ4FQ/1sF/nVGfejgfjDs1gdTGmfb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm3pfqEId2uCRqxGXBk6hBcD4/DOS/UCEXS8Vh2KDXs8dbNelFw6Xqfd1DkOOOwd/sppBkebC8BbrZzADFMY8nS4v8ybUeDRhgraZpniDPcpLxZaQK9/vNtgOl+XpEd82j/Yaz4xhtrC2Ux8Mcums8CP8bMwyPRXwIyMSalY6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBSZdj0i; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad3so40935951fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713209689; x=1713814489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74eh0UAxjJzTVRALg/TqF+8BFcarO+L4T6AcFES85ZQ=;
        b=uBSZdj0iJ7YWi/iCIKkcSf8QzNbly0iw8z8f6QAn7pHtVBCsn8vDbV88sFqabbzPe/
         8qt8Y3Nw1mjGvTpdEjHfCcv+LeXIQSE385185nh+WjHhSQcydGMivNUUgahpafnc2um6
         p6LW7DAR3yTaW3SzTLMotTn9I3WdJ1y+O17fCNXeDoLOqxg2/k/AB4qfUGY+ud36dsKr
         LBLTIPRi5N2HafysJt9+GN2Yd7Qud/FYNH4zfzmMDOdH+zDl8+4hbP73SZNr8cIxz8jG
         DagIeWNoVRSPdJmHcIWbiSzvJPV0VCD7b9fkczOIzNTNTqPQR9k86eCGTO79M+cF+eAD
         ewsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209689; x=1713814489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74eh0UAxjJzTVRALg/TqF+8BFcarO+L4T6AcFES85ZQ=;
        b=gczBsqGmXarEy0xWmktlWfw/akbZLWuwD5sVRVdHLYl/PTUAb+t5uWkesySYZbX7Xz
         AMDGWqFjydkYuN5WumuRHVBz6Jn18EhqeQibduMkQycGVKJG8jVbkc4udnekO7cYqIR8
         PpPveuwhfB1zw5j9I9lNxn0gjqdPMDxOwvSb3gEJIhh8jTEeZsQadKO/Q3DuFC56jqET
         CBFpX7rktQfrwd1t/7G5epNvbqF3P3VhctNaF/i78Nz0ZwHzEG068CYzDfibVPxlh4El
         f5w1vQvrhhvutpkBbHKo6hWV7qkOIuCdRfZx9kPptayK5ScKBRm7tywJyEAiRFvhsOpj
         QXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUQhcbXe/zSDtNI41dqmlVX3Y7UnQkBy70lLPHtjUHHYPI4JiDHw2IyhnE+eRtrokGpB8WhtRwmnxGwNZanguhCiBWFu6jukCknxuNi
X-Gm-Message-State: AOJu0Yz/hE3ejXxIb/tx2wFjZpWe5onwqgCDND02Y2/Wb+XC2vqvF40V
	WJIrpXAhvmsQOXv5KNEo7RpedTcDzx4QitXeLPDjbCbdZwG+VWqdCwDZNqzT36o=
X-Google-Smtp-Source: AGHT+IFQbBYBAbKPlge2VUflWQ2uNCh+LB7V46pgV2EVpKugyDBFZB4CcvFXwqvdSBuJQ983f8Qc0A==
X-Received: by 2002:a2e:9bcc:0:b0:2d7:16f6:f678 with SMTP id w12-20020a2e9bcc000000b002d716f6f678mr5697752ljj.15.1713209689508;
        Mon, 15 Apr 2024 12:34:49 -0700 (PDT)
Received: from [172.30.205.18] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c3-20020a2ea1c3000000b002d8c9bcedcdsm1344155ljm.95.2024.04.15.12.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:34:48 -0700 (PDT)
Message-ID: <c02f9730-3182-46b4-b584-02487aafa22b@linaro.org>
Date: Mon, 15 Apr 2024 21:34:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: Document reboot mode magic
To: Elliot Berman <quic_eberman@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/24 21:30, Elliot Berman wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

[...]


> +
> +    // Case 5: SYSTEM_RESET2 vendor resets
> +    psci {
> +      compatible = "arm,psci-1.0";
> +      method = "smc";
> +
> +      mode-edl = <0>;
> +      mode-bootloader = <1 2>;

These properties seem overly generic, and with PSCI only growing every
now and then, I think a reboot-mode (or similar) subnode would be in
order here

Konrad

