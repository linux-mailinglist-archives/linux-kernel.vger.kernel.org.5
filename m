Return-Path: <linux-kernel+bounces-13416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A148205E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F3F28208B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F938BF3;
	Sat, 30 Dec 2023 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWkdVvd2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E468489
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso2198489e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703939309; x=1704544109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=keCmGBN/im/IoCDZQ/LMPz0jTzLPy/YoVnmESVbA/O0=;
        b=HWkdVvd2bD61F9fDi+2fPBR4IjzGjJSXSS1kLOM5MFECXB4i61wxT1AmIeIxf7xW8V
         u9AVbaOdKwq9CU4IaK/jEnsSEWM/F/PHSYfwtRk0XDE9AnnUQ7R2i2FA8cdqdjc2bZRd
         03oqI+yg9bLHeCsD1dPdhoWTlcYLRiKDH7G6E/5ypKkT8ymkvH77vyscArvPLniKABic
         UuD1ZfATSxYqYmBP7cyMN925kR2a/Pmjexud5riSxXjb0RKsjid45VLIzz/8UR2cC5kg
         57EUUPLFT2vUg4tTWH3xvog/uvI/Rg2tYPdp/sCUDqwOxZOy0wTk28Kr0loMOJYPerWq
         uj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703939309; x=1704544109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keCmGBN/im/IoCDZQ/LMPz0jTzLPy/YoVnmESVbA/O0=;
        b=FTdgkx/Oyabrq9m2zlM8HZQTUtwZ6UuKzzgpwpMseDnJtc2/xbKmPs+ljnMaA4OzNW
         LQSfaaWIr4vsHxgHR6PTsbGsZMtaZrpgqffer5wxK/hY4S0Y9gJEFdUsp/TswcZ3TehA
         VOsZUsCj0X4+PXZyW7FMtrCdHiaf8sJa0honmGNbwKWGOWdabtJm8LASd81EEss3X+hO
         s+eMevxw+YjzRAWUwkRuLkDxeX38m0p8YmUU/m487YEtHmye4Tjw19LfG42KmrhaC40g
         qyUwYgNyS2N8zhC7VWFlo9OII3gEZ7KyFM9mlDvwirWMJ6c2ljOxOGp9WWhBxzqvupaa
         C2ug==
X-Gm-Message-State: AOJu0YxpBXE0Jnmhx3fORsJrUXPSsvOa80z4HLCPeJIOC8CJLWeg+m9g
	/u2A5qJOXdbwwEbBhrKx0NBzce+Q7CrmGQ==
X-Google-Smtp-Source: AGHT+IHgyk41heTkSrAA+GHMVqwm41w4cfBV4Y0QUrKHXCUt2GWjAV98NMh1l87in3lNfKs4MfJaiQ==
X-Received: by 2002:a05:6512:3f26:b0:50e:5a25:efbf with SMTP id y38-20020a0565123f2600b0050e5a25efbfmr5545047lfa.42.1703939308628;
        Sat, 30 Dec 2023 04:28:28 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a269597d173sm9240174ejb.135.2023.12.30.04.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 04:28:28 -0800 (PST)
Message-ID: <2e937686-d579-4553-ada8-17a1cb1237cf@linaro.org>
Date: Sat, 30 Dec 2023 13:28:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp: Fix PCIe PHY
 power-domains
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>
 <ZY6sh8nlEUyEfL0u@hovoldconsulting.com> <20231229170334.GA9098@thinkpad>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231229170334.GA9098@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 18:03, Manivannan Sadhasivam wrote:
> On Fri, Dec 29, 2023 at 12:24:55PM +0100, Johan Hovold wrote:
>> On Wed, Dec 27, 2023 at 11:28:26PM +0100, Konrad Dybcio wrote:
>>> The PCIe GDSCs are only related to the RCs. The PCIe PHYs on the other
>>> hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
>>
>> No, that does not seem to be entirely correct. I added the power-domains
>> here precisely because they were needed to enable the PHYs.
>>
>> This is something I stumbled over when trying to figure out how to
>> add support for the second lane pair (i.e. four-lane mode), and I just
>> went back and confirmed that this is still the case.
>>
>> If you try to enable one of these PHYs without the corresponding GDSC
>> being enabled, you end up with:
>>
>> [   37.709324] ------------[ cut here ]------------
>> [   37.718196] gcc_pcie_3b_aux_clk status stuck at 'off'
>> [   37.718205] WARNING: CPU: 4 PID: 482 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x144/0x15c
>> 	
> 
> Technically this patch is correct. PHYs are backed by MX domain only and not
> GDSCs. Only the controllers (PCIe, UFS, USB) are backed by GDSCs. The fact that
> you are seeing issue with PCIe Aux clock suggests me that this clock may not be
> applicable to the PHY but it needs to be enabled for working of the PHY somehow.
> I'll try to find the details on how exactly it is needed.
> 
> But if I get the answer like, "This clock is also sourced to PHY directly", then
> we may need to add dual power domain for PHY (both GDSC and MX).
> 
>> Now, you may or may not want to describe the above in the devicetree,
>> but this makes it sound like you're trying to work around an issue with
>> the current Linux implementation.

I did a bit of experimentation, and.. I think that the PHY itself doesn't
need the GDSC to be enabled.

However.

The AUX clock requires the GDSC to be enabled and the PHY will fail to
power on if this clock is disabled.

That makes me wonder if representing the PCIe PHY as a wholly separate
device (instead of e.g. it being a subdev of PCIe RC) is even correct..

>>
> 
> Adding MX domain to PHY in devicetree is definitely not a workaround. It is the
> actual hardware representation. MX is the always on domain, and when CX collapse
> happens during suspend state, it will ensure that all the analog components
> (like PHY) are kept powered on. Otherwise, we will see link down issues.
> 
> But, I heard from Qcom that _only_ on this platform, MX is not backing the PCIe
> PHY. I can correlate that with my encounter with PCIe issues after forcing CX
> power collapse.
I've heard otherwise, the PHY itself is powered by MX, but CX needs
to be (should be?) enabled for communication with the RC (which itself
needs CX to be up to function).

Konrad

