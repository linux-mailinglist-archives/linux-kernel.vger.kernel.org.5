Return-Path: <linux-kernel+bounces-13608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800D482091E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F51B216DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DCE559;
	Sat, 30 Dec 2023 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+tjupVo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15811D309
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d2376db79so72170785e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703978920; x=1704583720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9gYy29s9UglOJFtyJmti8blfRTxnRaCJhWJbNKd0iE=;
        b=T+tjupVoc4TgJjE/caSyNAUwhaqVRuzKinS5ujFzAA9HMsjdYfDp+2F1dz9HprTepm
         MzaQdjPvuTQwiLUtFGDfsZ/njmhN6eVJprKSgKFtD3CIfHZjrJBMv1CNQBsBDXkqoM1s
         /i/D/Lkvn9J0LogCZUp8hejW57jO2usTbg+aRz+TP8SlO4+5EqISxpbPeHFhmMnlLZfJ
         z1dZrjKlXJWStjlRiBA2xEr0empqfR+Mm95hXX6ZFAjRk4RdJSQtAQkkR7urw2WJd9bi
         kKlH9QDajL5mfYPFHSkvXs+YKff8PbWIhniudV4+1/zsSLhgc24oWheax9dtlM7XJTUp
         FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703978920; x=1704583720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9gYy29s9UglOJFtyJmti8blfRTxnRaCJhWJbNKd0iE=;
        b=pCET/Ba+dDuFVJSYfoQDrCCHUAHrVTjkvrvUREBcXceF3/EMkKu40lUvByvyPwbsC6
         ESEqRknhNPUMYJroN7RxciRfy1gpwU9GZnGr8xuC3Bkf8frIavOXyXgtvpYD0yrVYbdO
         afn4R7E0qJyg/m1yw6sdQsV3V/SvxyySiXvVAS9xdxJ5dqNr5MGmxDyqeF60DNjQ/OEu
         ZolcrJA1tmmSGG7MOu224KtdR9aPdMU1zoXfgyRSpv3eYf9M7C7MGyj17r95S2RDGCCD
         F91FPAw6VxGwNlhfIhjOfCejA0IMgdhgjDR7O8t/+UJamDUSquBl83eW51YVe5sN/BU1
         Rd/A==
X-Gm-Message-State: AOJu0YwUSRs9TERvsBfOcxdIoMdaJauGq96s/E5Bhc31eOt5vEg0L4cF
	G35TbhMhsO8S6mgI9TnKgiKgNxDMw2ZXog==
X-Google-Smtp-Source: AGHT+IExjsLqcwbnW3Dqimmzlg/bXNIGAXMRbVDyfe+oH5+zqSBGlBWlYfVGNVwyCZYaBqYqRzNWdQ==
X-Received: by 2002:a05:600c:4e09:b0:40d:7b1f:e424 with SMTP id b9-20020a05600c4e0900b0040d7b1fe424mr1739072wmq.20.1703978920243;
        Sat, 30 Dec 2023 15:28:40 -0800 (PST)
Received: from [192.168.16.140] (92.40.174.136.threembb.co.uk. [92.40.174.136])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b0040d3276ba19sm35621982wms.25.2023.12.30.15.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 15:28:39 -0800 (PST)
Message-ID: <8301e5b9-29fa-4c60-8694-335c63ae1883@linaro.org>
Date: Sun, 31 Dec 2023 00:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: add power domain to UFS phy
 interface
Content-Language: en-US
To: David Heidelberg <david@ixit.cz>, Luca Weiss <luca@z3ntu.xyz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
References: <20231229202959.266502-1-david@ixit.cz>
 <2710291.mvXUDI8C0e@z3ntu.xyz> <e299a7bd-2f50-41e0-a638-a1fbbeb65635@ixit.cz>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <e299a7bd-2f50-41e0-a638-a1fbbeb65635@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Did you boot-test this?

On 30/12/2023 00:18, David Heidelberg wrote:
> On 29/12/2023 22:37, Luca Weiss wrote:
> 
>> On Freitag, 29. Dezember 2023 21:29:54 CET David Heidelberg wrote:
>>> Reported by: `make CHECK_DTBS=1 qcom/sdm845-oneplus-enchilada.dtb`
>>>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi index c2244824355a..ad8677b62bfb
>>> 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -2644,6 +2644,8 @@ ufs_mem_phy: phy@1d87000 {
>>>               clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>>>                    <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>>>
>>> +            power-domains = <&gcc UFS_PHY_GDSC>;
>>> +
>>>               resets = <&ufs_mem_hc 0>;
>>>               reset-names = "ufsphy";
>> This is potentially the wrong power domain, see the conversation here:
>> https://lore.kernel.org/linux-arm-msm/20231204172829.GA69580@thinkpad/
> Thanks, I was thinking about  SDM845_MX, but then looked at rest more 
> closer qcom archs and thought it'll be likely GDSC (also by looking at 
> ufs_mem_hc reset vectors).
>>
>> Hopefully Mani can give some input here :)
>>
>> Regards
>> Luca
>>
>>

-- 
// Caleb (they/them)

