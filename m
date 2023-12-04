Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C8803114
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjLDK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjLDK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:59:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B907C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:59:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1b75f59a12so87058866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701687582; x=1702292382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0HgHBQ0hx8GhQGLQxTtBI+1qocQEqc+9+F9Qoq89AE=;
        b=THxqjWhJP193OdEDpAs3IJsULiFS9oKHPkt8lB4o9dSj+1uIebsTDFoeY9pgEUIKWG
         IPZ2l588LLqeC0H84+tY1m2Bu0PRFknR7w8uJVUuTbInVrb1YOGi2aP2hL8/usJW2rU0
         DEt/RWipXa0svK3zAthSQp1ZWWe3tHtvzEC+ptjAjZvBWg43YCMDki+Ug8Ctqd4oZX7i
         LjkS/m2kklWD2RjnYiVJ1h4DspsvuYhEsi++2fzY8Tlna9XPbHgWOWnZt+vtDxAp3Bvq
         4oz/TgktmWM71iuvgnUaoUlY2hvZs+E3mOo1WCiQ8ouK/Y88Tl3ugbF1UOrWXdVLSInI
         BWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687582; x=1702292382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0HgHBQ0hx8GhQGLQxTtBI+1qocQEqc+9+F9Qoq89AE=;
        b=dhorjIMKX0VoilG8rAVKbLSDLq8/UGTqgLsiI9WSC6uZ8ytnrBWkr83l9YRldLrmds
         w4BRpXop10Et38avht9Hwu7kvg4Gekf16tr47WA8U8kgDXY4PRr887XlCoixTtpogBwZ
         FfqE0GLZqvZX9Hp/qmEPp/PGWg3nKT9QZzZgjF0DyB5T4d0zIC9t9vDMcLEAVPQP9tcW
         /XksiskU4+SdwpycDQRvv22Q0HmntG1Ll4Hzebmo5OxhKBZEvkL/J32HKOZv3bXQUJMD
         qYt7yKglxVCwnCikI6xqw+vIPc/vyWRe4lkc4kCfN6Q+pn7isgCHiXw0+hsn8ZTSMCoC
         o2Og==
X-Gm-Message-State: AOJu0YzndwZOZ22s6hbj4fQN1Z2PeM+Y7VygobI6iQcd+dAQy+d820sq
        TnSdHe4Ysv+zuuxD1KwQV3cLgA==
X-Google-Smtp-Source: AGHT+IGv4vUMb4KB9godAH5Y+diZk9TpgDQc8jfgSTmIpUrIMAi3Qm+1ZtlHQHqpQXnUwIL1Ho+pCg==
X-Received: by 2002:a17:906:d3:b0:a1a:4f0a:2ede with SMTP id 19-20020a17090600d300b00a1a4f0a2edemr1468893eji.219.1701687582397;
        Mon, 04 Dec 2023 02:59:42 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id jt14-20020a170906ca0e00b00a13f7286209sm5168944ejb.8.2023.12.04.02.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:59:41 -0800 (PST)
Message-ID: <1aa2b7c9-b512-4101-83b6-1a5d4ca8e2f6@linaro.org>
Date:   Mon, 4 Dec 2023 11:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8916: Make blsp_dma
 controlled-remotely
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231204-msm8916-blsp-dma-remote-v1-0-3e49c8838c8d@gerhold.net>
 <20231204-msm8916-blsp-dma-remote-v1-1-3e49c8838c8d@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231204-msm8916-blsp-dma-remote-v1-1-3e49c8838c8d@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 11:21, Stephan Gerhold wrote:
> The blsp_dma controller is shared between the different subsystems,
> which is why it is already initialized by the firmware. We should not
> reinitialize it from Linux to avoid potential other users of the DMA
> engine to misbehave.
> 
> In mainline this can be described using the "qcom,controlled-remotely"
> property. In the downstream/vendor kernel from Qualcomm there is an
> opposite "qcom,managed-locally" property. This property is *not* set
> for the qcom,sps-dma@7884000 [1] so adding "qcom,controlled-remotely"
> upstream matches the behavior of the downstream/vendor kernel.
> 
> Adding this seems to fix some weird issues with UART where both
> input/output becomes garbled with certain obscure firmware versions on
> some devices.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.1-02310-8x16.0/arch/arm/boot/dts/qcom/msm8916.dtsi#L1466-1472
> 
> Cc: <stable@vger.kernel.org> # 6.5
> Fixes: a0e5fb103150 ("arm64: dts: qcom: Add msm8916 BLSP device nodes")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This should only be backported to v6.5+ since it depends on commit
> 8975dd41a9db ("dmaengine: qcom: bam_dma: allow omitting
> num-{channels,ees}") which landed in v6.5.
> ---
>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index e8a14dd7e7c2..7f8327b0dbdb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -2155,6 +2155,7 @@ blsp_dma: dma-controller@7884000 {
>   			clock-names = "bam_clk";
>   			#dma-cells = <1>;
>   			qcom,ee = <0>;
> +			qcom,controlled-remotely;
>   		};
>   
>   		blsp_uart1: serial@78af000 {
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
