Return-Path: <linux-kernel+bounces-13091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E281FF93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31401F22075
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961311705;
	Fri, 29 Dec 2023 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKEVaFcD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D38111B1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so714760366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703855189; x=1704459989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKl2hv7xjGsCk4ipbW2TPD5NpXw4HvPQGvbNkejIlh4=;
        b=mKEVaFcD/L2jaQ0hPvFrYEPYGCJswZBDPe0Ps+6c84ZAWBsa8q0Fx5Zsk06qwPM7Gx
         gQV5DNeDWt2d6CBRVGVVUPPSiywHQ1SCGirRaEEFEhLQRcCfDf4yy6kHzQF5bQGJkGWy
         WeKuRoI9qVL58g6as8+J+/tmD7/ONkfYp3wVhQHHgUhUzrTz6QNEa+YTyzwIXaRM03J/
         RuibcVzwQl/P95jGDc9aUKkB99y1IPcwUYGWqjCdJAk4A3ZYFDQ08Ikk5PeECqWIRi0c
         SCSnParoveJT7hXInk0OXwMVOMpf8WogBcP4w7vDwdOE8sQKFdByObzWfXQeWrsaHTST
         s2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703855189; x=1704459989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKl2hv7xjGsCk4ipbW2TPD5NpXw4HvPQGvbNkejIlh4=;
        b=TDlXbXNKzds4i5kkdR22DF43TVG8bthBnJpl0oF2lsvuLHHLpYFjgHcxsAZFXNzT4a
         hmgUoVR8kUs41yHFTh7sQCAYl9j2iG+gumUAXx9PMGm7S2g+My5PWZPR7ZTEYWrHnT5U
         gOjRWyJSULwy+3DKgriTbKrjsCILOt7HrsdcLtduEPwc/stUkoI34xz//SOV4hsFNDzC
         cwmXWw7QJu64Fa3388TqH68I2xYdcgHSQud+a824bf7Cg6pVagcomTsXf/Zm4lyE9DHq
         LpkgpP+E7pweuOZktiTt+XimPcEHhcYBvqqOM0vZFEs9RuuH3zqs8pfRLniwSyzDKFNG
         Ts1Q==
X-Gm-Message-State: AOJu0YydXm0Cw6cH7XZd4v0514n1gL+9Ld+VIdzkrw3U4DtO9CECKo5B
	XL7tvnhIAjK8fBIcjG9SSAOzD3wmlPLWhg==
X-Google-Smtp-Source: AGHT+IG6nayuDtLATAJ3w9ufh+iosF+lV0OjwmqvmBhBKgXTlvxjbK7Wz8rK3l6GS4p8DMngFG204w==
X-Received: by 2002:a17:906:7386:b0:a26:f18a:b31d with SMTP id f6-20020a170906738600b00a26f18ab31dmr2827006ejl.13.1703855189611;
        Fri, 29 Dec 2023 05:06:29 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id fh24-20020a1709073a9800b00a26a5f83cecsm7927239ejc.79.2023.12.29.05.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 05:06:29 -0800 (PST)
Message-ID: <b730bf22-fa3a-4720-9fd1-79d2207d6812@linaro.org>
Date: Fri, 29 Dec 2023 14:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 14:01, Johan Hovold wrote:
> On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
>> The USB GDSCs are only related to the controllers.
> 
> Are you sure?
That's what I've been told from rather reliable sources.

> 
>> The PHYs on the other
>> hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
>>
>> Fix the power-domains assignment to stop potentially toggling the GDSC
>> unnecessarily.
> 
> Again, there's no additional toggling being done here, but yes, this may
> keep the domains enabled during suspend depending on how the driver is
> implemented.
No, it can actually happen. (Some) QMP PHYs are referenced by the
DP hardware. If USB is disabled (or suspended), the DP being active
will hold these GDSCs enabled.

Konrad
> If that's the concern, then please spell that out too.
> 
>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> 
> May not be needed either.
> 
>> @@ -2597,7 +2597,7 @@ usb_2_qmpphy0: phy@88ef000 {
>>  				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
>>  			reset-names = "phy", "phy_phy";
>>  
>> -			power-domains = <&gcc USB30_MP_GDSC>;
>> +			power-domains = <&rpmhpd SC8280XP_MX>;
> 
> Johan

