Return-Path: <linux-kernel+bounces-36949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4472B83A943
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731491C21942
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68B6350F;
	Wed, 24 Jan 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTdGRbzQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A763500
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098259; cv=none; b=MfGQQUXpKaUx7SrkP/bZ5jCbEWbTxeI/MS96i+JjgulwnWQDdTFPj4NLXSXqsDQ2OGGA8pOh4wCyypfiH42YM5RG07IPlJpkmWnNDSZsJhiLUeFLdbSsBunp4WnQN/DdQwwTauBVjlyOCvn/MtaDYLY3W8cKggtWiSt8LnPRHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098259; c=relaxed/simple;
	bh=hBBe2xh59Q4+C63aRE6jewMWx0A0Jwfw4ICW1/4xxvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTN03oLuudSqZe3WhgMotZNY2uyjX3fPV3plhQj1jQPzK8nHnkXhd7IhaKJvR0PQJiqdur+/Zj8Guf/GwOAuHsR8AK6P4BbRO4GEbxPFfCZCG7x1jlB8bF0VqhV97LWoTC6kahspywGAMs5xtRnYIovl1R+QNCSUsLZHzb+cmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTdGRbzQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf108f6a2dso20473481fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706098255; x=1706703055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxqLYnJl0Q8qohdE/H5PX6zIbzKF8rVClXxhczfIt+Y=;
        b=aTdGRbzQ0IzNOcCw53gXx1ONy4dFroCtZUnBDZ/1TO01/PXtmHhwT4JlaFSPKR51Sy
         BkECo2AEkDzNhZicocNjDKZr1iTgq95p34vHI3Jgw5Ek7uTu+gpL7K6kfDwtIRNjlwoR
         jiQmEF8TevNI3MK9ehy5rF7QVzS/DtqYVCuVQ18e5q5snnh/zvUcABiD4j1zU35wdOWW
         XcFXgxcVZXeu3uyIH4MXyvjSSCKFLekxR5A/HKdZpBDlQZm8qOIprThZT8IVKLJvNDrt
         QChnb5bkk6HeAT/qBqtcOqXQ/od4HIO2g8XWWnt8C2fs6YSPMQ20SA2bM71JvjRKv/Ih
         NRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098255; x=1706703055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxqLYnJl0Q8qohdE/H5PX6zIbzKF8rVClXxhczfIt+Y=;
        b=gZpEJDzHa/W30QNAGSE2U0qfG8ZYbsJWdL9CjMIcuz2yVFN9LrCXJ6S5zGWpG7KXwU
         IegbPDx2o18ZLcVFT3bmRCWhrEQkANk4nd3hM8Z+lZ1tTh6ka4Fus+vbKLnbcYnQNW9l
         A4h9yG8Eq/PhFz+Umd5IoNoIN+X1OiwqtSTH2oTnKTeQiWsnLYcaOaC8WQOjThHHzHRe
         RjU6Di/ldf7KE/U/OuGNPT3PTwTBN8bM8ablts9L6U4mMQT4mNsWO3eQKqXcfO3qgpxN
         vMrdjf41EMMJvNd9IRIriojRcjupm0S77m0NpwCgzedusb9YZWAveaOBfjsOs4girXVj
         9DcA==
X-Gm-Message-State: AOJu0YxqrrgMI97kyy689FVSrkKDBTjyDHyUGYDJKKcUCxuWAsrRguGn
	Mxd/mHtCzmxCa6xZXqoPfBNPKG5GCwiNIjRdMXzZv71ohQqKDjSRVJwt7y3+/9s=
X-Google-Smtp-Source: AGHT+IEaLmOyU1xEoCIKY6SDGgPvE9yM+XwFW3GAikfxY2Ntww+EkTI1EUX72zmAXJwNZw0kGholAw==
X-Received: by 2002:a2e:87c9:0:b0:2ce:19d:211a with SMTP id v9-20020a2e87c9000000b002ce019d211amr681590ljj.62.1706098255309;
        Wed, 24 Jan 2024 04:10:55 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c3-20020a2ea1c3000000b002ccdb771df0sm3869539ljm.108.2024.01.24.04.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:10:54 -0800 (PST)
Message-ID: <5192c3b1-46fd-455d-aa67-b05bf5c54e19@linaro.org>
Date: Wed, 24 Jan 2024 13:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8953: add MDSS_BCR reset
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
 <20240123-msm8953-mdss-reset-v1-2-bb8c6d3ce897@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-msm8953-mdss-reset-v1-2-bb8c6d3ce897@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 22:03, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add an entry in the gcc driver for the MDSS_BCR reset found on MSM8953.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [luca: expand commit message, move entry]
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

I found some more definitions in lk2nd

88:#define  GCC_CRYPTO_BCR                    (CLK_CTL_BASE + 0x16000)
106:#define SDCC1_BCR                          (CLK_CTL_BASE + 0x42000) /* block reset*/
125:#define SDCC2_BCR                          (CLK_CTL_BASE + 0x43000) /* block reset */
150:#define USB_HS_BCR                         (CLK_CTL_BASE + 0x41000)
155:#define GCC_QUSB2_PHY_BCR                  (CLK_CTL_BASE + 0x4103C)
168:#define USB_30_BCR                  (CLK_CTL_BASE + 0x3F070)
189:#define USB3_PHY_BCR                (CLK_CTL_BASE + 0x3F034)
190:#define USB3PHY_PHY_BCR                 (CLK_CTL_BASE + 0x3F03C)

Couldn't find this one though, did you confirm that MDSS goes off
when you assert it?

Konrad

