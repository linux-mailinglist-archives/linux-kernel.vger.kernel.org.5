Return-Path: <linux-kernel+bounces-108588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE382880CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C701C216D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84E2E62E;
	Wed, 20 Mar 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqUuOTgx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514D2C698
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921674; cv=none; b=eFlpcBQBCVA6NzhLzR3ZlKuXjsjPvb0B2Xpirkg9x6kkh70gMHq29bguyaySyRSDRfneS66+ZzVthTWTo5AVBiyLYWfE/WK3QMyTY0F9xfvzFleVotVWAfkqG9kyjKi48mqvh98AjWAXP7Mj1oDUysbMOlwYpzFz/eDEbFsygW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921674; c=relaxed/simple;
	bh=YWDQGj+NIT4RX0QDpgYy97e5lxFO9pkCRRwl+TMF5yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGe3UDDGXSTMoufV/u+7TLd7BVU4oY/QWcsDbUWYbEaeHNDmFoEnW1XQBaGpUA/r4/e+0Q4VhfkyGWViF71uCLArQqGIJS+RSsQjgIq7Um+5PFJLAJRoUwhyrepaMPMe9Dz9zHHV4bw51MyIK7K6AZzSEy6G8zA0jdBIP9UBUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KqUuOTgx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568a53d2ce0so7828557a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710921671; x=1711526471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nNs5OHmBIF4OfZczAp5Q6QlN94OHf1q3wmIZoe179dY=;
        b=KqUuOTgxrX3f7kXUJOCNLLWFh0j4QowpiMG0qQLbLXQ5xycqiaO5BLV0AHyqAcc5KU
         fv0Hbsm/nneL9O60mh2G3P/ESnOa5xswHKsJ248tHXVqoVZyVyX+zP9YCq1bOYvcK7Yi
         ULu4X3qW6bDsb+8iXflV4zDmg+cWE2ay0Enf2AL0uDmUNvgbkl/M+BDQmGl8mEsc++Ev
         2v24IOvs48G9jFkrPoRP3jkbq/S4+OSES2/mNvl64QAp0m8QB0oYtvd9kKZN1OauMJEM
         7DxKVrS6OHKDgf58+dhNMb+Z5O1s45NjFYm7+5XNCQbbRI7wInyrmrY/iQ732AeSYt4G
         qQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710921671; x=1711526471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNs5OHmBIF4OfZczAp5Q6QlN94OHf1q3wmIZoe179dY=;
        b=HrlovTvohrZTJd8ZrU01ewYOaIlKJWEeoaqWP1lnL4BdHEoopDqHBj/UoChz5P0IfR
         lrh2ESYC28hBqoIApPLGV1cw1MAFBE61ZdBOshI47Mt9JPis5hL++upcPIFvvxm29IWx
         vQ4CIEhn/sgCJNCGcWo/1+mCAfmXmtzFXif4st0FTMIQdp0miLW7iGoXJK/zewvIrlRp
         xaMg5T7IRizlUbmLCmuHy5IX72Fc3MVHVHNrRQioqHkzo3ZfuTnKHdFAl/+Isdl2j/Zh
         nfsVXelkYy9pJFpUnL9oQWbYParJJy9V/iyGOH70q4deO5nbQRcOoWc3puHE9dCI30+Y
         z/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX0NCXDX5ag1LYz5CzgH0pskzrmL0eugliobFoty4LmwqlkQExj1dKq/js7neAw3gVaPQSfCWcBVu1FHOa51k7tYOBXHe6irhElxwm1
X-Gm-Message-State: AOJu0YxDEVR5Im6LPrRY4mB+i10YLuDld53YfvgKcrdfP19SZu6LIOmz
	qOdMeuRcCrgjXMw0fxKZ2OR04U4oHiYTKidzdyIoL1vfidTNn5UNcKf82y8tWlY=
X-Google-Smtp-Source: AGHT+IGmg7JhFd9YGo4SzD4tHxgDPiV+U6ye8mank53lEhUoWpv2I3LZiyYHwc5iz/pzjwNM7K6BOg==
X-Received: by 2002:a05:6402:2b87:b0:568:9ba8:8f1a with SMTP id fj7-20020a0564022b8700b005689ba88f1amr13766609edb.7.1710921670985;
        Wed, 20 Mar 2024 01:01:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id es8-20020a056402380800b00568afb0e731sm5435012edb.63.2024.03.20.01.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:01:10 -0700 (PDT)
Message-ID: <822989eb-0e8c-47af-b1ae-435f35472cb9@linaro.org>
Date: Wed, 20 Mar 2024 09:01:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 document PHY AUX clock on SM8[456]50 SoCs
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-1-926d7a4ccd80@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-1-926d7a4ccd80@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 11:44, Neil Armstrong wrote:
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
> "PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
> is muxed & gated then returned to the PHY as an input.
> 
> Document the clock IDs to select the PIPE clock or the AUX clock,
> also enforce a second clock-output-names and a #clock-cells value of 1
> for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


