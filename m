Return-Path: <linux-kernel+bounces-150778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156F8AA474
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846A91F21155
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA38194C64;
	Thu, 18 Apr 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8hncsoK"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF996D1C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473780; cv=none; b=kd59QLyAHywfYllOibnevj48TV6hrnJtxwQpr/jSARVw2NkMi8GXdCOPDKLgXRZj4iBfo76U37S1ROzmYrFSvlZxPrlguCGKeJxZoZCNE83uD1EfZIvfmyD3BPEl7n8uPL3AJhBR38cXFMogx92Kaq7TKNDrp/9DvHpml8vpiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473780; c=relaxed/simple;
	bh=wGzGycJk/Oi2kpbEFgexVOpTcNGX5gvdXuAs44SRsFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAeahd5PXPerpydbu++9uTdAPao/IRMn7ITvt6A58eLwPCnNu/KtJ471SS1GobtOKm6cyu3Ya3X2nKDVCi/5zneqcZ/aLfIhiSPqcI8rezEYzAZleaDbFjT09m9iPY/O4qpwTHn7VP0RiAwJFU0PiGaXPieTdk3jpy4/xYguCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8hncsoK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dac628f08fso3574821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473775; x=1714078575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNOD//alu/YfcmSed7oxxw7a4+KJ3u8Ghpd/YaoyNuE=;
        b=j8hncsoKYUqw879Y2+8Lx8xT9ymDcPIE4I2gBi9a9hn4fVOYX8frQk+4C5QMlDkeVC
         0dA14wy6rkMQpQIoKy15C1CVetKDGa6SIxCNbGy70iN9EYS9XYwwKw6Iw2H1IfAp5BYT
         VoWVUR/m1NepTXhnWYtAJw1Nh5pHkMyYWOxhD/JceJ/35O9QQFqaePKjAcbxgQFJgxXT
         QvMZIW34cnIFH8cIQ+nUKE4byVYjyT5x67+tinqt87tMj4LeCFSBd52c4h+JrpxhFd6f
         QmrpbmU0mkwAdHLUlkpf+8My16N85pUF+izF3g5bjg7vTfjsp+doh3UuQRRjG42duCdG
         LJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473775; x=1714078575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNOD//alu/YfcmSed7oxxw7a4+KJ3u8Ghpd/YaoyNuE=;
        b=Lu27gq+I4Mr10RXLFbsCYPYL39/360euLTbq+hAIp2Lh8fXCGSaumQg3t79ouIhMDY
         NnmmJPoPvU3DNmcltCLnCTKeUBpRXPx1dOOmjeCYDco5q7qdAIimM2tsqgYhjqr7JaYA
         GePwE20GnJ3lvDeOS3gFcEEbUPGbBhplg/4g7c61cB+k6mVmbc3/w9Y+i+IbKyLbSRW+
         tIclQKmOyGSrcDKBRebR00ZYUo0HOVo9FS6oMPAyv/bgXRHpfI9Tg393gBepE/07Yvl8
         pJXSovFo7u6hY7ztgi9huTXG0Qdb292BnFUnwON1ThnCDVGWXKAVksnza7aeQ2fSjLk5
         7ZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWP3PWsEn16Lh/jHkSAffm/0rDQikPnC1dibYy05OHpKF4atJUYXzBrsnm2mHfQ79/ex/fJb+L3iU2cyujnTpAMTOom68nI5TPk22l+
X-Gm-Message-State: AOJu0Yxu1VUPp0NDV9ysMhZ1lYlDbLtXI7F+8dk9FVKGRsTJR6eepWPA
	7BIL5EORm23ecPkSJAIyfX4Dez/v2sHovw5BHH13V+p18EPuzIbJGf+/JcNHev0=
