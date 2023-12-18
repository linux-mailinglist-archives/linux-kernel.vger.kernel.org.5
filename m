Return-Path: <linux-kernel+bounces-4409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CF817CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267521F2433C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51577740A9;
	Mon, 18 Dec 2023 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPytoR8U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF7740A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc61d4e5aeso27761641fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702935120; x=1703539920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSXNxdoZhofQ5RCoswX0f1+//hwvnN3EjdXTFtoy2HI=;
        b=YPytoR8UoXXL5CGUcl3dfCdIiBvwg6cv8N9QJ1ZrnuxwfYhVI+fQCxLtSjas1k3fMa
         dQSj5awbalo7vQ+36AI1X8F5cFYniL39UP1LqmBtfa2LV0yvMIHXsOOAm1jOu3H81FhM
         FaRlOAA65obniearn1MSBnImUrhJM7rGMnia5ABUqfkbVdty9TK/Hwn0nkVlVEmwmrFh
         P3Y5iW3pqbOYxMb1RT6LqECTLm7b382KNKOh87nHTw6cit8j4VYO1OtNIbLk7N0nEwQA
         7XWp7Ts8E8S+b1bMvEO/m1FA7hSAerod1ude64Cuv/cddqnfcoakG82l9aGFQq3pLsN5
         UTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702935120; x=1703539920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSXNxdoZhofQ5RCoswX0f1+//hwvnN3EjdXTFtoy2HI=;
        b=Lfn5rmpx9rz9SLqSvgIKWadvZ5lKQfcVm7g3owahlXXOy4YgCNYV5SK+J+ZC43yhot
         y4NV3Var1b6qZ8SitBGFSWvioZk8UWCwd1sxAvdt3ZPMFwXX9LVrRH1apQq8hMM2rmbL
         JAinqqgHKsGh+3a32C9YjWWpVX7k2KmafVMHHoz4MPsvywJhDaqPMRcVilEYAa2aQHc6
         B6Mh/1nkzzWdHW6sPUFIO2KGKTJ9aD7FkZPcd2zAy3MlyU09qJk6XZ8T0c7AztQYp89r
         5KAW2rd3/AvYqUOlpQ+nFPC2qe5RdiRZiwM24c8ydEZSej4c3Ps9KFz8Co8/9ukFmZkZ
         8soQ==
X-Gm-Message-State: AOJu0Yyc83icI9J+qQdHgL72ZNerWJMenBVLu83L5g2NuD6rN3EZg7CE
	yUBaqx5ItVXYaUQT2fVvecLX9A==
X-Google-Smtp-Source: AGHT+IGb9L/7IjmEK6JBuwbQuFPw/cgebNIiMG+aI27+Ezg3cWXCBXy+3+3B2cUOYWuEJ4oyHG7dOg==
X-Received: by 2002:a05:651c:2009:b0:2cc:63e4:884c with SMTP id s9-20020a05651c200900b002cc63e4884cmr1666186ljo.50.1702935119890;
        Mon, 18 Dec 2023 13:31:59 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b002cc710614besm507393ljj.0.2023.12.18.13.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 13:31:59 -0800 (PST)
Message-ID: <15d2bd66-29f3-435b-8494-d82ec4036413@linaro.org>
Date: Mon, 18 Dec 2023 22:31:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] arm64: dts: qcom: sm8550: Switch UFS from
 opp-table-hz to opp-v2
To: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
 <20231218-topic-8550_fixes-v1-10-ce1272d77540@linaro.org>
 <62f0c623-3819-f6be-115f-6b471ab79a58@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <62f0c623-3819-f6be-115f-6b471ab79a58@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/18/23 17:35, Nitin Rawat wrote:
> 
> 
> On 12/18/2023 9:32 PM, Konrad Dybcio wrote:
>> Now that the non-legacy form of OPP is supported within the UFS driver,
>> go ahead and switch to it, adding support for more intermediate freq/power
>> states.
>>
>> In doing so, add the CX RPMhPD under GCC to make sure at least some of
>> the power state requirements are *actually* propagated up the stack.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 50 +++++++++++++++++++++++++++++-------
>>   1 file changed, 41 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index d707d15cea5b..d6edd54f3ad3 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -1930,6 +1930,7 @@ ufs_mem_hc: ufs@1d84000 {
>>               iommus = <&apps_smmu 0x60 0x0>;
>>               dma-coherent;
>> +            operating-points-v2 = <&ufs_opp_table>;
>>               interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
>>                       <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
>> @@ -1950,18 +1951,49 @@ ufs_mem_hc: ufs@1d84000 {
>>                    <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>                    <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>                    <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
>> -            freq-table-hz =
>> -                <75000000 300000000>,
>> -                <0 0>,
>> -                <0 0>,
>> -                <75000000 300000000>,
>> -                <100000000 403000000>,
>> -                <0 0>,
>> -                <0 0>,
>> -                <0 0>;
>>               qcom,ice = <&ice>;
>>               status = "disabled";
>> +
>> +            ufs_opp_table: opp-table {
>> +                compatible = "operating-points-v2";
>> +
>> +                opp-75000000 {
>> +                    opp-hz = /bits/ 64 <75000000>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <75000000>,
>> +                         /bits/ 64 <100000000>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>;
>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>> +                };
>> +
>> +                opp-150000000 {
>> +                    opp-hz = /bits/ 64 <150000000>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <150000000>,
>> +                         /bits/ 64 <100000000> > +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>;
>> +                    required-opps = <&rpmhpd_opp_svs>;
>> +                };
>> +
>> +                opp-300000000 {
>> +                    opp-hz = /bits/ 64 <300000000>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <0>,
>> +                         /bits/ 64 <300000000>,
>> +                         /bits/ 64 <100000000>,
> Hi Konrad,
> 
> This entry is for ICE clock ? Shouldn't the entry be 403000000 ?
> Same for svs as well ?
Hi Nitin,

this entry is for the TCSR_UFS_PAD_CLKREF_EN/"ref_clk" clock,
which doesn't support ratesetting, so it should probably be 0
(or its actual value if we know it - I assumed it was 100 MHz
as it was there before).

The ICE clock is handled separately by the crypto@1d88000 node.

Thinking about it again, the original submission probably included
the ICE clock within the UFS node and when TCSRCC was created,
somebody might have omitted the wrong rate value.

Konrad

