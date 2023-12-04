Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5F803122
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjLDLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjLDK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:59:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C63116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:00:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c967010b2so2807883a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701687598; x=1702292398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UZiTscdrvqfLrwy30AwVqngp6T7XzxdwFwSMft6nhU=;
        b=z8GxFUzrTjz/WjrEsC/J1q1fF8XtJah/s1bHBE5mfAvZPMRsgpB5cIafOe+/r9vxr0
         oz6ldwuoP5YaVpte6E7LI//dD/kRLOVDCFLbTHmTih1eH0ruIT33KYpeTKwDVCzZIzwh
         3cKb2jbACiqwTM5pFZUfanYMxF2Xw+0q3LqQjVEQgHZTMQX7T3MVOQ904HH5/E3yU4gV
         x/hHzKgEbUTocn4UdJcsYgyy6kJQY7Mr+dcMNJiKmIe+AuQg3R1QG7kQuzNtzYkKAAqO
         MV50GPZS1bnoAdTrZfx3TfI9eh0xNBXLEXNWAxpJvEhtAy4LFwj56/jpQ8zkPEfazzOE
         40DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687598; x=1702292398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UZiTscdrvqfLrwy30AwVqngp6T7XzxdwFwSMft6nhU=;
        b=nK8pQKq4pcK3ktUcirkyagdPj5wI6u5Ix9+XUQCwQTDaoNRQ8K2pCrta/kMA7WYuTQ
         YnhLqMfwfsAVQXIILKCeOnEBxQffCkA+oBTgg/SlhAxyKcXg7DGve1XDrC1EHuO5mTNM
         8FNeSACz/hhFbstfhEGsRuEeqyNRS9+CV3aurves0xCC327qkw2IlC0GRGtlyF79hDLH
         58eoZiIarKMXQC/Vyv0MX4PH54g+zcUJXXtVkG2jZbd1w7VftYwvii8rH5Np4n7RrLw2
         Az0mw0W2Vid8J3n6BPvJ3hWMLAoVtT6PCeP8S0BQZLAb3E1XgKb4hJvaCK3D/YpCbrE1
         cQjA==
X-Gm-Message-State: AOJu0YzIbPpITM4M2yh3sOqTNgDy3RtmwZwitynsAWhsjj9wTh9MGxF3
        uUoaHnbF2i3vpeSdKttNGRDdig==
X-Google-Smtp-Source: AGHT+IH6YNMJgPuilryBN3FihpD8caMksKHY0VPo7u2+B069qKRk7r4odWOBmch9unNmjJPoEsKOHg==
X-Received: by 2002:a17:906:24b:b0:9a5:dc2b:6a5 with SMTP id 11-20020a170906024b00b009a5dc2b06a5mr5354376ejl.35.1701687598414;
        Mon, 04 Dec 2023 02:59:58 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id jt14-20020a170906ca0e00b00a13f7286209sm5168944ejb.8.2023.12.04.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:59:57 -0800 (PST)
Message-ID: <cd8af752-34ec-4ac3-8713-08add7d29b32@linaro.org>
Date:   Mon, 4 Dec 2023 11:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939: Make blsp_dma
 controlled-remotely
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231204-msm8916-blsp-dma-remote-v1-0-3e49c8838c8d@gerhold.net>
 <20231204-msm8916-blsp-dma-remote-v1-2-3e49c8838c8d@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231204-msm8916-blsp-dma-remote-v1-2-3e49c8838c8d@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.1-02310-8x16.0/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L866-872
> 
> Cc: <stable@vger.kernel.org> # 6.5
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This should only be backported to v6.5+ since it depends on commit
> 8975dd41a9db ("dmaengine: qcom: bam_dma: allow omitting
> num-{channels,ees}") which landed in v6.5.
> ---
>   arch/arm64/boot/dts/qcom/msm8939.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> index 95610a32750a..9eb8f1ceee99 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -1761,6 +1761,7 @@ blsp_dma: dma-controller@7884000 {
>   			clock-names = "bam_clk";
>   			#dma-cells = <1>;
>   			qcom,ee = <0>;
> +			qcom,controlled-remotely;
>   		};
>   
>   		blsp_uart1: serial@78af000 {
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
