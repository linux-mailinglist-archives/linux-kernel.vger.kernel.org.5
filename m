Return-Path: <linux-kernel+bounces-154173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C68AD89D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3314DB25505
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF21BF6D8;
	Mon, 22 Apr 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdbztOch"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9D1BED91
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826752; cv=none; b=cPWvWF/ahdgJDrVZNkcWyg/K1QIQMoS2H1yALiGiaUePkc03JUdC3wTJAcdqFPbMSydYg84MpNihDpvBxOzJud/C0aD2LGbb6adWf9r7aP8p44KQqZBw05Z9dSUG+cKZGVR7RNBFKiNT3dk5OP5THJamURYzZKHAYB6rRwC354g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826752; c=relaxed/simple;
	bh=A+pjZaVNLZlD4+785iXCBInD6tY2++kE/rsQCAPKzmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mddd8i9nnMr2W0Dyo+3rFC5TllvyhUxy4cIGTEDtyilSxllQn5TAQcan41/dDxHzJFevM5+NJHNPAL+tvUuDpmT+pJjKHB5dtdQc4ZKF9hEMEhyWrmc3glxeKdy3TB1BT95qRTjlrc+ee2qf8i++z0lI4S/NvxaqHhXU1qgiJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdbztOch; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so6052988e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713826749; x=1714431549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i01WWc8FrMY19HordvhidcNrQ81jJpkn1b3/nH/zGe8=;
        b=OdbztOchHf3JvCMpJveFDo4fuOqiK/LSD6pKRX+H5pZkD/tRLIziDHMtdD+ce3iaGz
         hH1JOSMyNGOZWgSLebbxMxF3YR5F0CywOBK+GPc6u8HwiukWDGsYy2nKC4KjDMVhYJjR
         +M4AKMPx6SHMk2eVxvrXDrw782KclyQd5qrQzQqEU+Q61W+rrmZ8F6XIawbiPRGGQqGb
         kq87zrf9E9+2cnmSkkDCIsD8VVSaSlWr/vyc60cOrBx96hSUqHdHNn+4V3DLjA6LuVL9
         Lce4X3IsVAykQ6/m0S02eLtpWsKeEF3jMXQfSsQY9gh90fi1xn6n50GI11vCqwYBfnx7
         ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826749; x=1714431549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i01WWc8FrMY19HordvhidcNrQ81jJpkn1b3/nH/zGe8=;
        b=lYoCrJOEocMuwC926PXJe9/bAV2m9E7cVJKkWvlGwj0TphOLeVVDTYWeT7W1GwdSJm
         6ulbf6L6KBvFMgJtfCx/kS9ATX99aBg14E71TWJb8LacVj0FDySjV8LEWTBYwwvDQ1yl
         ax48SOqL1kOeoikNR72Vo2TZQs+23jrFLVxEvspASs/OsHPPrBwM4zXK2TIHhbaMhoHU
         J90vKmIbbsP+gw/KxkYHD6Ym7nHVA4fpDctI9Bqj0/B4a49ooCOMkHJ+pqrRI4ZZJAhA
         qZDaA6Nyv94Hd7l1aV/Yl31nh2jvnx2h6evhTF4563HLpkCm/Jwd0iRfNIwt+12oZjvK
         Rnew==
X-Forwarded-Encrypted: i=1; AJvYcCX/q6XG9kHyoxFoacIkFvUu4NwpmPQXbJ6uBjOC6Q0C6vPVV3ZfpSHsOgBr4D0HEMhJlWd39mxw0IMb2ccYeQwyCWi+xtsqOlmLCfki
X-Gm-Message-State: AOJu0YwuJFUHETsyWo3P4MBf3Z/E5DIiYLWlVbEUTAvu6c8p1GLwnSoS
	Ugjbu2UshUGiAhHDA3u1YISv98+UQT8qBRwNXlz3BFHZTl5sSzo3sZTM/4oMik0=
X-Google-Smtp-Source: AGHT+IGM2GumwwiC2694i6yrlX+WVqY6Xo2siXBL73bwpoR1PZgNJjl6/DE+91yXjE9Has4vCfMkTQ==
X-Received: by 2002:ac2:455c:0:b0:51a:f362:ab2a with SMTP id j28-20020ac2455c000000b0051af362ab2amr4281198lfm.59.1713826748840;
        Mon, 22 Apr 2024 15:59:08 -0700 (PDT)
Received: from [172.30.204.103] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b00516c580b640sm1863304lft.13.2024.04.22.15.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:59:08 -0700 (PDT)
Message-ID: <3f595432-83ad-4513-a24e-87e8ed45eba6@linaro.org>
Date: Tue, 23 Apr 2024 00:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI: qcom: Add equalization settings for 16GT/s
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 agross@kernel.org, andersson@kernel.org, mani@kernel.org
Cc: quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-3-quic_schintav@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240419001013.28788-3-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/19/24 02:09, Shashank Babu Chinta Venkata wrote:
> GEN3_RELATED_OFFSET is being used to determine data rate of shadow
> registers. Select data rate as 16GT/s and set appropriate equilization
> settings to improve link stability for 16GT/s data rate.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---

[...]

> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg = GEN3_EQ_FMDC_T_MIN_PHASE23(0) |
> +		GEN3_EQ_FMDC_N_EVALS(0xD) |
> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(0x5) |
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(0x5);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg = GEN3_EQ_CONTROL_OFF_FB_MODE(0) |
> +		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE(0) |
> +		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL(0) |
> +		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC(0);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);

Also, any chance we could get some explanations as to what these magic values mean?

Preferably in the form of a #define for each one

Konrad

