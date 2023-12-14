Return-Path: <linux-kernel+bounces-254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19493813E58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFBF1C21F80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADEB6C6FF;
	Thu, 14 Dec 2023 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNvqmDHn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA36C6EF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so1208325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702597063; x=1703201863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VVO89L9VZTI3O6OBS8Xb5DAR6WYttB1FJb4u0vyyCs=;
        b=gNvqmDHnjciakuczgS9s0H+VShnwqyzKY2n/vKDg5BNFE/qyvp9zYA0JZAYiv4PHC4
         s/4lsex5L2Wqohr7/yzFuYUgu21PlH3rOliZacLb7pa5IL2eM2iJpgzsX++FDkEVA6Q3
         aI7D49bYa+he3WTuMFqSytOzEQX8Mt5Po9r5+dt17wfYWEx5aWiUGDfN+sFVfJ7NoI70
         c/wQeewZK68jpd4xpkMzoYe0AEQRughb4rtyu3rV5/fWiKotdCg8nn5w7D1m1BcDKlQ6
         UmxGgIYvurvbjvrtD4QNBbv4MeQtgJ73xF3ddosHy7Db134uFbluNXMa4FlcmWTE3Wr8
         9NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702597063; x=1703201863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VVO89L9VZTI3O6OBS8Xb5DAR6WYttB1FJb4u0vyyCs=;
        b=q9hce9er++McOFTquT7rpe1cqP3GKKCk5wx8AhHAsozQiqyW+2rr0NS+jWoffiPHbd
         1S78zb8UTytxaZc8nqufLRO5z3gPXwOzJiFlPnKd6M/qOES+n3F7n5bX/fWinx9Bc1cw
         sTHH8qHlhYAnE51eHXX1g7byTN7VPWSe2CaW/6rWnIBWBk6Pes772gfgql8k/1PAm/id
         feRQLB/cN5SOEIY1nx5F1HT3TgRmNY7RrO+0TOe8nOjLyT+MmngQDj6g49EorFivCqDW
         Au291OZsf7VKmmacrsTG/SbksAMgfzdvd7qpR313/g/Xv8O/48sUv2LqtwrIRT5uwvAa
         iVBQ==
X-Gm-Message-State: AOJu0YzjDt7K4J5qtRdmiWiYseYinHpcV0Y4k5wGXvxH3n+7K0/ZyZ8n
	NNprTKfnmESPbCdq6M9X/hA6WO5yUDp1+xblr+0TNw==
X-Google-Smtp-Source: AGHT+IEIw6fODakxs+SDKFkkOz22erjEWVpm1FcZcPyyqFr5OfNKp0LxnOkROs9ikxtK6hyVPI59WQ==
X-Received: by 2002:a05:6512:3408:b0:50b:fa1d:aecc with SMTP id i8-20020a056512340800b0050bfa1daeccmr4627770lfr.29.1702597042079;
        Thu, 14 Dec 2023 15:37:22 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f33-20020a0565123b2100b0050be242f50esm1981318lfv.58.2023.12.14.15.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 15:37:21 -0800 (PST)
Message-ID: <f6eb7bf1-7592-4313-9fe0-a3a8b8039ab5@linaro.org>
Date: Fri, 15 Dec 2023 00:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 initial device tree
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20231214-peregrine-v2-0-a35102268442@apitzsch.eu>
 <20231214-peregrine-v2-2-a35102268442@apitzsch.eu>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214-peregrine-v2-2-a35102268442@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 21:59, André Apitzsch wrote:
> This dts adds support for Motorola Moto G 4G released in 2013.
> 
> Add a device tree with initial support for:
> 
> - GPIO keys
> - Hall sensor
> - SDHCI
> - Vibrator
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
Excellent, thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

[...]

> +		pm8226_lvs1: lvs1 {
> +			/* Pull-up for I2C lines */
> +			regulator-always-on;
> +		};
just one q: is this intended to stay a-on, or will it be bound
to some i2c host (presumably camera)?

Konrad