X-Google-Smtp-Source: AGHT+IG0XdbMufW8P2nIZpf7qgVe3OH9Abfq3vBzkYJB/UwVOmO2hShAkFLgUgPW173oxVGi2cgNFQ==
X-Received: by 2002:ac2:4db9:0:b0:513:ec32:aa89 with SMTP id h25-20020ac24db9000000b00513ec32aa89mr96655lfe.2.1713473775021;
        Thu, 18 Apr 2024 13:56:15 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24ac9000000b0051950b81ae7sm380825lfp.237.2024.04.18.13.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:56:14 -0700 (PDT)
Message-ID: <752f077d-68a8-4bb5-86cf-c6d49cfe4606@linaro.org>
Date: Thu, 18 Apr 2024 23:56:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 6/6] arm64: dts: qcom: sm8650: Add video and
 camera clock controllers
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-7-quic_jkona@quicinc.com>
 <0a7da687-18fb-437f-b33a-e4a1de20177e@linaro.org>
 <9ac4117c-755e-4e49-b3a2-661e7195a7ed@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <9ac4117c-755e-4e49-b3a2-661e7195a7ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Konrad,

On 3/23/24 02:33, Konrad Dybcio wrote:
> On 21.03.2024 14:07, Vladimir Zapolskiy wrote:
>> Hello Jagadeesh,
>>
>> On 3/21/24 11:25, Jagadeesh Kona wrote:
>>> Add device nodes for video and camera clock controllers on Qualcomm
>>> SM8650 platform.
>>>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8650.dtsi | 28 ++++++++++++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> index 32c0a7b9aded..d862aa6be824 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> @@ -4,6 +4,8 @@
>>>     */
>>>      #include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>>> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>>>    #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>>>    #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>>>    #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
>>> @@ -3110,6 +3112,32 @@ opp-202000000 {
>>>                };
>>>            };
>>>    +        videocc: clock-controller@aaf0000 {
>>> +            compatible = "qcom,sm8650-videocc";
>>> +            reg = <0 0x0aaf0000 0 0x10000>;
>>> +            clocks = <&bi_tcxo_div2>,
>>> +                 <&gcc GCC_VIDEO_AHB_CLK>;
>>> +            power-domains = <&rpmhpd RPMHPD_MMCX>;
>>> +            required-opps = <&rpmhpd_opp_low_svs>;
>>
>> Please add default status = "disabled";
>>
>>> +            #clock-cells = <1>;
>>> +            #reset-cells = <1>;
>>> +            #power-domain-cells = <1>;
>>> +        };
>>> +
>>> +        camcc: clock-controller@ade0000 {
>>> +            compatible = "qcom,sm8650-camcc";
>>> +            reg = <0 0x0ade0000 0 0x20000>;
>>> +            clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>>> +                 <&bi_tcxo_div2>,
>>> +                 <&bi_tcxo_ao_div2>,
>>> +                 <&sleep_clk>;
>>> +            power-domains = <&rpmhpd RPMHPD_MMCX>;
>>> +            required-opps = <&rpmhpd_opp_low_svs>;
>>
>> Please add default status = "disabled";
>>
>>> +            #clock-cells = <1>;
>>> +            #reset-cells = <1>;
>>> +            #power-domain-cells = <1>;
>>> +        };
>>> +
>>>            mdss: display-subsystem@ae00000 {
>>>                compatible = "qcom,sm8650-mdss";
>>>                reg = <0 0x0ae00000 0 0x1000>;
>>
>> After disabling the clock controllers
> 
> Clock controllers should never be disabled period, that defeats the
> entire point of having unused clk/pd cleanup.

hm, that's very sane, I didn't think about it from this point, thanks!

> The only reason for them to be disabled is for cases where platform
> crashes on access due to stinky "security" settings (like with audio
> clocks), or when people are too lazy to upstream panel drivers and
> end up partially upstreaming display-related changes and continue
> using the bootloader-initialized framebuffer. This takes away from
> the very little determinism we have.
> 

--
Best wishes,
Vladimir

