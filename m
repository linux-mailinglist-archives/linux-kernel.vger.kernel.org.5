Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381D7CE553
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjJRRvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJRRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:51:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D25115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:51:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so94239881fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697651503; x=1698256303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHJSF5X1nkWgGuo3YQxKlNnSL2Jb3AlzWdUDQa0ejrA=;
        b=s82zJd5YurNSHwIlkxxXvaugD8+71EV9KMohp5SjSHngLsC1Rn2yM5RziwTJ7yFafC
         BfcHav6U41G6MpSuahq5sprt+oHC3z/fVr5IolHlC1bEw5DxDEOINIBTYgapmsEb9Q51
         v6lsV6HNDZ+vUr/HDAQ6dQsXMZdmdKf7RZp9UID09OPMyhBPLqdDf83hvQr+hi1E9an/
         DklhOjEqat+97H32YIpZMI7U4p3fqR9ixORxITWDXaQfnmb6dZtcWlL8Web2JfjAmNlH
         qa0KEzm9YJpAKxLLqPEkP3ebBZAeGR+a3RKgYFR0FU9pQOt49E/RWqBYI1ocx04kmdH0
         yMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651503; x=1698256303;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHJSF5X1nkWgGuo3YQxKlNnSL2Jb3AlzWdUDQa0ejrA=;
        b=EuvywIFjH7hDEKMdgqSQory+E8Fh4K7Ph8Ye9FvNa2VFGZgtjObk4eXVgetAKDhWj/
         3LLMkyKmmWlnOb1zhNndQ7L9D3SA8p2+DleRWuWggLFO1mINRTD1uJkikdDBQaSfXv7l
         AFWmOu1pubIf0JAiNtF25t7erJTRr1XNubK1RLJYrfyFRoTapfGxPLzJzNG09Jy5M2wG
         wpypUkM5el+qVQouxFef+QZ5T2g2w41HvV93xdflnA7mngra8uJnK1oXpktA38J449yO
         bbDeS3zF6oNvZlPBp6GlZ8jsPNaBaFmJm9b0KF0c9+HMwHFfCbphcCEOBUqTAV5oEw9Q
         KGsg==
X-Gm-Message-State: AOJu0Yxp+b9Qz2UEqDvVzfxxN6KmXanjU5kwy/LGGYx27Gl6YMUyD5cq
        eHSiUnJihTSrRImuwolfksI8Xg==
X-Google-Smtp-Source: AGHT+IGp5OwXk3ooeeFdICyeMDEnuecQP80Ve5odqVSAvaMAzznXCIvH5bx9jBx+HtZf6/Le6CMARA==
X-Received: by 2002:ac2:484c:0:b0:503:35b3:aa31 with SMTP id 12-20020ac2484c000000b0050335b3aa31mr4419418lfy.27.1697651503384;
        Wed, 18 Oct 2023 10:51:43 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050797a35f8csm779407lfe.162.2023.10.18.10.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 10:51:43 -0700 (PDT)
Message-ID: <b1926ed8-fbe2-4428-aa23-dc4279553417@linaro.org>
Date:   Wed, 18 Oct 2023 19:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: ipq5332: populate the opp table
 based on the eFuse
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org,
        quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1697600121.git.quic_varada@quicinc.com>
 <fbd343f731973f532496c2ccfe65e6b487a14db3.1697600121.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fbd343f731973f532496c2ccfe65e6b487a14db3.1697600121.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 11:29, Varadarajan Narayanan wrote:
> IPQ53xx have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Add support to read the eFuse and populate the OPPs based on it.
> 
> 	------------------------------------------------
> 	Frequency	BIT2	BIT1	opp-supported-hw
> 			1.1GHz	1.5GHz
> 	------------------------------------------------
> 	1100000000	1	1	0xf
BIT(0) | BIT(1) | BIT(2) is 0x7

> 	1500000000	0	1	0x3
> 	------------------------------------------------
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2:	Fix inconsistencies in comment and move it to commit log
> 	as suggested
> 	Remove opp-microvolt entries as no regulator is managed by Linux
> 	cpu_speed_bin -> cpu-speed-bin in node name
> 	Remove "nvmem-cell-names" due to dtbs_check error
> ---
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 4206f05..a0dcba3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -91,11 +91,19 @@
>   	};
>   
>   	cpu_opp_table: opp-table-cpu {
> -		compatible = "operating-points-v2";
> +		compatible = "operating-points-v2-kryo-cpu";
>   		opp-shared;
> +		nvmem-cells = <&cpu_speed_bin>;
>   
> -		opp-1488000000 {
> -			opp-hz = /bits/ 64 <1488000000>;
> +		opp-1100000000 {
> +			opp-hz = /bits/ 64 <1100000000>;
> +			opp-supported-hw = <0xF>;
hex literals must be lowercase.

Konrad
